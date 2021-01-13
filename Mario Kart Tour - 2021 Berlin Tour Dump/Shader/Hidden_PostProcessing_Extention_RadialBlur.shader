//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Extention/RadialBlur" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 42254
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	float _RenderViewportScaleFactor;
attribute highp vec3 in_POSITION0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
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
uniform 	vec4 _ScreenParams;
uniform 	float _BlurPower;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
lowp vec4 u_xlat10_3;
vec2 u_xlat8;
float u_xlat12;
void main()
{
    u_xlat0.xy = (-vs_TEXCOORD1.xy) + vec2(0.5, 0.5);
    u_xlat8.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat12 = inversesqrt(u_xlat8.x);
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _BlurPower;
    u_xlat0.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat1.xy = vec2(0.5, 0.5) / _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat1.xy = u_xlat0.xy * u_xlat8.xx + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat8.xx * u_xlat0.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.170000002, 0.170000002, 0.170000002, 0.170000002);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_2 * vec4(0.189999998, 0.189999998, 0.189999998, 0.189999998) + u_xlat16_1;
    u_xlat8.xy = u_xlat0.xy * vec2(2.0, 2.0) + vs_TEXCOORD1.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat16_1 = u_xlat10_2 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_1;
    u_xlat2 = u_xlat0.xyxy * vec4(3.0, 3.0, 4.0, 4.0) + vs_TEXCOORD1.xyxy;
    u_xlat10_3 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.zw);
    u_xlat16_1 = u_xlat10_3 * vec4(0.129999995, 0.129999995, 0.129999995, 0.129999995) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_2 * vec4(0.109999999, 0.109999999, 0.109999999, 0.109999999) + u_xlat16_1;
    u_xlat2 = u_xlat0.xyxy * vec4(5.0, 5.0, 6.0, 6.0) + vs_TEXCOORD1.xyxy;
    u_xlat10_3 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.zw);
    u_xlat16_1 = u_xlat10_3 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_2 * vec4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003) + u_xlat16_1;
    u_xlat2 = u_xlat0.xyxy * vec4(7.0, 7.0, 8.0, 8.0) + vs_TEXCOORD1.xyxy;
    u_xlat0.xy = u_xlat0.xy * vec2(9.0, 9.0) + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat10_3 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.zw);
    u_xlat16_1 = u_xlat10_3 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_2 * vec4(0.0299999993, 0.0299999993, 0.0299999993, 0.0299999993) + u_xlat16_1;
    SV_Target0 = u_xlat10_0 * vec4(0.00999999978, 0.00999999978, 0.00999999978, 0.00999999978) + u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	float _RenderViewportScaleFactor;
attribute highp vec3 in_POSITION0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
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
uniform 	vec4 _ScreenParams;
uniform 	float _BlurPower;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
lowp vec4 u_xlat10_3;
vec2 u_xlat8;
float u_xlat12;
void main()
{
    u_xlat0.xy = (-vs_TEXCOORD1.xy) + vec2(0.5, 0.5);
    u_xlat8.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat12 = inversesqrt(u_xlat8.x);
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _BlurPower;
    u_xlat0.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat1.xy = vec2(0.5, 0.5) / _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat1.xy = u_xlat0.xy * u_xlat8.xx + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat8.xx * u_xlat0.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.170000002, 0.170000002, 0.170000002, 0.170000002);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_2 * vec4(0.189999998, 0.189999998, 0.189999998, 0.189999998) + u_xlat16_1;
    u_xlat8.xy = u_xlat0.xy * vec2(2.0, 2.0) + vs_TEXCOORD1.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat16_1 = u_xlat10_2 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_1;
    u_xlat2 = u_xlat0.xyxy * vec4(3.0, 3.0, 4.0, 4.0) + vs_TEXCOORD1.xyxy;
    u_xlat10_3 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.zw);
    u_xlat16_1 = u_xlat10_3 * vec4(0.129999995, 0.129999995, 0.129999995, 0.129999995) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_2 * vec4(0.109999999, 0.109999999, 0.109999999, 0.109999999) + u_xlat16_1;
    u_xlat2 = u_xlat0.xyxy * vec4(5.0, 5.0, 6.0, 6.0) + vs_TEXCOORD1.xyxy;
    u_xlat10_3 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.zw);
    u_xlat16_1 = u_xlat10_3 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_2 * vec4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003) + u_xlat16_1;
    u_xlat2 = u_xlat0.xyxy * vec4(7.0, 7.0, 8.0, 8.0) + vs_TEXCOORD1.xyxy;
    u_xlat0.xy = u_xlat0.xy * vec2(9.0, 9.0) + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat10_3 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.zw);
    u_xlat16_1 = u_xlat10_3 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_2 * vec4(0.0299999993, 0.0299999993, 0.0299999993, 0.0299999993) + u_xlat16_1;
    SV_Target0 = u_xlat10_0 * vec4(0.00999999978, 0.00999999978, 0.00999999978, 0.00999999978) + u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	float _RenderViewportScaleFactor;
