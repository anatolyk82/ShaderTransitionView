### Shader Transition View

This is a small QML plugin which provides an easy way to apply different transitions between two QML views in your Qt/QML application.

 This short video can show some of those transitions.
[![ScreenShot](https://img-fotki.yandex.ru/get/68556/603575.21/0_d2fd4_2407de61_orig)](
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

**STView** is a QML element which provides a stack-based navigation model with different animation effects between two views.

Properties:

* *int* **duration** - the property defines how long the animation lasts (milliseconds).
* *int* **depth** - the property defines the number of items currently pushed onto the stack.
* *string* **currentItem** - the property defines the current QML file.
* *Array* **shaderEffectOptions** - a javascript array to set options for the current transition.
* *enum* **shaderEffect** - the property defines which shader effect will be applied for the next transition.
* *real* **progress** - it shows the progress of animation. The value changes from 0.0 to 1.0.
* *alias* **easing** - it specifies the easing curve used for the animation.

Methods:

* *void* **push(** *string* qmlfile **)** - it takes a path to a QML file as an argument which represents the next QML view and puts it into the stack. An animation will be applied to change the current view.
* *void* **pushItem(** *QQmlComponent* item **)** - it puts the next view represented as a QML component into the stack. An animation will be applied to change the current view.
* *void* **pop()** - it removes the last view from the stack. An animation will be applied to change the current view.
* *void* **clear()** - it removes all views from the stack.
* *void* **completeTransition()** - It mmmediately completes any transition.
* *TYPE* **top()** - it returns the stack's top item. If the top element is a path than *TYPE* is a string, otherwise it is *QQmlComponent*.

Signals:
* **animationStarted()** - this signal is emitted when the animation starts.
* **animationCompleted()** - this signal is emitted when the animation finishes.

### Transitions

**ShaderTransitionView.EffectWIND**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.
* *real* **size** - the option defines the size of transition zone during the animation between two views. This variable can take a value from 0.0 to 1.0

------------

**ShaderTransitionView.EffectCIRCLEOPEN**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.
* *real* **smoothness** - the option defines how smoothly one view goes into the other during the animation. This variable can take a value from 0.0 to 1.0

------------

**ShaderTransitionView.EffectPINWHEEL**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.

------------

**ShaderTransitionView.EffectDIRECTIONALWIPE**

Options:
* *real* **smoothness** - the option defines how smoothly one view goes into the other during the animation. This variable can take a value from 0.0 to 1.0
* *vector2d* **direction** - it is a 2D vector which defines a direction the animation. The origin is located at the top left side of the screen. For instance, if the **direction** is equal *Qt*.vector2d(1.0, -1.0), the animation goes for the left bottom side to top right side.

------------

**ShaderTransitionView.EffectRADIALWIPE**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.

------------


**ShaderTransitionView.EffectPIXELIZE**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.
* *real* **blocksize** - the option defines the size of one block. They appear randomly all over the first view replacing it by the next view.

------------

**ShaderTransitionView.EffectFLIP**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.

------------

**ShaderTransitionView.EffectFOLD**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.

------------

**ShaderTransitionView.EffectDOORWAY**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.
* *real* **reflection** -
* *real* **perspective** -
* *real* **depth** -

------------

**ShaderTransitionView.EffectFADECOLOR**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.
* *vector3d* **color** - the option defines which color overshadows one view replacing it by another. The option takes a 3D vector. Each component of the vector defines a color in RGB in range from 0.0 to 1.0. For instance *Qt*.vector3d( 1.0, 0.0, 0.0 ) defines a red color.
* *real* **colorPhase** - it defines an intensity of an overshadowing color. It can take values from 0.0 to 1.0.

------------

**ShaderTransitionView.EffectMORPH**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.
* *real* **strength** - the option defines an intensity of this animation.

------------

**ShaderTransitionView.EffectPOLKADOTS**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.
* *real* **dots** - the option defines how many expanding dots appear on the first view replacing it by the second one.

------------

**ShaderTransitionView.EffectSQUEEZE**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.

------------

**ShaderTransitionView.EffectHORIZONTALSLIDE**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.

------------

**ShaderTransitionView.EffectVERTICALSLIDE**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.

------------


### An experiment

Experimentally I made similar effects with video as a source. On the video below it's possible to see how it works.
[![ScreenShot](https://img-fotki.yandex.ru/get/68556/603575.21/0_d2fd4_2407de61_orig)](https://youtu.be/Sk99oeZu62g)
