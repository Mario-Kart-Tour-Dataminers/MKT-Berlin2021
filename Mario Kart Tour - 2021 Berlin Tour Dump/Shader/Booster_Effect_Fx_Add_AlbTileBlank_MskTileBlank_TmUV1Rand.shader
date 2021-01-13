//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Add_AlbTileBlank_MskTileBlank_TmUV1Rand" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
[Header(UV Random Animation Time)] _uvRandMin ("最小開始時間", Float) = 0
_uvRandMax ("最大開始時間", Float) = 1
_uvRandSeed ("時間ばらつき乱数の種", Vector) = (0,0,0,0)
_MainTex ("RGB(UV0)", 2D) = "white" { }
[Header(RGB UV Blank Header and Clamp Repeat Tile)] _AlbedoTileFreq ("コマ送り速度", Range(-1000, 1000)) = 0
_AlbedoTileSplitU ("U方向：分割数", Range(1, 32)) = 1
_AlbedoTileSplitV ("V方向：分割数", Range(1, 32)) = 1
_AlbedoClampCount ("繰り返すコマ数", Range(1, 512)) = 1
_AlbedoBlankCount ("先頭の空白コマ数", Range(0, 10000)) = 1
_AlphaTexture ("A(UV0)", 2D) = "black" { }
[Header(A UV Blank Header and Clamp Repeat Tile)] _AlphaTextureTileFreq ("コマ送り速度", Range(-1000, 1000)) = 0
_AlphaTextureTileSplitU ("U方向：分割数", Range(1, 32)) = 1
_AlphaTextureTileSplitV ("V方向：分割数", Range(1, 32)) = 1
_AlphaTextureClampCount ("繰り返すコマ数", Range(1, 512)) = 1
_AlphaTextureBlankCount ("先頭の空白コマ数", Range(0, 10000)) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 13504
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	mediump float _uvRandMin;
uniform 	mediump float _uvRandMax;
uniform 	mediump vec3 _uvRandSeed;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec2 in_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    u_xlat16_2 = dot(in_TEXCOORD1.xy, _uvRandSeed.xy);
    u_xlat16_2 = fract(u_xlat16_2);
    u_xlat16_5 = (-_uvRandMin) + _uvRandMax;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_5 + _uvRandMin;
    vs_NORMAL0 = (-u_xlat16_2) + booster_Env.x;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoTileFreq;
