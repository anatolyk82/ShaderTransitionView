import QtQuick 2.0

//Source code from: http://transitions.glsl.io/

ShaderEffect {
    anchors.fill: parent

    property variant srcSampler: textureSource
    property variant dstSampler: textureDestination

    property real progress: 0.0

    fragmentShader: "
uniform sampler2D srcSampler;
uniform sampler2D dstSampler;
uniform float progress;

varying highp vec2 qt_TexCoord0;

float rand(vec2 co) {
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
    vec2 p = qt_TexCoord0;
    vec2 q = qt_TexCoord0;
    p.x = (p.x - 0.5)/abs(progress - 0.5)*0.5 + 0.5;
    vec4 a = texture2D(srcSampler, p);
    vec4 b = texture2D(dstSampler, p);
    gl_FragColor = vec4(mix(a, b, step(0.5, progress)).rgb * step(abs(q.x - 0.5), abs(progress - 0.5)), 1.0);
}
"

}

