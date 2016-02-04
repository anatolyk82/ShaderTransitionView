import QtQuick 2.0

//Source code from: http://transitions.glsl.io/
/* http://transitions.glsl.io/transition/b86b90161503a0023231 */

ShaderEffect {
    anchors.fill: parent

    property variant srcSampler: textureSource
    property variant dstSampler: textureDestination

    property bool forward: true
    property real strength: 0.3

    property real progress: 0.0

    fragmentShader: "
uniform sampler2D srcSampler;
uniform sampler2D dstSampler;
uniform float progress;

const float PI = 3.141592653589793;

uniform float strength;
uniform bool forward;

varying highp vec2 qt_TexCoord0;

float Linear_ease(in float begin, in float change, in float duration, in float time) {
    return change * time / duration + begin;
}

float Exponential_easeInOut(in float begin, in float change, in float duration, in float time) {
    if (time == 0.0)
        return begin;
    else if (time == duration)
        return begin + change;
    time = time / (duration / 2.0);
    if (time < 1.0)
        return change / 2.0 * pow(2.0, 10.0 * (time - 1.0)) + begin;
    return change / 2.0 * (-pow(2.0, -10.0 * (time - 1.0)) + 2.0) + begin;
}

float Sinusoidal_easeInOut(in float begin, in float change, in float duration, in float time) {
    return -change / 2.0 * (cos(PI * time / duration) - 1.0) + begin;
}

/* random number between 0 and 1 */
float random(in vec3 scale, in float seed) {
    /* use the fragment position for randomness */
    return fract(sin(dot(gl_FragCoord.xyz + seed, scale)) * 43758.5453 + seed);
}

vec3 crossFade(in vec2 uv, in float dissolve) {
    if( forward ) {
        return mix(texture2D(srcSampler, uv).rgb, texture2D(dstSampler, uv).rgb, dissolve);
    } else {
        return mix(texture2D(dstSampler, uv).rgb, texture2D(srcSampler, uv).rgb, dissolve);
    }
}

void main() {
    float pr = forward ? progress : (1.0-progress);

    // Linear interpolate center across center half of the image
    vec2 center = vec2(Linear_ease(0.25, 0.5, 1.0, pr), 0.5);
    float dissolve = Exponential_easeInOut(0.0, 1.0, 1.0, pr);

    // Mirrored sinusoidal loop. 0->strength then strength->0
    float strength = Sinusoidal_easeInOut(0.0, strength, 0.5, pr);

    vec3 color = vec3(0.0);
    float total = 0.0;
    vec2 toCenter = center - qt_TexCoord0;

    /* randomize the lookup values to hide the fixed number of samples */
    float offset = random(vec3(12.9898, 78.233, 151.7182), 0.0);

    for (float t = 0.0; t <= 40.0; t++) {
        float percent = (t + offset) / 40.0;
        float weight = 4.0 * (percent - percent * percent);
        color += crossFade(qt_TexCoord0 + toCenter * percent * strength, dissolve) * weight;
        total += weight;
    }
    gl_FragColor = vec4(color / total, 1.0);
}
"

}