uniform 	mediump float _AlbedoTileSplitU;
uniform 	mediump float _AlbedoTileSplitV;
uniform 	mediump float _AlbedoClampCount;
uniform 	float _AlbedoBlankCount;
uniform 	mediump float _AlphaTextureTileFreq;
uniform 	mediump float _AlphaTextureTileSplitU;
uniform 	mediump float _AlphaTextureTileSplitV;
uniform 	mediump float _AlphaTextureClampCount;
uniform 	float _AlphaTextureBlankCount;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
highp vec4 phase0_Input0_2;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_NORMAL0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
vec2 u_xlat5;
vec2 u_xlat8;
float u_xlat13;
mediump float u_xlat16_13;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    phase0_Input0_2 = vec4(vs_TEXCOORD0, vs_TEXCOORD1);
    u_xlat16_0 = _AlbedoTileSplitV * _AlbedoTileSplitU;
    u_xlat16_0 = min(u_xlat16_0, _AlbedoClampCount);
    u_xlat0.x = u_xlat16_0 + _AlbedoBlankCount;
    u_xlat4 = vs_NORMAL0 * _AlbedoTileFreq;
    u_xlat4 = floor(u_xlat4);
    u_xlat8.xy = phase0_Input0_2.yw;
    u_xlat8.xy = clamp(u_xlat8.xy, 0.0, 1.0);
    u_xlat1.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat1.zw = phase0_Input0_2.xz;
    u_xlat8.xy = u_xlat1.zx * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat8.xy = trunc(u_xlat8.xy);
    u_xlat4 = u_xlat8.x + u_xlat4;
    u_xlat4 = u_xlat8.y * _AlbedoTileSplitU + u_xlat4;
    u_xlat8.xy = u_xlat1.zx * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV) + (-u_xlat8.xy);
    u_xlat1.x = u_xlat0.x * u_xlat4;
    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
    u_xlat0.x = (u_xlatb1) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat1.x = float(1.0) / u_xlat0.x;
    u_xlat4 = u_xlat4 * u_xlat1.x;
    u_xlat4 = fract(u_xlat4);
    u_xlat0.x = u_xlat0.x * u_xlat4 + (-_AlbedoBlankCount);
    u_xlatb1 = u_xlat0.x<0.0;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat1.x = vs_NORMAL0 * _AlphaTextureTileFreq;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat2.xy = u_xlat1.wy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV);
    u_xlat2.xy = trunc(u_xlat2.xy);
    u_xlat1.x = u_xlat1.x + u_xlat2.x;
    u_xlat1.x = u_xlat2.y * _AlphaTextureTileSplitU + u_xlat1.x;
    u_xlat5.xy = u_xlat1.wy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV) + (-u_xlat2.xy);
    u_xlat16_13 = _AlphaTextureTileSplitV * _AlphaTextureTileSplitU;
    u_xlat16_13 = min(u_xlat16_13, _AlphaTextureClampCount);
    u_xlat13 = u_xlat16_13 + _AlphaTextureBlankCount;
    u_xlat2.x = u_xlat13 * u_xlat1.x;
    u_xlatb2 = u_xlat2.x>=(-u_xlat2.x);
    u_xlat13 = (u_xlatb2) ? u_xlat13 : (-u_xlat13);
    u_xlat2.x = float(1.0) / u_xlat13;
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat2.x = u_xlat13 * u_xlat1.x + (-_AlphaTextureBlankCount);
    u_xlatb1 = u_xlat2.x<0.0;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat1.x = u_xlat0.x / _AlbedoTileSplitU;
    u_xlat0.y = floor(u_xlat1.x);
    u_xlat0.xy = u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.yx / vec2(_AlbedoTileSplitV, _AlbedoTileSplitU);
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat10_0.xyz = texture2D(_MainTex, u_xlat0.yz).xyz;
    u_xlat3 = vs_COLOR0 * _Color;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat3.xyz;
    u_xlat0.x = u_xlat2.x / _AlphaTextureTileSplitU;
    u_xlat2.y = floor(u_xlat0.x);
    u_xlat0.xy = u_xlat5.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat0.yx / vec2(_AlphaTextureTileSplitV, _AlphaTextureTileSplitU);
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat10_0.x = texture2D(_AlphaTexture, u_xlat0.yz).x;
    u_xlat16_0 = (-u_xlat10_0.x) + 1.0;
    SV_Target0.w = u_xlat16_0 * u_xlat3.w;
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
uniform 	vec4 booster_Env;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	mediump float _uvRandMin;
uniform 	mediump float _uvRandMax;
uniform 	mediump vec3 _uvRandSeed;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec2 in_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    u_xlat16_2 = dot(in_TEXCOORD1.xy, _uvRandSeed.xy);
    u_xlat16_2 = fract(u_xlat16_2);
    u_xlat16_5 = (-_uvRandMin) + _uvRandMax;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_5 + _uvRandMin;
    vs_NORMAL0 = (-u_xlat16_2) + booster_Env.x;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoTileFreq;
