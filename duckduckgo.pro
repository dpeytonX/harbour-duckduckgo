# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-duckduckgo

CONFIG += sailfishapp

SOURCES += src/duckduckgo.cpp

QMAKE_CXXFLAGS += -std=c++0x

OTHER_FILES += qml/* \
    qml/pages/* \
    qml/cover/CoverPage.qml \
    qml/widgets/* \
    rpm/* \
    translations/*.ts \
    harbour-duckduckgo.desktop \
    harbour-duckduckgo.png \
    duckduckgo.xml \
    duckduckgo.json \
    duckduckgo_small.png \
    duckduckgo_cover.png

OTHER_FILES += harbour/duckduckgo
QML_IMPORT_PATH = .
duckduckgo.files = harbour
duckduckgo.path = /usr/share/$${TARGET}
INSTALLS += duckduckgo

LIBS += -L$$PWD/harbour/duckduckgo/SailfishWidgets/Core -L$$PWD/harbour/duckduckgo/SailfishWidgets/Settings -lapplicationsettings -lcore
duckduckgolibs.files = $$PWD/harbour/duckduckgo/SailfishWidgets/Settings/libapplicationsettings* \
                       $$PWD/harbour/duckduckgo/SailfishWidgets/Core/libcore*
duckduckgolibs.path = /usr/share/$${TARGET}/lib
  # Delete the private lib for the harbour store RPM validator
duckduckgolibs.commands = "rm -fr /home/deploy/installroot/usr/share/harbour-duckduckgo/harbour/duckduckgo/SailfishWidgets/Core"
INSTALLS += duckduckgolibs

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/duckduckgo-de.ts

RESOURCES += \
    images.qrc \
    project.qrc

HEADERS +=
