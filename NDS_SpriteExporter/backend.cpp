#include "backend.h"
#include "AppConstants.h"
#include <QVariant>
#include <QFileInfo>
#include <QProcess>
#include <QDebug>
#include <QDir>
#include <QCoreApplication>

void Backend::changeTitle(QObject *windowObject, const QString &newTitle) const
{
    if (windowObject)
        windowObject->setProperty("title", newTitle);
}


bool Backend::checkFileValidity(const QUrl path) const
{
    QFileInfo fileInfo(path.toLocalFile());

    if (!fileInfo.exists() || !fileInfo.isFile())
    {
        qWarning() << "File does not exist or is not a regular file:" << fileInfo.path();
        return false;
    }

    QString extension = fileInfo.suffix().toLower();

    if (AppConstants::SupportedImageExtensions.contains(extension))
        return true;
    else return false;
}

bool Backend::exportSprite(QString const& imagePath, QString const& spriteName, QString const& assetsFolderPath, QString const& nitrofsFolderPath) const
{
    // 1. CLEAN PATHS: Convert URL (file:///...) to OS native paths (C:/...)
    // This handles spaces, special chars, and OS separators automatically.
    QString const cleanImagePath = QUrl(imagePath).toLocalFile();
    QString const cleanAssetsPath = QUrl(assetsFolderPath).toLocalFile();
    QString const cleanNitroPath = QUrl(nitrofsFolderPath).toLocalFile();
    QString const appDir = QCoreApplication::applicationDirPath();

    // 2. SETUP NAMES
    QString const finalFileName = spriteName + (spriteName.endsWith("Sprite") ? "" : "Sprite");

    // Absolute path to the tool
    QString const program = appDir + "/Thirdparty/grit.exe";

    QProcess gritProcess;

    // 3. Set where GRIT runs. All outputs will appear here.
    gritProcess.setWorkingDirectory(appDir);

    QStringList arguments;
    arguments
        << cleanImagePath        // Input file (absolute path)
        << "-ftb"                // Binary output
        << "-gB4"                // 4bpp
        << "-gT" << "7D197D"     // Transparent color
        << "-s" << finalFileName // Output symbol names
        << "-o" << finalFileName // Output files name
        << "-Mh8"                // Frame heigh in tiles (1 tile = 8 pixels)
        << "-Mw4";               // Frame width in tiles (1 tile = 8 pixels)

    gritProcess.start(program, arguments);

    // 4. WAIT & CHECK ERRORS
    if (!gritProcess.waitForFinished())
    {
        qDebug() << "GRIT process - Error:" << gritProcess.errorString();
        return false;
    }

    // Capture GRIT output (errors are often printed to Standard Error)
    QByteArray errorOutput = gritProcess.readAllStandardError();
    QByteArray stdOutput = gritProcess.readAllStandardOutput();

    if (gritProcess.exitCode() != 0 || !errorOutput.isEmpty())
    {
        qDebug() << "GRIT Failed!";
        qDebug() << "StdOut:" << stdOutput;
        qDebug() << "StdErr:" << errorOutput;
        return false;
    }

    // 5. MOVE FILES
    auto moveWithOverwrite = [](QString const& source, QString const& dest)
    {
        // Debug check
        if (!QFile::exists(source))
        {
            qDebug() << "Source missing:" << source;
            return false;
        }

        if (QFile::exists(dest) && !QFile::remove(dest))
        {
            qDebug() << "Cannot remove existing file:" << dest;
            return false;
        }

        bool success = QFile::rename(source, dest);
        if (!success) qDebug() << "Rename failed:" << source << "to" << dest;
        return success;
    };

    // Construct source paths (appDir + filename + extension)
    QString const srcHeader = appDir + "/" + finalFileName + ".h";
    QString const srcImg    = appDir + "/" + finalFileName + ".img.bin";
    QString const srcPal    = appDir + "/" + finalFileName + ".pal.bin";

    bool hMoved   = moveWithOverwrite(srcHeader, cleanAssetsPath + "/" + finalFileName + ".h");
    bool imgMoved = moveWithOverwrite(srcImg,    cleanNitroPath  + "/" + finalFileName + ".img.bin");
    bool palMoved = moveWithOverwrite(srcPal,    cleanNitroPath  + "/" + finalFileName + ".pal.bin");

    return hMoved && imgMoved && palMoved;
}

QString Backend::extractFileName(QString const& imagePath) const
{
    QString fileName = imagePath.split('/').back(); //remove path before file name
    fileName = fileName.split('.').front(); //remove extension (.png etc.)

    return fileName;
}
