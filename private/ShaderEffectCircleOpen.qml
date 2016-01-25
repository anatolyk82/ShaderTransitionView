import QtQuick 2.0

//Source code from: http://transitions.glsl.io/

ShaderEffect {
    anchors.fill: parent

    property variant srcSampler: textureSource
    property variant dstSampler: textureDestination

    property bool forward: true
    property real smoothness: 0.3

    property real progress: 0.0

    fragmentShader: "
uniform sampler2D srcSampler;
uniform sampler2D dstSampler;
uniform float progress;

const vec2 center = vec2(0.5, 0.5);
const float SQRT_2 = 1.414213562373;

uniform float smoothness;
uniform bool forward;

varying highp vec2 qt_TexCoord0;

void main() {
  float x = forward ? progress : 1.-progress;
  float m = smoothstep(-smoothness, 0.0, SQRT_2*distance(center, qt_TexCoord0) - x*(1.+smoothness));
  gl_FragColor = mix(texture2D(srcSampler, qt_TexCoord0), texture2D(dstSampler, qt_TexCoord0), forward ? 1.-m : m);
}
"

}

