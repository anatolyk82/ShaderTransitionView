import QtQuick 2.0

//Source code from: http://transitions.glsl.io/

ShaderEffect {
    anchors.fill: parent

    property variant srcSampler: textureSource
    property variant dstSampler: textureDestination

    property vector2d direction: Qt.vector2d(1.0, -1.0)
    property real smoothness: 0.3

    property real progress: 0.0

    fragmentShader: "
uniform sampler2D srcSampler;
uniform sampler2D dstSampler;
uniform float progress;

const vec2 center = vec2(0.5, 0.5);

uniform float smoothness;
uniform vec2 direction;

varying highp vec2 qt_TexCoord0;

void main() {
  vec2 v = normalize(direction);
  v /= abs(v.x)+abs(v.y);
  float d = v.x * center.x + v.y * center.y;
  float m = smoothstep(-smoothness, 0.0, v.x * qt_TexCoord0.x + v.y * qt_TexCoord0.y - (d-0.5+progress*(1.+smoothness)));
  gl_FragColor = mix(texture2D(dstSampler, qt_TexCoord0), texture2D(srcSampler, qt_TexCoord0), m);
}
"

}

