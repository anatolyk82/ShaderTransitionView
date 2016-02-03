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
    const float translateX = 0.0;
    float translateY = forward ? -1.0 : 1.0;

    float x = progress * translateX;
    float y = progress * translateY;

    if (x >= 0.0 && y >= 0.0) {
        if (qt_TexCoord0.x >= x && qt_TexCoord0.y >= y) {
            gl_FragColor = texture2D(srcSampler, qt_TexCoord0 - vec2(x, y));
        }
        else {
            vec2 uv;
            if (x > 0.0)
                uv = vec2(x - 1.0, y);
            else if (y > 0.0)
                uv = vec2(x, y - 1.0);
            gl_FragColor = texture2D(dstSampler, qt_TexCoord0 - uv);
        }
    }
    else if (x <= 0.0 && y <= 0.0) {
        if (qt_TexCoord0.x <= (1.0 + x) && qt_TexCoord0.y <= (1.0 + y))
            gl_FragColor = texture2D(srcSampler, qt_TexCoord0 - vec2(x, y));
        else {
            vec2 uv;
            if (x < 0.0)
                uv = vec2(x + 1.0, y);
            else if (y < 0.0)
                uv = vec2(x, y + 1.0);
            gl_FragColor = texture2D(dstSampler, qt_TexCoord0 - uv);
        }
    }
    else
        gl_FragColor = vec4(0.0);
}
"

}

