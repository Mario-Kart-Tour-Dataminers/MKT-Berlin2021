//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Blend_Ink" {
Properties {
_MainTex ("Texture", 2D) = "black" { }
_Color ("Color", Color) = (0,0,0,1)
_FinalTex ("Final Texture", 2D) = "black" { }
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "RenderType" = "Transparent" }
 Pass {
  Name "SimpleCopy"
  Tags { "IGNOREPROJECTOR" = "true" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 34723
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
void main()
{
    SV_TARGET0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
void main()
{
    SV_TARGET0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
void main()
{
    SV_TARGET0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = texture(_MainTex, vs_TEXCOORD0.xy);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = texture(_MainTex, vs_TEXCOORD0.xy);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = texture(_MainTex, vs_TEXCOORD0.xy);
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
 Pass {
  Name "InkPaint"
  Tags { "IGNOREPROJECTOR" = "true" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 67112
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_affineTrans[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4_affineTrans[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _fadingConsts;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
float u_xlat1;
bool u_xlatb1;
float u_xlat3;
float u_xlat5;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.z = (-u_xlat10_0) + 1.0;
    u_xlatb1 = 0.0<u_xlat0.z;
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat3 = max(_fadingConsts.x, 0.0);
    u_xlat5 = trunc(u_xlat3);
    u_xlat0.y = (-u_xlat5) + u_xlat3;
    u_xlat0.x = u_xlat5 * 0.015625;
    u_xlat0.w = 0.0;
    SV_TARGET0 = u_xlat0 * vec4(u_xlat1);
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_affineTrans[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4_affineTrans[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _fadingConsts;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
float u_xlat1;
bool u_xlatb1;
float u_xlat3;
float u_xlat5;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.z = (-u_xlat10_0) + 1.0;
    u_xlatb1 = 0.0<u_xlat0.z;
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat3 = max(_fadingConsts.x, 0.0);
    u_xlat5 = trunc(u_xlat3);
    u_xlat0.y = (-u_xlat5) + u_xlat3;
    u_xlat0.x = u_xlat5 * 0.015625;
    u_xlat0.w = 0.0;
    SV_TARGET0 = u_xlat0 * vec4(u_xlat1);
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_affineTrans[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4_affineTrans[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _fadingConsts;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
float u_xlat1;
bool u_xlatb1;
float u_xlat3;
float u_xlat5;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.z = (-u_xlat10_0) + 1.0;
    u_xlatb1 = 0.0<u_xlat0.z;
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat3 = max(_fadingConsts.x, 0.0);
    u_xlat5 = trunc(u_xlat3);
    u_xlat0.y = (-u_xlat5) + u_xlat3;
    u_xlat0.x = u_xlat5 * 0.015625;
    u_xlat0.w = 0.0;
    SV_TARGET0 = u_xlat0 * vec4(u_xlat1);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_affineTrans[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4_affineTrans[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _fadingConsts;
uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec4 u_xlat0;
mediump float u_xlat16_0;
float u_xlat1;
bool u_xlatb1;
float u_xlat3;
float u_xlat5;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.z = (-u_xlat16_0) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0<u_xlat0.z);
#else
    u_xlatb1 = 0.0<u_xlat0.z;
#endif
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat3 = max(_fadingConsts.x, 0.0);
    u_xlat5 = trunc(u_xlat3);
    u_xlat0.y = (-u_xlat5) + u_xlat3;
    u_xlat0.x = u_xlat5 * 0.015625;
    u_xlat0.w = 0.0;
    SV_TARGET0 = u_xlat0 * vec4(u_xlat1);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_affineTrans[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4_affineTrans[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _fadingConsts;
uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec4 u_xlat0;
mediump float u_xlat16_0;
float u_xlat1;
bool u_xlatb1;
float u_xlat3;
float u_xlat5;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.z = (-u_xlat16_0) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0<u_xlat0.z);
#else
    u_xlatb1 = 0.0<u_xlat0.z;
#endif
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat3 = max(_fadingConsts.x, 0.0);
    u_xlat5 = trunc(u_xlat3);
    u_xlat0.y = (-u_xlat5) + u_xlat3;
    u_xlat0.x = u_xlat5 * 0.015625;
    u_xlat0.w = 0.0;
    SV_TARGET0 = u_xlat0 * vec4(u_xlat1);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_affineTrans[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4_affineTrans[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _fadingConsts;
uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec4 u_xlat0;
mediump float u_xlat16_0;
float u_xlat1;
bool u_xlatb1;
float u_xlat3;
float u_xlat5;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.z = (-u_xlat16_0) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0<u_xlat0.z);
#else
    u_xlatb1 = 0.0<u_xlat0.z;
#endif
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat3 = max(_fadingConsts.x, 0.0);
    u_xlat5 = trunc(u_xlat3);
    u_xlat0.y = (-u_xlat5) + u_xlat3;
    u_xlat0.x = u_xlat5 * 0.015625;
    u_xlat0.w = 0.0;
    SV_TARGET0 = u_xlat0 * vec4(u_xlat1);
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
 Pass {
  Name "InkAging"
  Tags { "IGNOREPROJECTOR" = "true" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 151835
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _requiredSize;
uniform 	vec4 _fadingConsts;
uniform 	vec4 _touchPoints;
uniform 	vec4 _agingValues;
uniform 	vec4 _inkOffset;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
vec3 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.xy = (-_touchPoints.yx) + _touchPoints.wz;
    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlatb9 = 0.0>=u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat9 = max(u_xlat9, u_xlat6);
    u_xlat1 = vs_TEXCOORD0.xyxy + (-_inkOffset.xyxy);
    u_xlat1 = _requiredSize.xyxy * u_xlat1 + (-_touchPoints);
    u_xlat2 = u_xlat0.y * u_xlat1.y;
    u_xlat2 = u_xlat0.x * u_xlat1.x + (-u_xlat2);
    u_xlat0.x = dot(u_xlat1.yx, u_xlat0.xy);
    u_xlat3 = u_xlat2 * u_xlat2;
    u_xlat3 = u_xlat3 / u_xlat9;
    u_xlat9 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat9 = (-u_xlat3) + u_xlat9;
    u_xlatb0.z = u_xlat6<u_xlat0.x;
    u_xlatb0.x = 0.0>=u_xlat0.x;
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xz));
    u_xlat3 = u_xlat0.z * u_xlat9 + u_xlat3;
    u_xlat6 = (-u_xlat3) + u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat3;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_fadingConsts.z);
    u_xlat0.x = u_xlat0.x * _fadingConsts.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1 = texture2D(_MainTex, vs_TEXCOORD0.xy).xzwy;
    u_xlat3 = u_xlat1.x * 64.0;
    u_xlat3 = floor(u_xlat3);
    u_xlat3 = u_xlat1.w + u_xlat3;
    u_xlat3 = min(u_xlat3, _fadingConsts.x);
    u_xlat3 = u_xlat3 + (-_agingValues.w);
    u_xlat1.x = u_xlat0.x * u_xlat3;
    u_xlatb0.x = 0.0<u_xlat1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    SV_TARGET0.zw = u_xlat0.yz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3 = trunc(u_xlat0.x);
    SV_TARGET0.y = (-u_xlat3) + u_xlat0.x;
    SV_TARGET0.x = u_xlat3 * 0.015625;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _requiredSize;
uniform 	vec4 _fadingConsts;
uniform 	vec4 _touchPoints;
uniform 	vec4 _agingValues;
uniform 	vec4 _inkOffset;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
vec3 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.xy = (-_touchPoints.yx) + _touchPoints.wz;
    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlatb9 = 0.0>=u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat9 = max(u_xlat9, u_xlat6);
    u_xlat1 = vs_TEXCOORD0.xyxy + (-_inkOffset.xyxy);
    u_xlat1 = _requiredSize.xyxy * u_xlat1 + (-_touchPoints);
    u_xlat2 = u_xlat0.y * u_xlat1.y;
    u_xlat2 = u_xlat0.x * u_xlat1.x + (-u_xlat2);
    u_xlat0.x = dot(u_xlat1.yx, u_xlat0.xy);
    u_xlat3 = u_xlat2 * u_xlat2;
    u_xlat3 = u_xlat3 / u_xlat9;
    u_xlat9 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat9 = (-u_xlat3) + u_xlat9;
    u_xlatb0.z = u_xlat6<u_xlat0.x;
    u_xlatb0.x = 0.0>=u_xlat0.x;
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xz));
    u_xlat3 = u_xlat0.z * u_xlat9 + u_xlat3;
    u_xlat6 = (-u_xlat3) + u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat3;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_fadingConsts.z);
    u_xlat0.x = u_xlat0.x * _fadingConsts.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1 = texture2D(_MainTex, vs_TEXCOORD0.xy).xzwy;
    u_xlat3 = u_xlat1.x * 64.0;
    u_xlat3 = floor(u_xlat3);
    u_xlat3 = u_xlat1.w + u_xlat3;
    u_xlat3 = min(u_xlat3, _fadingConsts.x);
    u_xlat3 = u_xlat3 + (-_agingValues.w);
    u_xlat1.x = u_xlat0.x * u_xlat3;
    u_xlatb0.x = 0.0<u_xlat1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    SV_TARGET0.zw = u_xlat0.yz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3 = trunc(u_xlat0.x);
    SV_TARGET0.y = (-u_xlat3) + u_xlat0.x;
    SV_TARGET0.x = u_xlat3 * 0.015625;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _requiredSize;
uniform 	vec4 _fadingConsts;
uniform 	vec4 _touchPoints;
uniform 	vec4 _agingValues;
uniform 	vec4 _inkOffset;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
vec3 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.xy = (-_touchPoints.yx) + _touchPoints.wz;
    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlatb9 = 0.0>=u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat9 = max(u_xlat9, u_xlat6);
    u_xlat1 = vs_TEXCOORD0.xyxy + (-_inkOffset.xyxy);
    u_xlat1 = _requiredSize.xyxy * u_xlat1 + (-_touchPoints);
    u_xlat2 = u_xlat0.y * u_xlat1.y;
    u_xlat2 = u_xlat0.x * u_xlat1.x + (-u_xlat2);
    u_xlat0.x = dot(u_xlat1.yx, u_xlat0.xy);
    u_xlat3 = u_xlat2 * u_xlat2;
    u_xlat3 = u_xlat3 / u_xlat9;
    u_xlat9 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat9 = (-u_xlat3) + u_xlat9;
    u_xlatb0.z = u_xlat6<u_xlat0.x;
    u_xlatb0.x = 0.0>=u_xlat0.x;
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xz));
    u_xlat3 = u_xlat0.z * u_xlat9 + u_xlat3;
    u_xlat6 = (-u_xlat3) + u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat3;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_fadingConsts.z);
    u_xlat0.x = u_xlat0.x * _fadingConsts.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1 = texture2D(_MainTex, vs_TEXCOORD0.xy).xzwy;
    u_xlat3 = u_xlat1.x * 64.0;
    u_xlat3 = floor(u_xlat3);
    u_xlat3 = u_xlat1.w + u_xlat3;
    u_xlat3 = min(u_xlat3, _fadingConsts.x);
    u_xlat3 = u_xlat3 + (-_agingValues.w);
    u_xlat1.x = u_xlat0.x * u_xlat3;
    u_xlatb0.x = 0.0<u_xlat1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    SV_TARGET0.zw = u_xlat0.yz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3 = trunc(u_xlat0.x);
    SV_TARGET0.y = (-u_xlat3) + u_xlat0.x;
    SV_TARGET0.x = u_xlat3 * 0.015625;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _requiredSize;
uniform 	vec4 _fadingConsts;
uniform 	vec4 _touchPoints;
uniform 	vec4 _agingValues;
uniform 	vec4 _inkOffset;
uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec3 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = (-_touchPoints.yx) + _touchPoints.wz;
    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.0>=u_xlat6);
#else
    u_xlatb9 = 0.0>=u_xlat6;
#endif
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat9 = max(u_xlat9, u_xlat6);
    u_xlat1 = vs_TEXCOORD0.xyxy + (-_inkOffset.xyxy);
    u_xlat1 = _requiredSize.xyxy * u_xlat1 + (-_touchPoints);
    u_xlat2 = u_xlat0.y * u_xlat1.y;
    u_xlat2 = u_xlat0.x * u_xlat1.x + (-u_xlat2);
    u_xlat0.x = dot(u_xlat1.yx, u_xlat0.xy);
    u_xlat3 = u_xlat2 * u_xlat2;
    u_xlat3 = u_xlat3 / u_xlat9;
    u_xlat9 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat9 = (-u_xlat3) + u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.z = !!(u_xlat6<u_xlat0.x);
#else
    u_xlatb0.z = u_xlat6<u_xlat0.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0>=u_xlat0.x);
#else
    u_xlatb0.x = 0.0>=u_xlat0.x;
#endif
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xz));
    u_xlat3 = u_xlat0.z * u_xlat9 + u_xlat3;
    u_xlat6 = (-u_xlat3) + u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat3;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_fadingConsts.z);
    u_xlat0.x = u_xlat0.x * _fadingConsts.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy).xzwy;
    u_xlat3 = u_xlat1.x * 64.0;
    u_xlat3 = floor(u_xlat3);
    u_xlat3 = u_xlat1.w + u_xlat3;
    u_xlat3 = min(u_xlat3, _fadingConsts.x);
    u_xlat3 = u_xlat3 + (-_agingValues.w);
    u_xlat1.x = u_xlat0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<u_xlat1.x);
#else
    u_xlatb0.x = 0.0<u_xlat1.x;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    SV_TARGET0.zw = u_xlat0.yz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3 = trunc(u_xlat0.x);
    SV_TARGET0.y = (-u_xlat3) + u_xlat0.x;
    SV_TARGET0.x = u_xlat3 * 0.015625;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _requiredSize;
uniform 	vec4 _fadingConsts;
uniform 	vec4 _touchPoints;
uniform 	vec4 _agingValues;
uniform 	vec4 _inkOffset;
uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec3 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = (-_touchPoints.yx) + _touchPoints.wz;
    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.0>=u_xlat6);
#else
    u_xlatb9 = 0.0>=u_xlat6;
#endif
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat9 = max(u_xlat9, u_xlat6);
    u_xlat1 = vs_TEXCOORD0.xyxy + (-_inkOffset.xyxy);
    u_xlat1 = _requiredSize.xyxy * u_xlat1 + (-_touchPoints);
    u_xlat2 = u_xlat0.y * u_xlat1.y;
    u_xlat2 = u_xlat0.x * u_xlat1.x + (-u_xlat2);
    u_xlat0.x = dot(u_xlat1.yx, u_xlat0.xy);
    u_xlat3 = u_xlat2 * u_xlat2;
    u_xlat3 = u_xlat3 / u_xlat9;
    u_xlat9 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat9 = (-u_xlat3) + u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.z = !!(u_xlat6<u_xlat0.x);
#else
    u_xlatb0.z = u_xlat6<u_xlat0.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0>=u_xlat0.x);
