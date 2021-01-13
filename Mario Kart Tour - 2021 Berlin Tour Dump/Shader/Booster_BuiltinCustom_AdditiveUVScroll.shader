//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/BuiltinCustom/AdditiveUVScroll" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_MainTex2 ("Particle Texture2", 2D) = "white" { }
_InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
_ScrollSpeedU ("U Scroll Speed", Range(-10, 10)) = 0
_ScrollSpeedV ("V Scroll Speed", Range(-10, 10)) = 0
_ScrollSpeedU2 ("U Scroll Speed2", Range(-10, 10)) = 0
_ScrollSpeedV2 ("V Scroll Speed2", Range(-10, 10)) = 0
[KeywordEnum(ENABLE, DISABLE)] _USE_TEXTURE ("Use Texture", Float) = 0
[KeywordEnum(ONE, TOW)] _NUM_TEXTURE ("Num Texture", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 23952
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
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
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
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
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
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
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0 = u_xlat16_0;
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
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0 = u_xlat16_0;
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
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
vec2 u_xlat8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
vec2 u_xlat8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
vec2 u_xlat8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
vec2 u_xlat8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat16_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
vec2 u_xlat8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat16_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
vec2 u_xlat8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat16_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
vec2 u_xlat8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
vec2 u_xlat8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
vec2 u_xlat8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
vec2 u_xlat8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat16_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
vec2 u_xlat8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat16_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
vec2 u_xlat8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat16_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat3 = fract(u_xlat3);
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat3.xy;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat3.zw + u_xlat2.xy;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture2D(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat0 = u_xlat0 * u_xlat16_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat3 = fract(u_xlat3);
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat3.xy;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat3.zw + u_xlat2.xy;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture2D(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat0 = u_xlat0 * u_xlat16_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat3 = fract(u_xlat3);
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat3.xy;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat3.zw + u_xlat2.xy;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture2D(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat0 = u_xlat0 * u_xlat16_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat3 = fract(u_xlat3);
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat3.xy;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat3.zw + u_xlat2.xy;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MainTex2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = texture(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat0 = u_xlat0 * u_xlat16_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat3 = fract(u_xlat3);
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat3.xy;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat3.zw + u_xlat2.xy;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MainTex2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = texture(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat0 = u_xlat0 * u_xlat16_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat3 = fract(u_xlat3);
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat3.xy;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat3.zw + u_xlat2.xy;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MainTex2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = texture(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat0 = u_xlat0 * u_xlat16_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
vec2 u_xlat8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
vec2 u_xlat8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
vec2 u_xlat8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
vec2 u_xlat8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat16_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
vec2 u_xlat8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat16_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat3;
vec2 u_xlat8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat16_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat1 = fract(u_xlat1);
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw + u_xlat0.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture2D(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_1 = u_xlat16_1 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat1 = fract(u_xlat1);
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw + u_xlat0.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture2D(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_1 = u_xlat16_1 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat1 = fract(u_xlat1);
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw + u_xlat0.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture2D(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_1 = u_xlat16_1 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat1 = fract(u_xlat1);
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MainTex2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = texture(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_1 = u_xlat16_1 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat1 = fract(u_xlat1);
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MainTex2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = texture(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_1 = u_xlat16_1 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat1 = fract(u_xlat1);
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MainTex2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = texture(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_1 = u_xlat16_1 * _TintColor;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat10_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat10_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat10_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat9 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_3, u_xlat9);
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
float u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat9 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_3, u_xlat9);
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
float u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat9 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_3, u_xlat9);
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
float u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat9 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_3, u_xlat9);
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat9 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_3, u_xlat9);
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat9 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_3, u_xlat9);
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat9 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_3, u_xlat9);
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
float u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat9 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_3, u_xlat9);
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
float u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat9 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_3, u_xlat9);
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
float u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat9 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_3, u_xlat9);
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat9 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_3, u_xlat9);
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat9 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_3, u_xlat9);
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat3 = fract(u_xlat3);
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat3.xy;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat3.zw + u_xlat2.xy;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    u_xlat11 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_4, u_xlat11);
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
float u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture2D(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat0 = u_xlat0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat3 = fract(u_xlat3);
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat3.xy;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat3.zw + u_xlat2.xy;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    u_xlat11 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_4, u_xlat11);
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
float u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture2D(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat0 = u_xlat0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat3 = fract(u_xlat3);
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat3.xy;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat3.zw + u_xlat2.xy;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    u_xlat11 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_4, u_xlat11);
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
float u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture2D(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat0 = u_xlat0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat3 = fract(u_xlat3);
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat3.xy;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat3.zw + u_xlat2.xy;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    u_xlat11 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_4, u_xlat11);
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MainTex2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = texture(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat0 = u_xlat0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat3 = fract(u_xlat3);
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat3.xy;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat3.zw + u_xlat2.xy;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    u_xlat11 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_4, u_xlat11);
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MainTex2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = texture(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat0 = u_xlat0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat3 = fract(u_xlat3);
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat3.xy;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat3.zw + u_xlat2.xy;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    u_xlat11 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_4, u_xlat11);
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MainTex2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = texture(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat0 = u_xlat0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat9 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_3, u_xlat9);
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
float u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat9 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_3, u_xlat9);
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
float u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat9 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_3, u_xlat9);
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
float u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat9 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_3, u_xlat9);
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat9 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_3, u_xlat9);
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat9 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD2 = max(u_xlat16_3, u_xlat9);
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat10_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat10_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat10_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat10_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat10_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat10_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.xy = vec2(_ScrollSpeedU, _ScrollSpeedV) * booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * _TintColor;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat1 = fract(u_xlat1);
    vs_TEXCOORD0.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat3.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw + u_xlat3.xy;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture2D(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_1 = u_xlat16_1 * _TintColor;
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat1 = fract(u_xlat1);
    vs_TEXCOORD0.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat3.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw + u_xlat3.xy;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture2D(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_1 = u_xlat16_1 * _TintColor;
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat1 = fract(u_xlat1);
    vs_TEXCOORD0.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat3.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw + u_xlat3.xy;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture2D(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_1 = u_xlat16_1 * _TintColor;
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat1 = fract(u_xlat1);
    vs_TEXCOORD0.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat3.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw + u_xlat3.xy;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MainTex2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = texture(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_1 = u_xlat16_1 * _TintColor;
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat1 = fract(u_xlat1);
    vs_TEXCOORD0.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat3.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw + u_xlat3.xy;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MainTex2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = texture(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_1 = u_xlat16_1 * _TintColor;
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex2_ST;
uniform 	mediump float _ScrollSpeedU;
uniform 	mediump float _ScrollSpeedV;
uniform 	mediump float _ScrollSpeedU2;
uniform 	mediump float _ScrollSpeedV2;
uniform 	vec4 booster_Env;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = vec4(_ScrollSpeedU, _ScrollSpeedV, _ScrollSpeedU2, _ScrollSpeedV2) * booster_Env.xxxx;
    u_xlat1 = fract(u_xlat1);
    vs_TEXCOORD0.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat3.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw + u_xlat3.xy;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2 = max(u_xlat0.x, u_xlat16_2);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _TintColor;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MainTex2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = texture(_MainTex2, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
    u_xlat16_1 = u_xlat16_1 * _TintColor;
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat1 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat1);
    SV_Target0 = u_xlat0;
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
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
""
}
}
}
}
}