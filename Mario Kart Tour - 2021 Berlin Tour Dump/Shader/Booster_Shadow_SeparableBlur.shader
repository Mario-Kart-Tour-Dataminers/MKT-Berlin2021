//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Shadow/SeparableBlur" {
Properties {
_MainTex ("Base (RGB)", 2D) = "" { }
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 1229
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 offsets;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD1 = offsets.xyxy * vec4(1.0, 1.0, -1.0, -1.0) + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = offsets.xyxy * vec4(2.0, 2.0, -2.0, -2.0) + in_TEXCOORD0.xyxy;
    vs_TEXCOORD3 = offsets.xyxy * vec4(3.0, 3.0, -3.0, -3.0) + in_TEXCOORD0.xyxy;
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
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.400000006, 0.400000006, 0.400000006, 0.400000006) + u_xlat16_0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD1.zw);
    u_xlat16_0 = u_xlat10_1 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat16_0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.zw);
    u_xlat16_0 = u_xlat10_1 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat16_0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat16_0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.zw);
    u_xlat16_0 = u_xlat10_1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat16_0;
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
uniform 	vec4 offsets;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD1 = offsets.xyxy * vec4(1.0, 1.0, -1.0, -1.0) + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = offsets.xyxy * vec4(2.0, 2.0, -2.0, -2.0) + in_TEXCOORD0.xyxy;
    vs_TEXCOORD3 = offsets.xyxy * vec4(3.0, 3.0, -3.0, -3.0) + in_TEXCOORD0.xyxy;
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
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.400000006, 0.400000006, 0.400000006, 0.400000006) + u_xlat16_0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD1.zw);
    u_xlat16_0 = u_xlat10_1 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat16_0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.zw);
    u_xlat16_0 = u_xlat10_1 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat16_0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat16_0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.zw);
    u_xlat16_0 = u_xlat10_1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat16_0;
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
uniform 	vec4 offsets;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD1 = offsets.xyxy * vec4(1.0, 1.0, -1.0, -1.0) + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = offsets.xyxy * vec4(2.0, 2.0, -2.0, -2.0) + in_TEXCOORD0.xyxy;
    vs_TEXCOORD3 = offsets.xyxy * vec4(3.0, 3.0, -3.0, -3.0) + in_TEXCOORD0.xyxy;
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
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.400000006, 0.400000006, 0.400000006, 0.400000006) + u_xlat16_0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD1.zw);
    u_xlat16_0 = u_xlat10_1 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat16_0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.zw);
    u_xlat16_0 = u_xlat10_1 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat16_0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat16_0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.zw);
    u_xlat16_0 = u_xlat10_1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat16_0;
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
uniform 	vec4 offsets;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD1 = offsets.xyxy * vec4(1.0, 1.0, -1.0, -1.0) + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = offsets.xyxy * vec4(2.0, 2.0, -2.0, -2.0) + in_TEXCOORD0.xyxy;
    vs_TEXCOORD3 = offsets.xyxy * vec4(3.0, 3.0, -3.0, -3.0) + in_TEXCOORD0.xyxy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_1 * vec4(0.400000006, 0.400000006, 0.400000006, 0.400000006) + u_xlat16_0;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.zw);
    u_xlat16_0 = u_xlat16_1 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_0;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_1 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat16_0;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD2.zw);
    u_xlat16_0 = u_xlat16_1 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat16_0;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_0 = u_xlat16_1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat16_0;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD3.zw);
    u_xlat16_0 = u_xlat16_1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat16_0;
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
uniform 	vec4 offsets;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD1 = offsets.xyxy * vec4(1.0, 1.0, -1.0, -1.0) + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = offsets.xyxy * vec4(2.0, 2.0, -2.0, -2.0) + in_TEXCOORD0.xyxy;
    vs_TEXCOORD3 = offsets.xyxy * vec4(3.0, 3.0, -3.0, -3.0) + in_TEXCOORD0.xyxy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_1 * vec4(0.400000006, 0.400000006, 0.400000006, 0.400000006) + u_xlat16_0;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.zw);
    u_xlat16_0 = u_xlat16_1 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_0;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_1 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat16_0;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD2.zw);
    u_xlat16_0 = u_xlat16_1 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat16_0;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_0 = u_xlat16_1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat16_0;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD3.zw);
    u_xlat16_0 = u_xlat16_1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat16_0;
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
uniform 	vec4 offsets;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD1 = offsets.xyxy * vec4(1.0, 1.0, -1.0, -1.0) + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = offsets.xyxy * vec4(2.0, 2.0, -2.0, -2.0) + in_TEXCOORD0.xyxy;
    vs_TEXCOORD3 = offsets.xyxy * vec4(3.0, 3.0, -3.0, -3.0) + in_TEXCOORD0.xyxy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_1 * vec4(0.400000006, 0.400000006, 0.400000006, 0.400000006) + u_xlat16_0;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.zw);
    u_xlat16_0 = u_xlat16_1 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_0;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_1 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat16_0;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD2.zw);
    u_xlat16_0 = u_xlat16_1 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat16_0;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_0 = u_xlat16_1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat16_0;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD3.zw);
    u_xlat16_0 = u_xlat16_1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat16_0;
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