#else
    u_xlatb0.x = 0.0>=u_xlat0.x;
#endif
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xz));
    u_xlat3 = u_xlat0.z * u_xlat9 + u_xlat3;
    u_xlat6 = (-u_xlat3) + u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat3;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_fadingConsts.z);
    u_xlat0.x = u_xlat0.x * _fadingConsts.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy).xzwy;
    u_xlat3 = u_xlat1.x * 64.0;
    u_xlat3 = floor(u_xlat3);
    u_xlat3 = u_xlat1.w + u_xlat3;
    u_xlat3 = min(u_xlat3, _fadingConsts.x);
    u_xlat3 = u_xlat3 + (-_agingValues.w);
    u_xlat1.x = u_xlat0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<u_xlat1.x);
#else
    u_xlatb0.x = 0.0<u_xlat1.x;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    SV_TARGET0.zw = u_xlat0.yz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3 = trunc(u_xlat0.x);
    SV_TARGET0.y = (-u_xlat3) + u_xlat0.x;
    SV_TARGET0.x = u_xlat3 * 0.015625;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _requiredSize;
uniform 	vec4 _fadingConsts;
uniform 	vec4 _touchPoints;
uniform 	vec4 _agingValues;
uniform 	vec4 _inkOffset;
uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec3 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = (-_touchPoints.yx) + _touchPoints.wz;
    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.0>=u_xlat6);
