import QtQuick 2.0

//Source code from: http://transitions.glsl.io/

ShaderEffect {
    anchors.fill: parent

    property variant srcSampler: textureSource
    property variant dstSampler: textureDestination

    property real progress: 0.0
    property vector3d color: Qt.vector3d(0.0, 0.0, 0.0)
    property real colorPhase: 0.5

    fragmentShader: "
uniform sampler2D srcSampler;
uniform sampler2D dstSampler;
uniform float progress;
uniform bool forward;

uniform vec3 color;
uniform float colorPhase; // if 0.0, there is no black phase, if 0.9, the black phase is very important

varying highp vec2 qt_TexCoord0;

void main() {
    vec4 from = mix(vec4(color, 1.0), texture2D(srcSampler, qt_TexCoord0), smoothstep(1.0-colorPhase, 0.0, progress));
    vec4 to = mix(vec4(color, 1.0), texture2D(dstSampler, qt_TexCoord0), smoothstep( colorPhase, 1.0, progress));
    gl_FragColor = mix( from, to, progress );
}
"

}

