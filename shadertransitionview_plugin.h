#ifndef SHADERTRANSITIONVIEW_PLUGIN_H
#define SHADERTRANSITIONVIEW_PLUGIN_H

#include <QQmlExtensionPlugin>

class ShaderTransitionViewPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif // SHADERTRANSITIONVIEW_PLUGIN_H

