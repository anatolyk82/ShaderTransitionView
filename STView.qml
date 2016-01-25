import QtQuick 2.0
import "private"

import ShaderTransitionView 1.0

ShaderTransitionView {
    id: root

    property int duration: 1000
    property var itemList: []
    property int depth: 0
    property string currentItem: ""
    property var shaderEffectOptions: { "progress":0.0 }
    shaderEffect: ShaderTransitionView.EffectWIND

    function push( itemPath )
    {
        itemList.push( itemPath )
        currentItem = itemPath
        depth = itemList.length

        if( itemList.length > 1 ) {
            if( (itemList.length % 2) == 0 ) {
                loaderNextItem.source = itemPath
                //console.log("(push) l="+itemList.length + " [" + itemList + "] use NEXT")
            } else {
                loaderCurrentItem.source = itemPath
                //console.log("(push) l="+itemList.length + " [" + itemList + "] use CURR")
            }

            //loaderShaderEffect.source = shaderEffect
            loaderShaderEffect.setSource( __graphEffect(), shaderEffectOptions )
        } else {
            loaderCurrentItem.source = itemPath
            //console.log("(push) l="+itemList.length + " [" + itemList + "] use CURR")
        }
    }

    function pop()
    {
        if( itemList.length > 1 ) {
            itemList.pop()
            depth = itemList.length
            if( (itemList.length % 2) == 0 ) {
                loaderNextItem.source = itemList[ (itemList.length-1) ]
                currentItem = loaderNextItem.source
                //console.log("(pop) l="+itemList.length + " [" + itemList + "] use NEXT")
            } else {
                loaderCurrentItem.source = itemList[ (itemList.length-1) ]
                currentItem = loaderCurrentItem.source
                //console.log("(pop) l="+itemList.length + " [" + itemList + "] use CURR")
            }

            loaderShaderEffect.setSource( __graphEffect(), shaderEffectOptions )
        }
    }


    function clear()
    {
        itemList.splice( 0, itemList.length )
        depth = itemList.length
    }

    function __graphEffect()
    {
        var retFile = "private/ShaderEffectWind.qml"
        if( shaderEffect == ShaderTransitionView.EffectWIND ) {
            retFile = "private/ShaderEffectWind.qml"
        } else if (  shaderEffect == ShaderTransitionView.EffectPINWHEEL ) {
            retFile = "private/ShaderEffectPinWheel.qml"
        } else if (  shaderEffect == ShaderTransitionView.EffectCIRCLEOPEN ) {
            retFile = "private/ShaderEffectCircleOpen.qml"
        } else if (  shaderEffect == ShaderTransitionView.EffectDIRECTIONALWIPE ) {
            retFile = "private/ShaderEffectDirectionalWipe.qml"
        } else if (  shaderEffect == ShaderTransitionView.EffectRADIALWIPE ) {
            retFile = "private/ShaderEffectRadialWipe.qml"
        } else if (  shaderEffect == ShaderTransitionView.EffectPIXELIZE ) {
            retFile = "private/ShaderEffectPixelize.qml"
        } else if (  shaderEffect == ShaderTransitionView.EffectFLIP ) {
            retFile = "private/ShaderEffectFlip.qml"
        } else if (  shaderEffect == ShaderTransitionView.EffectFOLD ) {
            retFile = "private/ShaderEffectFold.qml"
        } else if (  shaderEffect == ShaderTransitionView.EffectDOORWAY ) {
            retFile = "private/ShaderEffectDoorway.qml"
        } else if (  shaderEffect == ShaderTransitionView.EffectFADECOLOR ) {
            retFile = "private/ShaderEffectFadeColor.qml"
        } else if (  shaderEffect == ShaderTransitionView.EffectMORPH ) {
            retFile = "private/ShaderEffectMorph.qml"
        } else if (  shaderEffect == ShaderTransitionView.EffectPOLKADOTS ) {
            retFile = "private/ShaderEffectPolkaDots.qml"
        } else if (  shaderEffect == ShaderTransitionView.EffectSQUEEZE ) {
            retFile = "private/ShaderEffectSqueeze.qml"
        }
        return retFile
    }


    property real progress: 0.0
    SequentialAnimation on progress {
        id: animProgress
        running: false
        ScriptAction {
            script: {
            }
        }
        PropertyAnimation {
            from: 0.0
            to: 1.0
            duration: root.duration
        }
        ScriptAction {
            script: {
                if( (itemList.length % 2) ) {
                    loaderNextItem.source = ""
                    //console.log("(clear NEXT) l="+itemList.length)
                } else {
                    loaderCurrentItem.source = ""
                    //console.log("(clear CURR) l="+itemList.length)
                }
                loaderShaderEffect.source = ""
                shaderEffectOptions = { "progress":0.0 }
            }
        }
    }


    Loader {
        id: loaderCurrentItem
        anchors.fill: parent
        onLoaded: {
            //console.log("(CURR) Loaded:"+source)
        }
    }
    Loader {
        id: loaderNextItem
        anchors.fill: parent
        onLoaded: {
            //console.log("(NEXT) Loaded:"+source)
        }
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