uniform 	mediump float _AlbedoTileSplitU;
uniform 	mediump float _AlbedoTileSplitV;
uniform 	mediump float _AlbedoClampCount;
uniform 	float _AlbedoBlankCount;
uniform 	mediump float _AlphaTextureTileFreq;
uniform 	mediump float _AlphaTextureTileSplitU;
uniform 	mediump float _AlphaTextureTileSplitV;
uniform 	mediump float _AlphaTextureClampCount;
uniform 	float _AlphaTextureBlankCount;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
highp vec4 phase0_Input0_2;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_NORMAL0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
vec2 u_xlat5;
vec2 u_xlat8;
float u_xlat13;
mediump float u_xlat16_13;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    phase0_Input0_2 = vec4(vs_TEXCOORD0, vs_TEXCOORD1);
    u_xlat16_0 = _AlbedoTileSplitV * _AlbedoTileSplitU;
    u_xlat16_0 = min(u_xlat16_0, _AlbedoClampCount);
    u_xlat0.x = u_xlat16_0 + _AlbedoBlankCount;
    u_xlat4 = vs_NORMAL0 * _AlbedoTileFreq;
    u_xlat4 = floor(u_xlat4);
    u_xlat8.xy = phase0_Input0_2.yw;
    u_xlat8.xy = clamp(u_xlat8.xy, 0.0, 1.0);
    u_xlat1.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat1.zw = phase0_Input0_2.xz;
    u_xlat8.xy = u_xlat1.zx * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat8.xy = trunc(u_xlat8.xy);
    u_xlat4 = u_xlat8.x + u_xlat4;
    u_xlat4 = u_xlat8.y * _AlbedoTileSplitU + u_xlat4;
    u_xlat8.xy = u_xlat1.zx * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV) + (-u_xlat8.xy);
    u_xlat1.x = u_xlat0.x * u_xlat4;
    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
    u_xlat0.x = (u_xlatb1) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat1.x = float(1.0) / u_xlat0.x;
    u_xlat4 = u_xlat4 * u_xlat1.x;
    u_xlat4 = fract(u_xlat4);
    u_xlat0.x = u_xlat0.x * u_xlat4 + (-_AlbedoBlankCount);
    u_xlatb1 = u_xlat0.x<0.0;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat1.x = vs_NORMAL0 * _AlphaTextureTileFreq;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat2.xy = u_xlat1.wy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV);
    u_xlat2.xy = trunc(u_xlat2.xy);
    u_xlat1.x = u_xlat1.x + u_xlat2.x;
    u_xlat1.x = u_xlat2.y * _AlphaTextureTileSplitU + u_xlat1.x;
    u_xlat5.xy = u_xlat1.wy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV) + (-u_xlat2.xy);
    u_xlat16_13 = _AlphaTextureTileSplitV * _AlphaTextureTileSplitU;
    u_xlat16_13 = min(u_xlat16_13, _AlphaTextureClampCount);
    u_xlat13 = u_xlat16_13 + _AlphaTextureBlankCount;
    u_xlat2.x = u_xlat13 * u_xlat1.x;
    u_xlatb2 = u_xlat2.x>=(-u_xlat2.x);
    u_xlat13 = (u_xlatb2) ? u_xlat13 : (-u_xlat13);
    u_xlat2.x = float(1.0) / u_xlat13;
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat2.x = u_xlat13 * u_xlat1.x + (-_AlphaTextureBlankCount);
    u_xlatb1 = u_xlat2.x<0.0;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat1.x = u_xlat0.x / _AlbedoTileSplitU;
    u_xlat0.y = floor(u_xlat1.x);
    u_xlat0.xy = u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.yx / vec2(_AlbedoTileSplitV, _AlbedoTileSplitU);
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat10_0.xyz = texture2D(_MainTex, u_xlat0.yz).xyz;
    u_xlat3 = vs_COLOR0 * _Color;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat3.xyz;
    u_xlat0.x = u_xlat2.x / _AlphaTextureTileSplitU;
    u_xlat2.y = floor(u_xlat0.x);
    u_xlat0.xy = u_xlat5.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat0.yx / vec2(_AlphaTextureTileSplitV, _AlphaTextureTileSplitU);
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat10_0.x = texture2D(_AlphaTexture, u_xlat0.yz).x;
    u_xlat16_0 = (-u_xlat10_0.x) + 1.0;
    SV_Target0.w = u_xlat16_0 * u_xlat3.w;
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
uniform 	vec4 booster_Env;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	mediump float _uvRandMin;
uniform 	mediump float _uvRandMax;
uniform 	mediump vec3 _uvRandSeed;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec2 in_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    u_xlat16_2 = dot(in_TEXCOORD1.xy, _uvRandSeed.xy);
    u_xlat16_2 = fract(u_xlat16_2);
    u_xlat16_5 = (-_uvRandMin) + _uvRandMax;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_5 + _uvRandMin;
    vs_NORMAL0 = (-u_xlat16_2) + booster_Env.x;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoTileFreq;