#else
    u_xlatb9 = 0.0>=u_xlat6;
#endif
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat9 = max(u_xlat9, u_xlat6);
    u_xlat1 = vs_TEXCOORD0.xyxy + (-_inkOffset.xyxy);
    u_xlat1 = _requiredSize.xyxy * u_xlat1 + (-_touchPoints);
    u_xlat2 = u_xlat0.y * u_xlat1.y;
    u_xlat2 = u_xlat0.x * u_xlat1.x + (-u_xlat2);
    u_xlat0.x = dot(u_xlat1.yx, u_xlat0.xy);
    u_xlat3 = u_xlat2 * u_xlat2;
    u_xlat3 = u_xlat3 / u_xlat9;
    u_xlat9 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat9 = (-u_xlat3) + u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.z = !!(u_xlat6<u_xlat0.x);
#else
    u_xlatb0.z = u_xlat6<u_xlat0.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0>=u_xlat0.x);
#else
    u_xlatb0.x = 0.0>=u_xlat0.x;
#endif
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xz));
    u_xlat3 = u_xlat0.z * u_xlat9 + u_xlat3;
    u_xlat6 = (-u_xlat3) + u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat3;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_fadingConsts.z);
    u_xlat0.x = u_xlat0.x * _fadingConsts.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy).xzwy;
    u_xlat3 = u_xlat1.x * 64.0;
    u_xlat3 = floor(u_xlat3);
    u_xlat3 = u_xlat1.w + u_xlat3;
    u_xlat3 = min(u_xlat3, _fadingConsts.x);
    u_xlat3 = u_xlat3 + (-_agingValues.w);
    u_xlat1.x = u_xlat0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<u_xlat1.x);
