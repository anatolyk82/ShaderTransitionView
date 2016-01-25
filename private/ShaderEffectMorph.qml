import QtQuick 2.0

//Source code from: http://transitions.glsl.io/

ShaderEffect {
    anchors.fill: parent

    property variant srcSampler: textureSource
    property variant dstSampler: textureDestination

    property real progress: 0.0
    property real strength: 0.1
    property bool forward: true

    fragmentShader: "
uniform sampler2D srcSampler;
uniform sampler2D dstSampler;
uniform float progress;

uniform bool forward;
uniform float strength;

varying highp vec2 qt_TexCoord0;

void main() {
    vec4 ca = texture2D(srcSampler, qt_TexCoord0);
    vec4 cb = texture2D(dstSampler, qt_TexCoord0);

    vec2 oa = (((ca.rg+ca.b)*0.5)*2.0-1.0);
    vec2 ob = (((cb.rg+cb.b)*0.5)*2.0-1.0);
    vec2 oc = mix(oa,ob,0.5)*strength;

    float w0 = progress;
    float w1 = 1.0-w0;
    gl_FragColor = mix(texture2D(srcSampler, qt_TexCoord0+oc*w0), texture2D(dstSampler, qt_TexCoord0-oc*w1), progress);
}
"

}