uniform 	mediump float _AlbedoTileSplitU;
uniform 	mediump float _AlbedoTileSplitV;
uniform 	mediump float _AlbedoClampCount;
uniform 	float _AlbedoBlankCount;
uniform 	mediump float _AlphaTextureTileFreq;
uniform 	mediump float _AlphaTextureTileSplitU;
uniform 	mediump float _AlphaTextureTileSplitV;
uniform 	mediump float _AlphaTextureClampCount;
uniform 	float _AlphaTextureBlankCount;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
highp vec4 phase0_Input0_2;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_NORMAL0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
vec2 u_xlat5;
vec2 u_xlat8;
float u_xlat13;
mediump float u_xlat16_13;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    phase0_Input0_2 = vec4(vs_TEXCOORD0, vs_TEXCOORD1);
    u_xlat16_0 = _AlbedoTileSplitV * _AlbedoTileSplitU;
    u_xlat16_0 = min(u_xlat16_0, _AlbedoClampCount);
    u_xlat0.x = u_xlat16_0 + _AlbedoBlankCount;
    u_xlat4 = vs_NORMAL0 * _AlbedoTileFreq;
    u_xlat4 = floor(u_xlat4);
    u_xlat8.xy = phase0_Input0_2.yw;
    u_xlat8.xy = clamp(u_xlat8.xy, 0.0, 1.0);
    u_xlat1.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat1.zw = phase0_Input0_2.xz;
    u_xlat8.xy = u_xlat1.zx * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat8.xy = trunc(u_xlat8.xy);
    u_xlat4 = u_xlat8.x + u_xlat4;
    u_xlat4 = u_xlat8.y * _AlbedoTileSplitU + u_xlat4;
    u_xlat8.xy = u_xlat1.zx * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV) + (-u_xlat8.xy);
    u_xlat1.x = u_xlat0.x * u_xlat4;
    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
    u_xlat0.x = (u_xlatb1) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat1.x = float(1.0) / u_xlat0.x;
    u_xlat4 = u_xlat4 * u_xlat1.x;
    u_xlat4 = fract(u_xlat4);
    u_xlat0.x = u_xlat0.x * u_xlat4 + (-_AlbedoBlankCount);
    u_xlatb1 = u_xlat0.x<0.0;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat1.x = vs_NORMAL0 * _AlphaTextureTileFreq;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat2.xy = u_xlat1.wy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV);
    u_xlat2.xy = trunc(u_xlat2.xy);
    u_xlat1.x = u_xlat1.x + u_xlat2.x;
    u_xlat1.x = u_xlat2.y * _AlphaTextureTileSplitU + u_xlat1.x;
    u_xlat5.xy = u_xlat1.wy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV) + (-u_xlat2.xy);
    u_xlat16_13 = _AlphaTextureTileSplitV * _AlphaTextureTileSplitU;
    u_xlat16_13 = min(u_xlat16_13, _AlphaTextureClampCount);
    u_xlat13 = u_xlat16_13 + _AlphaTextureBlankCount;
    u_xlat2.x = u_xlat13 * u_xlat1.x;
    u_xlatb2 = u_xlat2.x>=(-u_xlat2.x);
    u_xlat13 = (u_xlatb2) ? u_xlat13 : (-u_xlat13);
    u_xlat2.x = float(1.0) / u_xlat13;
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat2.x = u_xlat13 * u_xlat1.x + (-_AlphaTextureBlankCount);
    u_xlatb1 = u_xlat2.x<0.0;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat1.x = u_xlat0.x / _AlbedoTileSplitU;
    u_xlat0.y = floor(u_xlat1.x);
    u_xlat0.xy = u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.yx / vec2(_AlbedoTileSplitV, _AlbedoTileSplitU);
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat10_0.xyz = texture2D(_MainTex, u_xlat0.yz).xyz;
    u_xlat3 = vs_COLOR0 * _Color;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat3.xyz;
    u_xlat0.x = u_xlat2.x / _AlphaTextureTileSplitU;
    u_xlat2.y = floor(u_xlat0.x);
    u_xlat0.xy = u_xlat5.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat0.yx / vec2(_AlphaTextureTileSplitV, _AlphaTextureTileSplitU);
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat10_0.x = texture2D(_AlphaTexture, u_xlat0.yz).x;
    u_xlat16_0 = (-u_xlat10_0.x) + 1.0;
    SV_Target0.w = u_xlat16_0 * u_xlat3.w;
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
uniform 	vec4 booster_Env;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	mediump float _uvRandMin;
uniform 	mediump float _uvRandMax;
uniform 	mediump vec3 _uvRandSeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    u_xlat16_2 = dot(in_TEXCOORD1.xy, _uvRandSeed.xy);
    u_xlat16_2 = fract(u_xlat16_2);
    u_xlat16_5 = (-_uvRandMin) + _uvRandMax;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_5 + _uvRandMin;
    vs_NORMAL0 = (-u_xlat16_2) + booster_Env.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoTileFreq;
