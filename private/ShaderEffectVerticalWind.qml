import QtQuick 2.0

/*
 * Source code from: http://transitions.glsl.io/
 * http://transitions.glsl.io/transition/7de3f4b9482d2b0bf7bb
 */

ShaderEffect {
    anchors.fill: parent

    property variant srcSampler: textureSource
    property variant dstSampler: textureDestination
    property real progress: 0.0

    property real size: 0.1
    property bool forward: true

    fragmentShader: "
uniform sampler2D srcSampler;
uniform sampler2D dstSampler;
uniform float progress;

uniform float size;
uniform bool forward;

float rand (vec2 co) {
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

varying highp vec2 qt_TexCoord0;

void main() {
    float r = rand(vec2(0, qt_TexCoord0.x));
    float m = smoothstep(0.0, -size, qt_TexCoord0.y*(1.0-size) + size*r - ((forward ? (1.0-progress) : progress ) * (1.0 + size)));
    gl_FragColor = mix(texture2D(srcSampler, qt_TexCoord0), texture2D(dstSampler, qt_TexCoord0), forward ? 1.0-m : m);
}
"

}

