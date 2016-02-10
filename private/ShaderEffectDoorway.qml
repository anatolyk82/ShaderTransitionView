import QtQuick 2.0

/*
 * Source code from: http://transitions.glsl.io/
 * http://transitions.glsl.io/transition/979934722820b5e715fa by gre
 */

ShaderEffect {
    anchors.fill: parent

    property variant srcSampler: textureSource
    property variant dstSampler: textureDestination

    property real progress: 0.0
    property real reflection: 0.4
    property real perspective: 0.4
    property real depth: 2

    fragmentShader: "
uniform sampler2D srcSampler;
uniform sampler2D dstSampler;
uniform float progress;
uniform bool forward;

varying highp vec2 qt_TexCoord0;

const vec4 black = vec4(0.0, 0.0, 0.0, 1.0);
const vec2 boundMin = vec2(0.0, 0.0);
const vec2 boundMax = vec2(1.0, 1.0);

uniform float reflection;
uniform float perspective;
uniform float depth;

bool inBounds (vec2 p) {
  return all(lessThan(boundMin, p)) && all(lessThan(p, boundMax));
}

vec2 project (vec2 p) {
  return p * vec2(1.0, -1.2) + vec2(0.0, -0.02);
}

vec4 bgColor (vec2 p, vec2 pto) {
  vec4 c = black;
  pto = project(pto);
  if (inBounds(pto)) {
    c += mix(black, texture2D(dstSampler, pto), reflection * mix(1.0, 0.0, pto.y));
  }
  return c;
}


void main() {

    vec2 pfr = vec2(-1.), pto = vec2(-1.);

    float middleSlit = 2.0 * abs(qt_TexCoord0.x-0.5) - progress;
    if (middleSlit > 0.0) {
        pfr = qt_TexCoord0 + (qt_TexCoord0.x > 0.5 ? -1.0 : 1.0) * vec2(0.5*progress, 0.0);
        float d = 1.0/(1.0+perspective*progress*(1.0-middleSlit));
        pfr.y -= d/2.;
        pfr.y *= d;
        pfr.y += d/2.;
    }

    float size = mix(1.0, depth, 1.-progress);
    pto = (qt_TexCoord0 + vec2(-0.5, -0.5)) * vec2(size, size) + vec2(0.5, 0.5);

    if (inBounds(pfr)) {
        gl_FragColor = texture2D(srcSampler, pfr);
    }
    else if (inBounds(pto)) {
        gl_FragColor = texture2D(dstSampler, pto);
    }
    else {
        gl_FragColor = bgColor(qt_TexCoord0, pto);
    }
}
"

}

