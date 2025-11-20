#include "backend.h"
#include "AppConstants.h"
#include <QVariant>
#include <QFileInfo>

void Backend::changeTitle(QObject *windowObject, const QString &newTitle)
{
    if (windowObject)
        windowObject->setProperty("title", newTitle);
}


bool Backend::checkFileValidity(const QUrl path)
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
