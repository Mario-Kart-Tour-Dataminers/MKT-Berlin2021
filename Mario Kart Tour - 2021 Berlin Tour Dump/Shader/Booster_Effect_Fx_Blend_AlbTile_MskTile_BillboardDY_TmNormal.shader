//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Blend_AlbTile_MskTile_BillboardDY_TmNormal" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("RGB(UV0)", 2D) = "white" { }
[Header(RGB UV Tile)] _AlbedoTileFreq ("コマ送り速度", Range(-1000, 1000)) = 0
_AlbedoTileSplitU ("U方向：分割数", Range(1, 32)) = 1
_AlbedoTileSplitV ("V方向：分割数", Range(1, 32)) = 1
_AlphaTexture ("A(UV0)", 2D) = "black" { }
[Header(A UV Tile)] _AlphaTextureTileFreq ("コマ送り速度", Range(-1000, 1000)) = 0
_AlphaTextureTileSplitU ("U方向：分割数", Range(1, 32)) = 1
_AlphaTextureTileSplitV ("V方向：分割数", Range(1, 32)) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 45909
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_TEXCOORD1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.w = (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.x = u_xlat12 * u_xlat0.z;
    u_xlat1.z = u_xlat12 * (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.y = 0.0;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.zxy;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat3.xyz = u_xlat3.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat0.xyz = in_TEXCOORD1.xyz * u_xlat3.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
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
uniform 	mediump float _AlphaTextureTileFreq;
uniform 	mediump float _AlphaTextureTileSplitU;
uniform 	mediump float _AlphaTextureTileSplitV;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
vec2 u_xlat3;
mediump float u_xlat16_9;
bool u_xlatb10;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.x = booster_Env.x * _AlphaTextureTileFreq;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3.xy = vs_TEXCOORD1.xy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV);
    u_xlat3.xy = trunc(u_xlat3.xy);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = u_xlat3.y * _AlphaTextureTileSplitU + u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD1.xy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV) + (-u_xlat3.xy);
    u_xlat16_9 = _AlphaTextureTileSplitV * _AlphaTextureTileSplitU;
    u_xlat0.x = u_xlat0.x / u_xlat16_9;
    u_xlatb1 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb1) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat1.x = u_xlat16_9 * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / _AlphaTextureTileSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.y = (-u_xlat0.x);
    u_xlat0.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy / vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV);
    u_xlat10_0.x = texture2D(_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0.x) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat0.x = booster_Env.x * _AlbedoTileFreq;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat3.xy = trunc(u_xlat3.xy);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = u_xlat3.y * _AlbedoTileSplitU + u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV) + (-u_xlat3.xy);
    u_xlat16_9 = _AlbedoTileSplitV * _AlbedoTileSplitU;
    u_xlat0.x = u_xlat0.x / u_xlat16_9;
    u_xlatb10 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb10) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2.x = u_xlat16_9 * u_xlat0.x;
    u_xlat0.x = u_xlat2.x / _AlbedoTileSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.y = (-u_xlat0.x);
    u_xlat0.xy = u_xlat3.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat0.xy / vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat10_0.xyz = texture2D(_MainTex, u_xlat0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_TEXCOORD1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.w = (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.x = u_xlat12 * u_xlat0.z;
    u_xlat1.z = u_xlat12 * (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.y = 0.0;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.zxy;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat3.xyz = u_xlat3.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat0.xyz = in_TEXCOORD1.xyz * u_xlat3.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
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
uniform 	mediump float _AlphaTextureTileFreq;
uniform 	mediump float _AlphaTextureTileSplitU;
uniform 	mediump float _AlphaTextureTileSplitV;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
vec2 u_xlat3;
mediump float u_xlat16_9;
bool u_xlatb10;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.x = booster_Env.x * _AlphaTextureTileFreq;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3.xy = vs_TEXCOORD1.xy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV);
    u_xlat3.xy = trunc(u_xlat3.xy);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = u_xlat3.y * _AlphaTextureTileSplitU + u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD1.xy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV) + (-u_xlat3.xy);
    u_xlat16_9 = _AlphaTextureTileSplitV * _AlphaTextureTileSplitU;
    u_xlat0.x = u_xlat0.x / u_xlat16_9;
    u_xlatb1 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb1) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat1.x = u_xlat16_9 * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / _AlphaTextureTileSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.y = (-u_xlat0.x);
    u_xlat0.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy / vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV);
    u_xlat10_0.x = texture2D(_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0.x) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat0.x = booster_Env.x * _AlbedoTileFreq;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat3.xy = trunc(u_xlat3.xy);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = u_xlat3.y * _AlbedoTileSplitU + u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV) + (-u_xlat3.xy);
    u_xlat16_9 = _AlbedoTileSplitV * _AlbedoTileSplitU;
    u_xlat0.x = u_xlat0.x / u_xlat16_9;
    u_xlatb10 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb10) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2.x = u_xlat16_9 * u_xlat0.x;
    u_xlat0.x = u_xlat2.x / _AlbedoTileSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.y = (-u_xlat0.x);
    u_xlat0.xy = u_xlat3.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat0.xy / vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat10_0.xyz = texture2D(_MainTex, u_xlat0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_TEXCOORD1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.w = (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.x = u_xlat12 * u_xlat0.z;
    u_xlat1.z = u_xlat12 * (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.y = 0.0;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.zxy;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat3.xyz = u_xlat3.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat0.xyz = in_TEXCOORD1.xyz * u_xlat3.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
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
uniform 	mediump float _AlphaTextureTileFreq;
uniform 	mediump float _AlphaTextureTileSplitU;
uniform 	mediump float _AlphaTextureTileSplitV;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
vec2 u_xlat3;
mediump float u_xlat16_9;
bool u_xlatb10;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.x = booster_Env.x * _AlphaTextureTileFreq;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3.xy = vs_TEXCOORD1.xy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV);
    u_xlat3.xy = trunc(u_xlat3.xy);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = u_xlat3.y * _AlphaTextureTileSplitU + u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD1.xy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV) + (-u_xlat3.xy);
    u_xlat16_9 = _AlphaTextureTileSplitV * _AlphaTextureTileSplitU;
    u_xlat0.x = u_xlat0.x / u_xlat16_9;
    u_xlatb1 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb1) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat1.x = u_xlat16_9 * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / _AlphaTextureTileSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.y = (-u_xlat0.x);
    u_xlat0.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy / vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV);
    u_xlat10_0.x = texture2D(_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0.x) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat0.x = booster_Env.x * _AlbedoTileFreq;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat3.xy = trunc(u_xlat3.xy);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = u_xlat3.y * _AlbedoTileSplitU + u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV) + (-u_xlat3.xy);
    u_xlat16_9 = _AlbedoTileSplitV * _AlbedoTileSplitU;
    u_xlat0.x = u_xlat0.x / u_xlat16_9;
    u_xlatb10 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb10) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2.x = u_xlat16_9 * u_xlat0.x;
    u_xlat0.x = u_xlat2.x / _AlbedoTileSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.y = (-u_xlat0.x);
    u_xlat0.xy = u_xlat3.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat0.xy / vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat10_0.xyz = texture2D(_MainTex, u_xlat0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_TEXCOORD1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.w = (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.x = u_xlat12 * u_xlat0.z;
    u_xlat1.z = u_xlat12 * (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.y = 0.0;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.zxy;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat3.xyz = u_xlat3.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat0.xyz = in_TEXCOORD1.xyz * u_xlat3.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
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
uniform 	mediump float _AlphaTextureTileFreq;
uniform 	mediump float _AlphaTextureTileSplitU;
uniform 	mediump float _AlphaTextureTileSplitV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
vec2 u_xlat3;
mediump float u_xlat16_9;
bool u_xlatb10;
void main()
{
    u_xlat0.x = booster_Env.x * _AlphaTextureTileFreq;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3.xy = vs_TEXCOORD1.xy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV);
    u_xlat3.xy = trunc(u_xlat3.xy);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = u_xlat3.y * _AlphaTextureTileSplitU + u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD1.xy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV) + (-u_xlat3.xy);
    u_xlat16_9 = _AlphaTextureTileSplitV * _AlphaTextureTileSplitU;
    u_xlat0.x = u_xlat0.x / u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb1 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb1) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat1.x = u_xlat16_9 * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / _AlphaTextureTileSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.y = (-u_xlat0.x);
    u_xlat0.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy / vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV);
    u_xlat16_0.x = texture(_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.w = u_xlat16_0.x * u_xlat1.w;
    u_xlat0.x = booster_Env.x * _AlbedoTileFreq;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat3.xy = trunc(u_xlat3.xy);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = u_xlat3.y * _AlbedoTileSplitU + u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV) + (-u_xlat3.xy);
    u_xlat16_9 = _AlbedoTileSplitV * _AlbedoTileSplitU;
    u_xlat0.x = u_xlat0.x / u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb10 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb10) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2.x = u_xlat16_9 * u_xlat0.x;
    u_xlat0.x = u_xlat2.x / _AlbedoTileSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.y = (-u_xlat0.x);
    u_xlat0.xy = u_xlat3.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat0.xy / vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat16_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_TEXCOORD1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.w = (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.x = u_xlat12 * u_xlat0.z;
    u_xlat1.z = u_xlat12 * (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.y = 0.0;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.zxy;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat3.xyz = u_xlat3.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat0.xyz = in_TEXCOORD1.xyz * u_xlat3.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
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
uniform 	mediump float _AlphaTextureTileFreq;
uniform 	mediump float _AlphaTextureTileSplitU;
uniform 	mediump float _AlphaTextureTileSplitV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
vec2 u_xlat3;
mediump float u_xlat16_9;
bool u_xlatb10;
void main()
{
    u_xlat0.x = booster_Env.x * _AlphaTextureTileFreq;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3.xy = vs_TEXCOORD1.xy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV);
    u_xlat3.xy = trunc(u_xlat3.xy);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = u_xlat3.y * _AlphaTextureTileSplitU + u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD1.xy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV) + (-u_xlat3.xy);
    u_xlat16_9 = _AlphaTextureTileSplitV * _AlphaTextureTileSplitU;
    u_xlat0.x = u_xlat0.x / u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb1 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb1) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat1.x = u_xlat16_9 * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / _AlphaTextureTileSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.y = (-u_xlat0.x);
    u_xlat0.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy / vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV);
    u_xlat16_0.x = texture(_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.w = u_xlat16_0.x * u_xlat1.w;
    u_xlat0.x = booster_Env.x * _AlbedoTileFreq;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat3.xy = trunc(u_xlat3.xy);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = u_xlat3.y * _AlbedoTileSplitU + u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV) + (-u_xlat3.xy);
    u_xlat16_9 = _AlbedoTileSplitV * _AlbedoTileSplitU;
    u_xlat0.x = u_xlat0.x / u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb10 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb10) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2.x = u_xlat16_9 * u_xlat0.x;
    u_xlat0.x = u_xlat2.x / _AlbedoTileSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.y = (-u_xlat0.x);
    u_xlat0.xy = u_xlat3.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat0.xy / vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat16_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_TEXCOORD1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.w = (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.x = u_xlat12 * u_xlat0.z;
    u_xlat1.z = u_xlat12 * (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.y = 0.0;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.zxy;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat3.xyz = u_xlat3.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat0.xyz = in_TEXCOORD1.xyz * u_xlat3.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
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
uniform 	mediump float _AlphaTextureTileFreq;
uniform 	mediump float _AlphaTextureTileSplitU;
uniform 	mediump float _AlphaTextureTileSplitV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
vec2 u_xlat3;
mediump float u_xlat16_9;
bool u_xlatb10;
void main()
{
    u_xlat0.x = booster_Env.x * _AlphaTextureTileFreq;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3.xy = vs_TEXCOORD1.xy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV);
    u_xlat3.xy = trunc(u_xlat3.xy);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = u_xlat3.y * _AlphaTextureTileSplitU + u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD1.xy * vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV) + (-u_xlat3.xy);
    u_xlat16_9 = _AlphaTextureTileSplitV * _AlphaTextureTileSplitU;
    u_xlat0.x = u_xlat0.x / u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb1 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb1) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat1.x = u_xlat16_9 * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / _AlphaTextureTileSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.y = (-u_xlat0.x);
    u_xlat0.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy / vec2(_AlphaTextureTileSplitU, _AlphaTextureTileSplitV);
    u_xlat16_0.x = texture(_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.w = u_xlat16_0.x * u_xlat1.w;
    u_xlat0.x = booster_Env.x * _AlbedoTileFreq;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat3.xy = trunc(u_xlat3.xy);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = u_xlat3.y * _AlbedoTileSplitU + u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(_AlbedoTileSplitU, _AlbedoTileSplitV) + (-u_xlat3.xy);
    u_xlat16_9 = _AlbedoTileSplitV * _AlbedoTileSplitU;
    u_xlat0.x = u_xlat0.x / u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb10 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb10) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2.x = u_xlat16_9 * u_xlat0.x;
    u_xlat0.x = u_xlat2.x / _AlbedoTileSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.y = (-u_xlat0.x);
    u_xlat0.xy = u_xlat3.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat0.xy / vec2(_AlbedoTileSplitU, _AlbedoTileSplitV);
    u_xlat16_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
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