TEMPLATE = lib
TARGET = ShaderTransitionView
QT += qml quick
CONFIG += qt plugin c++11

TARGET = $$qtLibraryTarget($$TARGET)
uri = ShaderTransitionView

# Input
SOURCES += \
    shadertransitionview_plugin.cpp \
    shadertransitionview.cpp

HEADERS += \
    shadertransitionview_plugin.h \
    shadertransitionview.h

PLUGIN_PRIVATE = private/ShaderEffectCircleOpen.qml \
    private/ShaderEffectDirectionalWipe.qml \
    private/ShaderEffectDoorway.qml \
    private/ShaderEffectFadeColor.qml \
    private/ShaderEffectFlip.qml \
    private/ShaderEffectFold.qml \
    private/ShaderEffectMorph.qml \
    private/ShaderEffectPinWheel.qml \
    private/ShaderEffectPixelize.qml \
    private/ShaderEffectRadialWipe.qml \
    private/ShaderEffectWind.qml \
    private/ShaderEffectPolkaDots.qml \
    private/ShaderEffectSqueeze.qml \
    private/ShaderEffectHorizontalSlide.qml \
    private/ShaderEffectVerticalSlide.qml \
    private/ShaderEffectCrossZoom.qml \
    private/ShaderEffectSwirl.qml \
    private/ShaderEffectVerticalWind.qml

DISTFILES = qmldir \
    STView.qml \
    $$PLUGIN_PRIVATE \
    README.md \
    STVideoView.qml

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = qmldir STView.qml STVideoView.qml
qmldir_private.files = $$PLUGIN_PRIVATE

unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    target.path = $$installPath
    qmldir_private.path = $$installPath/private
    INSTALLS += target qmldir qmldir_private
}

