//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Shadow/BlobShadowMultiply" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Particle Texture", 2D) = "white" { }
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 52609
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _Position;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_4;
void main()
{
    u_xlat10_0.xy = texture2D(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_0.xy = u_xlat10_0.xy * vs_COLOR0.xw;
    u_xlat16_4 = u_xlat16_0.y * _Color.w;
    u_xlat16_1.xy = u_xlat16_0.xy * _Color.xw + vec2(-1.0, -1.0);
    SV_Target0.xw = vec2(u_xlat16_4) * u_xlat16_1.xy + vec2(1.0, 1.0);
    u_xlat0.x = _Position.y + 2500.0;
    u_xlat0.xy = u_xlat0.xx * vec2(0.000199999995, 0.050999999);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.y) * 0.00392156886 + u_xlat0.x;
    SV_Target0.yz = u_xlat0.xy;
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
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _Position;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_4;
void main()
{
    u_xlat10_0.xy = texture2D(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_0.xy = u_xlat10_0.xy * vs_COLOR0.xw;
    u_xlat16_4 = u_xlat16_0.y * _Color.w;
    u_xlat16_1.xy = u_xlat16_0.xy * _Color.xw + vec2(-1.0, -1.0);
    SV_Target0.xw = vec2(u_xlat16_4) * u_xlat16_1.xy + vec2(1.0, 1.0);
    u_xlat0.x = _Position.y + 2500.0;
    u_xlat0.xy = u_xlat0.xx * vec2(0.000199999995, 0.050999999);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.y) * 0.00392156886 + u_xlat0.x;
    SV_Target0.yz = u_xlat0.xy;
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
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _Position;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_4;
void main()
{
    u_xlat10_0.xy = texture2D(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_0.xy = u_xlat10_0.xy * vs_COLOR0.xw;
    u_xlat16_4 = u_xlat16_0.y * _Color.w;
    u_xlat16_1.xy = u_xlat16_0.xy * _Color.xw + vec2(-1.0, -1.0);
    SV_Target0.xw = vec2(u_xlat16_4) * u_xlat16_1.xy + vec2(1.0, 1.0);
    u_xlat0.x = _Position.y + 2500.0;
    u_xlat0.xy = u_xlat0.xx * vec2(0.000199999995, 0.050999999);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.y) * 0.00392156886 + u_xlat0.x;
    SV_Target0.yz = u_xlat0.xy;
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
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _Position;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_4;
void main()
{
    u_xlat16_0.xy = texture(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_0.xy = u_xlat16_0.xy * vs_COLOR0.xw;
    u_xlat16_4 = u_xlat16_0.y * _Color.w;
    u_xlat16_1.xy = u_xlat16_0.xy * _Color.xw + vec2(-1.0, -1.0);
    SV_Target0.xw = vec2(u_xlat16_4) * u_xlat16_1.xy + vec2(1.0, 1.0);
    u_xlat0.x = _Position.y + 2500.0;
    u_xlat0.xy = u_xlat0.xx * vec2(0.000199999995, 0.050999999);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.y) * 0.00392156886 + u_xlat0.x;
    SV_Target0.yz = u_xlat0.xy;
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
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _Position;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_4;
void main()
{
    u_xlat16_0.xy = texture(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_0.xy = u_xlat16_0.xy * vs_COLOR0.xw;
    u_xlat16_4 = u_xlat16_0.y * _Color.w;
    u_xlat16_1.xy = u_xlat16_0.xy * _Color.xw + vec2(-1.0, -1.0);
    SV_Target0.xw = vec2(u_xlat16_4) * u_xlat16_1.xy + vec2(1.0, 1.0);
    u_xlat0.x = _Position.y + 2500.0;
    u_xlat0.xy = u_xlat0.xx * vec2(0.000199999995, 0.050999999);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.y) * 0.00392156886 + u_xlat0.x;
    SV_Target0.yz = u_xlat0.xy;
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
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _Position;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_4;
void main()
{
    u_xlat16_0.xy = texture(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_0.xy = u_xlat16_0.xy * vs_COLOR0.xw;
    u_xlat16_4 = u_xlat16_0.y * _Color.w;
    u_xlat16_1.xy = u_xlat16_0.xy * _Color.xw + vec2(-1.0, -1.0);
    SV_Target0.xw = vec2(u_xlat16_4) * u_xlat16_1.xy + vec2(1.0, 1.0);
    u_xlat0.x = _Position.y + 2500.0;
    u_xlat0.xy = u_xlat0.xx * vec2(0.000199999995, 0.050999999);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.y) * 0.00392156886 + u_xlat0.x;
    SV_Target0.yz = u_xlat0.xy;
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
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _Position;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_4;
void main()
{
    u_xlat10_0.xy = texture2D(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_0.xy = u_xlat10_0.xy * vs_COLOR0.xw;
    u_xlat16_4 = u_xlat16_0.y * _Color.w;
    u_xlat16_1.xy = u_xlat16_0.xy * _Color.xw + vec2(-1.0, -1.0);
    SV_Target0.xw = vec2(u_xlat16_4) * u_xlat16_1.xy + vec2(1.0, 1.0);
    u_xlat0.x = _Position.y + 2500.0;
    u_xlat0.xy = u_xlat0.xx * vec2(0.000199999995, 0.050999999);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.y) * 0.00392156886 + u_xlat0.x;
    SV_Target0.yz = u_xlat0.xy;
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
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _Position;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_4;
void main()
{
    u_xlat10_0.xy = texture2D(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_0.xy = u_xlat10_0.xy * vs_COLOR0.xw;
    u_xlat16_4 = u_xlat16_0.y * _Color.w;
    u_xlat16_1.xy = u_xlat16_0.xy * _Color.xw + vec2(-1.0, -1.0);
    SV_Target0.xw = vec2(u_xlat16_4) * u_xlat16_1.xy + vec2(1.0, 1.0);
    u_xlat0.x = _Position.y + 2500.0;
    u_xlat0.xy = u_xlat0.xx * vec2(0.000199999995, 0.050999999);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.y) * 0.00392156886 + u_xlat0.x;
    SV_Target0.yz = u_xlat0.xy;
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
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _Position;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_4;
void main()
{
    u_xlat10_0.xy = texture2D(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_0.xy = u_xlat10_0.xy * vs_COLOR0.xw;
    u_xlat16_4 = u_xlat16_0.y * _Color.w;
    u_xlat16_1.xy = u_xlat16_0.xy * _Color.xw + vec2(-1.0, -1.0);
    SV_Target0.xw = vec2(u_xlat16_4) * u_xlat16_1.xy + vec2(1.0, 1.0);
    u_xlat0.x = _Position.y + 2500.0;
    u_xlat0.xy = u_xlat0.xx * vec2(0.000199999995, 0.050999999);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.y) * 0.00392156886 + u_xlat0.x;
    SV_Target0.yz = u_xlat0.xy;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _Position;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_4;
void main()
{
    u_xlat16_0.xy = texture(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_0.xy = u_xlat16_0.xy * vs_COLOR0.xw;
    u_xlat16_4 = u_xlat16_0.y * _Color.w;
    u_xlat16_1.xy = u_xlat16_0.xy * _Color.xw + vec2(-1.0, -1.0);
    SV_Target0.xw = vec2(u_xlat16_4) * u_xlat16_1.xy + vec2(1.0, 1.0);
    u_xlat0.x = _Position.y + 2500.0;
    u_xlat0.xy = u_xlat0.xx * vec2(0.000199999995, 0.050999999);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.y) * 0.00392156886 + u_xlat0.x;
    SV_Target0.yz = u_xlat0.xy;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _Position;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_4;
void main()
{
    u_xlat16_0.xy = texture(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_0.xy = u_xlat16_0.xy * vs_COLOR0.xw;
    u_xlat16_4 = u_xlat16_0.y * _Color.w;
    u_xlat16_1.xy = u_xlat16_0.xy * _Color.xw + vec2(-1.0, -1.0);
    SV_Target0.xw = vec2(u_xlat16_4) * u_xlat16_1.xy + vec2(1.0, 1.0);
    u_xlat0.x = _Position.y + 2500.0;
    u_xlat0.xy = u_xlat0.xx * vec2(0.000199999995, 0.050999999);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.y) * 0.00392156886 + u_xlat0.x;
    SV_Target0.yz = u_xlat0.xy;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _Position;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_4;
void main()
{
    u_xlat16_0.xy = texture(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_0.xy = u_xlat16_0.xy * vs_COLOR0.xw;
    u_xlat16_4 = u_xlat16_0.y * _Color.w;
    u_xlat16_1.xy = u_xlat16_0.xy * _Color.xw + vec2(-1.0, -1.0);
    SV_Target0.xw = vec2(u_xlat16_4) * u_xlat16_1.xy + vec2(1.0, 1.0);
    u_xlat0.x = _Position.y + 2500.0;
    u_xlat0.xy = u_xlat0.xx * vec2(0.000199999995, 0.050999999);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.y) * 0.00392156886 + u_xlat0.x;
    SV_Target0.yz = u_xlat0.xy;
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
}
}
}
}