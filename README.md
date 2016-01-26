### Shader Transition View

This is a small QML plugin which provides an easy way to apply different transitions between two QML views in your Qt/QML application.

 This short video can show some of those transitions.
[![ScreenShot](https://img-fotki.yandex.ru/get/45245/603575.21/0_d2efe_bfe3bcf_orig)](
https://youtu.be/oHp6sP0mv0o)

It also shows that the content of QML pages can be various. It doesn't matter whether a QML page has maps or any interactive element such Buttons or ListView for instance or maybe it's just a static picture.
 The plugin is very simple in use. Let's have a look how to do it on a small example:

```QML
import QtQuick 2.5
import QtQuick.Window 2.2
import ShaderTransitionView 1.0

Window {
    visible: true
    width: 1000
    height: 600

    STView {
        id: view
        anchors.fill: parent
        shaderEffect: ShaderTransitionView.EffectFADECOLOR
        shaderEffectOptions: { "color": Qt.vector3d(0.0, 0.0, 0.0) }
    }

    Component.onCompleted: {
        specialView.push( "PageExample1.qml" )
    }
}
```
Here *ShaderTransitionView* is a QML element which provides stack-based navigation model with effects shown above. At this moment it has two methods *push()* and *pop()*. The method *push(...)* takes a string argument - path to a QML file which will be displayed as the next scene. The method *pop()* removes the last page from the stack and displays the previous one.
