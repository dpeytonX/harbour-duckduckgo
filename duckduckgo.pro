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
TARGET = duckduckgo

CONFIG += sailfishapp

SOURCES += src/duckduckgo.cpp \
    src/manager.cpp

QMAKE_CXXFLAGS += -std=c++0x

OTHER_FILES += qml/duckduckgo.qml \
    qml/cover/CoverPage.qml \
    rpm/duckduckgo.changes.in \
    rpm/duckduckgo.spec \
    rpm/duckduckgo.yaml \
    translations/*.ts \
    duckduckgo.desktop \
    duckduckgo.png \
    duckduckgo.xml \
    duckduckgo_small.png \
    duckduckgo_cover.png \
    qml/pages/ConfigurePage.qml \
    rpm/duckduckgo.spec \
    qml/widgets/StandardListView.qml \
    qml/widgets/InformationalLabel.qml \
    qml/widgets/Heading.qml \
    qml/widgets/DescriptiveLabel.qml \
    qml/pages/SearchPage.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/duckduckgo-de.ts

RESOURCES += \
    images.qrc \
    project.qrc

HEADERS += \
    src/manager.h