uniform 	mediump float _AlbedoTileSplitU;
uniform 	mediump float _AlbedoTileSplitV;
uniform 	mediump float _AlbedoClampCount;
uniform 	float _AlbedoBlankCount;
uniform 	mediump float _AlphaTextureTileFreq;
uniform 	mediump float _AlphaTextureTileSplitU;
uniform 	mediump float _AlphaTextureTileSplitV;
uniform 	mediump float _AlphaTextureClampCount;
uniform 	float _AlphaTextureBlankCount;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
highp vec4 phase0_Input0_2;
in highp vec2 vs_TEXCOORD1;
in highp float vs_NORMAL0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
vec2 u_xlat5;
vec2 u_xlat8;
float u_xlat13;
mediump float u_xlat16_13;
void main()
{
    phase0_Input0_2 = vec4(vs_TEXCOORD0, vs_TEXCOORD1);
    u_xlat16_0.x = _AlbedoTileSplitV * _AlbedoTileSplitU;
    u_xlat16_0.x = min(u_xlat16_0.x, _AlbedoClampCount);
    u_xlat0.x = u_xlat16_0.x + _AlbedoBlankCount;
    u_xlat4 = vs_NORMAL0 * _AlbedoTileFreq;
    u_xlat4 = floor(u_xlat4);
    u_xlat8.xy = phase0_Input0_2.yw;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.xy = min(max(u_xlat8.xy, 0.0), 1.0);
#else
    u_xlat8.xy = clamp(u_xlat8.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat1.zw = phase0_Input0_2.xz;
    u_xlat8.xy = u_xlat1.zx * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat8.xy = trunc(u_xlat8.xy);
    u_xlat4 = u_xlat8.x + u_xlat4;
    u_xlat4 = u_xlat8.y * _AlbedoTileSplitU + u_xlat4;
    u_xlat8.xy = u_xlat1.zx * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV) + (-u_xlat8.xy);
    u_xlat1.x = u_xlat0.x * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlat0.x = (u_xlatb1) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat1.x = float(1.0) / u_xlat0.x;
    u_xlat4 = u_xlat4 * u_xlat1.x;
    u_xlat4 = fract(u_xlat4);
    u_xlat0.x = u_xlat0.x * u_xlat4 + (-_AlbedoBlankCount);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.0);
