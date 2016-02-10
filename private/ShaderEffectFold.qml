import QtQuick 2.0

/* Source code from: http://transitions.glsl.io/
 * http://transitions.glsl.io/transition/f6fc39f4cfcbb97f96a6 by nwoeanhinnogaehr
 */

ShaderEffect {
    anchors.fill: parent

    property variant srcSampler: textureSource
    property variant dstSampler: textureDestination

    property real progress: 0.0
    property bool forward: true

    fragmentShader: "
uniform sampler2D srcSampler;
uniform sampler2D dstSampler;
uniform float progress;
uniform bool forward;

varying highp vec2 qt_TexCoord0;

void main() {
    if( forward ) {
        vec4 a = texture2D(srcSampler, qt_TexCoord0 / vec2(1.0-progress, 1.0));
        vec4 b = texture2D(dstSampler, (qt_TexCoord0 - vec2(1.0-progress, 0.0)) / vec2(progress, 1.0));
        gl_FragColor = mix(a, b, step(1.0-qt_TexCoord0.x, progress));
    } else {
        vec4 a = texture2D(srcSampler, (qt_TexCoord0 - vec2(progress, 0.0)) / vec2(1.0-progress, 1.0));
        vec4 b = texture2D(dstSampler, qt_TexCoord0 / vec2(progress, 1.0));
        gl_FragColor = mix(a, b, step(qt_TexCoord0.x, progress));
    }
}
"

}

