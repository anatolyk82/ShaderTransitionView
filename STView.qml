import QtQuick 2.0
import "private"

import ShaderTransitionView 1.0

ShaderTransitionView {
    id: root

    property int duration: 1000
    property var itemList: []
    property int depth: 0
    property string currentItem: ""
    property var transitionOptions: { "progress":0.0 }
    transition: ShaderTransitionView.EffectWIND

    signal animationStarted();
    signal animationCompleted();

    property real progress: 0.0
    property alias easing: animProperty.easing

    /*onDepthChanged: {
        console.log("["+itemList + "]:" + depth)
    }*/

    function push( itemPath )
    {
        itemList.push( itemPath )
        currentItem = itemPath
        depth = itemList.length

        if( itemList.length > 1 ) {
            if( (itemList.length % 2) == 0 ) {
                loaderNextItem.source = itemPath
            } else {
                loaderCurrentItem.source = itemPath
            }

            loaderShaderEffect.setSource( __graphEffect(), transitionOptions )
        } else {
            loaderCurrentItem.source = itemPath
        }
    }

    function pop()
    {
        if( itemList.length > 1 ) {
            itemList.pop()
            depth = itemList.length

            var lastElement = itemList[ (itemList.length-1) ]
            if( lastElement.indexOf("ShaderTransitionView::component:") == 0 )
            {
                var item = topQQuickItem()
                if( lengthQQuickStack() > 1 ) {
                    item = popQQuickItem()
                }

                if( (itemList.length % 2) == 0 ) {
                    loaderNextItem.sourceComponent = item
                } else {
                    loaderCurrentItem.sourceComponent = item
                }
            }
            else
            {
                if( (itemList.length % 2) == 0 ) {
                    loaderNextItem.source = itemList[ (itemList.length-1) ]
                    currentItem = loaderNextItem.source
                    //console.log("(pop) l="+itemList.length + " [" + itemList + "] use NEXT")
                } else {
                    loaderCurrentItem.source = itemList[ (itemList.length-1) ]
                    currentItem = loaderCurrentItem.source
                    //console.log("(pop) l="+itemList.length + " [" + itemList + "] use CURR")
                }
            }
            loaderShaderEffect.setSource( __graphEffect(), transitionOptions )
        }
    }

    function clear()
    {
        clearQQuickStack()
        itemList.splice( 0, itemList.length )
        depth = itemList.length
    }

    function top()
    {
        var lastElement = itemList[ (itemList.length-1) ]
        if( lastElement.indexOf("ShaderTransitionView::component:") == 0 )
        {
            return topQQuickItem()
        }
        else
        {
            return lastElement
        }
    }

    function pushItem( item )
    {
        var cmp = "ShaderTransitionView::component:" + lengthQQuickStack()
        pushQQuickItem( item )
        itemList.push( cmp )

        currentItem = cmp
        depth = itemList.length

        if( itemList.length > 1 ) {
            if( (itemList.length % 2) == 0 ) {
                loaderNextItem.sourceComponent = item
            } else {
                loaderCurrentItem.sourceComponent = item
            }

            loaderShaderEffect.setSource( __graphEffect(), transitionOptions )
        } else {
            loaderCurrentItem.sourceComponent = item
        }
    }

    function completeTransition()
    {
        animProgress.running = false
        root.progress = 1.0
    }

    function __get( index )
    {
        var item = ""

        if( (index < itemList.length) && (index >= 0) )
        {
            item = itemList[ index ]
            currentItem = item

            itemList.splice( index, 1 )
            depth = itemList.length

            if( item.indexOf("ShaderTransitionView::component:") == 0 )
            {
                var indxInsideStack = item.split(":")[3]
                console.log("indxInsideStack="+indxInsideStack)
                /*if( (itemList.length % 2) == 0 ) {
                    loaderNextItem.sourceComponent = getQQuickItem(indxInsideStack)
                } else {
                    loaderCurrentItem.sourceComponent = getQQuickItem(indxInsideStack)
                }*/
            }
            else
            {
                /*if( (itemList.length % 2) == 0 ) {
                    loaderNextItem.source = item
                } else {
                    loaderCurrentItem.source = item
                }*/
            }
        }

        return item
    }

    function __graphEffect()
    {
        var retFile = "private/ShaderEffectWind.qml"
        if( transition == ShaderTransitionView.EffectWIND ) {
            retFile = "private/ShaderEffectWind.qml"
        } else if (  transition == ShaderTransitionView.EffectVERTICALWIND ) {
            retFile = "private/ShaderEffectVerticalWind.qml"
        } else if (  transition == ShaderTransitionView.EffectPINWHEEL ) {
            retFile = "private/ShaderEffectPinWheel.qml"
        } else if (  transition == ShaderTransitionView.EffectCIRCLEOPEN ) {
            retFile = "private/ShaderEffectCircleOpen.qml"
        } else if (  transition == ShaderTransitionView.EffectDIRECTIONALWIPE ) {
            retFile = "private/ShaderEffectDirectionalWipe.qml"
        } else if (  transition == ShaderTransitionView.EffectRADIALWIPE ) {
            retFile = "private/ShaderEffectRadialWipe.qml"
        } else if (  transition == ShaderTransitionView.EffectPIXELIZE ) {
            retFile = "private/ShaderEffectPixelize.qml"
        } else if (  transition == ShaderTransitionView.EffectFLIP ) {
            retFile = "private/ShaderEffectFlip.qml"
        } else if (  transition == ShaderTransitionView.EffectFOLD ) {
            retFile = "private/ShaderEffectFold.qml"
        } else if (  transition == ShaderTransitionView.EffectDOORWAY ) {
            retFile = "private/ShaderEffectDoorway.qml"
        } else if (  transition == ShaderTransitionView.EffectFADECOLOR ) {
            retFile = "private/ShaderEffectFadeColor.qml"
        } else if (  transition == ShaderTransitionView.EffectMORPH ) {
            retFile = "private/ShaderEffectMorph.qml"
        } else if (  transition == ShaderTransitionView.EffectPOLKADOTS ) {
            retFile = "private/ShaderEffectPolkaDots.qml"
        } else if (  transition == ShaderTransitionView.EffectSQUEEZE ) {
            retFile = "private/ShaderEffectSqueeze.qml"
        } else if (  transition == ShaderTransitionView.EffectHORIZONTALSLIDE ) {
            retFile = "private/ShaderEffectHorizontalSlide.qml"
        } else if (  transition == ShaderTransitionView.EffectVERTICALSLIDE ) {
            retFile = "private/ShaderEffectVerticalSlide.qml"
        } else if (  transition == ShaderTransitionView.EffectCROSSZOOM ) {
            retFile = "private/ShaderEffectCrossZoom.qml"
        } else if (  transition == ShaderTransitionView.EffectSWIRL ) {
            retFile = "private/ShaderEffectSwirl.qml"
        } else if (  transition == ShaderTransitionView.EffectLINEARBLUR ) {
            retFile = "private/ShaderEffectLinearBlur.qml"
        } else if (  transition == ShaderTransitionView.EffectSWAP ) {
            retFile = "private/ShaderEffectSwap.qml"
        } else if (  transition == ShaderTransitionView.EffectCROSSHATCH ) {
            retFile = "private/ShaderEffectCrossHatch.qml"
        }
        return retFile
    }


    SequentialAnimation on progress {
        id: animProgress
        running: false
        ScriptAction {
            script: {
                root.animationStarted()
            }
        }
        PropertyAnimation {
            id: animProperty
            from: 0.0
            to: 1.0
            duration: root.duration
        }
        ScriptAction {
            script: {
                if( (itemList.length % 2) ) {
                    loaderNextItem.source = ""
                    loaderNextItem.sourceComponent = undefined
                    //console.log("(clear NEXT) l="+itemList.length)
                } else {
                    loaderCurrentItem.source = ""
                    loaderCurrentItem.sourceComponent = undefined
                    //console.log("(clear CURR) l="+itemList.length)
                }
                loaderShaderEffect.source = ""
                transitionOptions = { "progress":0.0 }

                root.animationCompleted()
            }
        }
    }


    Loader {
        id: loaderCurrentItem
        anchors.fill: parent
    }
    Loader {
        id: loaderNextItem
        anchors.fill: parent
    }



    ShaderEffectSource {
        id: textureSource
        hideSource: false
    }

    ShaderEffectSource {
        id: textureDestination
        hideSource: false
    }

    Loader {
        id: loaderShaderEffect
        anchors.fill: parent
        onLoaded: {
            if( (itemList.length % 2) == 0 ) {
                textureSource.sourceItem = loaderCurrentItem.item
                textureDestination.sourceItem = loaderNextItem.item
                //console.log("(shader) l="+itemList.length + " from CURR to NEXT")
            } else {
                textureSource.sourceItem = loaderNextItem.item
                textureDestination.sourceItem = loaderCurrentItem.item
                //console.log("(shader) l="+itemList.length + " from NEXT to CURR")
            }
            item.srcSampler = textureSource
            item.dstSampler = textureDestination

            root.progress = 0.0
            animProgress.restart()
        }
    }

    Binding {
        target: loaderShaderEffect.item
        property: "progress"
        value: root.progress
    }
}