#else
    u_xlatb0.x = 0.0<u_xlat1.x;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    SV_TARGET0.zw = u_xlat0.yz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3 = trunc(u_xlat0.x);
    SV_TARGET0.y = (-u_xlat3) + u_xlat0.x;
    SV_TARGET0.x = u_xlat3 * 0.015625;
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
 Pass {
  Name "InkDraw"
  Tags { "IGNOREPROJECTOR" = "true" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 216793
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Color;
uniform 	vec4 _fadingConsts;
uniform 	vec4 _inkOffset;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FinalTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
vec2 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + _inkOffset.xy;
    u_xlat10_1.xyz = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture2D(_FinalTex, u_xlat0.xy).xyz;
    SV_TARGET0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat0.x = u_xlat10_1.x * 64.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat10_1.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _fadingConsts.y;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = u_xlat0.x * 1.57079637;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat10_1.z;
    SV_TARGET0.w = u_xlat0.x * _Color.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Color;
uniform 	vec4 _fadingConsts;
uniform 	vec4 _inkOffset;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FinalTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
vec2 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + _inkOffset.xy;
    u_xlat10_1.xyz = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture2D(_FinalTex, u_xlat0.xy).xyz;
    SV_TARGET0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat0.x = u_xlat10_1.x * 64.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat10_1.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _fadingConsts.y;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = u_xlat0.x * 1.57079637;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat10_1.z;
    SV_TARGET0.w = u_xlat0.x * _Color.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Color;
uniform 	vec4 _fadingConsts;
uniform 	vec4 _inkOffset;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FinalTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
vec2 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + _inkOffset.xy;
    u_xlat10_1.xyz = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture2D(_FinalTex, u_xlat0.xy).xyz;
    SV_TARGET0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat0.x = u_xlat10_1.x * 64.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat10_1.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _fadingConsts.y;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = u_xlat0.x * 1.57079637;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat10_1.z;
    SV_TARGET0.w = u_xlat0.x * _Color.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _Color;
uniform 	vec4 _fadingConsts;
uniform 	vec4 _inkOffset;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _FinalTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + _inkOffset.xy;
    u_xlat16_1.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = texture(_FinalTex, u_xlat0.xy).xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat0.x = u_xlat16_1.x * 64.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat16_1.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _fadingConsts.y;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = u_xlat0.x * 1.57079637;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.z;
    SV_TARGET0.w = u_xlat0.x * _Color.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _Color;
uniform 	vec4 _fadingConsts;
uniform 	vec4 _inkOffset;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _FinalTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + _inkOffset.xy;
    u_xlat16_1.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = texture(_FinalTex, u_xlat0.xy).xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat0.x = u_xlat16_1.x * 64.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat16_1.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _fadingConsts.y;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = u_xlat0.x * 1.57079637;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.z;
    SV_TARGET0.w = u_xlat0.x * _Color.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _Color;
uniform 	vec4 _fadingConsts;
uniform 	vec4 _inkOffset;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _FinalTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + _inkOffset.xy;
    u_xlat16_1.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = texture(_FinalTex, u_xlat0.xy).xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat0.x = u_xlat16_1.x * 64.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat16_1.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _fadingConsts.y;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = u_xlat0.x * 1.57079637;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.z;
    SV_TARGET0.w = u_xlat0.x * _Color.w;
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
 Pass {
  Name "InkCopy"
  Tags { "IGNOREPROJECTOR" = "true" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 293810
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_affineTrans[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4_affineTrans[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
void main()
{
    SV_TARGET0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_affineTrans[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4_affineTrans[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
void main()
{
    SV_TARGET0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_affineTrans[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4_affineTrans[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
void main()
{
    SV_TARGET0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_affineTrans[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4_affineTrans[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = texture(_MainTex, vs_TEXCOORD0.xy);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_affineTrans[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4_affineTrans[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = texture(_MainTex, vs_TEXCOORD0.xy);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_affineTrans[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4_affineTrans[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_affineTrans[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = texture(_MainTex, vs_TEXCOORD0.xy);
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
 Pass {
  Name "InkAging2"
  Tags { "IGNOREPROJECTOR" = "true" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 359470
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _requiredSize;
uniform 	vec4 _fadingConsts;
uniform 	vec4 _touchPoints;
uniform 	vec4 _touchPointsSecond;
uniform 	vec4 _agingValues;
uniform 	vec4 _inkOffset;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
vec3 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat8;
bool u_xlatb8;
float u_xlat12;
bool u_xlatb12;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.xy = (-_touchPoints.yx) + _touchPoints.wz;
    u_xlat8 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlatb12 = 0.0>=u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat12 = max(u_xlat12, u_xlat8);
    u_xlat1 = vs_TEXCOORD0.xyxy + (-_inkOffset.xyxy);
    u_xlat2 = _requiredSize.xyxy * u_xlat1.zwzw + (-_touchPoints);
    u_xlat1 = _requiredSize.xyxy * u_xlat1 + (-_touchPointsSecond);
    u_xlat3 = u_xlat0.y * u_xlat2.y;
    u_xlat3 = u_xlat0.x * u_xlat2.x + (-u_xlat3);
    u_xlat0.x = dot(u_xlat2.yx, u_xlat0.xy);
    u_xlat4.x = u_xlat3 * u_xlat3;
    u_xlat4.x = u_xlat4.x / u_xlat12;
    u_xlat12 = dot(u_xlat2.zw, u_xlat2.zw);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat12 = (-u_xlat4.x) + u_xlat12;
    u_xlatb0.z = u_xlat8<u_xlat0.x;
    u_xlatb0.x = 0.0>=u_xlat0.x;
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xz));
    u_xlat4.x = u_xlat0.z * u_xlat12 + u_xlat4.x;
    u_xlat8 = (-u_xlat4.x) + u_xlat2.x;
    u_xlat0.x = u_xlat0.x * u_xlat8 + u_xlat4.x;
    u_xlat4.xy = (-_touchPointsSecond.yx) + _touchPointsSecond.wz;
    u_xlat12 = u_xlat1.y * u_xlat4.y;
    u_xlat12 = u_xlat4.x * u_xlat1.x + (-u_xlat12);
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat2.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = dot(u_xlat1.yx, u_xlat4.xy);
    u_xlatb8 = 0.0>=u_xlat2.x;
    u_xlat8 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = max(u_xlat8, u_xlat2.x);
    u_xlatb2 = u_xlat2.x<u_xlat4.x;
    u_xlatb4 = 0.0>=u_xlat4.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat8 = u_xlat12 / u_xlat8;
    u_xlat12 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat12 = (-u_xlat8) + u_xlat12;
    u_xlat8 = u_xlat2.x * u_xlat12 + u_xlat8;
    u_xlat12 = (-u_xlat8) + u_xlat1.x;
    u_xlat4.x = u_xlat4.x * u_xlat12 + u_xlat8;
    u_xlat0.x = min(u_xlat4.x, u_xlat0.x);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_fadingConsts.z);
    u_xlat0.x = u_xlat0.x * _fadingConsts.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1 = texture2D(_MainTex, vs_TEXCOORD0.xy).xzwy;
    u_xlat4.x = u_xlat1.x * 64.0;
    u_xlat4.x = floor(u_xlat4.x);
    u_xlat4.x = u_xlat1.w + u_xlat4.x;
    u_xlat4.x = min(u_xlat4.x, _fadingConsts.x);
    u_xlat4.x = u_xlat4.x + (-_agingValues.w);
    u_xlat1.x = u_xlat0.x * u_xlat4.x;
    u_xlatb0.x = 0.0<u_xlat1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    SV_TARGET0.zw = u_xlat0.yz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = trunc(u_xlat0.x);
    SV_TARGET0.y = (-u_xlat4.x) + u_xlat0.x;
    SV_TARGET0.x = u_xlat4.x * 0.015625;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _requiredSize;
uniform 	vec4 _fadingConsts;
uniform 	vec4 _touchPoints;
uniform 	vec4 _touchPointsSecond;
uniform 	vec4 _agingValues;
uniform 	vec4 _inkOffset;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
vec3 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat8;
bool u_xlatb8;
float u_xlat12;
bool u_xlatb12;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.xy = (-_touchPoints.yx) + _touchPoints.wz;
    u_xlat8 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlatb12 = 0.0>=u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat12 = max(u_xlat12, u_xlat8);
    u_xlat1 = vs_TEXCOORD0.xyxy + (-_inkOffset.xyxy);
    u_xlat2 = _requiredSize.xyxy * u_xlat1.zwzw + (-_touchPoints);
    u_xlat1 = _requiredSize.xyxy * u_xlat1 + (-_touchPointsSecond);
    u_xlat3 = u_xlat0.y * u_xlat2.y;
    u_xlat3 = u_xlat0.x * u_xlat2.x + (-u_xlat3);
    u_xlat0.x = dot(u_xlat2.yx, u_xlat0.xy);
    u_xlat4.x = u_xlat3 * u_xlat3;
    u_xlat4.x = u_xlat4.x / u_xlat12;
    u_xlat12 = dot(u_xlat2.zw, u_xlat2.zw);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat12 = (-u_xlat4.x) + u_xlat12;
    u_xlatb0.z = u_xlat8<u_xlat0.x;
    u_xlatb0.x = 0.0>=u_xlat0.x;
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xz));
    u_xlat4.x = u_xlat0.z * u_xlat12 + u_xlat4.x;
    u_xlat8 = (-u_xlat4.x) + u_xlat2.x;
    u_xlat0.x = u_xlat0.x * u_xlat8 + u_xlat4.x;
    u_xlat4.xy = (-_touchPointsSecond.yx) + _touchPointsSecond.wz;
    u_xlat12 = u_xlat1.y * u_xlat4.y;
    u_xlat12 = u_xlat4.x * u_xlat1.x + (-u_xlat12);
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat2.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = dot(u_xlat1.yx, u_xlat4.xy);
    u_xlatb8 = 0.0>=u_xlat2.x;
    u_xlat8 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = max(u_xlat8, u_xlat2.x);
    u_xlatb2 = u_xlat2.x<u_xlat4.x;
    u_xlatb4 = 0.0>=u_xlat4.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat8 = u_xlat12 / u_xlat8;
    u_xlat12 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat12 = (-u_xlat8) + u_xlat12;
    u_xlat8 = u_xlat2.x * u_xlat12 + u_xlat8;
    u_xlat12 = (-u_xlat8) + u_xlat1.x;
    u_xlat4.x = u_xlat4.x * u_xlat12 + u_xlat8;
    u_xlat0.x = min(u_xlat4.x, u_xlat0.x);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_fadingConsts.z);
    u_xlat0.x = u_xlat0.x * _fadingConsts.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1 = texture2D(_MainTex, vs_TEXCOORD0.xy).xzwy;
    u_xlat4.x = u_xlat1.x * 64.0;
    u_xlat4.x = floor(u_xlat4.x);
    u_xlat4.x = u_xlat1.w + u_xlat4.x;
    u_xlat4.x = min(u_xlat4.x, _fadingConsts.x);
    u_xlat4.x = u_xlat4.x + (-_agingValues.w);
    u_xlat1.x = u_xlat0.x * u_xlat4.x;
    u_xlatb0.x = 0.0<u_xlat1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    SV_TARGET0.zw = u_xlat0.yz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = trunc(u_xlat0.x);
    SV_TARGET0.y = (-u_xlat4.x) + u_xlat0.x;
    SV_TARGET0.x = u_xlat4.x * 0.015625;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _requiredSize;
uniform 	vec4 _fadingConsts;
uniform 	vec4 _touchPoints;
uniform 	vec4 _touchPointsSecond;
uniform 	vec4 _agingValues;
uniform 	vec4 _inkOffset;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_TARGET0 gl_FragData[0]
vec3 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat8;
bool u_xlatb8;
float u_xlat12;
bool u_xlatb12;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.xy = (-_touchPoints.yx) + _touchPoints.wz;
    u_xlat8 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlatb12 = 0.0>=u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat12 = max(u_xlat12, u_xlat8);
    u_xlat1 = vs_TEXCOORD0.xyxy + (-_inkOffset.xyxy);
    u_xlat2 = _requiredSize.xyxy * u_xlat1.zwzw + (-_touchPoints);
    u_xlat1 = _requiredSize.xyxy * u_xlat1 + (-_touchPointsSecond);
    u_xlat3 = u_xlat0.y * u_xlat2.y;
    u_xlat3 = u_xlat0.x * u_xlat2.x + (-u_xlat3);
    u_xlat0.x = dot(u_xlat2.yx, u_xlat0.xy);
    u_xlat4.x = u_xlat3 * u_xlat3;
    u_xlat4.x = u_xlat4.x / u_xlat12;
    u_xlat12 = dot(u_xlat2.zw, u_xlat2.zw);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat12 = (-u_xlat4.x) + u_xlat12;
    u_xlatb0.z = u_xlat8<u_xlat0.x;
    u_xlatb0.x = 0.0>=u_xlat0.x;
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xz));
    u_xlat4.x = u_xlat0.z * u_xlat12 + u_xlat4.x;
    u_xlat8 = (-u_xlat4.x) + u_xlat2.x;
    u_xlat0.x = u_xlat0.x * u_xlat8 + u_xlat4.x;
    u_xlat4.xy = (-_touchPointsSecond.yx) + _touchPointsSecond.wz;
    u_xlat12 = u_xlat1.y * u_xlat4.y;
    u_xlat12 = u_xlat4.x * u_xlat1.x + (-u_xlat12);
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat2.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = dot(u_xlat1.yx, u_xlat4.xy);
    u_xlatb8 = 0.0>=u_xlat2.x;
    u_xlat8 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = max(u_xlat8, u_xlat2.x);
    u_xlatb2 = u_xlat2.x<u_xlat4.x;
    u_xlatb4 = 0.0>=u_xlat4.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat8 = u_xlat12 / u_xlat8;
    u_xlat12 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat12 = (-u_xlat8) + u_xlat12;
    u_xlat8 = u_xlat2.x * u_xlat12 + u_xlat8;
    u_xlat12 = (-u_xlat8) + u_xlat1.x;
    u_xlat4.x = u_xlat4.x * u_xlat12 + u_xlat8;
    u_xlat0.x = min(u_xlat4.x, u_xlat0.x);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_fadingConsts.z);
    u_xlat0.x = u_xlat0.x * _fadingConsts.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1 = texture2D(_MainTex, vs_TEXCOORD0.xy).xzwy;
    u_xlat4.x = u_xlat1.x * 64.0;
    u_xlat4.x = floor(u_xlat4.x);
    u_xlat4.x = u_xlat1.w + u_xlat4.x;
    u_xlat4.x = min(u_xlat4.x, _fadingConsts.x);
    u_xlat4.x = u_xlat4.x + (-_agingValues.w);
    u_xlat1.x = u_xlat0.x * u_xlat4.x;
    u_xlatb0.x = 0.0<u_xlat1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    SV_TARGET0.zw = u_xlat0.yz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = trunc(u_xlat0.x);
    SV_TARGET0.y = (-u_xlat4.x) + u_xlat0.x;
    SV_TARGET0.x = u_xlat4.x * 0.015625;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _requiredSize;
uniform 	vec4 _fadingConsts;
uniform 	vec4 _touchPoints;
uniform 	vec4 _touchPointsSecond;
uniform 	vec4 _agingValues;
uniform 	vec4 _inkOffset;
uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec3 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat8;
bool u_xlatb8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = (-_touchPoints.yx) + _touchPoints.wz;
    u_xlat8 = dot(u_xlat0.xy, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0>=u_xlat8);
#else
    u_xlatb12 = 0.0>=u_xlat8;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat12 = max(u_xlat12, u_xlat8);
    u_xlat1 = vs_TEXCOORD0.xyxy + (-_inkOffset.xyxy);
    u_xlat2 = _requiredSize.xyxy * u_xlat1.zwzw + (-_touchPoints);
    u_xlat1 = _requiredSize.xyxy * u_xlat1 + (-_touchPointsSecond);
    u_xlat3 = u_xlat0.y * u_xlat2.y;
    u_xlat3 = u_xlat0.x * u_xlat2.x + (-u_xlat3);
    u_xlat0.x = dot(u_xlat2.yx, u_xlat0.xy);
    u_xlat4.x = u_xlat3 * u_xlat3;
    u_xlat4.x = u_xlat4.x / u_xlat12;
    u_xlat12 = dot(u_xlat2.zw, u_xlat2.zw);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat12 = (-u_xlat4.x) + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.z = !!(u_xlat8<u_xlat0.x);
#else
    u_xlatb0.z = u_xlat8<u_xlat0.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0>=u_xlat0.x);
#else
    u_xlatb0.x = 0.0>=u_xlat0.x;
#endif
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xz));
    u_xlat4.x = u_xlat0.z * u_xlat12 + u_xlat4.x;
    u_xlat8 = (-u_xlat4.x) + u_xlat2.x;
    u_xlat0.x = u_xlat0.x * u_xlat8 + u_xlat4.x;
    u_xlat4.xy = (-_touchPointsSecond.yx) + _touchPointsSecond.wz;
    u_xlat12 = u_xlat1.y * u_xlat4.y;
    u_xlat12 = u_xlat4.x * u_xlat1.x + (-u_xlat12);
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat2.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = dot(u_xlat1.yx, u_xlat4.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0>=u_xlat2.x);
#else
    u_xlatb8 = 0.0>=u_xlat2.x;
#endif
    u_xlat8 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = max(u_xlat8, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2.x<u_xlat4.x);
#else
    u_xlatb2 = u_xlat2.x<u_xlat4.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.0>=u_xlat4.x);
#else
    u_xlatb4 = 0.0>=u_xlat4.x;
#endif
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat8 = u_xlat12 / u_xlat8;
    u_xlat12 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat12 = (-u_xlat8) + u_xlat12;
    u_xlat8 = u_xlat2.x * u_xlat12 + u_xlat8;
    u_xlat12 = (-u_xlat8) + u_xlat1.x;
    u_xlat4.x = u_xlat4.x * u_xlat12 + u_xlat8;
    u_xlat0.x = min(u_xlat4.x, u_xlat0.x);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_fadingConsts.z);
    u_xlat0.x = u_xlat0.x * _fadingConsts.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy).xzwy;
    u_xlat4.x = u_xlat1.x * 64.0;
    u_xlat4.x = floor(u_xlat4.x);
    u_xlat4.x = u_xlat1.w + u_xlat4.x;
    u_xlat4.x = min(u_xlat4.x, _fadingConsts.x);
    u_xlat4.x = u_xlat4.x + (-_agingValues.w);
    u_xlat1.x = u_xlat0.x * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<u_xlat1.x);
#else
    u_xlatb0.x = 0.0<u_xlat1.x;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    SV_TARGET0.zw = u_xlat0.yz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = trunc(u_xlat0.x);
    SV_TARGET0.y = (-u_xlat4.x) + u_xlat0.x;
    SV_TARGET0.x = u_xlat4.x * 0.015625;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _requiredSize;
uniform 	vec4 _fadingConsts;
uniform 	vec4 _touchPoints;
uniform 	vec4 _touchPointsSecond;
uniform 	vec4 _agingValues;
uniform 	vec4 _inkOffset;
uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec3 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat8;
bool u_xlatb8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = (-_touchPoints.yx) + _touchPoints.wz;
    u_xlat8 = dot(u_xlat0.xy, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0>=u_xlat8);
#else
    u_xlatb12 = 0.0>=u_xlat8;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat12 = max(u_xlat12, u_xlat8);
    u_xlat1 = vs_TEXCOORD0.xyxy + (-_inkOffset.xyxy);
    u_xlat2 = _requiredSize.xyxy * u_xlat1.zwzw + (-_touchPoints);
    u_xlat1 = _requiredSize.xyxy * u_xlat1 + (-_touchPointsSecond);
    u_xlat3 = u_xlat0.y * u_xlat2.y;
    u_xlat3 = u_xlat0.x * u_xlat2.x + (-u_xlat3);
    u_xlat0.x = dot(u_xlat2.yx, u_xlat0.xy);
    u_xlat4.x = u_xlat3 * u_xlat3;
    u_xlat4.x = u_xlat4.x / u_xlat12;
    u_xlat12 = dot(u_xlat2.zw, u_xlat2.zw);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat12 = (-u_xlat4.x) + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.z = !!(u_xlat8<u_xlat0.x);
#else
    u_xlatb0.z = u_xlat8<u_xlat0.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0>=u_xlat0.x);
#else
    u_xlatb0.x = 0.0>=u_xlat0.x;
#endif
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xz));
    u_xlat4.x = u_xlat0.z * u_xlat12 + u_xlat4.x;
    u_xlat8 = (-u_xlat4.x) + u_xlat2.x;
    u_xlat0.x = u_xlat0.x * u_xlat8 + u_xlat4.x;
    u_xlat4.xy = (-_touchPointsSecond.yx) + _touchPointsSecond.wz;
    u_xlat12 = u_xlat1.y * u_xlat4.y;
    u_xlat12 = u_xlat4.x * u_xlat1.x + (-u_xlat12);
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat2.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = dot(u_xlat1.yx, u_xlat4.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0>=u_xlat2.x);
#else
    u_xlatb8 = 0.0>=u_xlat2.x;
#endif
    u_xlat8 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = max(u_xlat8, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2.x<u_xlat4.x);
#else
    u_xlatb2 = u_xlat2.x<u_xlat4.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.0>=u_xlat4.x);
#else
    u_xlatb4 = 0.0>=u_xlat4.x;
#endif
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat8 = u_xlat12 / u_xlat8;
    u_xlat12 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat12 = (-u_xlat8) + u_xlat12;
    u_xlat8 = u_xlat2.x * u_xlat12 + u_xlat8;
    u_xlat12 = (-u_xlat8) + u_xlat1.x;
    u_xlat4.x = u_xlat4.x * u_xlat12 + u_xlat8;
    u_xlat0.x = min(u_xlat4.x, u_xlat0.x);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_fadingConsts.z);
    u_xlat0.x = u_xlat0.x * _fadingConsts.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy).xzwy;
    u_xlat4.x = u_xlat1.x * 64.0;
    u_xlat4.x = floor(u_xlat4.x);
    u_xlat4.x = u_xlat1.w + u_xlat4.x;
    u_xlat4.x = min(u_xlat4.x, _fadingConsts.x);
    u_xlat4.x = u_xlat4.x + (-_agingValues.w);
    u_xlat1.x = u_xlat0.x * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<u_xlat1.x);
