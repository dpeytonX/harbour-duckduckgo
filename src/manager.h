#ifndef MANAGER_H
#define MANAGER_H

#include <QObject>

class Manager : public QObject
{
    Q_OBJECT
public:
    explicit Manager(QObject *parent = 0);

signals:

public slots:
    bool toggleDuckDuckGo(bool enable);
    bool fileExists();
};

#endif // MANAGER_H
