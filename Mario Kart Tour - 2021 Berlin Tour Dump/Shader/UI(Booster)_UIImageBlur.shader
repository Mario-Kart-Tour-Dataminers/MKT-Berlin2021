//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "UI(Booster)/UIImageBlur" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 29624
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
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
uniform 	float _scale;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(_scale);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat1 = vec4(_scale) * vec4(-1.0, 1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat10_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(-1.0, -1.0, -2.0, 2.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat2.xy = vec2(_scale) * vec2(2.0, 2.0) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat10_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(2.0, -2.0, -2.0, -2.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat10_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(3.0, 3.0, -3.0, 3.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat10_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(3.0, -3.0, -3.0, -3.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat10_1 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * vec4(0.0769230798, 0.0769230798, 0.0769230798, 0.0769230798);
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
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
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
uniform 	float _scale;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(_scale);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat1 = vec4(_scale) * vec4(-1.0, 1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat10_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(-1.0, -1.0, -2.0, 2.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat2.xy = vec2(_scale) * vec2(2.0, 2.0) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat10_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(2.0, -2.0, -2.0, -2.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat10_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(3.0, 3.0, -3.0, 3.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat10_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(3.0, -3.0, -3.0, -3.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat10_1 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * vec4(0.0769230798, 0.0769230798, 0.0769230798, 0.0769230798);
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
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
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
uniform 	float _scale;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(_scale);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat1 = vec4(_scale) * vec4(-1.0, 1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat10_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(-1.0, -1.0, -2.0, 2.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat2.xy = vec2(_scale) * vec2(2.0, 2.0) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat10_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(2.0, -2.0, -2.0, -2.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat10_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(3.0, 3.0, -3.0, 3.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat10_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(3.0, -3.0, -3.0, -3.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat10_1 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * vec4(0.0769230798, 0.0769230798, 0.0769230798, 0.0769230798);
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
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	float _scale;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(_scale);
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = vec4(_scale) * vec4(-1.0, 1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(-1.0, -1.0, -2.0, 2.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat2.xy = vec2(_scale) * vec2(2.0, 2.0) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(2.0, -2.0, -2.0, -2.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(3.0, 3.0, -3.0, 3.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(3.0, -3.0, -3.0, -3.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * vec4(0.0769230798, 0.0769230798, 0.0769230798, 0.0769230798);
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
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	float _scale;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(_scale);
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = vec4(_scale) * vec4(-1.0, 1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(-1.0, -1.0, -2.0, 2.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat2.xy = vec2(_scale) * vec2(2.0, 2.0) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(2.0, -2.0, -2.0, -2.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(3.0, 3.0, -3.0, 3.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(3.0, -3.0, -3.0, -3.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * vec4(0.0769230798, 0.0769230798, 0.0769230798, 0.0769230798);
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
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	float _scale;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(_scale);
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = vec4(_scale) * vec4(-1.0, 1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(-1.0, -1.0, -2.0, 2.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat2.xy = vec2(_scale) * vec2(2.0, 2.0) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(2.0, -2.0, -2.0, -2.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(3.0, 3.0, -3.0, 3.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = vec4(_scale) * vec4(3.0, -3.0, -3.0, -3.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * vec4(0.0769230798, 0.0769230798, 0.0769230798, 0.0769230798);
    SV_Target0 = u_xlat16_0;
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