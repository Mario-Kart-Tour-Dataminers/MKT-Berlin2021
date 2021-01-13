//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "UI(Booster)/MonochromeInterpolation(二色補間)" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_ColorMin ("Color Min", Color) = (0,0,0,0)
_ColorMax ("Color Max", Color) = (1,1,1,1)
[KeywordEnum(FALSE,TRUE)] _ETC1 ("ETC1", Float) = 0
_Stencil ("Stencil ID", Float) = 0
_StencilComp ("Stencil Comparison", Float) = 8
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 32519
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "_ETC1_FALSE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD4 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _ColorMin;
uniform 	mediump vec4 _ColorMax;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
float u_xlat6;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD4.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD4.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.x = u_xlat10_1.y + u_xlat10_1.x;
    u_xlat16_2.x = u_xlat10_1.z + u_xlat16_2.x;
    u_xlat16_3 = u_xlat16_2.x * 0.333333343;
    u_xlat16_2 = (-_ColorMin) + _ColorMax;
    u_xlat2 = vec4(u_xlat16_3) * u_xlat16_2 + _ColorMin;
    u_xlat3 = u_xlat10_1.w * u_xlat2.w;
    u_xlat3 = u_xlat3 * vs_COLOR0.w;
    u_xlat6 = u_xlat3 * u_xlat0.x + -0.00100000005;
    u_xlat2.w = u_xlat0.x * u_xlat3;
    SV_Target0 = u_xlat2;
    u_xlatb0.x = u_xlat6<0.0;
    if(((int(u_xlatb0.x) * -1))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ETC1_FALSE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD4 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _ColorMin;
uniform 	mediump vec4 _ColorMax;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
float u_xlat6;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD4.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD4.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.x = u_xlat10_1.y + u_xlat10_1.x;
    u_xlat16_2.x = u_xlat10_1.z + u_xlat16_2.x;
    u_xlat16_3 = u_xlat16_2.x * 0.333333343;
    u_xlat16_2 = (-_ColorMin) + _ColorMax;
    u_xlat2 = vec4(u_xlat16_3) * u_xlat16_2 + _ColorMin;
    u_xlat3 = u_xlat10_1.w * u_xlat2.w;
    u_xlat3 = u_xlat3 * vs_COLOR0.w;
    u_xlat6 = u_xlat3 * u_xlat0.x + -0.00100000005;
    u_xlat2.w = u_xlat0.x * u_xlat3;
    SV_Target0 = u_xlat2;
    u_xlatb0.x = u_xlat6<0.0;
    if(((int(u_xlatb0.x) * -1))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ETC1_FALSE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD4 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _ColorMin;
uniform 	mediump vec4 _ColorMax;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
float u_xlat6;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD4.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD4.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.x = u_xlat10_1.y + u_xlat10_1.x;
    u_xlat16_2.x = u_xlat10_1.z + u_xlat16_2.x;
    u_xlat16_3 = u_xlat16_2.x * 0.333333343;
    u_xlat16_2 = (-_ColorMin) + _ColorMax;
    u_xlat2 = vec4(u_xlat16_3) * u_xlat16_2 + _ColorMin;
    u_xlat3 = u_xlat10_1.w * u_xlat2.w;
    u_xlat3 = u_xlat3 * vs_COLOR0.w;
    u_xlat6 = u_xlat3 * u_xlat0.x + -0.00100000005;
    u_xlat2.w = u_xlat0.x * u_xlat3;
    SV_Target0 = u_xlat2;
    u_xlatb0.x = u_xlat6<0.0;
    if(((int(u_xlatb0.x) * -1))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_ETC1_FALSE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD4 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _ColorMin;
uniform 	mediump vec4 _ColorMax;
uniform 	vec4 _ClipRect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
float u_xlat6;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD4.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD4.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_2.x = u_xlat16_1.z + u_xlat16_2.x;
    u_xlat16_3 = u_xlat16_2.x * 0.333333343;
    u_xlat16_2 = (-_ColorMin) + _ColorMax;
    u_xlat2 = vec4(u_xlat16_3) * u_xlat16_2 + _ColorMin;
    u_xlat3 = u_xlat16_1.w * u_xlat2.w;
    u_xlat3 = u_xlat3 * vs_COLOR0.w;
    u_xlat6 = u_xlat3 * u_xlat0.x + -0.00100000005;
    u_xlat2.w = u_xlat0.x * u_xlat3;
    SV_Target0 = u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat6<0.0);
#else
    u_xlatb0.x = u_xlat6<0.0;
#endif
    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_ETC1_FALSE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD4 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _ColorMin;
uniform 	mediump vec4 _ColorMax;
uniform 	vec4 _ClipRect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
float u_xlat6;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD4.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD4.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_2.x = u_xlat16_1.z + u_xlat16_2.x;
    u_xlat16_3 = u_xlat16_2.x * 0.333333343;
    u_xlat16_2 = (-_ColorMin) + _ColorMax;
    u_xlat2 = vec4(u_xlat16_3) * u_xlat16_2 + _ColorMin;
    u_xlat3 = u_xlat16_1.w * u_xlat2.w;
    u_xlat3 = u_xlat3 * vs_COLOR0.w;
    u_xlat6 = u_xlat3 * u_xlat0.x + -0.00100000005;
    u_xlat2.w = u_xlat0.x * u_xlat3;
    SV_Target0 = u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat6<0.0);
#else
    u_xlatb0.x = u_xlat6<0.0;
#endif
    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_ETC1_FALSE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD4 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _ColorMin;
uniform 	mediump vec4 _ColorMax;
uniform 	vec4 _ClipRect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
float u_xlat6;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD4.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD4.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_2.x = u_xlat16_1.z + u_xlat16_2.x;
    u_xlat16_3 = u_xlat16_2.x * 0.333333343;
    u_xlat16_2 = (-_ColorMin) + _ColorMax;
    u_xlat2 = vec4(u_xlat16_3) * u_xlat16_2 + _ColorMin;
    u_xlat3 = u_xlat16_1.w * u_xlat2.w;
    u_xlat3 = u_xlat3 * vs_COLOR0.w;
    u_xlat6 = u_xlat3 * u_xlat0.x + -0.00100000005;
    u_xlat2.w = u_xlat0.x * u_xlat3;
    SV_Target0 = u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat6<0.0);
