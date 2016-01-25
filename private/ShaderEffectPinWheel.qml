import QtQuick 2.0

//Source code from: http://transitions.glsl.io/

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
    float circPos = atan(forward ? (qt_TexCoord0.x - 0.5) : (qt_TexCoord0.y - 0.5),
                         forward ? (qt_TexCoord0.y - 0.5) : (qt_TexCoord0.x - 0.5)) + progress;
    float modPos = mod(circPos, 3.1415 / 4.);
    float signed = sign((+progress) - modPos);
    float smoothed = smoothstep(0., 1., signed);

    if (smoothed > 0.5) {
        gl_FragColor = texture2D(dstSampler, qt_TexCoord0);
    } else {
        gl_FragColor = texture2D(srcSampler, qt_TexCoord0);
    }
}
"

}

