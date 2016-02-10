import QtQuick 2.0

/* Source code from: http://transitions.glsl.io/
 * http://transitions.glsl.io/transition/80c2d40cac3f98453176 by gre
 */

ShaderEffect {
    anchors.fill: parent

    property variant srcSampler: textureSource
    property variant dstSampler: textureDestination

    property real intensity: 0.3

    property real progress: 0.0

    fragmentShader: "
uniform sampler2D srcSampler;
uniform sampler2D dstSampler;
uniform float progress;

uniform float intensity;
const int passes = 6;

varying highp vec2 qt_TexCoord0;

void main() {
    vec4 c1 = vec4(0.0);
    vec4 c2 = vec4(0.0);

    float disp = intensity*(0.5-distance(0.5, progress));
    for (int xi=0; xi<passes; xi++)
    {
        float x = float(xi) / float(passes) - 0.5;
        for (int yi=0; yi<passes; yi++)
        {
            float y = float(yi) / float(passes) - 0.5;
            vec2 v = vec2(x,y);
            float d = disp;
            c1 += texture2D(srcSampler, qt_TexCoord0 + d*v);
            c2 += texture2D(dstSampler, qt_TexCoord0 + d*v);
        }
    }
    c1 /= float(passes*passes);
    c2 /= float(passes*passes);
    gl_FragColor = mix(c1, c2, progress);
}
"

}

