//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Blend_MskWarpScrWarp_CulBack" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_AlphaTexture ("A(UV0)", 2D) = "black" { }
[Header(A UV Scroll)] _AlphaTextureScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AlphaTextureScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
_WarpTexture ("Warp(UV0)", 2D) = "black" { }
_WarpScale ("Warp Scale", Range(0, 1024)) = 0
[Header(W UV Scroll)] _WarpScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_WarpScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 44645
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _AlphaTexture_ST;
uniform 	vec4 _WarpTexture_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _WarpTexture_ST.xy + _WarpTexture_ST.zw;
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
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	vec4 _AlphaTexture_TexelSize;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	mediump float _WarpScale;
uniform 	mediump float _WarpScrollSpeedU;
uniform 	mediump float _WarpScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _WarpTexture;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat0.yz = u_xlat0.xx * vec2(_WarpScrollSpeedU, _WarpScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0 = fract(u_xlat0);
    u_xlat2.xy = u_xlat0.yz + vs_TEXCOORD3.xy;
    u_xlat10_1.xyz = texture2D(_WarpTexture, u_xlat2.xy).xyz;
    u_xlat16_2.xy = u_xlat10_1.xy + vec2(-0.5, -0.5);
    u_xlat16_1 = u_xlat10_1.z * _WarpScale;
    u_xlat16_3 = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(u_xlat16_3);
    u_xlat16_2.xy = vec2(u_xlat16_1) * u_xlat16_2.xy;
    u_xlat0.xy = u_xlat16_2.xy * _AlphaTexture_TexelSize.xy + u_xlat0.xw;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    SV_Target0.xyz = u_xlat1.xyz;
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
uniform 	vec4 _AlphaTexture_ST;
uniform 	vec4 _WarpTexture_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _WarpTexture_ST.xy + _WarpTexture_ST.zw;
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
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	vec4 _AlphaTexture_TexelSize;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	mediump float _WarpScale;
uniform 	mediump float _WarpScrollSpeedU;
uniform 	mediump float _WarpScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _WarpTexture;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat0.yz = u_xlat0.xx * vec2(_WarpScrollSpeedU, _WarpScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0 = fract(u_xlat0);
    u_xlat2.xy = u_xlat0.yz + vs_TEXCOORD3.xy;
    u_xlat10_1.xyz = texture2D(_WarpTexture, u_xlat2.xy).xyz;
    u_xlat16_2.xy = u_xlat10_1.xy + vec2(-0.5, -0.5);
    u_xlat16_1 = u_xlat10_1.z * _WarpScale;
    u_xlat16_3 = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(u_xlat16_3);
    u_xlat16_2.xy = vec2(u_xlat16_1) * u_xlat16_2.xy;
    u_xlat0.xy = u_xlat16_2.xy * _AlphaTexture_TexelSize.xy + u_xlat0.xw;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    SV_Target0.xyz = u_xlat1.xyz;
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
uniform 	vec4 _AlphaTexture_ST;
uniform 	vec4 _WarpTexture_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _WarpTexture_ST.xy + _WarpTexture_ST.zw;
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
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	vec4 _AlphaTexture_TexelSize;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	mediump float _WarpScale;
uniform 	mediump float _WarpScrollSpeedU;
uniform 	mediump float _WarpScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _WarpTexture;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat0.yz = u_xlat0.xx * vec2(_WarpScrollSpeedU, _WarpScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0 = fract(u_xlat0);
    u_xlat2.xy = u_xlat0.yz + vs_TEXCOORD3.xy;
    u_xlat10_1.xyz = texture2D(_WarpTexture, u_xlat2.xy).xyz;
    u_xlat16_2.xy = u_xlat10_1.xy + vec2(-0.5, -0.5);
    u_xlat16_1 = u_xlat10_1.z * _WarpScale;
    u_xlat16_3 = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(u_xlat16_3);
    u_xlat16_2.xy = vec2(u_xlat16_1) * u_xlat16_2.xy;
    u_xlat0.xy = u_xlat16_2.xy * _AlphaTexture_TexelSize.xy + u_xlat0.xw;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    SV_Target0.xyz = u_xlat1.xyz;
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
uniform 	vec4 _AlphaTexture_ST;
uniform 	vec4 _WarpTexture_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _WarpTexture_ST.xy + _WarpTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	vec4 _AlphaTexture_TexelSize;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	mediump float _WarpScale;
uniform 	mediump float _WarpScrollSpeedU;
uniform 	mediump float _WarpScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _WarpTexture;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat0.yz = u_xlat0.xx * vec2(_WarpScrollSpeedU, _WarpScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0 = fract(u_xlat0);
    u_xlat2.xy = u_xlat0.yz + vs_TEXCOORD3.xy;
    u_xlat16_1.xyz = texture(_WarpTexture, u_xlat2.xy).xyz;
    u_xlat16_2.xy = u_xlat16_1.xy + vec2(-0.5, -0.5);
    u_xlat16_1.x = u_xlat16_1.z * _WarpScale;
    u_xlat16_3 = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(u_xlat16_3);
    u_xlat16_2.xy = u_xlat16_1.xx * u_xlat16_2.xy;
    u_xlat0.xy = u_xlat16_2.xy * _AlphaTexture_TexelSize.xy + u_xlat0.xw;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    SV_Target0.xyz = u_xlat1.xyz;
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
uniform 	vec4 _AlphaTexture_ST;
uniform 	vec4 _WarpTexture_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _WarpTexture_ST.xy + _WarpTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	vec4 _AlphaTexture_TexelSize;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	mediump float _WarpScale;
uniform 	mediump float _WarpScrollSpeedU;
uniform 	mediump float _WarpScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _WarpTexture;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat0.yz = u_xlat0.xx * vec2(_WarpScrollSpeedU, _WarpScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0 = fract(u_xlat0);
    u_xlat2.xy = u_xlat0.yz + vs_TEXCOORD3.xy;
    u_xlat16_1.xyz = texture(_WarpTexture, u_xlat2.xy).xyz;
    u_xlat16_2.xy = u_xlat16_1.xy + vec2(-0.5, -0.5);
    u_xlat16_1.x = u_xlat16_1.z * _WarpScale;
    u_xlat16_3 = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(u_xlat16_3);
    u_xlat16_2.xy = u_xlat16_1.xx * u_xlat16_2.xy;
    u_xlat0.xy = u_xlat16_2.xy * _AlphaTexture_TexelSize.xy + u_xlat0.xw;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    SV_Target0.xyz = u_xlat1.xyz;
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
uniform 	vec4 _AlphaTexture_ST;
uniform 	vec4 _WarpTexture_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _WarpTexture_ST.xy + _WarpTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	vec4 _AlphaTexture_TexelSize;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	mediump float _WarpScale;
uniform 	mediump float _WarpScrollSpeedU;
uniform 	mediump float _WarpScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _WarpTexture;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat0.yz = u_xlat0.xx * vec2(_WarpScrollSpeedU, _WarpScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0 = fract(u_xlat0);
    u_xlat2.xy = u_xlat0.yz + vs_TEXCOORD3.xy;
    u_xlat16_1.xyz = texture(_WarpTexture, u_xlat2.xy).xyz;
    u_xlat16_2.xy = u_xlat16_1.xy + vec2(-0.5, -0.5);
    u_xlat16_1.x = u_xlat16_1.z * _WarpScale;
    u_xlat16_3 = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(u_xlat16_3);
    u_xlat16_2.xy = u_xlat16_1.xx * u_xlat16_2.xy;
    u_xlat0.xy = u_xlat16_2.xy * _AlphaTexture_TexelSize.xy + u_xlat0.xw;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    SV_Target0.xyz = u_xlat1.xyz;
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