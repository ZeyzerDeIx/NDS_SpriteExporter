#include "backend.h"
#include "AppConstants.h"
#include <QVariant>
#include <QFileInfo>
#include <QProcess>
#include <QDebug>

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

bool Backend::exportSprite(QString const& imagePath, QString const& spriteName) const
{
    QProcess gritProcess;
    QString program = "Thirdparty/grit.exe";

    QString const finalName = spriteName + (spriteName.endsWith("Sprite") ? "" : "Sprite");

    QStringList arguments;
    arguments
        << imagePath.mid(8) //mid(8) to ignore "file//:"
        << "-ftb"           //require binary files
        << "-gB4"           //require 16 colors palette
        << "-gT 7D197D"     //transparency color
        << "-s "+finalName  //created variables name
        << "-o "+finalName  //created files name
        << "-Mh8"           //frame heigh in tiles (1 tile = 8 pixels)
        << "-Mw4";          //frame width in tiles (1 tile = 8 pixels)

    gritProcess.start(program, arguments);

    if (gritProcess.waitForFinished()) qDebug() << "Success";
    else qDebug() << "Error:" << gritProcess.errorString();

    return true;
}

QString Backend::extractFileName(QString const& imagePath) const
{
    QString fileName = imagePath.split('/').back(); //remove path before file name
    fileName = fileName.split('.').front(); //remove extension (.png etc.)

    return fileName;
}