attribute highp vec3 in_POSITION0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
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
uniform 	vec4 _ScreenParams;
uniform 	float _BlurPower;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
lowp vec4 u_xlat10_3;
vec2 u_xlat8;
float u_xlat12;
void main()
{
    u_xlat0.xy = (-vs_TEXCOORD1.xy) + vec2(0.5, 0.5);
    u_xlat8.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat12 = inversesqrt(u_xlat8.x);
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _BlurPower;
    u_xlat0.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat1.xy = vec2(0.5, 0.5) / _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat1.xy = u_xlat0.xy * u_xlat8.xx + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat8.xx * u_xlat0.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.170000002, 0.170000002, 0.170000002, 0.170000002);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_2 * vec4(0.189999998, 0.189999998, 0.189999998, 0.189999998) + u_xlat16_1;
    u_xlat8.xy = u_xlat0.xy * vec2(2.0, 2.0) + vs_TEXCOORD1.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat16_1 = u_xlat10_2 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_1;
    u_xlat2 = u_xlat0.xyxy * vec4(3.0, 3.0, 4.0, 4.0) + vs_TEXCOORD1.xyxy;
    u_xlat10_3 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.zw);
    u_xlat16_1 = u_xlat10_3 * vec4(0.129999995, 0.129999995, 0.129999995, 0.129999995) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_2 * vec4(0.109999999, 0.109999999, 0.109999999, 0.109999999) + u_xlat16_1;
    u_xlat2 = u_xlat0.xyxy * vec4(5.0, 5.0, 6.0, 6.0) + vs_TEXCOORD1.xyxy;
    u_xlat10_3 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.zw);
    u_xlat16_1 = u_xlat10_3 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_2 * vec4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003) + u_xlat16_1;
    u_xlat2 = u_xlat0.xyxy * vec4(7.0, 7.0, 8.0, 8.0) + vs_TEXCOORD1.xyxy;
    u_xlat0.xy = u_xlat0.xy * vec2(9.0, 9.0) + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat10_3 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.zw);
    u_xlat16_1 = u_xlat10_3 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_2 * vec4(0.0299999993, 0.0299999993, 0.0299999993, 0.0299999993) + u_xlat16_1;
    SV_Target0 = u_xlat10_0 * vec4(0.00999999978, 0.00999999978, 0.00999999978, 0.00999999978) + u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _BlurPower;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec2 u_xlat8;
float u_xlat12;
void main()
{
    u_xlat0.xy = (-vs_TEXCOORD1.xy) + vec2(0.5, 0.5);
    u_xlat8.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat12 = inversesqrt(u_xlat8.x);
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _BlurPower;
    u_xlat0.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat1.xy = vec2(0.5, 0.5) / _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat1.xy = u_xlat0.xy * u_xlat8.xx + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat8.xx * u_xlat0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = u_xlat16_1 * vec4(0.170000002, 0.170000002, 0.170000002, 0.170000002);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_2 * vec4(0.189999998, 0.189999998, 0.189999998, 0.189999998) + u_xlat16_1;
    u_xlat8.xy = u_xlat0.xy * vec2(2.0, 2.0) + vs_TEXCOORD1.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat8.xy);
    u_xlat16_1 = u_xlat16_2 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_1;
    u_xlat2 = u_xlat0.xyxy * vec4(3.0, 3.0, 4.0, 4.0) + vs_TEXCOORD1.xyxy;
    u_xlat16_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_MainTex, u_xlat2.zw);
    u_xlat16_1 = u_xlat16_3 * vec4(0.129999995, 0.129999995, 0.129999995, 0.129999995) + u_xlat16_1;
    u_xlat16_1 = u_xlat16_2 * vec4(0.109999999, 0.109999999, 0.109999999, 0.109999999) + u_xlat16_1;
    u_xlat2 = u_xlat0.xyxy * vec4(5.0, 5.0, 6.0, 6.0) + vs_TEXCOORD1.xyxy;
    u_xlat16_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_MainTex, u_xlat2.zw);
    u_xlat16_1 = u_xlat16_3 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat16_1;
    u_xlat16_1 = u_xlat16_2 * vec4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003) + u_xlat16_1;
    u_xlat2 = u_xlat0.xyxy * vec4(7.0, 7.0, 8.0, 8.0) + vs_TEXCOORD1.xyxy;
    u_xlat0.xy = u_xlat0.xy * vec2(9.0, 9.0) + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_MainTex, u_xlat2.zw);
    u_xlat16_1 = u_xlat16_3 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat16_1;
    u_xlat16_1 = u_xlat16_2 * vec4(0.0299999993, 0.0299999993, 0.0299999993, 0.0299999993) + u_xlat16_1;
    SV_Target0 = u_xlat16_0 * vec4(0.00999999978, 0.00999999978, 0.00999999978, 0.00999999978) + u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _BlurPower;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec2 u_xlat8;