#else
    u_xlatb1 = u_xlat0.x<0.0;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat1.x = vs_NORMAL0 * _AlphaTextureTileFreq;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat2.xy = u_xlat1.wy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV);
    u_xlat2.xy = trunc(u_xlat2.xy);
    u_xlat1.x = u_xlat1.x + u_xlat2.x;
    u_xlat1.x = u_xlat2.y * _AlphaTextureTileSplitU + u_xlat1.x;
    u_xlat5.xy = u_xlat1.wy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV) + (-u_xlat2.xy);
    u_xlat16_13 = _AlphaTextureTileSplitV * _AlphaTextureTileSplitU;
    u_xlat16_13 = min(u_xlat16_13, _AlphaTextureClampCount);
    u_xlat13 = u_xlat16_13 + _AlphaTextureBlankCount;
    u_xlat2.x = u_xlat13 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2.x>=(-u_xlat2.x));
#else
    u_xlatb2 = u_xlat2.x>=(-u_xlat2.x);
#endif
    u_xlat13 = (u_xlatb2) ? u_xlat13 : (-u_xlat13);
    u_xlat2.x = float(1.0) / u_xlat13;
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat2.x = u_xlat13 * u_xlat1.x + (-_AlphaTextureBlankCount);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat2.x<0.0);
#else
    u_xlatb1 = u_xlat2.x<0.0;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat1.x = u_xlat0.x / _AlbedoTileSplitU;
    u_xlat0.y = floor(u_xlat1.x);
    u_xlat0.xy = u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.yx / vec2(_AlbedoTileSplitV, _AlbedoTileSplitU);
    u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat16_0.xyz = texture(_MainTex, u_xlat0.yz).xyz;
    u_xlat3 = vs_COLOR0 * _Color;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat3.xyz;
    u_xlat0.x = u_xlat2.x / _AlphaTextureTileSplitU;
    u_xlat2.y = floor(u_xlat0.x);
    u_xlat0.xy = u_xlat5.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat0.yx / vec2(_AlphaTextureTileSplitV, _AlphaTextureTileSplitU);
    u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat16_0.x = texture(_AlphaTexture, u_xlat0.yz).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    SV_Target0.w = u_xlat16_0.x * u_xlat3.w;
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
uniform 	vec4 booster_Env;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	mediump float _uvRandMin;
uniform 	mediump float _uvRandMax;
uniform 	mediump vec3 _uvRandSeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    u_xlat16_2 = dot(in_TEXCOORD1.xy, _uvRandSeed.xy);
    u_xlat16_2 = fract(u_xlat16_2);
    u_xlat16_5 = (-_uvRandMin) + _uvRandMax;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_5 + _uvRandMin;
    vs_NORMAL0 = (-u_xlat16_2) + booster_Env.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoTileFreq;
uniform 	mediump float _AlbedoTileSplitU;
uniform 	mediump float _AlbedoTileSplitV;
uniform 	mediump float _AlbedoClampCount;
uniform 	float _AlbedoBlankCount;
uniform 	mediump float _AlphaTextureTileFreq;
uniform 	mediump float _AlphaTextureTileSplitU;
uniform 	mediump float _AlphaTextureTileSplitV;
uniform 	mediump float _AlphaTextureClampCount;
uniform 	float _AlphaTextureBlankCount;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
highp vec4 phase0_Input0_2;
in highp vec2 vs_TEXCOORD1;
in highp float vs_NORMAL0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
vec2 u_xlat5;
vec2 u_xlat8;
float u_xlat13;
mediump float u_xlat16_13;
void main()
{
    phase0_Input0_2 = vec4(vs_TEXCOORD0, vs_TEXCOORD1);
    u_xlat16_0.x = _AlbedoTileSplitV * _AlbedoTileSplitU;
    u_xlat16_0.x = min(u_xlat16_0.x, _AlbedoClampCount);
    u_xlat0.x = u_xlat16_0.x + _AlbedoBlankCount;
    u_xlat4 = vs_NORMAL0 * _AlbedoTileFreq;
    u_xlat4 = floor(u_xlat4);
    u_xlat8.xy = phase0_Input0_2.yw;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.xy = min(max(u_xlat8.xy, 0.0), 1.0);
#else
    u_xlat8.xy = clamp(u_xlat8.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat1.zw = phase0_Input0_2.xz;
    u_xlat8.xy = u_xlat1.zx * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat8.xy = trunc(u_xlat8.xy);
    u_xlat4 = u_xlat8.x + u_xlat4;
    u_xlat4 = u_xlat8.y * _AlbedoTileSplitU + u_xlat4;
    u_xlat8.xy = u_xlat1.zx * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV) + (-u_xlat8.xy);
    u_xlat1.x = u_xlat0.x * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlat0.x = (u_xlatb1) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat1.x = float(1.0) / u_xlat0.x;
    u_xlat4 = u_xlat4 * u_xlat1.x;
    u_xlat4 = fract(u_xlat4);
    u_xlat0.x = u_xlat0.x * u_xlat4 + (-_AlbedoBlankCount);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.0);
