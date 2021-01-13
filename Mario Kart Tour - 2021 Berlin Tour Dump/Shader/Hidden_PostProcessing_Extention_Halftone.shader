//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Extention/Halftone" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 21957
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
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _DotPatternRowColumnNumber;
uniform 	float _DarkeningFactor;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
float u_xlat4;
mediump float u_xlat16_4;
void main()
{
    u_xlat0.x = dot(vec2(0.707000017, -0.707000017), vs_TEXCOORD0.xy);
    u_xlat0.y = dot(vec2(0.707000017, 0.707000017), vs_TEXCOORD0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(_DotPatternRowColumnNumber);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat2.x = dFdx(u_xlat0.x);
    u_xlat4 = dFdy(u_xlat0.x);
    u_xlat2.x = abs(u_xlat4) + abs(u_xlat2.x);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4 = u_xlat10_1.y + u_xlat10_1.x;
    u_xlat16_4 = u_xlat10_1.z + u_xlat16_4;
    u_xlat16_4 = (-u_xlat16_4) * 0.333333343 + 1.0;
    u_xlat0.w = u_xlat16_4 * u_xlat16_4 + u_xlat2.x;
    u_xlat2.x = u_xlat16_4 * u_xlat16_4 + (-u_xlat2.x);
    u_xlat0.xz = (-u_xlat2.xx) + u_xlat0.xw;
    u_xlat2.x = float(1.0) / u_xlat0.z;
    u_xlat0.x = u_xlat2.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat2.xyz = u_xlat10_1.xyz * vec3(vec3(_DarkeningFactor, _DarkeningFactor, _DarkeningFactor));
    u_xlat1.xyz = (-u_xlat10_1.xyz) * vec3(vec3(_DarkeningFactor, _DarkeningFactor, _DarkeningFactor)) + u_xlat10_1.xyz;
    SV_TARGET0.w = u_xlat10_1.w;
    SV_TARGET0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
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
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _DotPatternRowColumnNumber;
uniform 	float _DarkeningFactor;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
float u_xlat4;
mediump float u_xlat16_4;
void main()
{
    u_xlat0.x = dot(vec2(0.707000017, -0.707000017), vs_TEXCOORD0.xy);
    u_xlat0.y = dot(vec2(0.707000017, 0.707000017), vs_TEXCOORD0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(_DotPatternRowColumnNumber);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat2.x = dFdx(u_xlat0.x);
    u_xlat4 = dFdy(u_xlat0.x);
    u_xlat2.x = abs(u_xlat4) + abs(u_xlat2.x);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4 = u_xlat10_1.y + u_xlat10_1.x;
    u_xlat16_4 = u_xlat10_1.z + u_xlat16_4;
    u_xlat16_4 = (-u_xlat16_4) * 0.333333343 + 1.0;
    u_xlat0.w = u_xlat16_4 * u_xlat16_4 + u_xlat2.x;
    u_xlat2.x = u_xlat16_4 * u_xlat16_4 + (-u_xlat2.x);
    u_xlat0.xz = (-u_xlat2.xx) + u_xlat0.xw;
    u_xlat2.x = float(1.0) / u_xlat0.z;
    u_xlat0.x = u_xlat2.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat2.xyz = u_xlat10_1.xyz * vec3(vec3(_DarkeningFactor, _DarkeningFactor, _DarkeningFactor));
    u_xlat1.xyz = (-u_xlat10_1.xyz) * vec3(vec3(_DarkeningFactor, _DarkeningFactor, _DarkeningFactor)) + u_xlat10_1.xyz;
    SV_TARGET0.w = u_xlat10_1.w;
    SV_TARGET0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
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
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _DotPatternRowColumnNumber;
uniform 	float _DarkeningFactor;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
float u_xlat4;
mediump float u_xlat16_4;
void main()
{
    u_xlat0.x = dot(vec2(0.707000017, -0.707000017), vs_TEXCOORD0.xy);
    u_xlat0.y = dot(vec2(0.707000017, 0.707000017), vs_TEXCOORD0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(_DotPatternRowColumnNumber);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat2.x = dFdx(u_xlat0.x);
    u_xlat4 = dFdy(u_xlat0.x);
    u_xlat2.x = abs(u_xlat4) + abs(u_xlat2.x);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4 = u_xlat10_1.y + u_xlat10_1.x;
    u_xlat16_4 = u_xlat10_1.z + u_xlat16_4;
    u_xlat16_4 = (-u_xlat16_4) * 0.333333343 + 1.0;
    u_xlat0.w = u_xlat16_4 * u_xlat16_4 + u_xlat2.x;
    u_xlat2.x = u_xlat16_4 * u_xlat16_4 + (-u_xlat2.x);
    u_xlat0.xz = (-u_xlat2.xx) + u_xlat0.xw;
    u_xlat2.x = float(1.0) / u_xlat0.z;
    u_xlat0.x = u_xlat2.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat2.xyz = u_xlat10_1.xyz * vec3(vec3(_DarkeningFactor, _DarkeningFactor, _DarkeningFactor));
    u_xlat1.xyz = (-u_xlat10_1.xyz) * vec3(vec3(_DarkeningFactor, _DarkeningFactor, _DarkeningFactor)) + u_xlat10_1.xyz;
    SV_TARGET0.w = u_xlat10_1.w;
    SV_TARGET0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
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
uniform 	float _DotPatternRowColumnNumber;
uniform 	float _DarkeningFactor;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
float u_xlat4;
mediump float u_xlat16_4;
void main()
{
    u_xlat0.x = dot(vec2(0.707000017, -0.707000017), vs_TEXCOORD0.xy);
    u_xlat0.y = dot(vec2(0.707000017, 0.707000017), vs_TEXCOORD0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(_DotPatternRowColumnNumber);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat2.x = dFdx(u_xlat0.x);
    u_xlat4 = dFdy(u_xlat0.x);
    u_xlat2.x = abs(u_xlat4) + abs(u_xlat2.x);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4 = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_4 = u_xlat16_1.z + u_xlat16_4;
    u_xlat16_4 = (-u_xlat16_4) * 0.333333343 + 1.0;
    u_xlat0.w = u_xlat16_4 * u_xlat16_4 + u_xlat2.x;
    u_xlat2.x = u_xlat16_4 * u_xlat16_4 + (-u_xlat2.x);
    u_xlat0.xz = (-u_xlat2.xx) + u_xlat0.xw;
    u_xlat2.x = float(1.0) / u_xlat0.z;
    u_xlat0.x = u_xlat2.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_DarkeningFactor, _DarkeningFactor, _DarkeningFactor));
    u_xlat1.xyz = (-u_xlat16_1.xyz) * vec3(vec3(_DarkeningFactor, _DarkeningFactor, _DarkeningFactor)) + u_xlat16_1.xyz;
    SV_TARGET0.w = u_xlat16_1.w;
    SV_TARGET0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
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
uniform 	float _DotPatternRowColumnNumber;
uniform 	float _DarkeningFactor;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
float u_xlat4;
mediump float u_xlat16_4;
void main()
{
    u_xlat0.x = dot(vec2(0.707000017, -0.707000017), vs_TEXCOORD0.xy);
    u_xlat0.y = dot(vec2(0.707000017, 0.707000017), vs_TEXCOORD0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(_DotPatternRowColumnNumber);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat2.x = dFdx(u_xlat0.x);
    u_xlat4 = dFdy(u_xlat0.x);
    u_xlat2.x = abs(u_xlat4) + abs(u_xlat2.x);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4 = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_4 = u_xlat16_1.z + u_xlat16_4;
    u_xlat16_4 = (-u_xlat16_4) * 0.333333343 + 1.0;
    u_xlat0.w = u_xlat16_4 * u_xlat16_4 + u_xlat2.x;
    u_xlat2.x = u_xlat16_4 * u_xlat16_4 + (-u_xlat2.x);
    u_xlat0.xz = (-u_xlat2.xx) + u_xlat0.xw;
    u_xlat2.x = float(1.0) / u_xlat0.z;
    u_xlat0.x = u_xlat2.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_DarkeningFactor, _DarkeningFactor, _DarkeningFactor));
    u_xlat1.xyz = (-u_xlat16_1.xyz) * vec3(vec3(_DarkeningFactor, _DarkeningFactor, _DarkeningFactor)) + u_xlat16_1.xyz;
    SV_TARGET0.w = u_xlat16_1.w;
    SV_TARGET0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
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
uniform 	float _DotPatternRowColumnNumber;
uniform 	float _DarkeningFactor;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
float u_xlat4;
mediump float u_xlat16_4;
void main()
{
    u_xlat0.x = dot(vec2(0.707000017, -0.707000017), vs_TEXCOORD0.xy);
    u_xlat0.y = dot(vec2(0.707000017, 0.707000017), vs_TEXCOORD0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(_DotPatternRowColumnNumber);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat2.x = dFdx(u_xlat0.x);
    u_xlat4 = dFdy(u_xlat0.x);
    u_xlat2.x = abs(u_xlat4) + abs(u_xlat2.x);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4 = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_4 = u_xlat16_1.z + u_xlat16_4;
    u_xlat16_4 = (-u_xlat16_4) * 0.333333343 + 1.0;
    u_xlat0.w = u_xlat16_4 * u_xlat16_4 + u_xlat2.x;
    u_xlat2.x = u_xlat16_4 * u_xlat16_4 + (-u_xlat2.x);
    u_xlat0.xz = (-u_xlat2.xx) + u_xlat0.xw;
    u_xlat2.x = float(1.0) / u_xlat0.z;
    u_xlat0.x = u_xlat2.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_DarkeningFactor, _DarkeningFactor, _DarkeningFactor));
    u_xlat1.xyz = (-u_xlat16_1.xyz) * vec3(vec3(_DarkeningFactor, _DarkeningFactor, _DarkeningFactor)) + u_xlat16_1.xyz;
    SV_TARGET0.w = u_xlat16_1.w;
    SV_TARGET0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
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