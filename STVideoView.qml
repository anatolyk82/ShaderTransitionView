import QtQuick 2.0
import "private"
import QtMultimedia 5.5

import ShaderTransitionView 1.0

ShaderTransitionView {
    id: root

    property int duration: 1000
    property var itemList: []
    property int depth: 0
    property string currentItem: ""
    property var shaderEffectOptions: { "progress":0.0 }
    shaderEffect: ShaderTransitionView.EffectWIND

    property variant videoOutput: videoOutputCurrent
    property variant mediaPlayer: playerCurrent

    property bool __softChangingOfVolume: false


    property bool autoPlay: mediaPlayer.autoPlay


    function push( itemPath )
    {
        itemList.push( itemPath )
        currentItem = itemPath
        depth = itemList.length

        if( itemList.length > 1 ) {
            if( (itemList.length % 2) == 0 ) {
                playerNext.source = itemPath

                mediaPlayer = playerNext
                videoOutput = videoOutputNext
            } else {
                playerCurrent.source = itemPath

                mediaPlayer = playerCurrent
                videoOutput = videoOutputCurrent
            }

            loaderShaderEffect.setSource( __graphEffect(), shaderEffectOptions )
        } else {
            playerCurrent.source = itemPath

            mediaPlayer = playerCurrent
            videoOutput = videoOutputCurrent
        }
    }

    function pop()
    {
        if( itemList.length > 1 ) {
            itemList.pop()
            depth = itemList.length
            if( (itemList.length % 2) == 0 ) {
                playerNext.source = itemList[ (itemList.length-1) ]
                currentItem = playerNext.source

                mediaPlayer = playerNext
                videoOutput = videoOutputNext
            } else {
                playerCurrent.source = itemList[ (itemList.length-1) ]
                currentItem = playerCurrent.source

                mediaPlayer = playerCurrent
                videoOutput = videoOutputCurrent
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
                    playerNext.source = ""
                } else {
                    playerCurrent.source = ""
                }
                loaderShaderEffect.source = ""
                shaderEffectOptions = { "progress":0.0 }
                __softChangingOfVolume = false
            }
        }
    }


    //*******************************************************//
    MediaPlayer {
        id: playerCurrent
        autoPlay: true
        /*onStatusChanged: {
            if(status == MediaPlayer.NoMedia) {
                console.log("No media has been set.")
            } else if(status == MediaPlayer.InvalidMedia) {
                console.log("The media cannot be played.")
            }
        }
        onPlaybackStateChanged: {
            if( playbackState == MediaPlayer.PlayingState ) {
                console.log("CURRENT: playing")
            }
        }*/
        Behavior on volume { NumberAnimation { duration: __softChangingOfVolume ? root.duration : 0 } }
    }
    VideoOutput {
        id: videoOutputCurrent
        source: playerCurrent
        anchors.fill: parent
    }
    //*******************************************************//
    MediaPlayer {
        id: playerNext
        autoPlay: true
        /*onStatusChanged: {
            if(status == MediaPlayer.NoMedia) {
                console.log("No media has been set.")
            } else if(status == MediaPlayer.InvalidMedia) {
                console.log("The media cannot be played.")
            }
        }
        onPlaybackStateChanged: {
            if( playbackState == MediaPlayer.PlayingState ) {
                console.log("NEXT: playing")
            }
        }*/
        Behavior on volume { NumberAnimation { duration: __softChangingOfVolume ? root.duration : 0 } }
    }
    VideoOutput {
        id: videoOutputNext
        source: playerNext
        anchors.fill: parent
    }
    //*******************************************************//




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
            __softChangingOfVolume = true
            if( (itemList.length % 2) == 0 ) {
                textureSource.sourceItem = videoOutputCurrent
                textureDestination.sourceItem = videoOutputNext

                playerCurrent.volume = 0
                playerNext.volume = 1
            } else {
                textureSource.sourceItem = videoOutputNext
                textureDestination.sourceItem = videoOutputCurrent

                playerCurrent.volume = 1
                playerNext.volume = 0
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

