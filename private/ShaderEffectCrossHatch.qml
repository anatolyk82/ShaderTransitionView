import QtQuick 2.0

/* Source code from: http://transitions.glsl.io/
 * http://transitions.glsl.io/transition/04fd9a7de4012cbb03f6 by pthrasher
 */

ShaderEffect {
    anchors.fill: parent

    property variant srcSampler: textureSource
    property variant dstSampler: textureDestination

    property bool forward: true

    property real progress: 0.0

    fragmentShader: "
uniform sampler2D srcSampler;
uniform sampler2D dstSampler;
uniform float progress;

uniform bool forward;

const vec2 center = vec2(0.5, 0.5);

float rand(vec2 co) {
  return fract(sin(dot(co.xy ,vec2(10.0,10.0))) * 10000.0);
}

varying highp vec2 qt_TexCoord0;

void main() {
    float x = forward ? progress : 1.0 - progress;
    float dist = distance(center, qt_TexCoord0);
    float r = x*1.7 - min(rand(vec2(qt_TexCoord0.y, 0.0)), rand(vec2(0.0, qt_TexCoord0.x)));
    float m = step(dist, r);
    vec4 v1 = forward ? texture2D(srcSampler, qt_TexCoord0) : texture2D(dstSampler, qt_TexCoord0);
    vec4 v2 = forward ? texture2D(dstSampler, qt_TexCoord0) : texture2D(srcSampler, qt_TexCoord0);
    gl_FragColor = mix(v1, v2, m);
}
"

}