#else
    u_xlatb1 = u_xlat0.x<0.0;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat1.x = vs_NORMAL0 * _AlphaTextureTileFreq;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat2.xy = u_xlat1.wy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV);
    u_xlat2.xy = trunc(u_xlat2.xy);
    u_xlat1.x = u_xlat1.x + u_xlat2.x;
    u_xlat1.x = u_xlat2.y * _AlphaTextureTileSplitU + u_xlat1.x;
    u_xlat5.xy = u_xlat1.wy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV) + (-u_xlat2.xy);
    u_xlat16_13 = _AlphaTextureTileSplitV * _AlphaTextureTileSplitU;
    u_xlat16_13 = min(u_xlat16_13, _AlphaTextureClampCount);
    u_xlat13 = u_xlat16_13 + _AlphaTextureBlankCount;
    u_xlat2.x = u_xlat13 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2.x>=(-u_xlat2.x));
#else
    u_xlatb2 = u_xlat2.x>=(-u_xlat2.x);
#endif
    u_xlat13 = (u_xlatb2) ? u_xlat13 : (-u_xlat13);
    u_xlat2.x = float(1.0) / u_xlat13;
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat2.x = u_xlat13 * u_xlat1.x + (-_AlphaTextureBlankCount);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat2.x<0.0);
#else
    u_xlatb1 = u_xlat2.x<0.0;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat1.x = u_xlat0.x / _AlbedoTileSplitU;
    u_xlat0.y = floor(u_xlat1.x);
    u_xlat0.xy = u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.yx / vec2(_AlbedoTileSplitV, _AlbedoTileSplitU);
    u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat16_0.xyz = texture(_MainTex, u_xlat0.yz).xyz;
    u_xlat3 = vs_COLOR0 * _Color;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat3.xyz;
    u_xlat0.x = u_xlat2.x / _AlphaTextureTileSplitU;
    u_xlat2.y = floor(u_xlat0.x);
    u_xlat0.xy = u_xlat5.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat0.yx / vec2(_AlphaTextureTileSplitV, _AlphaTextureTileSplitU);
    u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat16_0.x = texture(_AlphaTexture, u_xlat0.yz).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    SV_Target0.w = u_xlat16_0.x * u_xlat3.w;
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
uniform 	vec4 booster_Env;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	mediump float _uvRandMin;
uniform 	mediump float _uvRandMax;
uniform 	mediump vec3 _uvRandSeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    u_xlat16_2 = dot(in_TEXCOORD1.xy, _uvRandSeed.xy);
    u_xlat16_2 = fract(u_xlat16_2);
    u_xlat16_5 = (-_uvRandMin) + _uvRandMax;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_5 + _uvRandMin;
    vs_NORMAL0 = (-u_xlat16_2) + booster_Env.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoTileFreq;
