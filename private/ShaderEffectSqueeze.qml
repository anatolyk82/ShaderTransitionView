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

float progressY (float y) {
  return 0.5 + (y-0.5) / ( forward ? (1.0-progress) : progress);
}

varying highp vec2 qt_TexCoord0;

void main() {

    float y = progressY(qt_TexCoord0.y);

    if (y < 0.0 || y > 1.0) {
        if( forward ) {
            gl_FragColor = texture2D(dstSampler, qt_TexCoord0);
        } else {
            gl_FragColor = texture2D(srcSampler, qt_TexCoord0);
        }
    } else {
        vec2 fp = vec2(qt_TexCoord0.x, y);
        float r = 0.0;
        float g = 0.0;
        float b = 0.0;
        if( forward ) {
            r = texture2D(srcSampler, fp).r;
            g = texture2D(srcSampler, fp).g;
            b = texture2D(srcSampler, fp).b;
        } else {
            r = texture2D(dstSampler, fp).r;
            g = texture2D(dstSampler, fp).g;
            b = texture2D(dstSampler, fp).b;
        }
        gl_FragColor = vec4( r, g, b, 1.0 );
    }
}
"

}

