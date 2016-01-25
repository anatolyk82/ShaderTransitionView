#include "shadertransitionview_plugin.h"
#include "shadertransitionview.h"

#include <qqml.h>

void ShaderTransitionViewPlugin::registerTypes(const char *uri)
{
    // @uri ShaderTransitionView
    qmlRegisterType<ShaderTransitionView>(uri, 1, 0, "ShaderTransitionView");
}


