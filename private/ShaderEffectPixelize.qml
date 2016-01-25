import QtQuick 2.0

//Source code from: http://transitions.glsl.io/

ShaderEffect {
    anchors.fill: parent

    property variant srcSampler: textureSource
    property variant dstSampler: textureDestination

    property real progress: 0.0
    property real blocksize: 55.0

    fragmentShader: "
uniform sampler2D srcSampler;
uniform sampler2D dstSampler;
uniform float progress;

uniform float blocksize;

varying highp vec2 qt_TexCoord0;

float rand(vec2 co) {
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
    float p = step(rand(floor(gl_FragCoord.xy/blocksize)), progress);
    gl_FragColor = mix(texture2D(srcSampler, qt_TexCoord0), texture2D(dstSampler, qt_TexCoord0), p);
}
"

}

