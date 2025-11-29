#pragma once

#include <QObject>
#include <QUrl>

class Backend : public QObject
{
    Q_OBJECT
public:
    explicit Backend(QObject *parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE void changeTitle(QObject *windowObject, const QString &newTitle) const;
    Q_INVOKABLE bool checkFileValidity(const QUrl path) const;
    Q_INVOKABLE bool exportSprite(QString const& imagePath,
                                  QString const& spriteName,
                                  QString const& assetsFolderPath,
                                  QString const& nitrofsFolderPath) const;
    Q_INVOKABLE QString extractFileName(QString const& imagePath) const;
};
