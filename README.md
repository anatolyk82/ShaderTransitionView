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
Here *STView* is a QML element which provides stack-based navigation model with effects shown above. At this moment it has two methods *push()* and *pop()*. The method *push(...)* takes a string argument - path to a QML file which will be displayed as the next scene. The method *pop()* removes the last page from the stack and displays the previous one.


### STView

Properties:

* *int* **duration** - the property defines how long the animation lasts.
* *int* **depth** - the property defines the number of items currently pushed onto the stack..
* *string* **currentItem** - the property defines a path of the current QML file.
* *Array* **shaderEffectOptions** - a javascript array to set options for the current shader effect.
* *enum* **shaderEffect** - it defines which shader effects will be applied for the next transition.


Methods:

* *void* **push(** *string* qmlfile **)** - it puts the next view into the stack. An animation will be applied to change the current view.
* *void* **pop()** - it removes the last view from the stack. An animation will be applied to change the current view.
* *void* **clear()** - it removes all views from the stack.



### Transitions

**ShaderTransitionView.EffectWIND**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.
* *real* **size** - the option defines the size of transition zone during the animation between two views. This variable can take a value from 0.0 to 1.0


**ShaderTransitionView.EffectCIRCLEOPEN**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.
* *real* **smoothness** - the option defines how smoothly one view goes into the other during the animation. This variable can take a value from 0.0 to 1.0


**ShaderTransitionView.EffectPINWHEEL**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.


**ShaderTransitionView.EffectDIRECTIONALWIPE**

Options:
* *real* **smoothness** -
* *vector2d* **direction** -


**ShaderTransitionView.EffectRADIALWIPE**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.



**ShaderTransitionView.EffectPIXELIZE**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.
* *real* **blocksize** -


**ShaderTransitionView.EffectFLIP**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.


**ShaderTransitionView.EffectFOLD**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.


**ShaderTransitionView.EffectDOORWAY**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.
* *real* **reflection** -
* *real* **perspective** -
* *real* **depth** -


**ShaderTransitionView.EffectFADECOLOR**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.
* *real* **colorPhase** -
* *vector3d* **color** -


**ShaderTransitionView.EffectMORPH**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.
* *real* **strength** -


**ShaderTransitionView.EffectPOLKADOTS**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.
* *real* **dots** -

**ShaderTransitionView.EffectSQUEEZE**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.
