import QtQuick 2.0

/*
 * Source code from: http://transitions.glsl.io/
 * http://transitions.glsl.io/transition/2a3f2e907e1c0a152e60 by gre
 */

ShaderEffect {
    anchors.fill: parent

    property variant srcSampler: textureSource
    property variant dstSampler: textureDestination

    property real progress: 0.0
    property real reflection: 0.4
    property real perspective: 0.2
    property real depth: 3

    property bool forward: true

    fragmentShader: "
uniform sampler2D srcSampler;
uniform sampler2D dstSampler;
uniform float progress;

varying highp vec2 qt_TexCoord0;

const vec4 black = vec4(0.0, 0.0, 0.0, 1.0);
const vec2 boundMin = vec2(0.0, 0.0);
const vec2 boundMax = vec2(1.0, 1.0);

uniform float reflection;
uniform float perspective;
uniform float depth;
uniform bool forward;


bool inBounds (vec2 p) {
  return all(lessThan(boundMin, p)) && all(lessThan(p, boundMax));
}

vec2 project (vec2 p) {
  return p * vec2( 1.0, 2.0-p.y ) + vec2(0.0, 0.001) ;
}

vec4 bgColor (vec2 from, vec2 to) {
  vec4 c = black;
  from = project(from);
  if (inBounds(from)) {
    c += mix(black, texture2D(srcSampler, from), reflection * mix(1.0, 0.0, 1.0-from.y));
  }
  to = project(to);
  if (inBounds(to)) {
    c += mix(black, texture2D(dstSampler, to), reflection * mix(1.0, 0.0, 1.0-to.y));
  }
  return c;
}


void main() {

  vec2 pfr = vec2(-1.0, -1.0);
  vec2 pto = vec2(-1.0, -1.0);
  float pr = forward ? progress : (1.0-progress);

  float size = mix(1.0, depth, pr);
  float persp = perspective * pr;
  pfr = (qt_TexCoord0 + vec2(-0.0, -0.5)) * vec2(size/(1.0-perspective*pr), size/(1.0-size*persp*qt_TexCoord0.x)) + vec2(0.0, 0.5);

  size = mix(1.0, depth, 1.0-pr);
  persp = perspective * (1.0-pr);
  pto = (qt_TexCoord0 + vec2(-1.0, -0.5)) * vec2(size/(1.0-perspective*(1.0-pr)), size/(1.0-size*persp*(0.5-qt_TexCoord0.x))) + vec2(1.0, 0.5);

  bool fromOver = pr < 0.5;

  if (fromOver)
  {
    if (inBounds(pfr)) {
      gl_FragColor = forward ? texture2D( srcSampler, pfr) : texture2D( dstSampler, pfr);
    } else if (inBounds(pto)) {
      gl_FragColor = forward ? texture2D(dstSampler, pto) : texture2D( srcSampler, pto);
    } else {
      gl_FragColor = bgColor(pfr, pto);
    }
  }
  else
  {
    if (inBounds(pto)) {
      gl_FragColor = forward ? texture2D(dstSampler, pto) : texture2D(srcSampler, pto);
    } else if (inBounds(pfr)) {
      gl_FragColor = forward ? texture2D(srcSampler, pfr) : texture2D(dstSampler, pfr);
    } else {
      gl_FragColor = bgColor(pfr, pto);
    }
  }
}
"

}

