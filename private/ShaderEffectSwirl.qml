import QtQuick 2.0

//Source code: http://transitions.glsl.io/transition/cacfedb8cca0f5ce3f7c
/*
  (C) Sergey Kosarevsky, 2014
  Available under the terms of MIT license
  http://www.linderdaum.com
*/


ShaderEffect {
    anchors.fill: parent

    property variant srcSampler: textureSource
    property variant dstSampler: textureDestination

    property bool forward: true //clockwise
    property real rotation: 3.0

    property real progress: 0.0

    fragmentShader: "
uniform sampler2D srcSampler;
uniform sampler2D dstSampler;
uniform float progress;

uniform bool forward;
uniform float rotation;

varying highp vec2 qt_TexCoord0;
const float PI = 3.141592653589;

void main() {
    float radius = 1.0;

    vec2 texCoord = qt_TexCoord0 - vec2( 0.5, 0.5 );
    float dist = length(texCoord);
    float direction = forward ? -1.0 : 1.0;

    if ( dist < radius )
    {
        float percent = (radius - dist) / radius;
        float A = ( progress <= 0.5 ) ? mix( 0.0, 1.0, progress/0.5 ) : mix( 1.0, 0.0, (progress-0.5)/0.5 );
        float theta = direction * percent * percent * A * rotation * PI;
        float S = sin( theta );
        float C = cos( theta );
        texCoord = vec2( dot(texCoord, vec2(C, -S)), dot(texCoord, vec2(S, C)) );
    }
    texCoord += vec2( 0.5, 0.5 );

    vec4 C0 = texture2D( srcSampler, texCoord );
    vec4 C1 = texture2D( dstSampler, texCoord );

    gl_FragColor = mix( C0, C1, progress );
}
"

}
