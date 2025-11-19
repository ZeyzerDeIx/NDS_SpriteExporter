#include "backend.h"
#include <QVariant>

void Backend::changeTitle(QObject *windowObject, const QString &newTitle)
{
    if (windowObject)
        windowObject->setProperty("title", newTitle);
}