#else
    u_xlatb0.x = 0.0<u_xlat1.x;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    SV_TARGET0.zw = u_xlat0.yz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = trunc(u_xlat0.x);
    SV_TARGET0.y = (-u_xlat4.x) + u_xlat0.x;
    SV_TARGET0.x = u_xlat4.x * 0.015625;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _requiredSize;
uniform 	vec4 _fadingConsts;
uniform 	vec4 _touchPoints;
uniform 	vec4 _touchPointsSecond;
uniform 	vec4 _agingValues;
uniform 	vec4 _inkOffset;
uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec3 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat8;
bool u_xlatb8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = (-_touchPoints.yx) + _touchPoints.wz;
    u_xlat8 = dot(u_xlat0.xy, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0>=u_xlat8);
#else
    u_xlatb12 = 0.0>=u_xlat8;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat12 = max(u_xlat12, u_xlat8);
    u_xlat1 = vs_TEXCOORD0.xyxy + (-_inkOffset.xyxy);
    u_xlat2 = _requiredSize.xyxy * u_xlat1.zwzw + (-_touchPoints);
    u_xlat1 = _requiredSize.xyxy * u_xlat1 + (-_touchPointsSecond);
    u_xlat3 = u_xlat0.y * u_xlat2.y;
    u_xlat3 = u_xlat0.x * u_xlat2.x + (-u_xlat3);
    u_xlat0.x = dot(u_xlat2.yx, u_xlat0.xy);
    u_xlat4.x = u_xlat3 * u_xlat3;
    u_xlat4.x = u_xlat4.x / u_xlat12;
    u_xlat12 = dot(u_xlat2.zw, u_xlat2.zw);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat12 = (-u_xlat4.x) + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.z = !!(u_xlat8<u_xlat0.x);