#else
    u_xlatb0.x = u_xlat6<0.0;
#endif
    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_ETC1_TRUE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD4 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _ColorMin;
uniform 	mediump vec4 _ColorMax;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_2;
lowp vec3 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD4.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD4.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.x = u_xlat10_2.y + u_xlat10_2.x;
    u_xlat16_1.x = u_xlat10_2.z + u_xlat16_1.x;
    u_xlat16_2 = u_xlat16_1.x * 0.333333343;
    u_xlat16_1 = (-_ColorMin) + _ColorMax;
    u_xlat1 = vec4(u_xlat16_2) * u_xlat16_1 + _ColorMin;
    u_xlat10_2.x = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat2 = u_xlat10_2.x * u_xlat1.w;
    u_xlat2 = u_xlat2 * vs_COLOR0.w;
    u_xlat4 = u_xlat2 * u_xlat0.x + -0.00100000005;
    u_xlat1.w = u_xlat0.x * u_xlat2;
    SV_Target0 = u_xlat1;
    u_xlatb0.x = u_xlat4<0.0;
    if(((int(u_xlatb0.x) * -1))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ETC1_TRUE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD4 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _ColorMin;
uniform 	mediump vec4 _ColorMax;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_2;
lowp vec3 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD4.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD4.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.x = u_xlat10_2.y + u_xlat10_2.x;
    u_xlat16_1.x = u_xlat10_2.z + u_xlat16_1.x;
    u_xlat16_2 = u_xlat16_1.x * 0.333333343;
    u_xlat16_1 = (-_ColorMin) + _ColorMax;
    u_xlat1 = vec4(u_xlat16_2) * u_xlat16_1 + _ColorMin;
    u_xlat10_2.x = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat2 = u_xlat10_2.x * u_xlat1.w;
    u_xlat2 = u_xlat2 * vs_COLOR0.w;
    u_xlat4 = u_xlat2 * u_xlat0.x + -0.00100000005;
    u_xlat1.w = u_xlat0.x * u_xlat2;
    SV_Target0 = u_xlat1;
    u_xlatb0.x = u_xlat4<0.0;
    if(((int(u_xlatb0.x) * -1))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ETC1_TRUE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD4 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _ColorMin;
uniform 	mediump vec4 _ColorMax;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_2;
lowp vec3 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD4.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD4.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.x = u_xlat10_2.y + u_xlat10_2.x;
    u_xlat16_1.x = u_xlat10_2.z + u_xlat16_1.x;
    u_xlat16_2 = u_xlat16_1.x * 0.333333343;
    u_xlat16_1 = (-_ColorMin) + _ColorMax;
    u_xlat1 = vec4(u_xlat16_2) * u_xlat16_1 + _ColorMin;
    u_xlat10_2.x = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat2 = u_xlat10_2.x * u_xlat1.w;
    u_xlat2 = u_xlat2 * vs_COLOR0.w;
    u_xlat4 = u_xlat2 * u_xlat0.x + -0.00100000005;
    u_xlat1.w = u_xlat0.x * u_xlat2;
    SV_Target0 = u_xlat1;
    u_xlatb0.x = u_xlat4<0.0;
    if(((int(u_xlatb0.x) * -1))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_ETC1_TRUE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD4 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _ColorMin;
uniform 	mediump vec4 _ColorMax;
uniform 	vec4 _ClipRect;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat4;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD4.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD4.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_1.x = u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_2.x = u_xlat16_1.x * 0.333333343;
    u_xlat16_1 = (-_ColorMin) + _ColorMax;
    u_xlat1 = u_xlat16_2.xxxx * u_xlat16_1 + _ColorMin;
    u_xlat16_2.x = texture(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat2 = u_xlat16_2.x * u_xlat1.w;
    u_xlat2 = u_xlat2 * vs_COLOR0.w;
    u_xlat4 = u_xlat2 * u_xlat0.x + -0.00100000005;
    u_xlat1.w = u_xlat0.x * u_xlat2;
    SV_Target0 = u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat4<0.0);
#else
    u_xlatb0.x = u_xlat4<0.0;
#endif
    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_ETC1_TRUE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD4 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _ColorMin;
uniform 	mediump vec4 _ColorMax;
uniform 	vec4 _ClipRect;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat4;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD4.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD4.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_1.x = u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_2.x = u_xlat16_1.x * 0.333333343;
    u_xlat16_1 = (-_ColorMin) + _ColorMax;
    u_xlat1 = u_xlat16_2.xxxx * u_xlat16_1 + _ColorMin;
    u_xlat16_2.x = texture(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat2 = u_xlat16_2.x * u_xlat1.w;
    u_xlat2 = u_xlat2 * vs_COLOR0.w;
    u_xlat4 = u_xlat2 * u_xlat0.x + -0.00100000005;
    u_xlat1.w = u_xlat0.x * u_xlat2;
    SV_Target0 = u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat4<0.0);
#else
    u_xlatb0.x = u_xlat4<0.0;
#endif
    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_ETC1_TRUE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD4 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _ColorMin;
uniform 	mediump vec4 _ColorMax;
uniform 	vec4 _ClipRect;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat4;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD4.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD4.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_1.x = u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_2.x = u_xlat16_1.x * 0.333333343;
    u_xlat16_1 = (-_ColorMin) + _ColorMax;
    u_xlat1 = u_xlat16_2.xxxx * u_xlat16_1 + _ColorMin;
    u_xlat16_2.x = texture(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat2 = u_xlat16_2.x * u_xlat1.w;
    u_xlat2 = u_xlat2 * vs_COLOR0.w;
    u_xlat4 = u_xlat2 * u_xlat0.x + -0.00100000005;
    u_xlat1.w = u_xlat0.x * u_xlat2;
    SV_Target0 = u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat4<0.0);
#else
    u_xlatb0.x = u_xlat4<0.0;
#endif
    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "_ETC1_FALSE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ETC1_FALSE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ETC1_FALSE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_ETC1_FALSE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_ETC1_FALSE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_ETC1_FALSE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_ETC1_TRUE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ETC1_TRUE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ETC1_TRUE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_ETC1_TRUE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_ETC1_TRUE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_ETC1_TRUE" }
""
}
}
}
}
}