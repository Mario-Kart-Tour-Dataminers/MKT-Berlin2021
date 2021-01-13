//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Add_AlbTileClamp" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("RGB(UV0)", 2D) = "white" { }
[Header(RGB UV Clamp Repeat Tile)] _AlbedoTileFreq ("コマ送り速度", Range(-1000, 1000)) = 0
_AlbedoTileSplitU ("U方向：分割数", Range(1, 32)) = 1
_AlbedoTileSplitV ("V方向：分割数", Range(1, 32)) = 1
_AlbedoClampCount ("繰り返すコマ数", Range(1, 512)) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 55251
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump float _AlbedoTileFreq;
uniform 	mediump float _AlbedoTileSplitU;
uniform 	mediump float _AlbedoTileSplitV;
uniform 	mediump float _AlbedoClampCount;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
float u_xlat6;
mediump float u_xlat16_6;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat0.x = u_xlat0.x * _AlbedoTileFreq;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.x = vs_TEXCOORD0.y;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat1.y = (-u_xlat2.x) + 1.0;
    u_xlat1.x = vs_TEXCOORD0.x;
    u_xlat2.xy = u_xlat1.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat2.xy = trunc(u_xlat2.xy);
    u_xlat0.x = u_xlat2.x + u_xlat0.x;
    u_xlat0.x = u_xlat2.y * _AlbedoTileSplitU + u_xlat0.x;
    u_xlat2.xy = u_xlat1.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV) + (-u_xlat2.xy);
    u_xlat16_6 = _AlbedoTileSplitV * _AlbedoTileSplitU;
    u_xlat6 = min(u_xlat16_6, _AlbedoClampCount);
    u_xlat1.x = u_xlat6 * u_xlat0.x;
    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
    u_xlat6 = (u_xlatb1) ? u_xlat6 : (-u_xlat6);
    u_xlat1.x = float(1.0) / u_xlat6;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat1.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat1.x / _AlbedoTileSplitU;
    u_xlat1.y = floor(u_xlat0.x);
    u_xlat0.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.yx / vec2(_AlbedoTileSplitV, _AlbedoTileSplitU);
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat10_0.xyz = texture2D(_MainTex, u_xlat0.yz).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
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
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump float _AlbedoTileFreq;
uniform 	mediump float _AlbedoTileSplitU;
uniform 	mediump float _AlbedoTileSplitV;
uniform 	mediump float _AlbedoClampCount;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
float u_xlat6;
mediump float u_xlat16_6;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat0.x = u_xlat0.x * _AlbedoTileFreq;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.x = vs_TEXCOORD0.y;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat1.y = (-u_xlat2.x) + 1.0;
    u_xlat1.x = vs_TEXCOORD0.x;
    u_xlat2.xy = u_xlat1.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat2.xy = trunc(u_xlat2.xy);
    u_xlat0.x = u_xlat2.x + u_xlat0.x;
    u_xlat0.x = u_xlat2.y * _AlbedoTileSplitU + u_xlat0.x;
    u_xlat2.xy = u_xlat1.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV) + (-u_xlat2.xy);
    u_xlat16_6 = _AlbedoTileSplitV * _AlbedoTileSplitU;
    u_xlat6 = min(u_xlat16_6, _AlbedoClampCount);
    u_xlat1.x = u_xlat6 * u_xlat0.x;
    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
    u_xlat6 = (u_xlatb1) ? u_xlat6 : (-u_xlat6);
    u_xlat1.x = float(1.0) / u_xlat6;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat1.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat1.x / _AlbedoTileSplitU;
    u_xlat1.y = floor(u_xlat0.x);
    u_xlat0.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.yx / vec2(_AlbedoTileSplitV, _AlbedoTileSplitU);
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat10_0.xyz = texture2D(_MainTex, u_xlat0.yz).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
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
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump float _AlbedoTileFreq;
uniform 	mediump float _AlbedoTileSplitU;
uniform 	mediump float _AlbedoTileSplitV;
uniform 	mediump float _AlbedoClampCount;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
float u_xlat6;
mediump float u_xlat16_6;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat0.x = u_xlat0.x * _AlbedoTileFreq;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.x = vs_TEXCOORD0.y;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat1.y = (-u_xlat2.x) + 1.0;
    u_xlat1.x = vs_TEXCOORD0.x;
    u_xlat2.xy = u_xlat1.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat2.xy = trunc(u_xlat2.xy);
    u_xlat0.x = u_xlat2.x + u_xlat0.x;
    u_xlat0.x = u_xlat2.y * _AlbedoTileSplitU + u_xlat0.x;
    u_xlat2.xy = u_xlat1.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV) + (-u_xlat2.xy);
    u_xlat16_6 = _AlbedoTileSplitV * _AlbedoTileSplitU;
    u_xlat6 = min(u_xlat16_6, _AlbedoClampCount);
    u_xlat1.x = u_xlat6 * u_xlat0.x;
    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
    u_xlat6 = (u_xlatb1) ? u_xlat6 : (-u_xlat6);
    u_xlat1.x = float(1.0) / u_xlat6;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat1.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat1.x / _AlbedoTileSplitU;
    u_xlat1.y = floor(u_xlat0.x);
    u_xlat0.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.yx / vec2(_AlbedoTileSplitV, _AlbedoTileSplitU);
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat10_0.xyz = texture2D(_MainTex, u_xlat0.yz).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoTileFreq;
uniform 	mediump float _AlbedoTileSplitU;
uniform 	mediump float _AlbedoTileSplitV;
uniform 	mediump float _AlbedoClampCount;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
float u_xlat6;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat0.x = u_xlat0.x * _AlbedoTileFreq;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.x = vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat1.y = (-u_xlat2.x) + 1.0;
    u_xlat1.x = vs_TEXCOORD0.x;
    u_xlat2.xy = u_xlat1.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat2.xy = trunc(u_xlat2.xy);
    u_xlat0.x = u_xlat2.x + u_xlat0.x;
    u_xlat0.x = u_xlat2.y * _AlbedoTileSplitU + u_xlat0.x;
    u_xlat2.xy = u_xlat1.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV) + (-u_xlat2.xy);
    u_xlat16_6 = _AlbedoTileSplitV * _AlbedoTileSplitU;
    u_xlat6 = min(u_xlat16_6, _AlbedoClampCount);
    u_xlat1.x = u_xlat6 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlat6 = (u_xlatb1) ? u_xlat6 : (-u_xlat6);
    u_xlat1.x = float(1.0) / u_xlat6;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat1.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat1.x / _AlbedoTileSplitU;
    u_xlat1.y = floor(u_xlat0.x);
    u_xlat0.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.yx / vec2(_AlbedoTileSplitV, _AlbedoTileSplitU);
    u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat16_0.xyz = texture(_MainTex, u_xlat0.yz).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoTileFreq;
