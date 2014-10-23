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

SOURCES += src/duckduckgo.cpp \
    src/manager.cpp

QMAKE_CXXFLAGS += -std=c++0x

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    rpm/harbour-duckduckgo.spec \
    rpm/harbour-duckduckgo.yaml \
    translations/*.ts \
    duckduckgo.xml \
    duckduckgo_small.png \
    duckduckgo_cover.png \
    qml/pages/ConfigurePage.qml \
    qml/widgets/StandardListView.qml \
    qml/widgets/InformationalLabel.qml \
    qml/widgets/Heading.qml \
    qml/widgets/DescriptiveLabel.qml \
    qml/pages/SearchPage.qml \
    harbour-duckduckgo.desktop \
    harbour-duckduckgo.png \
    rpm/harbour-duckduckgo.changes.in \
    qml/harbour-duckduckgo.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/duckduckgo-de.ts

RESOURCES += \
    images.qrc \
    project.qrc

HEADERS += \
    src/manager.h