#else
    u_xlatb0.z = u_xlat8<u_xlat0.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0>=u_xlat0.x);
#else
    u_xlatb0.x = 0.0>=u_xlat0.x;
#endif
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xz));
    u_xlat4.x = u_xlat0.z * u_xlat12 + u_xlat4.x;
    u_xlat8 = (-u_xlat4.x) + u_xlat2.x;
    u_xlat0.x = u_xlat0.x * u_xlat8 + u_xlat4.x;
    u_xlat4.xy = (-_touchPointsSecond.yx) + _touchPointsSecond.wz;
    u_xlat12 = u_xlat1.y * u_xlat4.y;
    u_xlat12 = u_xlat4.x * u_xlat1.x + (-u_xlat12);
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat2.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = dot(u_xlat1.yx, u_xlat4.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0>=u_xlat2.x);
#else
    u_xlatb8 = 0.0>=u_xlat2.x;
#endif
    u_xlat8 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = max(u_xlat8, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2.x<u_xlat4.x);
#else
    u_xlatb2 = u_xlat2.x<u_xlat4.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.0>=u_xlat4.x);
#else
    u_xlatb4 = 0.0>=u_xlat4.x;
#endif
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat8 = u_xlat12 / u_xlat8;
    u_xlat12 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat12 = (-u_xlat8) + u_xlat12;
    u_xlat8 = u_xlat2.x * u_xlat12 + u_xlat8;
    u_xlat12 = (-u_xlat8) + u_xlat1.x;
    u_xlat4.x = u_xlat4.x * u_xlat12 + u_xlat8;
    u_xlat0.x = min(u_xlat4.x, u_xlat0.x);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_fadingConsts.z);
    u_xlat0.x = u_xlat0.x * _fadingConsts.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy).xzwy;
    u_xlat4.x = u_xlat1.x * 64.0;
    u_xlat4.x = floor(u_xlat4.x);
    u_xlat4.x = u_xlat1.w + u_xlat4.x;
    u_xlat4.x = min(u_xlat4.x, _fadingConsts.x);
    u_xlat4.x = u_xlat4.x + (-_agingValues.w);
    u_xlat1.x = u_xlat0.x * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<u_xlat1.x);
#else
    u_xlatb0.x = 0.0<u_xlat1.x;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    SV_TARGET0.zw = u_xlat0.yz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = trunc(u_xlat0.x);
    SV_TARGET0.y = (-u_xlat4.x) + u_xlat0.x;
    SV_TARGET0.x = u_xlat4.x * 0.015625;
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