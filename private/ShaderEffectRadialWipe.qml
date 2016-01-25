import QtQuick 2.0

//Source code from: http://transitions.glsl.io/

ShaderEffect {
    anchors.fill: parent

    property variant srcSampler: textureSource
    property variant dstSampler: textureDestination

    property bool forward: true //clockwise

    property real progress: 0.0

    fragmentShader: "
uniform sampler2D srcSampler;
uniform sampler2D dstSampler;
uniform float progress;
uniform bool forward;

varying highp vec2 qt_TexCoord0;
const float PI = 3.141592653589;

void main() {
  vec2 rp = qt_TexCoord0*2.0 - 1.0;
  float a = atan(rp.x, rp.y);

  float pa = forward ? 1.75*PI-progress*PI*2.5 : progress*PI*2.5-PI*1.25;
  vec4 fromColor = texture2D(srcSampler, qt_TexCoord0);
  vec4 toColor = texture2D(dstSampler, qt_TexCoord0);

  if( (a<pa)&&(forward == true) ) {
    gl_FragColor = mix(toColor, fromColor, smoothstep(0.0, 1.0, (pa-a)));
  } else if( (a>pa)&&(forward == false) ) {
    gl_FragColor = mix(toColor, fromColor, smoothstep(0.0, 1.0, (a-pa)));
  } else {
    gl_FragColor = toColor;
  }
}
"

}