uniform 	mediump float _AlbedoTileSplitU;
uniform 	mediump float _AlbedoTileSplitV;
uniform 	mediump float _AlbedoClampCount;
uniform 	float _AlbedoBlankCount;
uniform 	mediump float _AlphaTextureTileFreq;
uniform 	mediump float _AlphaTextureTileSplitU;
uniform 	mediump float _AlphaTextureTileSplitV;
uniform 	mediump float _AlphaTextureClampCount;
uniform 	float _AlphaTextureBlankCount;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
highp vec4 phase0_Input0_2;
in highp vec2 vs_TEXCOORD1;
in highp float vs_NORMAL0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
vec2 u_xlat5;
vec2 u_xlat8;
float u_xlat13;
mediump float u_xlat16_13;
void main()
{
    phase0_Input0_2 = vec4(vs_TEXCOORD0, vs_TEXCOORD1);
    u_xlat16_0.x = _AlbedoTileSplitV * _AlbedoTileSplitU;
    u_xlat16_0.x = min(u_xlat16_0.x, _AlbedoClampCount);
    u_xlat0.x = u_xlat16_0.x + _AlbedoBlankCount;
    u_xlat4 = vs_NORMAL0 * _AlbedoTileFreq;
    u_xlat4 = floor(u_xlat4);
    u_xlat8.xy = phase0_Input0_2.yw;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.xy = min(max(u_xlat8.xy, 0.0), 1.0);
#else
    u_xlat8.xy = clamp(u_xlat8.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat1.zw = phase0_Input0_2.xz;
    u_xlat8.xy = u_xlat1.zx * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat8.xy = trunc(u_xlat8.xy);
    u_xlat4 = u_xlat8.x + u_xlat4;
    u_xlat4 = u_xlat8.y * _AlbedoTileSplitU + u_xlat4;
    u_xlat8.xy = u_xlat1.zx * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV) + (-u_xlat8.xy);
    u_xlat1.x = u_xlat0.x * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlat0.x = (u_xlatb1) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat1.x = float(1.0) / u_xlat0.x;
    u_xlat4 = u_xlat4 * u_xlat1.x;
    u_xlat4 = fract(u_xlat4);
    u_xlat0.x = u_xlat0.x * u_xlat4 + (-_AlbedoBlankCount);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.0);
#else
    u_xlatb1 = u_xlat0.x<0.0;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat1.x = vs_NORMAL0 * _AlphaTextureTileFreq;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat2.xy = u_xlat1.wy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV);
    u_xlat2.xy = trunc(u_xlat2.xy);
    u_xlat1.x = u_xlat1.x + u_xlat2.x;
    u_xlat1.x = u_xlat2.y * _AlphaTextureTileSplitU + u_xlat1.x;
    u_xlat5.xy = u_xlat1.wy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV) + (-u_xlat2.xy);
    u_xlat16_13 = _AlphaTextureTileSplitV * _AlphaTextureTileSplitU;
    u_xlat16_13 = min(u_xlat16_13, _AlphaTextureClampCount);
    u_xlat13 = u_xlat16_13 + _AlphaTextureBlankCount;
    u_xlat2.x = u_xlat13 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2.x>=(-u_xlat2.x));
#else
    u_xlatb2 = u_xlat2.x>=(-u_xlat2.x);
#endif
    u_xlat13 = (u_xlatb2) ? u_xlat13 : (-u_xlat13);
    u_xlat2.x = float(1.0) / u_xlat13;
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat2.x = u_xlat13 * u_xlat1.x + (-_AlphaTextureBlankCount);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat2.x<0.0);
#else
    u_xlatb1 = u_xlat2.x<0.0;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat1.x = u_xlat0.x / _AlbedoTileSplitU;
    u_xlat0.y = floor(u_xlat1.x);
    u_xlat0.xy = u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.yx / vec2(_AlbedoTileSplitV, _AlbedoTileSplitU);
    u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat16_0.xyz = texture(_MainTex, u_xlat0.yz).xyz;
    u_xlat3 = vs_COLOR0 * _Color;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat3.xyz;
    u_xlat0.x = u_xlat2.x / _AlphaTextureTileSplitU;
    u_xlat2.y = floor(u_xlat0.x);
    u_xlat0.xy = u_xlat5.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat0.yx / vec2(_AlphaTextureTileSplitV, _AlphaTextureTileSplitU);
    u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat16_0.x = texture(_AlphaTexture, u_xlat0.yz).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    SV_Target0.w = u_xlat16_0.x * u_xlat3.w;
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