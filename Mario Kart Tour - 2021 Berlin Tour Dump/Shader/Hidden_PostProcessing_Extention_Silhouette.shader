//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Extention/Silhouette" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 9998
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	float _RenderViewportScaleFactor;
attribute highp vec3 in_POSITION0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _DepthFactor;
uniform 	float _BaseDepth;
uniform 	float _SecondaryColorThreshold;
uniform lowp sampler2D _CameraDepthNormalsTexture;
varying highp vec2 vs_TEXCOORD1;
#define SV_TARGET0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
float u_xlat1;
float u_xlat2;
float u_xlat4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
float u_xlat6;
void main()
{
    u_xlat0.xy = vec2(0.200000003, 3.0) / vec2(_DepthFactor);
    u_xlat0.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat0.xy = sqrt(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat2 = u_xlat0.x + (-u_xlat0.y);
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat10_4.xy = texture2D(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy).zw;
    u_xlat4 = dot(u_xlat10_4.xy, vec2(1.0, 0.00392156886));
    u_xlat6 = (-u_xlat0.x) + u_xlat4;
    u_xlatb0 = u_xlat0.x<u_xlat4;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat6 + -1.0;
    u_xlat6 = (-u_xlat6) * u_xlat6 + 1.0;
    u_xlat6 = u_xlat6 * _DepthFactor;
    u_xlat6 = u_xlat6 * 0.100000001 + 0.200000003;
    u_xlat1 = u_xlat4 + -1.0;
    u_xlat1 = (-u_xlat1) * u_xlat1 + 1.0;
    u_xlat6 = (-_DepthFactor) * u_xlat1 + u_xlat6;
    u_xlat1 = u_xlat1 * _DepthFactor;
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat1;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat6 = (-u_xlat2) + u_xlat4;
    u_xlatb4 = u_xlat2<u_xlat4;
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat2 = 0.5 / u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat6 + 0.5;
    u_xlat2 = (-u_xlat0.x) + u_xlat2;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat4 * u_xlat2 + u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    SV_TARGET0.xz = u_xlat0.xx * vec2(vec2(_SecondaryColorThreshold, _SecondaryColorThreshold));
    SV_TARGET0.y = u_xlat0.x + _BaseDepth;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	float _RenderViewportScaleFactor;
attribute highp vec3 in_POSITION0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _DepthFactor;
uniform 	float _BaseDepth;
uniform 	float _SecondaryColorThreshold;
uniform lowp sampler2D _CameraDepthNormalsTexture;
varying highp vec2 vs_TEXCOORD1;
#define SV_TARGET0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
float u_xlat1;
float u_xlat2;
float u_xlat4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
float u_xlat6;
void main()
{
    u_xlat0.xy = vec2(0.200000003, 3.0) / vec2(_DepthFactor);
    u_xlat0.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat0.xy = sqrt(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat2 = u_xlat0.x + (-u_xlat0.y);
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat10_4.xy = texture2D(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy).zw;
    u_xlat4 = dot(u_xlat10_4.xy, vec2(1.0, 0.00392156886));
    u_xlat6 = (-u_xlat0.x) + u_xlat4;
    u_xlatb0 = u_xlat0.x<u_xlat4;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat6 + -1.0;
    u_xlat6 = (-u_xlat6) * u_xlat6 + 1.0;
    u_xlat6 = u_xlat6 * _DepthFactor;
    u_xlat6 = u_xlat6 * 0.100000001 + 0.200000003;
    u_xlat1 = u_xlat4 + -1.0;
    u_xlat1 = (-u_xlat1) * u_xlat1 + 1.0;
    u_xlat6 = (-_DepthFactor) * u_xlat1 + u_xlat6;
    u_xlat1 = u_xlat1 * _DepthFactor;
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat1;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat6 = (-u_xlat2) + u_xlat4;
    u_xlatb4 = u_xlat2<u_xlat4;
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat2 = 0.5 / u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat6 + 0.5;
    u_xlat2 = (-u_xlat0.x) + u_xlat2;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat4 * u_xlat2 + u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    SV_TARGET0.xz = u_xlat0.xx * vec2(vec2(_SecondaryColorThreshold, _SecondaryColorThreshold));
    SV_TARGET0.y = u_xlat0.x + _BaseDepth;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	float _RenderViewportScaleFactor;
attribute highp vec3 in_POSITION0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _DepthFactor;
uniform 	float _BaseDepth;
uniform 	float _SecondaryColorThreshold;
uniform lowp sampler2D _CameraDepthNormalsTexture;
varying highp vec2 vs_TEXCOORD1;
#define SV_TARGET0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
float u_xlat1;
float u_xlat2;
float u_xlat4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
float u_xlat6;
void main()
{
    u_xlat0.xy = vec2(0.200000003, 3.0) / vec2(_DepthFactor);
    u_xlat0.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat0.xy = sqrt(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat2 = u_xlat0.x + (-u_xlat0.y);
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat10_4.xy = texture2D(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy).zw;
    u_xlat4 = dot(u_xlat10_4.xy, vec2(1.0, 0.00392156886));
    u_xlat6 = (-u_xlat0.x) + u_xlat4;
    u_xlatb0 = u_xlat0.x<u_xlat4;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat6 + -1.0;
    u_xlat6 = (-u_xlat6) * u_xlat6 + 1.0;
    u_xlat6 = u_xlat6 * _DepthFactor;
    u_xlat6 = u_xlat6 * 0.100000001 + 0.200000003;
    u_xlat1 = u_xlat4 + -1.0;
    u_xlat1 = (-u_xlat1) * u_xlat1 + 1.0;
    u_xlat6 = (-_DepthFactor) * u_xlat1 + u_xlat6;
    u_xlat1 = u_xlat1 * _DepthFactor;
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat1;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat6 = (-u_xlat2) + u_xlat4;
    u_xlatb4 = u_xlat2<u_xlat4;
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat2 = 0.5 / u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat6 + 0.5;
    u_xlat2 = (-u_xlat0.x) + u_xlat2;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat4 * u_xlat2 + u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    SV_TARGET0.xz = u_xlat0.xx * vec2(vec2(_SecondaryColorThreshold, _SecondaryColorThreshold));
    SV_TARGET0.y = u_xlat0.x + _BaseDepth;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	float _DepthFactor;
uniform 	float _BaseDepth;
uniform 	float _SecondaryColorThreshold;
uniform mediump sampler2D _CameraDepthNormalsTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
bool u_xlatb0;
float u_xlat1;
float u_xlat2;
float u_xlat4;
mediump vec2 u_xlat16_4;
bool u_xlatb4;
float u_xlat6;
void main()
{
    u_xlat0.xy = vec2(0.200000003, 3.0) / vec2(_DepthFactor);
    u_xlat0.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat0.xy = sqrt(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat2 = u_xlat0.x + (-u_xlat0.y);
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat16_4.xy = texture(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy).zw;
    u_xlat4 = dot(u_xlat16_4.xy, vec2(1.0, 0.00392156886));
    u_xlat6 = (-u_xlat0.x) + u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat4);
#else
    u_xlatb0 = u_xlat0.x<u_xlat4;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat6 + -1.0;
    u_xlat6 = (-u_xlat6) * u_xlat6 + 1.0;
    u_xlat6 = u_xlat6 * _DepthFactor;
    u_xlat6 = u_xlat6 * 0.100000001 + 0.200000003;
    u_xlat1 = u_xlat4 + -1.0;
    u_xlat1 = (-u_xlat1) * u_xlat1 + 1.0;
    u_xlat6 = (-_DepthFactor) * u_xlat1 + u_xlat6;
    u_xlat1 = u_xlat1 * _DepthFactor;
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat2) + u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat2<u_xlat4);
#else
    u_xlatb4 = u_xlat2<u_xlat4;
#endif
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat2 = 0.5 / u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat6 + 0.5;
    u_xlat2 = (-u_xlat0.x) + u_xlat2;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat4 * u_xlat2 + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_TARGET0.xz = u_xlat0.xx * vec2(vec2(_SecondaryColorThreshold, _SecondaryColorThreshold));
    SV_TARGET0.y = u_xlat0.x + _BaseDepth;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	float _DepthFactor;
uniform 	float _BaseDepth;
uniform 	float _SecondaryColorThreshold;
uniform mediump sampler2D _CameraDepthNormalsTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
bool u_xlatb0;
float u_xlat1;
float u_xlat2;
float u_xlat4;
mediump vec2 u_xlat16_4;
bool u_xlatb4;
float u_xlat6;
void main()
{
    u_xlat0.xy = vec2(0.200000003, 3.0) / vec2(_DepthFactor);
    u_xlat0.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat0.xy = sqrt(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat2 = u_xlat0.x + (-u_xlat0.y);
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat16_4.xy = texture(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy).zw;
    u_xlat4 = dot(u_xlat16_4.xy, vec2(1.0, 0.00392156886));
    u_xlat6 = (-u_xlat0.x) + u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat4);
#else
    u_xlatb0 = u_xlat0.x<u_xlat4;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat6 + -1.0;
    u_xlat6 = (-u_xlat6) * u_xlat6 + 1.0;
    u_xlat6 = u_xlat6 * _DepthFactor;
    u_xlat6 = u_xlat6 * 0.100000001 + 0.200000003;
    u_xlat1 = u_xlat4 + -1.0;
    u_xlat1 = (-u_xlat1) * u_xlat1 + 1.0;
    u_xlat6 = (-_DepthFactor) * u_xlat1 + u_xlat6;
    u_xlat1 = u_xlat1 * _DepthFactor;
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat2) + u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat2<u_xlat4);
#else
    u_xlatb4 = u_xlat2<u_xlat4;
#endif
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat2 = 0.5 / u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat6 + 0.5;
    u_xlat2 = (-u_xlat0.x) + u_xlat2;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat4 * u_xlat2 + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_TARGET0.xz = u_xlat0.xx * vec2(vec2(_SecondaryColorThreshold, _SecondaryColorThreshold));
    SV_TARGET0.y = u_xlat0.x + _BaseDepth;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	float _DepthFactor;
uniform 	float _BaseDepth;
uniform 	float _SecondaryColorThreshold;
uniform mediump sampler2D _CameraDepthNormalsTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
bool u_xlatb0;
float u_xlat1;
float u_xlat2;
float u_xlat4;
mediump vec2 u_xlat16_4;
bool u_xlatb4;
float u_xlat6;
void main()
{
    u_xlat0.xy = vec2(0.200000003, 3.0) / vec2(_DepthFactor);
    u_xlat0.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat0.xy = sqrt(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat2 = u_xlat0.x + (-u_xlat0.y);
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat16_4.xy = texture(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy).zw;
    u_xlat4 = dot(u_xlat16_4.xy, vec2(1.0, 0.00392156886));
    u_xlat6 = (-u_xlat0.x) + u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat4);
#else
    u_xlatb0 = u_xlat0.x<u_xlat4;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat6 + -1.0;
    u_xlat6 = (-u_xlat6) * u_xlat6 + 1.0;
    u_xlat6 = u_xlat6 * _DepthFactor;
    u_xlat6 = u_xlat6 * 0.100000001 + 0.200000003;
    u_xlat1 = u_xlat4 + -1.0;
    u_xlat1 = (-u_xlat1) * u_xlat1 + 1.0;
    u_xlat6 = (-_DepthFactor) * u_xlat1 + u_xlat6;
    u_xlat1 = u_xlat1 * _DepthFactor;
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat2) + u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat2<u_xlat4);
#else
    u_xlatb4 = u_xlat2<u_xlat4;
#endif
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat2 = 0.5 / u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat6 + 0.5;
    u_xlat2 = (-u_xlat0.x) + u_xlat2;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat4 * u_xlat2 + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_TARGET0.xz = u_xlat0.xx * vec2(vec2(_SecondaryColorThreshold, _SecondaryColorThreshold));
    SV_TARGET0.y = u_xlat0.x + _BaseDepth;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
}
}
}
}