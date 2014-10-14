#include "manager.h"

#include <QDebug>
#include <QFile>

Manager::Manager(QObject *parent) :
    QObject(parent)
{
}

bool Manager::fileExists() {
    bool result = QFile("/home/nemo/.mozilla/mozembed/searchplugins/duckduckgo.xml").exists();
    qDebug() << "file " << (result ? "exists" : "does not exist");
    return result;
}

bool Manager::toggleDuckDuckGo(bool enable) {
    if(enable) {
        //Read mozilla plugin file from resource
        QFile file(":/project/duckduckgo.xml");
        if(!file.exists()) {
            qDebug() << "Resource file does not exist";
            return false;
        }

        // Copy file to user's home directory
        bool result = file.copy("/home/nemo/.mozilla/mozembed/searchplugins/duckduckgo.xml");
        qDebug() << "file was " << (result ? "copied" : "not copied");
        return result;
    }

    bool result = QFile("/home/nemo/.mozilla/mozembed/searchplugins/duckduckgo.xml").remove();
    qDebug() << "file was " << (result ? "removed" : "not removed");
    return result;
}
