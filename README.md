### Shader Transition View

This is a small QML plugin which provides an easy way to apply different transitions between two QML views in your Qt/QML application.

To learn more about the project visit [wiki pages](https://github.com/anatolyk82/ShaderTransitionView/wiki).

 This short video can show some of those transitions.
[![ScreenShot](https://img-fotki.yandex.ru/get/68556/603575.21/0_d2fd4_2407de61_orig)](
https://youtu.be/rS-fmlKRQ3s)

 There is a demo application which shows how *ShaderTransitionView* actually works. The app can be found [here](https://github.com/anatolyk82/ShaderTransitionViewDemo).


### STView

**STView** is a QML element which provides a stack-based navigation model with different animation effects between two views.

Import statement: ```import ShaderTransitionView 1.0```

Properties:

* *int* **duration** - the property defines how long the animation lasts (milliseconds).
* *int* **depth** - the property defines the number of items currently pushed onto the stack.
* *string* **currentItem** - the property defines the current QML file. If the current view is a QML component it returns a string *ShaderTranstionView::component:N* where *N* is a number of a QML component in the stack.
* *Array* **transitionOptions** - a javascript array to set options for the current transition.
* *enum* **transition** - the property defines which shader effect will be applied for the next transition.
* *real* **progress** - it shows the progress of animation. The value changes from 0.0 to 1.0.
* *alias* **easing** - it specifies the easing curve used for the animation.

Methods:

* *void* **push(** *string* qmlfile **)** - it takes a path to a QML file as an argument which represents the next QML view and puts it into the stack. An animation will be applied to change the current view.
* *void* **pushItem(** *QQmlComponent* item **)** - it puts the next view represented as a QML component into the stack. An animation will be applied to change the current view.
* *void* **pop()** - it removes the last view from the stack. An animation will be applied to change the current view.
* *void* **clear()** - it removes all views from the stack.
* *void* **completeTransition()** - It immediately completes any transition.
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

**ShaderTransitionView.EffectVERTICALWIND**

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

Read [more](https://github.com/anatolyk82/ShaderTransitionView/wiki/EffectRADIALWIPE)...

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
* *bool* **forward** - the option defines a direction of animation which will be applied. The default value is *true*.
* *real* **reflection** - the option defines how intensively the reflection is. The default value is *0.4*.
* *real* **perspective** - the option defines how much the foreground view has a perspective effect when it's opening. The closer the value to zero the less the perspective effect is. The default value is *0.4*.
* *real* **depth** - the option defines how deep one goes away back replacing by the next one. The default value is *2*.

Read [more](https://github.com/anatolyk82/ShaderTransitionView/wiki/EffectDOORWAY)...

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

Read [more](https://github.com/anatolyk82/ShaderTransitionView/wiki/EffectPOLKADOTS)...

------------

**ShaderTransitionView.EffectSQUEEZE**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.

Read [more](https://github.com/anatolyk82/ShaderTransitionView/wiki/EffectSQUEEZE)...

------------

**ShaderTransitionView.EffectHORIZONTALSLIDE**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.

------------

**ShaderTransitionView.EffectVERTICALSLIDE**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.

------------

**ShaderTransitionView.EffectCROSSZOOM**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied.
* *real* **strength** - the option defines an intensity of this a zoom animation.

Read [more](https://github.com/anatolyk82/ShaderTransitionView/wiki/EffectCROSSZOOM)...

------------

**ShaderTransitionView.EffectSWIRL**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied. If it is *true* it twists clockwise.
* *real* **rotation** - the option defines how many turnovers will be applied.

Read [more](https://github.com/anatolyk82/ShaderTransitionView/wiki/EffectSWIRL)...

------------

**ShaderTransitionView.EffectLINEARBLUR**

Options:
* *real* **intensity** - the option defines the intensity of blur effect.

Read [more](https://github.com/anatolyk82/ShaderTransitionView/wiki/EffectLINEARBLUR)...

------------

**ShaderTransitionView.EffectSWAP**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied. The default value is *true*.
* *real* **reflection** - the option defines how intensively the reflection is. The default value is *0.4*.
* *real* **perspective** - the option defines how far one view turns back replacing by the next one. The default value is *0.2*.
* *real* **depth** - the option defines how deep one view moves back replacing by the next one. The default value is *3.0*.

Read [more](https://github.com/anatolyk82/ShaderTransitionView/wiki/EffectSWAP)...

------------

**ShaderTransitionView.EffectCROSSHATCH**

Options:
* *bool* **forward** - the option defines a direction of animation which will be applied. The default value is *true*.

Read [more](https://github.com/anatolyk82/ShaderTransitionView/wiki/EffectCROSSHATCH)...

------------


### How to use it

The video above shows that the content of QML pages can be various. It doesn't matter whether a QML page has maps or any interactive element such as Button or ListView for instance or maybe it's just a static picture.
Let's have a look how to use the plugin in QML:

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
        duration: 700
        transition: ShaderTransitionView.EffectFADECOLOR
        transitionOptions: { "color": Qt.vector3d(0.0, 0.0, 0.0) }
    }

    Component.onCompleted: {
        specialView.push( "PageExample1.qml" )
    }
}
```
We created a new window and filled it by *STView*. By calling the method *push(...)* in *Component.onCompleted* in such a way *specialView.push( "PageExample1.qml" )* we put a QML page *PageExample1.qml* into the stack so the page *PageExample1.qml* will be displayed when the window appears. Next time when we want to change the current view by the next one, we need to call the same method *push(...)* or we there is one more similar method *pushItem(...)* in *STView* which puts the next view represented as *QQmlComponent*.
Here is another example:

```QML
import QtQuick 2.5
import QtQuick.Window 2.2
import ShaderTransitionView 1.0

Window {
    visible: true
    width: 1000
    height: 600

    Component {
      id: componentPage2
      MyPage2 {
        id: myPage2
        onBackPressed: {
          stView.transitionOptions = { "forward":false }
          stView.pop()
        }
        onNextPressed: {
          stView.transitionOptions = { "forward":true }
          stView.pushItem( componentPage3 )
        }
      }
    }

    Component {
      id: componentPage3
      MyPage3 {
        id: myPage3
        onBackPressed: {
          stView.transitionOptions = { "forward":false }
          stView.pop()
        }
      }
    }

    STView {
        id: stView
        anchors.fill: parent
        duration: 700
        transition: ShaderTransitionView.EffectWIND
        transitionOptions: { "size": 0.3 }
    }

    Component.onCompleted: {
        stView.push( "PageExample1.qml" )
    }
}
```
Here we have two additional pages *MyPage2{...}* and *MyPage3{...}* represented as QML components. They will be loaded when we call the method *pushItem(...)* If our pages emit signals *backPressed()* and *nextPressed()* we can define handlers and put/remove pages into/from the stack. This example also shows that we can put any different options for transition every time when we put or remove pages.
 For the button "Back" we can change direction of unfolding animation.
```QML
  stView.transitionOptions = { "forward":false }
  stView.pop()
```
The method *pop()* removes the current page from the stack and displays the previous one. If we want to go to the next page we will do very similar actions but instead removing a page from the stack we need to put it into the stack by calling *push(...)* or *pushItem(...)*.
```QML
  stView.transitionOptions = { "forward":true }
  stView.pushItem( componentPage3 )
```
Transitions and options for each transition can be changed during navigation through the stack.


### An experiment

Experimentally I made similar effects with video as a source. On the video below it's possible to see how it works.
[![ScreenShot](https://img-fotki.yandex.ru/get/68556/603575.21/0_d2fd4_2407de61_orig)](https://youtu.be/Sk99oeZu62g)