float u_xlat12;
void main()
{
    u_xlat0.xy = (-vs_TEXCOORD1.xy) + vec2(0.5, 0.5);
    u_xlat8.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat12 = inversesqrt(u_xlat8.x);
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _BlurPower;
    u_xlat0.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat1.xy = vec2(0.5, 0.5) / _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat1.xy = u_xlat0.xy * u_xlat8.xx + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat8.xx * u_xlat0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = u_xlat16_1 * vec4(0.170000002, 0.170000002, 0.170000002, 0.170000002);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_2 * vec4(0.189999998, 0.189999998, 0.189999998, 0.189999998) + u_xlat16_1;
    u_xlat8.xy = u_xlat0.xy * vec2(2.0, 2.0) + vs_TEXCOORD1.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat8.xy);
    u_xlat16_1 = u_xlat16_2 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_1;
    u_xlat2 = u_xlat0.xyxy * vec4(3.0, 3.0, 4.0, 4.0) + vs_TEXCOORD1.xyxy;
    u_xlat16_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_MainTex, u_xlat2.zw);
    u_xlat16_1 = u_xlat16_3 * vec4(0.129999995, 0.129999995, 0.129999995, 0.129999995) + u_xlat16_1;
    u_xlat16_1 = u_xlat16_2 * vec4(0.109999999, 0.109999999, 0.109999999, 0.109999999) + u_xlat16_1;
    u_xlat2 = u_xlat0.xyxy * vec4(5.0, 5.0, 6.0, 6.0) + vs_TEXCOORD1.xyxy;
    u_xlat16_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_MainTex, u_xlat2.zw);
    u_xlat16_1 = u_xlat16_3 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat16_1;
    u_xlat16_1 = u_xlat16_2 * vec4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003) + u_xlat16_1;
    u_xlat2 = u_xlat0.xyxy * vec4(7.0, 7.0, 8.0, 8.0) + vs_TEXCOORD1.xyxy;
    u_xlat0.xy = u_xlat0.xy * vec2(9.0, 9.0) + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_MainTex, u_xlat2.zw);
    u_xlat16_1 = u_xlat16_3 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat16_1;
    u_xlat16_1 = u_xlat16_2 * vec4(0.0299999993, 0.0299999993, 0.0299999993, 0.0299999993) + u_xlat16_1;
    SV_Target0 = u_xlat16_0 * vec4(0.00999999978, 0.00999999978, 0.00999999978, 0.00999999978) + u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _BlurPower;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec2 u_xlat8;
float u_xlat12;
void main()
{
    u_xlat0.xy = (-vs_TEXCOORD1.xy) + vec2(0.5, 0.5);
    u_xlat8.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat12 = inversesqrt(u_xlat8.x);
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _BlurPower;
    u_xlat0.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat1.xy = vec2(0.5, 0.5) / _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat1.xy = u_xlat0.xy * u_xlat8.xx + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat8.xx * u_xlat0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = u_xlat16_1 * vec4(0.170000002, 0.170000002, 0.170000002, 0.170000002);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_2 * vec4(0.189999998, 0.189999998, 0.189999998, 0.189999998) + u_xlat16_1;
    u_xlat8.xy = u_xlat0.xy * vec2(2.0, 2.0) + vs_TEXCOORD1.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat8.xy);
    u_xlat16_1 = u_xlat16_2 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_1;
    u_xlat2 = u_xlat0.xyxy * vec4(3.0, 3.0, 4.0, 4.0) + vs_TEXCOORD1.xyxy;
    u_xlat16_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_MainTex, u_xlat2.zw);
    u_xlat16_1 = u_xlat16_3 * vec4(0.129999995, 0.129999995, 0.129999995, 0.129999995) + u_xlat16_1;
    u_xlat16_1 = u_xlat16_2 * vec4(0.109999999, 0.109999999, 0.109999999, 0.109999999) + u_xlat16_1;
    u_xlat2 = u_xlat0.xyxy * vec4(5.0, 5.0, 6.0, 6.0) + vs_TEXCOORD1.xyxy;
    u_xlat16_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_MainTex, u_xlat2.zw);
    u_xlat16_1 = u_xlat16_3 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat16_1;
    u_xlat16_1 = u_xlat16_2 * vec4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003) + u_xlat16_1;
    u_xlat2 = u_xlat0.xyxy * vec4(7.0, 7.0, 8.0, 8.0) + vs_TEXCOORD1.xyxy;
    u_xlat0.xy = u_xlat0.xy * vec2(9.0, 9.0) + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_MainTex, u_xlat2.zw);
    u_xlat16_1 = u_xlat16_3 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat16_1;
    u_xlat16_1 = u_xlat16_2 * vec4(0.0299999993, 0.0299999993, 0.0299999993, 0.0299999993) + u_xlat16_1;
    SV_Target0 = u_xlat16_0 * vec4(0.00999999978, 0.00999999978, 0.00999999978, 0.00999999978) + u_xlat16_1;
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