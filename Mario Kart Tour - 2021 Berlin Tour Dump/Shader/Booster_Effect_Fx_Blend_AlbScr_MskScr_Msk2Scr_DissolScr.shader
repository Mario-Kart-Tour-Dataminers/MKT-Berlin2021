//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Blend_AlbScr_MskScr_Msk2Scr_DissolScr" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("RGB(UV0)", 2D) = "white" { }
[Header(RGB UV Scroll)] _AlbedoScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AlbedoScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
_AlphaTexture ("A(UV0)", 2D) = "black" { }
[Header(A UV Scroll)] _AlphaTextureScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AlphaTextureScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
[Header(Alpha 2)] _Alpha2Texture ("A2(UV0)", 2D) = "black" { }
[Header(A2 UV Scroll)] _Alpha2TextureScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_Alpha2TextureScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
_DissolveTexture ("Dissolve(UV0)", 2D) = "black" { }
_DissolveStart ("開始時間", Float) = 0
_DissolveTime ("溶解時間", Float) = 1
[Header(D UV Scroll)] _DissolveScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_DissolveScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 39132
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	vec4 _Alpha2Texture_ST;
uniform 	vec4 _DissolveTexture_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD5;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _DissolveTexture_ST.xy + _DissolveTexture_ST.zw;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _Alpha2Texture_ST.xy + _Alpha2Texture_ST.zw;
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	mediump float _Alpha2TextureScrollSpeedU;
uniform 	mediump float _Alpha2TextureScrollSpeedV;
uniform 	float _DissolveStart;
uniform 	float _DissolveTime;
uniform 	mediump float _DissolveScrollSpeedU;
uniform 	mediump float _DissolveScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
uniform lowp sampler2D _Alpha2Texture;
uniform lowp sampler2D _DissolveTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
float u_xlat9;
void main()
{
    u_xlat0 = booster_Env.x + (-_effectStart);
    u_xlat3.xy = vec2(u_xlat0) * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.xy;
    u_xlat10_3 = texture2D(_AlphaTexture, u_xlat3.xy).x;
    u_xlat16_3 = (-u_xlat10_3) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat3.x = u_xlat16_3 * u_xlat1.w;
    u_xlat6.xy = vec2(u_xlat0) * vec2(_Alpha2TextureScrollSpeedU, _Alpha2TextureScrollSpeedV);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD5.xy;
    u_xlat10_6 = texture2D(_Alpha2Texture, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat10_6) + 1.0;
    u_xlat3.x = u_xlat16_6 * u_xlat3.x;
    u_xlat6.xy = vec2(u_xlat0) * vec2(_DissolveScrollSpeedU, _DissolveScrollSpeedV);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD2.xy;
    u_xlat10_6 = texture2D(_DissolveTexture, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat10_6) + 1.0;
    u_xlat6.x = u_xlat16_6 * _DissolveTime;
    u_xlat9 = u_xlat0 + (-_DissolveStart);
    u_xlat2.xy = vec2(u_xlat0) * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat10_2.xyz = texture2D(_MainTex, u_xlat2.xy).xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlatb0 = u_xlat9<u_xlat6.x;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    SV_Target0.w = u_xlat0 * u_xlat3.x;
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
uniform 	vec4 _AlphaTexture_ST;
uniform 	vec4 _Alpha2Texture_ST;
uniform 	vec4 _DissolveTexture_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD5;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _DissolveTexture_ST.xy + _DissolveTexture_ST.zw;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _Alpha2Texture_ST.xy + _Alpha2Texture_ST.zw;
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	mediump float _Alpha2TextureScrollSpeedU;
uniform 	mediump float _Alpha2TextureScrollSpeedV;
uniform 	float _DissolveStart;
uniform 	float _DissolveTime;
uniform 	mediump float _DissolveScrollSpeedU;
uniform 	mediump float _DissolveScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
uniform lowp sampler2D _Alpha2Texture;
uniform lowp sampler2D _DissolveTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
float u_xlat9;
void main()
{
    u_xlat0 = booster_Env.x + (-_effectStart);
    u_xlat3.xy = vec2(u_xlat0) * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.xy;
    u_xlat10_3 = texture2D(_AlphaTexture, u_xlat3.xy).x;
    u_xlat16_3 = (-u_xlat10_3) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat3.x = u_xlat16_3 * u_xlat1.w;
    u_xlat6.xy = vec2(u_xlat0) * vec2(_Alpha2TextureScrollSpeedU, _Alpha2TextureScrollSpeedV);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD5.xy;
    u_xlat10_6 = texture2D(_Alpha2Texture, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat10_6) + 1.0;
    u_xlat3.x = u_xlat16_6 * u_xlat3.x;
    u_xlat6.xy = vec2(u_xlat0) * vec2(_DissolveScrollSpeedU, _DissolveScrollSpeedV);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD2.xy;
    u_xlat10_6 = texture2D(_DissolveTexture, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat10_6) + 1.0;
    u_xlat6.x = u_xlat16_6 * _DissolveTime;
    u_xlat9 = u_xlat0 + (-_DissolveStart);
    u_xlat2.xy = vec2(u_xlat0) * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat10_2.xyz = texture2D(_MainTex, u_xlat2.xy).xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlatb0 = u_xlat9<u_xlat6.x;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    SV_Target0.w = u_xlat0 * u_xlat3.x;
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
uniform 	vec4 _AlphaTexture_ST;
uniform 	vec4 _Alpha2Texture_ST;
uniform 	vec4 _DissolveTexture_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD5;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _DissolveTexture_ST.xy + _DissolveTexture_ST.zw;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _Alpha2Texture_ST.xy + _Alpha2Texture_ST.zw;
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	mediump float _Alpha2TextureScrollSpeedU;
uniform 	mediump float _Alpha2TextureScrollSpeedV;
uniform 	float _DissolveStart;
uniform 	float _DissolveTime;
uniform 	mediump float _DissolveScrollSpeedU;
uniform 	mediump float _DissolveScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
uniform lowp sampler2D _Alpha2Texture;
uniform lowp sampler2D _DissolveTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
float u_xlat9;
void main()
{
    u_xlat0 = booster_Env.x + (-_effectStart);
    u_xlat3.xy = vec2(u_xlat0) * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.xy;
    u_xlat10_3 = texture2D(_AlphaTexture, u_xlat3.xy).x;
    u_xlat16_3 = (-u_xlat10_3) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat3.x = u_xlat16_3 * u_xlat1.w;
    u_xlat6.xy = vec2(u_xlat0) * vec2(_Alpha2TextureScrollSpeedU, _Alpha2TextureScrollSpeedV);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD5.xy;
    u_xlat10_6 = texture2D(_Alpha2Texture, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat10_6) + 1.0;
    u_xlat3.x = u_xlat16_6 * u_xlat3.x;
    u_xlat6.xy = vec2(u_xlat0) * vec2(_DissolveScrollSpeedU, _DissolveScrollSpeedV);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD2.xy;
    u_xlat10_6 = texture2D(_DissolveTexture, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat10_6) + 1.0;
    u_xlat6.x = u_xlat16_6 * _DissolveTime;
    u_xlat9 = u_xlat0 + (-_DissolveStart);
    u_xlat2.xy = vec2(u_xlat0) * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat10_2.xyz = texture2D(_MainTex, u_xlat2.xy).xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlatb0 = u_xlat9<u_xlat6.x;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    SV_Target0.w = u_xlat0 * u_xlat3.x;
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
uniform 	vec4 _AlphaTexture_ST;
uniform 	vec4 _Alpha2Texture_ST;
uniform 	vec4 _DissolveTexture_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _DissolveTexture_ST.xy + _DissolveTexture_ST.zw;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _Alpha2Texture_ST.xy + _Alpha2Texture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	mediump float _Alpha2TextureScrollSpeedU;
uniform 	mediump float _Alpha2TextureScrollSpeedV;
uniform 	float _DissolveStart;
uniform 	float _DissolveTime;
uniform 	mediump float _DissolveScrollSpeedU;
uniform 	mediump float _DissolveScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
uniform mediump sampler2D _Alpha2Texture;
uniform mediump sampler2D _DissolveTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
vec2 u_xlat6;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0 = booster_Env.x + (-_effectStart);
    u_xlat3.xy = vec2(u_xlat0) * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.xy;
    u_xlat16_3 = texture(_AlphaTexture, u_xlat3.xy).x;
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat3.x = u_xlat16_3 * u_xlat1.w;
    u_xlat6.xy = vec2(u_xlat0) * vec2(_Alpha2TextureScrollSpeedU, _Alpha2TextureScrollSpeedV);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD5.xy;
    u_xlat16_6 = texture(_Alpha2Texture, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat3.x = u_xlat16_6 * u_xlat3.x;
    u_xlat6.xy = vec2(u_xlat0) * vec2(_DissolveScrollSpeedU, _DissolveScrollSpeedV);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD2.xy;
    u_xlat16_6 = texture(_DissolveTexture, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat6.x = u_xlat16_6 * _DissolveTime;
    u_xlat9 = u_xlat0 + (-_DissolveStart);
    u_xlat2.xy = vec2(u_xlat0) * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat9<u_xlat6.x);
#else
    u_xlatb0 = u_xlat9<u_xlat6.x;
#endif
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    SV_Target0.w = u_xlat0 * u_xlat3.x;
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
uniform 	vec4 _AlphaTexture_ST;
uniform 	vec4 _Alpha2Texture_ST;
uniform 	vec4 _DissolveTexture_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _DissolveTexture_ST.xy + _DissolveTexture_ST.zw;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _Alpha2Texture_ST.xy + _Alpha2Texture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	mediump float _Alpha2TextureScrollSpeedU;
uniform 	mediump float _Alpha2TextureScrollSpeedV;
uniform 	float _DissolveStart;
uniform 	float _DissolveTime;
uniform 	mediump float _DissolveScrollSpeedU;
uniform 	mediump float _DissolveScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
uniform mediump sampler2D _Alpha2Texture;
uniform mediump sampler2D _DissolveTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
vec2 u_xlat6;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0 = booster_Env.x + (-_effectStart);
    u_xlat3.xy = vec2(u_xlat0) * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.xy;
    u_xlat16_3 = texture(_AlphaTexture, u_xlat3.xy).x;
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat3.x = u_xlat16_3 * u_xlat1.w;
    u_xlat6.xy = vec2(u_xlat0) * vec2(_Alpha2TextureScrollSpeedU, _Alpha2TextureScrollSpeedV);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD5.xy;
    u_xlat16_6 = texture(_Alpha2Texture, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat3.x = u_xlat16_6 * u_xlat3.x;
    u_xlat6.xy = vec2(u_xlat0) * vec2(_DissolveScrollSpeedU, _DissolveScrollSpeedV);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD2.xy;
    u_xlat16_6 = texture(_DissolveTexture, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat6.x = u_xlat16_6 * _DissolveTime;
    u_xlat9 = u_xlat0 + (-_DissolveStart);
    u_xlat2.xy = vec2(u_xlat0) * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat9<u_xlat6.x);
#else
    u_xlatb0 = u_xlat9<u_xlat6.x;
#endif
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    SV_Target0.w = u_xlat0 * u_xlat3.x;
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
uniform 	vec4 _AlphaTexture_ST;
uniform 	vec4 _Alpha2Texture_ST;
uniform 	vec4 _DissolveTexture_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _DissolveTexture_ST.xy + _DissolveTexture_ST.zw;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _Alpha2Texture_ST.xy + _Alpha2Texture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	mediump float _Alpha2TextureScrollSpeedU;
uniform 	mediump float _Alpha2TextureScrollSpeedV;
uniform 	float _DissolveStart;
uniform 	float _DissolveTime;
uniform 	mediump float _DissolveScrollSpeedU;
uniform 	mediump float _DissolveScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
uniform mediump sampler2D _Alpha2Texture;
uniform mediump sampler2D _DissolveTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
vec2 u_xlat6;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0 = booster_Env.x + (-_effectStart);
    u_xlat3.xy = vec2(u_xlat0) * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.xy;
    u_xlat16_3 = texture(_AlphaTexture, u_xlat3.xy).x;
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat3.x = u_xlat16_3 * u_xlat1.w;
    u_xlat6.xy = vec2(u_xlat0) * vec2(_Alpha2TextureScrollSpeedU, _Alpha2TextureScrollSpeedV);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD5.xy;
    u_xlat16_6 = texture(_Alpha2Texture, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat3.x = u_xlat16_6 * u_xlat3.x;
    u_xlat6.xy = vec2(u_xlat0) * vec2(_DissolveScrollSpeedU, _DissolveScrollSpeedV);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD2.xy;
    u_xlat16_6 = texture(_DissolveTexture, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat6.x = u_xlat16_6 * _DissolveTime;
    u_xlat9 = u_xlat0 + (-_DissolveStart);
    u_xlat2.xy = vec2(u_xlat0) * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    SV_Target0.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat9<u_xlat6.x);
#else
    u_xlatb0 = u_xlat9<u_xlat6.x;
#endif
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    SV_Target0.w = u_xlat0 * u_xlat3.x;
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