uniform 	mediump float _AlbedoTileSplitU;
uniform 	mediump float _AlbedoTileSplitV;
uniform 	mediump float _AlbedoClampCount;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
float u_xlat6;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat0.x = u_xlat0.x * _AlbedoTileFreq;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.x = vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat1.y = (-u_xlat2.x) + 1.0;
    u_xlat1.x = vs_TEXCOORD0.x;
    u_xlat2.xy = u_xlat1.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat2.xy = trunc(u_xlat2.xy);
    u_xlat0.x = u_xlat2.x + u_xlat0.x;
    u_xlat0.x = u_xlat2.y * _AlbedoTileSplitU + u_xlat0.x;
    u_xlat2.xy = u_xlat1.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV) + (-u_xlat2.xy);
    u_xlat16_6 = _AlbedoTileSplitV * _AlbedoTileSplitU;
    u_xlat6 = min(u_xlat16_6, _AlbedoClampCount);
    u_xlat1.x = u_xlat6 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlat6 = (u_xlatb1) ? u_xlat6 : (-u_xlat6);
    u_xlat1.x = float(1.0) / u_xlat6;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat1.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat1.x / _AlbedoTileSplitU;
    u_xlat1.y = floor(u_xlat0.x);
    u_xlat0.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.yx / vec2(_AlbedoTileSplitV, _AlbedoTileSplitU);
    u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat16_0.xyz = texture(_MainTex, u_xlat0.yz).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoTileFreq;
uniform 	mediump float _AlbedoTileSplitU;
uniform 	mediump float _AlbedoTileSplitV;
uniform 	mediump float _AlbedoClampCount;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
float u_xlat6;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat0.x = u_xlat0.x * _AlbedoTileFreq;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.x = vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat1.y = (-u_xlat2.x) + 1.0;
    u_xlat1.x = vs_TEXCOORD0.x;
    u_xlat2.xy = u_xlat1.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat2.xy = trunc(u_xlat2.xy);
    u_xlat0.x = u_xlat2.x + u_xlat0.x;
    u_xlat0.x = u_xlat2.y * _AlbedoTileSplitU + u_xlat0.x;
    u_xlat2.xy = u_xlat1.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV) + (-u_xlat2.xy);
    u_xlat16_6 = _AlbedoTileSplitV * _AlbedoTileSplitU;
    u_xlat6 = min(u_xlat16_6, _AlbedoClampCount);
    u_xlat1.x = u_xlat6 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlat6 = (u_xlatb1) ? u_xlat6 : (-u_xlat6);
    u_xlat1.x = float(1.0) / u_xlat6;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat1.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat1.x / _AlbedoTileSplitU;
    u_xlat1.y = floor(u_xlat0.x);
    u_xlat0.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.yx / vec2(_AlbedoTileSplitV, _AlbedoTileSplitU);
    u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat16_0.xyz = texture(_MainTex, u_xlat0.yz).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
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