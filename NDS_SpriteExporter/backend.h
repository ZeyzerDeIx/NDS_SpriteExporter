#pragma once

#include <QObject>
#include <QUrl>

class Backend : public QObject
{
    Q_OBJECT
public:
    explicit Backend(QObject *parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE void changeTitle(QObject *windowObject, const QString &newTitle);
    Q_INVOKABLE bool checkFileValidity(const QUrl path);
};
