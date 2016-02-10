import QtQuick 2.0

/* Source code from: http://transitions.glsl.io/
 * http://transitions.glsl.io/transition/06450f79cab706705bf9 by bobylito
 */

ShaderEffect {
    anchors.fill: parent

    property variant srcSampler: textureSource
    property variant dstSampler: textureDestination
    property real progress: 0.0

    property bool forward: true
    property real dots: 5

    fragmentShader: "
uniform sampler2D srcSampler;
uniform sampler2D dstSampler;
uniform float progress;

uniform bool forward;
uniform float dots;

varying highp vec2 qt_TexCoord0;

const vec2 c = vec2(0.5, 0.5);

void main() {
    float p = forward ? progress : 1.0 - progress;
    bool nextImage = distance(fract(qt_TexCoord0 * dots), c) < p;

    vec4 to = texture2D( dstSampler, qt_TexCoord0);
    vec4 from = texture2D( srcSampler, qt_TexCoord0);

    if(nextImage) {
        gl_FragColor = forward ? to : from;
    } else {
        gl_FragColor = forward ? from : to;
    }
}
"

}

