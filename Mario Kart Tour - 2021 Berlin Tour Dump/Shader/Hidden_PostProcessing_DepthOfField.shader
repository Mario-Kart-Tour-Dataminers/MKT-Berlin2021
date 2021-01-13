//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/DepthOfField" {
Properties {
}
SubShader {
 Pass {
  Name "CoC Calculation"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 58799
Program "vp" {
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
uniform 	vec4 _ZBufferParams;
uniform 	float _Distance;
uniform 	float _LensCoeff;
uniform 	float _RcpMaxCoC;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
float u_xlat1;
void main()
{
    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat0 = _ZBufferParams.z * u_xlat0 + _ZBufferParams.w;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat1 = u_xlat0 + (-_Distance);
    u_xlat0 = max(u_xlat0, 9.99999975e-06);
    u_xlat1 = u_xlat1 * _LensCoeff;
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.5;
    u_xlat0 = u_xlat0 * _RcpMaxCoC + 0.5;
    SV_Target0 = vec4(u_xlat0);
#ifdef UNITY_ADRENO_ES3
    SV_Target0 = min(max(SV_Target0, 0.0), 1.0);
#else
    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
#endif
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
uniform 	vec4 _ZBufferParams;
uniform 	float _Distance;
uniform 	float _LensCoeff;
uniform 	float _RcpMaxCoC;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
float u_xlat1;
void main()
{
    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat0 = _ZBufferParams.z * u_xlat0 + _ZBufferParams.w;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat1 = u_xlat0 + (-_Distance);
    u_xlat0 = max(u_xlat0, 9.99999975e-06);
    u_xlat1 = u_xlat1 * _LensCoeff;
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.5;
    u_xlat0 = u_xlat0 * _RcpMaxCoC + 0.5;
    SV_Target0 = vec4(u_xlat0);
#ifdef UNITY_ADRENO_ES3
    SV_Target0 = min(max(SV_Target0, 0.0), 1.0);
#else
    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
#endif
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
uniform 	vec4 _ZBufferParams;
uniform 	float _Distance;
uniform 	float _LensCoeff;
uniform 	float _RcpMaxCoC;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
float u_xlat1;
void main()
{
    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat0 = _ZBufferParams.z * u_xlat0 + _ZBufferParams.w;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat1 = u_xlat0 + (-_Distance);
    u_xlat0 = max(u_xlat0, 9.99999975e-06);
    u_xlat1 = u_xlat1 * _LensCoeff;
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.5;
    u_xlat0 = u_xlat0 * _RcpMaxCoC + 0.5;
    SV_Target0 = vec4(u_xlat0);
#ifdef UNITY_ADRENO_ES3
    SV_Target0 = min(max(SV_Target0, 0.0), 1.0);
#else
    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
}
Program "fp" {
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
 Pass {
  Name "CoC Temporal Filter"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 73120
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 310 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
layout(location = 0) out highp vec2 vs_TEXCOORD0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
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
#version 310 es

precision highp float;
precision highp int;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec3 _TaaParams;
uniform mediump sampler2D _CoCTex;
uniform mediump sampler2D _CameraMotionVectorsTexture;
uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec3 u_xlat5;
bool u_xlatb5;
bool u_xlatb6;
float u_xlat8;
bool u_xlatb9;
vec2 u_xlat11;
float u_xlat12;
void main()
{
    u_xlat0.xy = _MainTex_TexelSize.yy * vec2(-0.0, -1.0);
    u_xlat1 = (-_MainTex_TexelSize.xyyy) * vec4(1.0, 0.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat12 = texture(_CoCTex, u_xlat1.xy).x;
    u_xlat0.z = texture(_CoCTex, u_xlat1.zw).x;
    u_xlat1.xy = vs_TEXCOORD0.xy + (-_TaaParams.xxyz.yz);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat1.x = texture(_CoCTex, u_xlat1.xy).x;
    u_xlatb5 = u_xlat12<u_xlat1.x;
    u_xlat2.z = (u_xlatb5) ? u_xlat12 : u_xlat1.x;
    u_xlat12 = max(u_xlat12, u_xlat1.x);
    u_xlat12 = max(u_xlat0.z, u_xlat12);
    u_xlatb9 = u_xlat0.z<u_xlat2.z;
    u_xlat3.xy = _MainTex_TexelSize.xy * vec2(1.0, 0.0);
    u_xlat11.xy = (-u_xlat3.xy);
    u_xlat2.xy = mix(vec2(0.0, 0.0), u_xlat11.xy, vec2(bvec2(u_xlatb5)));
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat2 = _MainTex_TexelSize.yyxy * vec4(0.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat5.z = texture(_CoCTex, u_xlat2.xy).x;
    u_xlat2.x = texture(_CoCTex, u_xlat2.zw).x;
    u_xlatb6 = u_xlat5.z<u_xlat0.z;
    u_xlat5.xy = _MainTex_TexelSize.yy * vec2(0.0, 1.0);
    u_xlat12 = max(u_xlat12, u_xlat5.z);
    u_xlat12 = max(u_xlat2.x, u_xlat12);
    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat5.xyz : u_xlat0.xyz;
    u_xlatb5 = u_xlat2.x<u_xlat0.z;
    u_xlat8 = min(u_xlat2.x, u_xlat0.z);
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat3.xy : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0.xy = texture(_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat0.xy = (-u_xlat16_0.xy) + vs_TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0.x = texture(_MainTex, u_xlat0.xy).x;
    u_xlat0.x = max(u_xlat8, u_xlat16_0.x);
    u_xlat0.x = min(u_xlat12, u_xlat0.x);
    u_xlat0.x = (-u_xlat1.x) + u_xlat0.x;
    SV_Target0 = vec4(_TaaParams.z, _TaaParams.z, _TaaParams.z, _TaaParams.z) * u_xlat0.xxxx + u_xlat1.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 310 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
layout(location = 0) out highp vec2 vs_TEXCOORD0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
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
#version 310 es

precision highp float;
precision highp int;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec3 _TaaParams;
uniform mediump sampler2D _CoCTex;
uniform mediump sampler2D _CameraMotionVectorsTexture;
uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec3 u_xlat5;
bool u_xlatb5;
bool u_xlatb6;
float u_xlat8;
bool u_xlatb9;
vec2 u_xlat11;
float u_xlat12;
void main()
{
    u_xlat0.xy = _MainTex_TexelSize.yy * vec2(-0.0, -1.0);
    u_xlat1 = (-_MainTex_TexelSize.xyyy) * vec4(1.0, 0.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat12 = texture(_CoCTex, u_xlat1.xy).x;
    u_xlat0.z = texture(_CoCTex, u_xlat1.zw).x;
    u_xlat1.xy = vs_TEXCOORD0.xy + (-_TaaParams.xxyz.yz);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat1.x = texture(_CoCTex, u_xlat1.xy).x;
    u_xlatb5 = u_xlat12<u_xlat1.x;
    u_xlat2.z = (u_xlatb5) ? u_xlat12 : u_xlat1.x;
    u_xlat12 = max(u_xlat12, u_xlat1.x);
    u_xlat12 = max(u_xlat0.z, u_xlat12);
    u_xlatb9 = u_xlat0.z<u_xlat2.z;
    u_xlat3.xy = _MainTex_TexelSize.xy * vec2(1.0, 0.0);
    u_xlat11.xy = (-u_xlat3.xy);
    u_xlat2.xy = mix(vec2(0.0, 0.0), u_xlat11.xy, vec2(bvec2(u_xlatb5)));
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat2 = _MainTex_TexelSize.yyxy * vec4(0.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat5.z = texture(_CoCTex, u_xlat2.xy).x;
    u_xlat2.x = texture(_CoCTex, u_xlat2.zw).x;
    u_xlatb6 = u_xlat5.z<u_xlat0.z;
    u_xlat5.xy = _MainTex_TexelSize.yy * vec2(0.0, 1.0);
    u_xlat12 = max(u_xlat12, u_xlat5.z);
    u_xlat12 = max(u_xlat2.x, u_xlat12);
    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat5.xyz : u_xlat0.xyz;
    u_xlatb5 = u_xlat2.x<u_xlat0.z;
    u_xlat8 = min(u_xlat2.x, u_xlat0.z);
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat3.xy : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0.xy = texture(_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat0.xy = (-u_xlat16_0.xy) + vs_TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0.x = texture(_MainTex, u_xlat0.xy).x;
    u_xlat0.x = max(u_xlat8, u_xlat16_0.x);
    u_xlat0.x = min(u_xlat12, u_xlat0.x);
    u_xlat0.x = (-u_xlat1.x) + u_xlat0.x;
    SV_Target0 = vec4(_TaaParams.z, _TaaParams.z, _TaaParams.z, _TaaParams.z) * u_xlat0.xxxx + u_xlat1.xxxx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 310 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
layout(location = 0) out highp vec2 vs_TEXCOORD0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
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
#version 310 es

precision highp float;
precision highp int;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec3 _TaaParams;
uniform mediump sampler2D _CoCTex;
uniform mediump sampler2D _CameraMotionVectorsTexture;
uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec3 u_xlat5;
bool u_xlatb5;
bool u_xlatb6;
float u_xlat8;
bool u_xlatb9;
vec2 u_xlat11;
float u_xlat12;
void main()
{
    u_xlat0.xy = _MainTex_TexelSize.yy * vec2(-0.0, -1.0);
    u_xlat1 = (-_MainTex_TexelSize.xyyy) * vec4(1.0, 0.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat12 = texture(_CoCTex, u_xlat1.xy).x;
    u_xlat0.z = texture(_CoCTex, u_xlat1.zw).x;
    u_xlat1.xy = vs_TEXCOORD0.xy + (-_TaaParams.xxyz.yz);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat1.x = texture(_CoCTex, u_xlat1.xy).x;
    u_xlatb5 = u_xlat12<u_xlat1.x;
    u_xlat2.z = (u_xlatb5) ? u_xlat12 : u_xlat1.x;
    u_xlat12 = max(u_xlat12, u_xlat1.x);
    u_xlat12 = max(u_xlat0.z, u_xlat12);
    u_xlatb9 = u_xlat0.z<u_xlat2.z;
    u_xlat3.xy = _MainTex_TexelSize.xy * vec2(1.0, 0.0);
    u_xlat11.xy = (-u_xlat3.xy);
    u_xlat2.xy = mix(vec2(0.0, 0.0), u_xlat11.xy, vec2(bvec2(u_xlatb5)));
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat2 = _MainTex_TexelSize.yyxy * vec4(0.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat5.z = texture(_CoCTex, u_xlat2.xy).x;
    u_xlat2.x = texture(_CoCTex, u_xlat2.zw).x;
    u_xlatb6 = u_xlat5.z<u_xlat0.z;
    u_xlat5.xy = _MainTex_TexelSize.yy * vec2(0.0, 1.0);
    u_xlat12 = max(u_xlat12, u_xlat5.z);
    u_xlat12 = max(u_xlat2.x, u_xlat12);
    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat5.xyz : u_xlat0.xyz;
    u_xlatb5 = u_xlat2.x<u_xlat0.z;
    u_xlat8 = min(u_xlat2.x, u_xlat0.z);
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat3.xy : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0.xy = texture(_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat0.xy = (-u_xlat16_0.xy) + vs_TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0.x = texture(_MainTex, u_xlat0.xy).x;
    u_xlat0.x = max(u_xlat8, u_xlat16_0.x);
    u_xlat0.x = min(u_xlat12, u_xlat0.x);
    u_xlat0.x = (-u_xlat1.x) + u_xlat0.x;
    SV_Target0 = vec4(_TaaParams.z, _TaaParams.z, _TaaParams.z, _TaaParams.z) * u_xlat0.xxxx + u_xlat1.xxxx;
    return;
}

#endif
"
}
}
Program "fp" {
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
 Pass {
  Name "Downsample and Prefilter"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 152566
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 310 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
layout(location = 0) out highp vec2 vs_TEXCOORD0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
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
#version 310 es

precision highp float;
precision highp int;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CoCTex;
layout(location = 0) in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_8;
bool u_xlatb8;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_MainTex, u_xlat0.zw).xyz;
    u_xlat16_13 = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_13 = max(u_xlat16_1.z, u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 + 1.0;
    u_xlat16_8 = texture(_CoCTex, u_xlat0.zw).x;
    u_xlat16_8 = u_xlat16_8 * 2.0 + -1.0;
    u_xlat16_12 = abs(u_xlat16_8) / u_xlat16_13;
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0 = texture(_CoCTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat16_0 * 2.0 + -1.0;
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_4 = abs(u_xlat16_0) / u_xlat16_4;
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_4) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat16_3.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat16_12 = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_12 = max(u_xlat16_3.z, u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 + 1.0;
    u_xlat16_13 = texture(_CoCTex, u_xlat2.xy).x;
    u_xlat16_13 = u_xlat16_13 * 2.0 + -1.0;
    u_xlat16_12 = abs(u_xlat16_13) / u_xlat16_12;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_12) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat16_3.xyz = texture(_MainTex, u_xlat2.zw).xyz;
    u_xlat16_12 = texture(_CoCTex, u_xlat2.zw).x;
    u_xlat16_12 = u_xlat16_12 * 2.0 + -1.0;
    u_xlat16_2.x = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_2.x = max(u_xlat16_3.z, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = abs(u_xlat16_12) / u_xlat16_2.x;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_2.xxx + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_4 + u_xlat16_2.x;
    u_xlat16_4 = max(u_xlat16_4, 9.99999975e-06);
    u_xlat16_1.xyz = u_xlat16_1.xyz / vec3(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_12, u_xlat16_8);
    u_xlat16_4 = min(u_xlat16_12, u_xlat16_4);
    u_xlat4 = min(u_xlat16_4, u_xlat16_0);
    u_xlat0.x = max(u_xlat16_8, u_xlat16_0);
    u_xlatb8 = u_xlat0.x<(-u_xlat4);
    u_xlat0.x = (u_xlatb8) ? u_xlat4 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaxCoC;
    u_xlat4 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat4 = u_xlat4 * abs(u_xlat0.x);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    SV_Target0.w = u_xlat0.x;
    u_xlat0.x = u_xlat4 * -2.0 + 3.0;
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 310 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
layout(location = 0) out highp vec2 vs_TEXCOORD0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
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
#version 310 es

precision highp float;
precision highp int;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CoCTex;
layout(location = 0) in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_8;
bool u_xlatb8;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_MainTex, u_xlat0.zw).xyz;
    u_xlat16_13 = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_13 = max(u_xlat16_1.z, u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 + 1.0;
    u_xlat16_8 = texture(_CoCTex, u_xlat0.zw).x;
    u_xlat16_8 = u_xlat16_8 * 2.0 + -1.0;
    u_xlat16_12 = abs(u_xlat16_8) / u_xlat16_13;
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0 = texture(_CoCTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat16_0 * 2.0 + -1.0;
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_4 = abs(u_xlat16_0) / u_xlat16_4;
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_4) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat16_3.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat16_12 = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_12 = max(u_xlat16_3.z, u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 + 1.0;
    u_xlat16_13 = texture(_CoCTex, u_xlat2.xy).x;
    u_xlat16_13 = u_xlat16_13 * 2.0 + -1.0;
    u_xlat16_12 = abs(u_xlat16_13) / u_xlat16_12;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_12) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat16_3.xyz = texture(_MainTex, u_xlat2.zw).xyz;
    u_xlat16_12 = texture(_CoCTex, u_xlat2.zw).x;
    u_xlat16_12 = u_xlat16_12 * 2.0 + -1.0;
    u_xlat16_2.x = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_2.x = max(u_xlat16_3.z, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = abs(u_xlat16_12) / u_xlat16_2.x;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_2.xxx + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_4 + u_xlat16_2.x;
    u_xlat16_4 = max(u_xlat16_4, 9.99999975e-06);
    u_xlat16_1.xyz = u_xlat16_1.xyz / vec3(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_12, u_xlat16_8);
    u_xlat16_4 = min(u_xlat16_12, u_xlat16_4);
    u_xlat4 = min(u_xlat16_4, u_xlat16_0);
    u_xlat0.x = max(u_xlat16_8, u_xlat16_0);
    u_xlatb8 = u_xlat0.x<(-u_xlat4);
    u_xlat0.x = (u_xlatb8) ? u_xlat4 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaxCoC;
    u_xlat4 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat4 = u_xlat4 * abs(u_xlat0.x);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    SV_Target0.w = u_xlat0.x;
    u_xlat0.x = u_xlat4 * -2.0 + 3.0;
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 310 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
layout(location = 0) out highp vec2 vs_TEXCOORD0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
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
#version 310 es

precision highp float;
precision highp int;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CoCTex;
layout(location = 0) in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_8;
bool u_xlatb8;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_MainTex, u_xlat0.zw).xyz;
    u_xlat16_13 = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_13 = max(u_xlat16_1.z, u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 + 1.0;
    u_xlat16_8 = texture(_CoCTex, u_xlat0.zw).x;
    u_xlat16_8 = u_xlat16_8 * 2.0 + -1.0;
    u_xlat16_12 = abs(u_xlat16_8) / u_xlat16_13;
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0 = texture(_CoCTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat16_0 * 2.0 + -1.0;
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_4 = abs(u_xlat16_0) / u_xlat16_4;
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_4) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat16_3.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat16_12 = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_12 = max(u_xlat16_3.z, u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 + 1.0;
    u_xlat16_13 = texture(_CoCTex, u_xlat2.xy).x;
    u_xlat16_13 = u_xlat16_13 * 2.0 + -1.0;
    u_xlat16_12 = abs(u_xlat16_13) / u_xlat16_12;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_12) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat16_3.xyz = texture(_MainTex, u_xlat2.zw).xyz;
    u_xlat16_12 = texture(_CoCTex, u_xlat2.zw).x;
    u_xlat16_12 = u_xlat16_12 * 2.0 + -1.0;
    u_xlat16_2.x = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_2.x = max(u_xlat16_3.z, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = abs(u_xlat16_12) / u_xlat16_2.x;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_2.xxx + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_4 + u_xlat16_2.x;
    u_xlat16_4 = max(u_xlat16_4, 9.99999975e-06);
    u_xlat16_1.xyz = u_xlat16_1.xyz / vec3(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_12, u_xlat16_8);
    u_xlat16_4 = min(u_xlat16_12, u_xlat16_4);
    u_xlat4 = min(u_xlat16_4, u_xlat16_0);
    u_xlat0.x = max(u_xlat16_8, u_xlat16_0);
    u_xlatb8 = u_xlat0.x<(-u_xlat4);
    u_xlat0.x = (u_xlatb8) ? u_xlat4 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaxCoC;
    u_xlat4 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat4 = u_xlat4 * abs(u_xlat0.x);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    SV_Target0.w = u_xlat0.x;
    u_xlat0.x = u_xlat4 * -2.0 + 3.0;
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat0.xyz;
    return;
}

#endif
"
}
}
Program "fp" {
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
 Pass {
  Name "Bokeh Filter (small)"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 197836
Program "vp" {
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
vec2 ImmCB_0_0_0[16];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.545454562, 0.0);
	ImmCB_0_0_0[2] = vec2(0.168554723, 0.518758118);
	ImmCB_0_0_0[3] = vec2(-0.441282034, 0.320610106);
	ImmCB_0_0_0[4] = vec2(-0.441281974, -0.320610195);
	ImmCB_0_0_0[5] = vec2(0.168554798, -0.518758118);
	ImmCB_0_0_0[6] = vec2(1.0, 0.0);
	ImmCB_0_0_0[7] = vec2(0.809017003, 0.587785244);
	ImmCB_0_0_0[8] = vec2(0.309016973, 0.95105654);
	ImmCB_0_0_0[9] = vec2(-0.309017032, 0.95105648);
	ImmCB_0_0_0[10] = vec2(-0.809017062, 0.587785184);
	ImmCB_0_0_0[11] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[12] = vec2(-0.809016943, -0.587785363);
	ImmCB_0_0_0[13] = vec2(-0.309016645, -0.9510566);
	ImmCB_0_0_0[14] = vec2(0.309017122, -0.95105648);
	ImmCB_0_0_0[15] = vec2(0.809016943, -0.587785304);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<16 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.196349546;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[16];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.545454562, 0.0);
	ImmCB_0_0_0[2] = vec2(0.168554723, 0.518758118);
	ImmCB_0_0_0[3] = vec2(-0.441282034, 0.320610106);
	ImmCB_0_0_0[4] = vec2(-0.441281974, -0.320610195);
	ImmCB_0_0_0[5] = vec2(0.168554798, -0.518758118);
	ImmCB_0_0_0[6] = vec2(1.0, 0.0);
	ImmCB_0_0_0[7] = vec2(0.809017003, 0.587785244);
	ImmCB_0_0_0[8] = vec2(0.309016973, 0.95105654);
	ImmCB_0_0_0[9] = vec2(-0.309017032, 0.95105648);
	ImmCB_0_0_0[10] = vec2(-0.809017062, 0.587785184);
	ImmCB_0_0_0[11] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[12] = vec2(-0.809016943, -0.587785363);
	ImmCB_0_0_0[13] = vec2(-0.309016645, -0.9510566);
	ImmCB_0_0_0[14] = vec2(0.309017122, -0.95105648);
	ImmCB_0_0_0[15] = vec2(0.809016943, -0.587785304);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<16 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.196349546;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[16];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.545454562, 0.0);
	ImmCB_0_0_0[2] = vec2(0.168554723, 0.518758118);
	ImmCB_0_0_0[3] = vec2(-0.441282034, 0.320610106);
	ImmCB_0_0_0[4] = vec2(-0.441281974, -0.320610195);
	ImmCB_0_0_0[5] = vec2(0.168554798, -0.518758118);
	ImmCB_0_0_0[6] = vec2(1.0, 0.0);
	ImmCB_0_0_0[7] = vec2(0.809017003, 0.587785244);
	ImmCB_0_0_0[8] = vec2(0.309016973, 0.95105654);
	ImmCB_0_0_0[9] = vec2(-0.309017032, 0.95105648);
	ImmCB_0_0_0[10] = vec2(-0.809017062, 0.587785184);
	ImmCB_0_0_0[11] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[12] = vec2(-0.809016943, -0.587785363);
	ImmCB_0_0_0[13] = vec2(-0.309016645, -0.9510566);
	ImmCB_0_0_0[14] = vec2(0.309017122, -0.95105648);
	ImmCB_0_0_0[15] = vec2(0.809016943, -0.587785304);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<16 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.196349546;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
    return;
}

#endif
"
}
}
Program "fp" {
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
 Pass {
  Name "Bokeh Filter (medium)"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 321493
Program "vp" {
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
vec2 ImmCB_0_0_0[22];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.533333361, 0.0);
	ImmCB_0_0_0[2] = vec2(0.332527906, 0.41697681);
	ImmCB_0_0_0[3] = vec2(-0.118677847, 0.519961596);
	ImmCB_0_0_0[4] = vec2(-0.480516732, 0.231404707);
	ImmCB_0_0_0[5] = vec2(-0.480516732, -0.231404677);
	ImmCB_0_0_0[6] = vec2(-0.118677631, -0.519961655);
	ImmCB_0_0_0[7] = vec2(0.332527846, -0.416976899);
	ImmCB_0_0_0[8] = vec2(1.0, 0.0);
	ImmCB_0_0_0[9] = vec2(0.90096885, 0.433883756);
	ImmCB_0_0_0[10] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[11] = vec2(0.222520977, 0.974927902);
	ImmCB_0_0_0[12] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[13] = vec2(-0.623489976, 0.781831384);
	ImmCB_0_0_0[14] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[15] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[17] = vec2(-0.623489618, -0.781831622);
	ImmCB_0_0_0[18] = vec2(-0.222520545, -0.974928021);
	ImmCB_0_0_0[19] = vec2(0.222521499, -0.974927783);
	ImmCB_0_0_0[20] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[21] = vec2(0.90096885, -0.433883756);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<22 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.142799661;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[22];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.533333361, 0.0);
	ImmCB_0_0_0[2] = vec2(0.332527906, 0.41697681);
	ImmCB_0_0_0[3] = vec2(-0.118677847, 0.519961596);
	ImmCB_0_0_0[4] = vec2(-0.480516732, 0.231404707);
	ImmCB_0_0_0[5] = vec2(-0.480516732, -0.231404677);
	ImmCB_0_0_0[6] = vec2(-0.118677631, -0.519961655);
	ImmCB_0_0_0[7] = vec2(0.332527846, -0.416976899);
	ImmCB_0_0_0[8] = vec2(1.0, 0.0);
	ImmCB_0_0_0[9] = vec2(0.90096885, 0.433883756);
	ImmCB_0_0_0[10] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[11] = vec2(0.222520977, 0.974927902);
	ImmCB_0_0_0[12] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[13] = vec2(-0.623489976, 0.781831384);
	ImmCB_0_0_0[14] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[15] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[17] = vec2(-0.623489618, -0.781831622);
	ImmCB_0_0_0[18] = vec2(-0.222520545, -0.974928021);
	ImmCB_0_0_0[19] = vec2(0.222521499, -0.974927783);
	ImmCB_0_0_0[20] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[21] = vec2(0.90096885, -0.433883756);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<22 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.142799661;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[22];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.533333361, 0.0);
	ImmCB_0_0_0[2] = vec2(0.332527906, 0.41697681);
	ImmCB_0_0_0[3] = vec2(-0.118677847, 0.519961596);
	ImmCB_0_0_0[4] = vec2(-0.480516732, 0.231404707);
	ImmCB_0_0_0[5] = vec2(-0.480516732, -0.231404677);
	ImmCB_0_0_0[6] = vec2(-0.118677631, -0.519961655);
	ImmCB_0_0_0[7] = vec2(0.332527846, -0.416976899);
	ImmCB_0_0_0[8] = vec2(1.0, 0.0);
	ImmCB_0_0_0[9] = vec2(0.90096885, 0.433883756);
	ImmCB_0_0_0[10] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[11] = vec2(0.222520977, 0.974927902);
	ImmCB_0_0_0[12] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[13] = vec2(-0.623489976, 0.781831384);
	ImmCB_0_0_0[14] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[15] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[17] = vec2(-0.623489618, -0.781831622);
	ImmCB_0_0_0[18] = vec2(-0.222520545, -0.974928021);
	ImmCB_0_0_0[19] = vec2(0.222521499, -0.974927783);
	ImmCB_0_0_0[20] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[21] = vec2(0.90096885, -0.433883756);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<22 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.142799661;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
    return;
}

#endif
"
}
}
Program "fp" {
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
 Pass {
  Name "Bokeh Filter (large)"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 368794
Program "vp" {
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
vec2 ImmCB_0_0_0[43];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.363636374, 0.0);
	ImmCB_0_0_0[2] = vec2(0.226723567, 0.284302384);
	ImmCB_0_0_0[3] = vec2(-0.0809167102, 0.354519248);
	ImmCB_0_0_0[4] = vec2(-0.327625036, 0.157775939);
	ImmCB_0_0_0[5] = vec2(-0.327625036, -0.157775909);
	ImmCB_0_0_0[6] = vec2(-0.0809165612, -0.354519278);
	ImmCB_0_0_0[7] = vec2(0.226723522, -0.284302413);
	ImmCB_0_0_0[8] = vec2(0.681818187, 0.0);
	ImmCB_0_0_0[9] = vec2(0.614296973, 0.295829833);
	ImmCB_0_0_0[10] = vec2(0.425106674, 0.533066928);
	ImmCB_0_0_0[11] = vec2(0.151718855, 0.664723575);
	ImmCB_0_0_0[12] = vec2(-0.151718825, 0.664723575);
	ImmCB_0_0_0[13] = vec2(-0.425106794, 0.533066869);
	ImmCB_0_0_0[14] = vec2(-0.614296973, 0.295829862);
	ImmCB_0_0_0[15] = vec2(-0.681818187, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.614296973, -0.295829833);
	ImmCB_0_0_0[17] = vec2(-0.425106555, -0.533067048);
	ImmCB_0_0_0[18] = vec2(-0.151718557, -0.664723635);
	ImmCB_0_0_0[19] = vec2(0.151719198, -0.664723516);
	ImmCB_0_0_0[20] = vec2(0.425106615, -0.533067048);
	ImmCB_0_0_0[21] = vec2(0.614296973, -0.295829833);
	ImmCB_0_0_0[22] = vec2(1.0, 0.0);
	ImmCB_0_0_0[23] = vec2(0.955572784, 0.294755191);
	ImmCB_0_0_0[24] = vec2(0.826238751, 0.5633201);
	ImmCB_0_0_0[25] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[26] = vec2(0.365340978, 0.930873752);
	ImmCB_0_0_0[27] = vec2(0.0747300014, 0.997203827);
	ImmCB_0_0_0[28] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[29] = vec2(-0.50000006, 0.866025388);
	ImmCB_0_0_0[30] = vec2(-0.733051956, 0.680172682);
	ImmCB_0_0_0[31] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[32] = vec2(-0.988830864, 0.149042085);
	ImmCB_0_0_0[33] = vec2(-0.988830805, -0.149042487);
	ImmCB_0_0_0[34] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[35] = vec2(-0.733051836, -0.680172801);
	ImmCB_0_0_0[36] = vec2(-0.499999911, -0.866025448);
	ImmCB_0_0_0[37] = vec2(-0.222521007, -0.974927902);
	ImmCB_0_0_0[38] = vec2(0.074730292, -0.997203767);
	ImmCB_0_0_0[39] = vec2(0.365341485, -0.930873573);
	ImmCB_0_0_0[40] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[41] = vec2(0.826238811, -0.563319981);
	ImmCB_0_0_0[42] = vec2(0.955572903, -0.294754833);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<43 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0730602965;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[43];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.363636374, 0.0);
	ImmCB_0_0_0[2] = vec2(0.226723567, 0.284302384);
	ImmCB_0_0_0[3] = vec2(-0.0809167102, 0.354519248);
	ImmCB_0_0_0[4] = vec2(-0.327625036, 0.157775939);
	ImmCB_0_0_0[5] = vec2(-0.327625036, -0.157775909);
	ImmCB_0_0_0[6] = vec2(-0.0809165612, -0.354519278);
	ImmCB_0_0_0[7] = vec2(0.226723522, -0.284302413);
	ImmCB_0_0_0[8] = vec2(0.681818187, 0.0);
	ImmCB_0_0_0[9] = vec2(0.614296973, 0.295829833);
	ImmCB_0_0_0[10] = vec2(0.425106674, 0.533066928);
	ImmCB_0_0_0[11] = vec2(0.151718855, 0.664723575);
	ImmCB_0_0_0[12] = vec2(-0.151718825, 0.664723575);
	ImmCB_0_0_0[13] = vec2(-0.425106794, 0.533066869);
	ImmCB_0_0_0[14] = vec2(-0.614296973, 0.295829862);
	ImmCB_0_0_0[15] = vec2(-0.681818187, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.614296973, -0.295829833);
	ImmCB_0_0_0[17] = vec2(-0.425106555, -0.533067048);
	ImmCB_0_0_0[18] = vec2(-0.151718557, -0.664723635);
	ImmCB_0_0_0[19] = vec2(0.151719198, -0.664723516);
	ImmCB_0_0_0[20] = vec2(0.425106615, -0.533067048);
	ImmCB_0_0_0[21] = vec2(0.614296973, -0.295829833);
	ImmCB_0_0_0[22] = vec2(1.0, 0.0);
	ImmCB_0_0_0[23] = vec2(0.955572784, 0.294755191);
	ImmCB_0_0_0[24] = vec2(0.826238751, 0.5633201);
	ImmCB_0_0_0[25] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[26] = vec2(0.365340978, 0.930873752);
	ImmCB_0_0_0[27] = vec2(0.0747300014, 0.997203827);
	ImmCB_0_0_0[28] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[29] = vec2(-0.50000006, 0.866025388);
	ImmCB_0_0_0[30] = vec2(-0.733051956, 0.680172682);
	ImmCB_0_0_0[31] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[32] = vec2(-0.988830864, 0.149042085);
	ImmCB_0_0_0[33] = vec2(-0.988830805, -0.149042487);
	ImmCB_0_0_0[34] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[35] = vec2(-0.733051836, -0.680172801);
	ImmCB_0_0_0[36] = vec2(-0.499999911, -0.866025448);
	ImmCB_0_0_0[37] = vec2(-0.222521007, -0.974927902);
	ImmCB_0_0_0[38] = vec2(0.074730292, -0.997203767);
	ImmCB_0_0_0[39] = vec2(0.365341485, -0.930873573);
	ImmCB_0_0_0[40] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[41] = vec2(0.826238811, -0.563319981);
	ImmCB_0_0_0[42] = vec2(0.955572903, -0.294754833);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<43 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0730602965;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[43];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.363636374, 0.0);
	ImmCB_0_0_0[2] = vec2(0.226723567, 0.284302384);
	ImmCB_0_0_0[3] = vec2(-0.0809167102, 0.354519248);
	ImmCB_0_0_0[4] = vec2(-0.327625036, 0.157775939);
	ImmCB_0_0_0[5] = vec2(-0.327625036, -0.157775909);
	ImmCB_0_0_0[6] = vec2(-0.0809165612, -0.354519278);
	ImmCB_0_0_0[7] = vec2(0.226723522, -0.284302413);
	ImmCB_0_0_0[8] = vec2(0.681818187, 0.0);
	ImmCB_0_0_0[9] = vec2(0.614296973, 0.295829833);
	ImmCB_0_0_0[10] = vec2(0.425106674, 0.533066928);
	ImmCB_0_0_0[11] = vec2(0.151718855, 0.664723575);
	ImmCB_0_0_0[12] = vec2(-0.151718825, 0.664723575);
	ImmCB_0_0_0[13] = vec2(-0.425106794, 0.533066869);
	ImmCB_0_0_0[14] = vec2(-0.614296973, 0.295829862);
	ImmCB_0_0_0[15] = vec2(-0.681818187, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.614296973, -0.295829833);
	ImmCB_0_0_0[17] = vec2(-0.425106555, -0.533067048);
	ImmCB_0_0_0[18] = vec2(-0.151718557, -0.664723635);
	ImmCB_0_0_0[19] = vec2(0.151719198, -0.664723516);
	ImmCB_0_0_0[20] = vec2(0.425106615, -0.533067048);
	ImmCB_0_0_0[21] = vec2(0.614296973, -0.295829833);
	ImmCB_0_0_0[22] = vec2(1.0, 0.0);
	ImmCB_0_0_0[23] = vec2(0.955572784, 0.294755191);
	ImmCB_0_0_0[24] = vec2(0.826238751, 0.5633201);
	ImmCB_0_0_0[25] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[26] = vec2(0.365340978, 0.930873752);
	ImmCB_0_0_0[27] = vec2(0.0747300014, 0.997203827);
	ImmCB_0_0_0[28] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[29] = vec2(-0.50000006, 0.866025388);
	ImmCB_0_0_0[30] = vec2(-0.733051956, 0.680172682);
	ImmCB_0_0_0[31] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[32] = vec2(-0.988830864, 0.149042085);
	ImmCB_0_0_0[33] = vec2(-0.988830805, -0.149042487);
	ImmCB_0_0_0[34] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[35] = vec2(-0.733051836, -0.680172801);
	ImmCB_0_0_0[36] = vec2(-0.499999911, -0.866025448);
	ImmCB_0_0_0[37] = vec2(-0.222521007, -0.974927902);
	ImmCB_0_0_0[38] = vec2(0.074730292, -0.997203767);
	ImmCB_0_0_0[39] = vec2(0.365341485, -0.930873573);
	ImmCB_0_0_0[40] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[41] = vec2(0.826238811, -0.563319981);
	ImmCB_0_0_0[42] = vec2(0.955572903, -0.294754833);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<43 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0730602965;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
    return;
}

#endif
"
}
}
Program "fp" {
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
 Pass {
  Name "Bokeh Filter (very large)"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 445628
Program "vp" {
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
vec2 ImmCB_0_0_0[71];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.275862098, 0.0);
	ImmCB_0_0_0[2] = vec2(0.171997204, 0.215677679);
	ImmCB_0_0_0[3] = vec2(-0.0613850951, 0.268945664);
	ImmCB_0_0_0[4] = vec2(-0.248543158, 0.119692102);
	ImmCB_0_0_0[5] = vec2(-0.248543158, -0.11969208);
	ImmCB_0_0_0[6] = vec2(-0.0613849834, -0.268945694);
	ImmCB_0_0_0[7] = vec2(0.171997175, -0.215677708);
	ImmCB_0_0_0[8] = vec2(0.517241359, 0.0);
	ImmCB_0_0_0[9] = vec2(0.466018349, 0.224422619);
	ImmCB_0_0_0[10] = vec2(0.322494715, 0.40439558);
	ImmCB_0_0_0[11] = vec2(0.115097053, 0.504273057);
	ImmCB_0_0_0[12] = vec2(-0.115097038, 0.504273057);
	ImmCB_0_0_0[13] = vec2(-0.322494805, 0.404395521);
	ImmCB_0_0_0[14] = vec2(-0.466018349, 0.224422649);
	ImmCB_0_0_0[15] = vec2(-0.517241359, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.466018349, -0.224422619);
	ImmCB_0_0_0[17] = vec2(-0.322494626, -0.40439564);
	ImmCB_0_0_0[18] = vec2(-0.11509683, -0.504273117);
	ImmCB_0_0_0[19] = vec2(0.115097322, -0.504272997);
	ImmCB_0_0_0[20] = vec2(0.322494656, -0.40439564);
	ImmCB_0_0_0[21] = vec2(0.466018349, -0.224422619);
	ImmCB_0_0_0[22] = vec2(0.758620679, 0.0);
	ImmCB_0_0_0[23] = vec2(0.724917293, 0.223607376);
	ImmCB_0_0_0[24] = vec2(0.626801789, 0.427346289);
	ImmCB_0_0_0[25] = vec2(0.472992241, 0.593113542);
	ImmCB_0_0_0[26] = vec2(0.277155221, 0.706180096);
	ImmCB_0_0_0[27] = vec2(0.0566917248, 0.756499469);
	ImmCB_0_0_0[28] = vec2(-0.168808997, 0.73960048);
	ImmCB_0_0_0[29] = vec2(-0.379310399, 0.656984746);
	ImmCB_0_0_0[30] = vec2(-0.556108356, 0.515993059);
	ImmCB_0_0_0[31] = vec2(-0.683493614, 0.32915324);
	ImmCB_0_0_0[32] = vec2(-0.750147521, 0.113066405);
	ImmCB_0_0_0[33] = vec2(-0.750147521, -0.113066711);
	ImmCB_0_0_0[34] = vec2(-0.683493614, -0.32915318);
	ImmCB_0_0_0[35] = vec2(-0.556108296, -0.515993178);
	ImmCB_0_0_0[36] = vec2(-0.37931028, -0.656984806);
	ImmCB_0_0_0[37] = vec2(-0.168809041, -0.73960048);
	ImmCB_0_0_0[38] = vec2(0.0566919446, -0.75649941);
	ImmCB_0_0_0[39] = vec2(0.277155608, -0.706179917);
	ImmCB_0_0_0[40] = vec2(0.472992152, -0.593113661);
	ImmCB_0_0_0[41] = vec2(0.626801848, -0.4273462);
	ImmCB_0_0_0[42] = vec2(0.724917352, -0.223607108);
	ImmCB_0_0_0[43] = vec2(1.0, 0.0);
	ImmCB_0_0_0[44] = vec2(0.974927902, 0.222520933);
	ImmCB_0_0_0[45] = vec2(0.90096885, 0.433883756);
	ImmCB_0_0_0[46] = vec2(0.781831503, 0.623489797);
	ImmCB_0_0_0[47] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[48] = vec2(0.433883637, 0.900968909);
	ImmCB_0_0_0[49] = vec2(0.222520977, 0.974927902);
	ImmCB_0_0_0[50] = vec2(0.0, 1.0);
	ImmCB_0_0_0[51] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[52] = vec2(-0.433883846, 0.90096885);
	ImmCB_0_0_0[53] = vec2(-0.623489976, 0.781831384);
	ImmCB_0_0_0[54] = vec2(-0.781831682, 0.623489559);
	ImmCB_0_0_0[55] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[56] = vec2(-0.974927902, 0.222520933);
	ImmCB_0_0_0[57] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[58] = vec2(-0.974927902, -0.222520873);
	ImmCB_0_0_0[59] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[60] = vec2(-0.781831384, -0.623489916);
	ImmCB_0_0_0[61] = vec2(-0.623489618, -0.781831622);
	ImmCB_0_0_0[62] = vec2(-0.433883458, -0.900969028);
	ImmCB_0_0_0[63] = vec2(-0.222520545, -0.974928021);
	ImmCB_0_0_0[64] = vec2(0.0, -1.0);
	ImmCB_0_0_0[65] = vec2(0.222521499, -0.974927783);
	ImmCB_0_0_0[66] = vec2(0.433883488, -0.900968969);
	ImmCB_0_0_0[67] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[68] = vec2(0.781831443, -0.623489857);
	ImmCB_0_0_0[69] = vec2(0.90096885, -0.433883756);
	ImmCB_0_0_0[70] = vec2(0.974927902, -0.222520858);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<71 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0442477837;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[71];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.275862098, 0.0);
	ImmCB_0_0_0[2] = vec2(0.171997204, 0.215677679);
	ImmCB_0_0_0[3] = vec2(-0.0613850951, 0.268945664);
	ImmCB_0_0_0[4] = vec2(-0.248543158, 0.119692102);
	ImmCB_0_0_0[5] = vec2(-0.248543158, -0.11969208);
	ImmCB_0_0_0[6] = vec2(-0.0613849834, -0.268945694);
	ImmCB_0_0_0[7] = vec2(0.171997175, -0.215677708);
	ImmCB_0_0_0[8] = vec2(0.517241359, 0.0);
	ImmCB_0_0_0[9] = vec2(0.466018349, 0.224422619);
	ImmCB_0_0_0[10] = vec2(0.322494715, 0.40439558);
	ImmCB_0_0_0[11] = vec2(0.115097053, 0.504273057);
	ImmCB_0_0_0[12] = vec2(-0.115097038, 0.504273057);
	ImmCB_0_0_0[13] = vec2(-0.322494805, 0.404395521);
	ImmCB_0_0_0[14] = vec2(-0.466018349, 0.224422649);
	ImmCB_0_0_0[15] = vec2(-0.517241359, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.466018349, -0.224422619);
	ImmCB_0_0_0[17] = vec2(-0.322494626, -0.40439564);
	ImmCB_0_0_0[18] = vec2(-0.11509683, -0.504273117);
	ImmCB_0_0_0[19] = vec2(0.115097322, -0.504272997);
	ImmCB_0_0_0[20] = vec2(0.322494656, -0.40439564);
	ImmCB_0_0_0[21] = vec2(0.466018349, -0.224422619);
	ImmCB_0_0_0[22] = vec2(0.758620679, 0.0);
	ImmCB_0_0_0[23] = vec2(0.724917293, 0.223607376);
	ImmCB_0_0_0[24] = vec2(0.626801789, 0.427346289);
	ImmCB_0_0_0[25] = vec2(0.472992241, 0.593113542);
	ImmCB_0_0_0[26] = vec2(0.277155221, 0.706180096);
	ImmCB_0_0_0[27] = vec2(0.0566917248, 0.756499469);
	ImmCB_0_0_0[28] = vec2(-0.168808997, 0.73960048);
	ImmCB_0_0_0[29] = vec2(-0.379310399, 0.656984746);
	ImmCB_0_0_0[30] = vec2(-0.556108356, 0.515993059);
	ImmCB_0_0_0[31] = vec2(-0.683493614, 0.32915324);
	ImmCB_0_0_0[32] = vec2(-0.750147521, 0.113066405);
	ImmCB_0_0_0[33] = vec2(-0.750147521, -0.113066711);
	ImmCB_0_0_0[34] = vec2(-0.683493614, -0.32915318);
	ImmCB_0_0_0[35] = vec2(-0.556108296, -0.515993178);
	ImmCB_0_0_0[36] = vec2(-0.37931028, -0.656984806);
	ImmCB_0_0_0[37] = vec2(-0.168809041, -0.73960048);
	ImmCB_0_0_0[38] = vec2(0.0566919446, -0.75649941);
	ImmCB_0_0_0[39] = vec2(0.277155608, -0.706179917);
	ImmCB_0_0_0[40] = vec2(0.472992152, -0.593113661);
	ImmCB_0_0_0[41] = vec2(0.626801848, -0.4273462);
	ImmCB_0_0_0[42] = vec2(0.724917352, -0.223607108);
	ImmCB_0_0_0[43] = vec2(1.0, 0.0);
	ImmCB_0_0_0[44] = vec2(0.974927902, 0.222520933);
	ImmCB_0_0_0[45] = vec2(0.90096885, 0.433883756);
	ImmCB_0_0_0[46] = vec2(0.781831503, 0.623489797);
	ImmCB_0_0_0[47] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[48] = vec2(0.433883637, 0.900968909);
	ImmCB_0_0_0[49] = vec2(0.222520977, 0.974927902);
	ImmCB_0_0_0[50] = vec2(0.0, 1.0);
	ImmCB_0_0_0[51] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[52] = vec2(-0.433883846, 0.90096885);
	ImmCB_0_0_0[53] = vec2(-0.623489976, 0.781831384);
	ImmCB_0_0_0[54] = vec2(-0.781831682, 0.623489559);
	ImmCB_0_0_0[55] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[56] = vec2(-0.974927902, 0.222520933);
	ImmCB_0_0_0[57] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[58] = vec2(-0.974927902, -0.222520873);
	ImmCB_0_0_0[59] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[60] = vec2(-0.781831384, -0.623489916);
	ImmCB_0_0_0[61] = vec2(-0.623489618, -0.781831622);
	ImmCB_0_0_0[62] = vec2(-0.433883458, -0.900969028);
	ImmCB_0_0_0[63] = vec2(-0.222520545, -0.974928021);
	ImmCB_0_0_0[64] = vec2(0.0, -1.0);
	ImmCB_0_0_0[65] = vec2(0.222521499, -0.974927783);
	ImmCB_0_0_0[66] = vec2(0.433883488, -0.900968969);
	ImmCB_0_0_0[67] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[68] = vec2(0.781831443, -0.623489857);
	ImmCB_0_0_0[69] = vec2(0.90096885, -0.433883756);
	ImmCB_0_0_0[70] = vec2(0.974927902, -0.222520858);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<71 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0442477837;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[71];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.275862098, 0.0);
	ImmCB_0_0_0[2] = vec2(0.171997204, 0.215677679);
	ImmCB_0_0_0[3] = vec2(-0.0613850951, 0.268945664);
	ImmCB_0_0_0[4] = vec2(-0.248543158, 0.119692102);
	ImmCB_0_0_0[5] = vec2(-0.248543158, -0.11969208);
	ImmCB_0_0_0[6] = vec2(-0.0613849834, -0.268945694);
	ImmCB_0_0_0[7] = vec2(0.171997175, -0.215677708);
	ImmCB_0_0_0[8] = vec2(0.517241359, 0.0);
	ImmCB_0_0_0[9] = vec2(0.466018349, 0.224422619);
	ImmCB_0_0_0[10] = vec2(0.322494715, 0.40439558);
	ImmCB_0_0_0[11] = vec2(0.115097053, 0.504273057);
	ImmCB_0_0_0[12] = vec2(-0.115097038, 0.504273057);
	ImmCB_0_0_0[13] = vec2(-0.322494805, 0.404395521);
	ImmCB_0_0_0[14] = vec2(-0.466018349, 0.224422649);
	ImmCB_0_0_0[15] = vec2(-0.517241359, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.466018349, -0.224422619);
	ImmCB_0_0_0[17] = vec2(-0.322494626, -0.40439564);
	ImmCB_0_0_0[18] = vec2(-0.11509683, -0.504273117);
	ImmCB_0_0_0[19] = vec2(0.115097322, -0.504272997);
	ImmCB_0_0_0[20] = vec2(0.322494656, -0.40439564);
	ImmCB_0_0_0[21] = vec2(0.466018349, -0.224422619);
	ImmCB_0_0_0[22] = vec2(0.758620679, 0.0);
	ImmCB_0_0_0[23] = vec2(0.724917293, 0.223607376);
	ImmCB_0_0_0[24] = vec2(0.626801789, 0.427346289);
	ImmCB_0_0_0[25] = vec2(0.472992241, 0.593113542);
	ImmCB_0_0_0[26] = vec2(0.277155221, 0.706180096);
	ImmCB_0_0_0[27] = vec2(0.0566917248, 0.756499469);
	ImmCB_0_0_0[28] = vec2(-0.168808997, 0.73960048);
	ImmCB_0_0_0[29] = vec2(-0.379310399, 0.656984746);
	ImmCB_0_0_0[30] = vec2(-0.556108356, 0.515993059);
	ImmCB_0_0_0[31] = vec2(-0.683493614, 0.32915324);
	ImmCB_0_0_0[32] = vec2(-0.750147521, 0.113066405);
	ImmCB_0_0_0[33] = vec2(-0.750147521, -0.113066711);
	ImmCB_0_0_0[34] = vec2(-0.683493614, -0.32915318);
	ImmCB_0_0_0[35] = vec2(-0.556108296, -0.515993178);
	ImmCB_0_0_0[36] = vec2(-0.37931028, -0.656984806);
	ImmCB_0_0_0[37] = vec2(-0.168809041, -0.73960048);
	ImmCB_0_0_0[38] = vec2(0.0566919446, -0.75649941);
	ImmCB_0_0_0[39] = vec2(0.277155608, -0.706179917);
	ImmCB_0_0_0[40] = vec2(0.472992152, -0.593113661);
	ImmCB_0_0_0[41] = vec2(0.626801848, -0.4273462);
	ImmCB_0_0_0[42] = vec2(0.724917352, -0.223607108);
	ImmCB_0_0_0[43] = vec2(1.0, 0.0);
	ImmCB_0_0_0[44] = vec2(0.974927902, 0.222520933);
	ImmCB_0_0_0[45] = vec2(0.90096885, 0.433883756);
	ImmCB_0_0_0[46] = vec2(0.781831503, 0.623489797);
	ImmCB_0_0_0[47] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[48] = vec2(0.433883637, 0.900968909);
	ImmCB_0_0_0[49] = vec2(0.222520977, 0.974927902);
	ImmCB_0_0_0[50] = vec2(0.0, 1.0);
	ImmCB_0_0_0[51] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[52] = vec2(-0.433883846, 0.90096885);
	ImmCB_0_0_0[53] = vec2(-0.623489976, 0.781831384);
	ImmCB_0_0_0[54] = vec2(-0.781831682, 0.623489559);
	ImmCB_0_0_0[55] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[56] = vec2(-0.974927902, 0.222520933);
	ImmCB_0_0_0[57] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[58] = vec2(-0.974927902, -0.222520873);
	ImmCB_0_0_0[59] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[60] = vec2(-0.781831384, -0.623489916);
	ImmCB_0_0_0[61] = vec2(-0.623489618, -0.781831622);
	ImmCB_0_0_0[62] = vec2(-0.433883458, -0.900969028);
	ImmCB_0_0_0[63] = vec2(-0.222520545, -0.974928021);
	ImmCB_0_0_0[64] = vec2(0.0, -1.0);
	ImmCB_0_0_0[65] = vec2(0.222521499, -0.974927783);
	ImmCB_0_0_0[66] = vec2(0.433883488, -0.900968969);
	ImmCB_0_0_0[67] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[68] = vec2(0.781831443, -0.623489857);
	ImmCB_0_0_0[69] = vec2(0.90096885, -0.433883756);
	ImmCB_0_0_0[70] = vec2(0.974927902, -0.222520858);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<71 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0442477837;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
    return;
}

#endif
"
}
}
Program "fp" {
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
 Pass {
  Name "Postfilter"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 493748
Program "vp" {
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat16_1 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = texture(_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    SV_Target0 = u_xlat16_0 * vec4(0.25, 0.25, 0.25, 0.25);
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat16_1 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = texture(_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    SV_Target0 = u_xlat16_0 * vec4(0.25, 0.25, 0.25, 0.25);
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat16_1 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = texture(_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    SV_Target0 = u_xlat16_0 * vec4(0.25, 0.25, 0.25, 0.25);
    return;
}

#endif
"
}
}
Program "fp" {
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
 Pass {
  Name "Combine"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 569740
Program "vp" {
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
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform mediump sampler2D _DepthOfFieldTex;
uniform mediump sampler2D _CoCTex;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat16_0 = texture(_CoCTex, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat16_0 + -0.5;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat3 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat0.x = u_xlat16_0 * _MaxCoC + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat0.x * u_xlat3;
    u_xlat1 = texture(_DepthOfFieldTex, vs_TEXCOORD1.xy);
    u_xlat0.x = u_xlat3 * u_xlat0.x + u_xlat1.w;
    u_xlat0.x = (-u_xlat6) * u_xlat1.w + u_xlat0.x;
    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
    u_xlat1.w = max(u_xlat1.z, u_xlat3);
    u_xlat2 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat2.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
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
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform mediump sampler2D _DepthOfFieldTex;
uniform mediump sampler2D _CoCTex;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat16_0 = texture(_CoCTex, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat16_0 + -0.5;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat3 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat0.x = u_xlat16_0 * _MaxCoC + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat0.x * u_xlat3;
    u_xlat1 = texture(_DepthOfFieldTex, vs_TEXCOORD1.xy);
    u_xlat0.x = u_xlat3 * u_xlat0.x + u_xlat1.w;
    u_xlat0.x = (-u_xlat6) * u_xlat1.w + u_xlat0.x;
    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
    u_xlat1.w = max(u_xlat1.z, u_xlat3);
    u_xlat2 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat2.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
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
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform mediump sampler2D _DepthOfFieldTex;
uniform mediump sampler2D _CoCTex;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat16_0 = texture(_CoCTex, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat16_0 + -0.5;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat3 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat0.x = u_xlat16_0 * _MaxCoC + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat0.x * u_xlat3;
    u_xlat1 = texture(_DepthOfFieldTex, vs_TEXCOORD1.xy);
    u_xlat0.x = u_xlat3 * u_xlat0.x + u_xlat1.w;
    u_xlat0.x = (-u_xlat6) * u_xlat1.w + u_xlat0.x;
    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
    u_xlat1.w = max(u_xlat1.z, u_xlat3);
    u_xlat2 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat2.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
}
Program "fp" {
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
 Pass {
  Name "Debug Overlay"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 590047
Program "vp" {
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
uniform 	vec4 _ZBufferParams;
uniform 	float _Distance;
uniform 	float _LensCoeff;
uniform mediump sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat0.x + (-_Distance);
    u_xlat2 = u_xlat2 * _LensCoeff;
    u_xlat0.x = u_xlat2 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 80.0;
    u_xlat2 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xzw = u_xlat0.xxx * vec3(0.0, 1.0, 1.0) + vec3(1.0, 0.0, 0.0);
    u_xlat1.xyz = (-u_xlat0.xww) + vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat0.xyz = vec3(u_xlat2) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_6 = dot(u_xlat16_1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat16_6 = u_xlat16_6 + 0.5;
    SV_Target0.xyz = vec3(u_xlat16_6) * u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _Distance;
uniform 	float _LensCoeff;
uniform mediump sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat0.x + (-_Distance);
    u_xlat2 = u_xlat2 * _LensCoeff;
    u_xlat0.x = u_xlat2 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 80.0;
    u_xlat2 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xzw = u_xlat0.xxx * vec3(0.0, 1.0, 1.0) + vec3(1.0, 0.0, 0.0);
    u_xlat1.xyz = (-u_xlat0.xww) + vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat0.xyz = vec3(u_xlat2) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_6 = dot(u_xlat16_1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat16_6 = u_xlat16_6 + 0.5;
    SV_Target0.xyz = vec3(u_xlat16_6) * u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _Distance;
uniform 	float _LensCoeff;
uniform mediump sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat0.x + (-_Distance);
    u_xlat2 = u_xlat2 * _LensCoeff;
    u_xlat0.x = u_xlat2 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 80.0;
    u_xlat2 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xzw = u_xlat0.xxx * vec3(0.0, 1.0, 1.0) + vec3(1.0, 0.0, 0.0);
    u_xlat1.xyz = (-u_xlat0.xww) + vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat0.xyz = vec3(u_xlat2) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_6 = dot(u_xlat16_1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat16_6 = u_xlat16_6 + 0.5;
    SV_Target0.xyz = vec3(u_xlat16_6) * u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
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
SubShader {
 Pass {
  Name "CoC Calculation"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 677815
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
uniform 	vec4 _ZBufferParams;
uniform 	float _Distance;
uniform 	float _LensCoeff;
uniform 	float _RcpMaxCoC;
uniform highp sampler2D _CameraDepthTexture;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
float u_xlat1;
void main()
{
    u_xlat0 = texture2D(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat0 = _ZBufferParams.z * u_xlat0 + _ZBufferParams.w;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat1 = u_xlat0 + (-_Distance);
    u_xlat0 = max(u_xlat0, 9.99999975e-06);
    u_xlat1 = u_xlat1 * _LensCoeff;
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.5;
    u_xlat0 = u_xlat0 * _RcpMaxCoC + 0.5;
    SV_Target0 = vec4(u_xlat0);
    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	float _Distance;
uniform 	float _LensCoeff;
uniform 	float _RcpMaxCoC;
uniform highp sampler2D _CameraDepthTexture;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
float u_xlat1;
void main()
{
    u_xlat0 = texture2D(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat0 = _ZBufferParams.z * u_xlat0 + _ZBufferParams.w;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat1 = u_xlat0 + (-_Distance);
    u_xlat0 = max(u_xlat0, 9.99999975e-06);
    u_xlat1 = u_xlat1 * _LensCoeff;
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.5;
    u_xlat0 = u_xlat0 * _RcpMaxCoC + 0.5;
    SV_Target0 = vec4(u_xlat0);
    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	float _Distance;
uniform 	float _LensCoeff;
uniform 	float _RcpMaxCoC;
uniform highp sampler2D _CameraDepthTexture;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
float u_xlat1;
void main()
{
    u_xlat0 = texture2D(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat0 = _ZBufferParams.z * u_xlat0 + _ZBufferParams.w;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat1 = u_xlat0 + (-_Distance);
    u_xlat0 = max(u_xlat0, 9.99999975e-06);
    u_xlat1 = u_xlat1 * _LensCoeff;
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.5;
    u_xlat0 = u_xlat0 * _RcpMaxCoC + 0.5;
    SV_Target0 = vec4(u_xlat0);
    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	float _Distance;
uniform 	float _LensCoeff;
uniform 	float _RcpMaxCoC;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
float u_xlat1;
void main()
{
    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat0 = _ZBufferParams.z * u_xlat0 + _ZBufferParams.w;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat1 = u_xlat0 + (-_Distance);
    u_xlat0 = max(u_xlat0, 9.99999975e-06);
    u_xlat1 = u_xlat1 * _LensCoeff;
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.5;
    u_xlat0 = u_xlat0 * _RcpMaxCoC + 0.5;
    SV_Target0 = vec4(u_xlat0);
#ifdef UNITY_ADRENO_ES3
    SV_Target0 = min(max(SV_Target0, 0.0), 1.0);
#else
    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
#endif
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
uniform 	vec4 _ZBufferParams;
uniform 	float _Distance;
uniform 	float _LensCoeff;
uniform 	float _RcpMaxCoC;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
float u_xlat1;
void main()
{
    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat0 = _ZBufferParams.z * u_xlat0 + _ZBufferParams.w;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat1 = u_xlat0 + (-_Distance);
    u_xlat0 = max(u_xlat0, 9.99999975e-06);
    u_xlat1 = u_xlat1 * _LensCoeff;
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.5;
    u_xlat0 = u_xlat0 * _RcpMaxCoC + 0.5;
    SV_Target0 = vec4(u_xlat0);
#ifdef UNITY_ADRENO_ES3
    SV_Target0 = min(max(SV_Target0, 0.0), 1.0);
#else
    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
#endif
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
uniform 	vec4 _ZBufferParams;
uniform 	float _Distance;
uniform 	float _LensCoeff;
uniform 	float _RcpMaxCoC;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
float u_xlat1;
void main()
{
    u_xlat0 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat0 = _ZBufferParams.z * u_xlat0 + _ZBufferParams.w;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat1 = u_xlat0 + (-_Distance);
    u_xlat0 = max(u_xlat0, 9.99999975e-06);
    u_xlat1 = u_xlat1 * _LensCoeff;
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.5;
    u_xlat0 = u_xlat0 * _RcpMaxCoC + 0.5;
    SV_Target0 = vec4(u_xlat0);
#ifdef UNITY_ADRENO_ES3
    SV_Target0 = min(max(SV_Target0, 0.0), 1.0);
#else
    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
#endif
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
 Pass {
  Name "CoC Temporal Filter"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 742507
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec3 _TaaParams;
uniform lowp sampler2D _CoCTex;
uniform lowp sampler2D _CameraMotionVectorsTexture;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec3 u_xlat5;
bool u_xlatb5;
bool u_xlatb6;
float u_xlat8;
bool u_xlatb9;
vec2 u_xlat11;
float u_xlat12;
void main()
{
    u_xlat0.xy = _MainTex_TexelSize.yy * vec2(-0.0, -1.0);
    u_xlat1 = (-_MainTex_TexelSize.xyyy) * vec4(1.0, 0.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat12 = texture2D(_CoCTex, u_xlat1.xy).x;
    u_xlat0.z = texture2D(_CoCTex, u_xlat1.zw).x;
    u_xlat1.xy = vs_TEXCOORD0.xy + (-_TaaParams.xxyz.yz);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat1.x = texture2D(_CoCTex, u_xlat1.xy).x;
    u_xlatb5 = u_xlat12<u_xlat1.x;
    u_xlat2.z = (u_xlatb5) ? u_xlat12 : u_xlat1.x;
    u_xlat12 = max(u_xlat12, u_xlat1.x);
    u_xlat12 = max(u_xlat0.z, u_xlat12);
    u_xlatb9 = u_xlat0.z<u_xlat2.z;
    u_xlat3.xy = _MainTex_TexelSize.xy * vec2(1.0, 0.0);
    u_xlat11.xy = (-u_xlat3.xy);
    u_xlat2.xy = mix(vec2(0.0, 0.0), u_xlat11.xy, vec2(bvec2(u_xlatb5)));
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat2 = _MainTex_TexelSize.yyxy * vec4(0.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat5.z = texture2D(_CoCTex, u_xlat2.xy).x;
    u_xlat2.x = texture2D(_CoCTex, u_xlat2.zw).x;
    u_xlatb6 = u_xlat5.z<u_xlat0.z;
    u_xlat5.xy = _MainTex_TexelSize.yy * vec2(0.0, 1.0);
    u_xlat12 = max(u_xlat12, u_xlat5.z);
    u_xlat12 = max(u_xlat2.x, u_xlat12);
    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat5.xyz : u_xlat0.xyz;
    u_xlatb5 = u_xlat2.x<u_xlat0.z;
    u_xlat8 = min(u_xlat2.x, u_xlat0.z);
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat3.xy : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat10_0.xy = texture2D(_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat0.xy = (-u_xlat10_0.xy) + vs_TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.xy).x;
    u_xlat0.x = max(u_xlat8, u_xlat10_0.x);
    u_xlat0.x = min(u_xlat12, u_xlat0.x);
    u_xlat0.x = (-u_xlat1.x) + u_xlat0.x;
    SV_Target0 = vec4(_TaaParams.z, _TaaParams.z, _TaaParams.z, _TaaParams.z) * u_xlat0.xxxx + u_xlat1.xxxx;
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec3 _TaaParams;
uniform lowp sampler2D _CoCTex;
uniform lowp sampler2D _CameraMotionVectorsTexture;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec3 u_xlat5;
bool u_xlatb5;
bool u_xlatb6;
float u_xlat8;
bool u_xlatb9;
vec2 u_xlat11;
float u_xlat12;
void main()
{
    u_xlat0.xy = _MainTex_TexelSize.yy * vec2(-0.0, -1.0);
    u_xlat1 = (-_MainTex_TexelSize.xyyy) * vec4(1.0, 0.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat12 = texture2D(_CoCTex, u_xlat1.xy).x;
    u_xlat0.z = texture2D(_CoCTex, u_xlat1.zw).x;
    u_xlat1.xy = vs_TEXCOORD0.xy + (-_TaaParams.xxyz.yz);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat1.x = texture2D(_CoCTex, u_xlat1.xy).x;
    u_xlatb5 = u_xlat12<u_xlat1.x;
    u_xlat2.z = (u_xlatb5) ? u_xlat12 : u_xlat1.x;
    u_xlat12 = max(u_xlat12, u_xlat1.x);
    u_xlat12 = max(u_xlat0.z, u_xlat12);
    u_xlatb9 = u_xlat0.z<u_xlat2.z;
    u_xlat3.xy = _MainTex_TexelSize.xy * vec2(1.0, 0.0);
    u_xlat11.xy = (-u_xlat3.xy);
    u_xlat2.xy = mix(vec2(0.0, 0.0), u_xlat11.xy, vec2(bvec2(u_xlatb5)));
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat2 = _MainTex_TexelSize.yyxy * vec4(0.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat5.z = texture2D(_CoCTex, u_xlat2.xy).x;
    u_xlat2.x = texture2D(_CoCTex, u_xlat2.zw).x;
    u_xlatb6 = u_xlat5.z<u_xlat0.z;
    u_xlat5.xy = _MainTex_TexelSize.yy * vec2(0.0, 1.0);
    u_xlat12 = max(u_xlat12, u_xlat5.z);
    u_xlat12 = max(u_xlat2.x, u_xlat12);
    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat5.xyz : u_xlat0.xyz;
    u_xlatb5 = u_xlat2.x<u_xlat0.z;
    u_xlat8 = min(u_xlat2.x, u_xlat0.z);
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat3.xy : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat10_0.xy = texture2D(_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat0.xy = (-u_xlat10_0.xy) + vs_TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.xy).x;
    u_xlat0.x = max(u_xlat8, u_xlat10_0.x);
    u_xlat0.x = min(u_xlat12, u_xlat0.x);
    u_xlat0.x = (-u_xlat1.x) + u_xlat0.x;
    SV_Target0 = vec4(_TaaParams.z, _TaaParams.z, _TaaParams.z, _TaaParams.z) * u_xlat0.xxxx + u_xlat1.xxxx;
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec3 _TaaParams;
uniform lowp sampler2D _CoCTex;
uniform lowp sampler2D _CameraMotionVectorsTexture;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec3 u_xlat5;
bool u_xlatb5;
bool u_xlatb6;
float u_xlat8;
bool u_xlatb9;
vec2 u_xlat11;
float u_xlat12;
void main()
{
    u_xlat0.xy = _MainTex_TexelSize.yy * vec2(-0.0, -1.0);
    u_xlat1 = (-_MainTex_TexelSize.xyyy) * vec4(1.0, 0.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat12 = texture2D(_CoCTex, u_xlat1.xy).x;
    u_xlat0.z = texture2D(_CoCTex, u_xlat1.zw).x;
    u_xlat1.xy = vs_TEXCOORD0.xy + (-_TaaParams.xxyz.yz);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat1.x = texture2D(_CoCTex, u_xlat1.xy).x;
    u_xlatb5 = u_xlat12<u_xlat1.x;
    u_xlat2.z = (u_xlatb5) ? u_xlat12 : u_xlat1.x;
    u_xlat12 = max(u_xlat12, u_xlat1.x);
    u_xlat12 = max(u_xlat0.z, u_xlat12);
    u_xlatb9 = u_xlat0.z<u_xlat2.z;
    u_xlat3.xy = _MainTex_TexelSize.xy * vec2(1.0, 0.0);
    u_xlat11.xy = (-u_xlat3.xy);
    u_xlat2.xy = mix(vec2(0.0, 0.0), u_xlat11.xy, vec2(bvec2(u_xlatb5)));
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat2 = _MainTex_TexelSize.yyxy * vec4(0.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat5.z = texture2D(_CoCTex, u_xlat2.xy).x;
    u_xlat2.x = texture2D(_CoCTex, u_xlat2.zw).x;
    u_xlatb6 = u_xlat5.z<u_xlat0.z;
    u_xlat5.xy = _MainTex_TexelSize.yy * vec2(0.0, 1.0);
    u_xlat12 = max(u_xlat12, u_xlat5.z);
    u_xlat12 = max(u_xlat2.x, u_xlat12);
    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat5.xyz : u_xlat0.xyz;
    u_xlatb5 = u_xlat2.x<u_xlat0.z;
    u_xlat8 = min(u_xlat2.x, u_xlat0.z);
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat3.xy : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat10_0.xy = texture2D(_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat0.xy = (-u_xlat10_0.xy) + vs_TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.xy).x;
    u_xlat0.x = max(u_xlat8, u_xlat10_0.x);
    u_xlat0.x = min(u_xlat12, u_xlat0.x);
    u_xlat0.x = (-u_xlat1.x) + u_xlat0.x;
    SV_Target0 = vec4(_TaaParams.z, _TaaParams.z, _TaaParams.z, _TaaParams.z) * u_xlat0.xxxx + u_xlat1.xxxx;
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec3 _TaaParams;
uniform mediump sampler2D _CoCTex;
uniform mediump sampler2D _CameraMotionVectorsTexture;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec3 u_xlat5;
bool u_xlatb5;
bool u_xlatb6;
float u_xlat8;
bool u_xlatb9;
vec2 u_xlat11;
float u_xlat12;
void main()
{
    u_xlat0.xy = _MainTex_TexelSize.yy * vec2(-0.0, -1.0);
    u_xlat1 = (-_MainTex_TexelSize.xyyy) * vec4(1.0, 0.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat12 = texture(_CoCTex, u_xlat1.xy).x;
    u_xlat0.z = texture(_CoCTex, u_xlat1.zw).x;
    u_xlat1.xy = vs_TEXCOORD0.xy + (-_TaaParams.xxyz.yz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat1.x = texture(_CoCTex, u_xlat1.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat12<u_xlat1.x);
#else
    u_xlatb5 = u_xlat12<u_xlat1.x;
#endif
    u_xlat2.z = (u_xlatb5) ? u_xlat12 : u_xlat1.x;
    u_xlat12 = max(u_xlat12, u_xlat1.x);
    u_xlat12 = max(u_xlat0.z, u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat0.z<u_xlat2.z);
#else
    u_xlatb9 = u_xlat0.z<u_xlat2.z;
#endif
    u_xlat3.xy = _MainTex_TexelSize.xy * vec2(1.0, 0.0);
    u_xlat11.xy = (-u_xlat3.xy);
    u_xlat2.xy = mix(vec2(0.0, 0.0), u_xlat11.xy, vec2(bvec2(u_xlatb5)));
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat2 = _MainTex_TexelSize.yyxy * vec4(0.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat5.z = texture(_CoCTex, u_xlat2.xy).x;
    u_xlat2.x = texture(_CoCTex, u_xlat2.zw).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat5.z<u_xlat0.z);
#else
    u_xlatb6 = u_xlat5.z<u_xlat0.z;
#endif
    u_xlat5.xy = _MainTex_TexelSize.yy * vec2(0.0, 1.0);
    u_xlat12 = max(u_xlat12, u_xlat5.z);
    u_xlat12 = max(u_xlat2.x, u_xlat12);
    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat5.xyz : u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat2.x<u_xlat0.z);
#else
    u_xlatb5 = u_xlat2.x<u_xlat0.z;
#endif
    u_xlat8 = min(u_xlat2.x, u_xlat0.z);
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat3.xy : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0.xy = texture(_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat0.xy = (-u_xlat16_0.xy) + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0.x = texture(_MainTex, u_xlat0.xy).x;
    u_xlat0.x = max(u_xlat8, u_xlat16_0.x);
    u_xlat0.x = min(u_xlat12, u_xlat0.x);
    u_xlat0.x = (-u_xlat1.x) + u_xlat0.x;
    SV_Target0 = vec4(_TaaParams.z, _TaaParams.z, _TaaParams.z, _TaaParams.z) * u_xlat0.xxxx + u_xlat1.xxxx;
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec3 _TaaParams;
uniform mediump sampler2D _CoCTex;
uniform mediump sampler2D _CameraMotionVectorsTexture;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec3 u_xlat5;
bool u_xlatb5;
bool u_xlatb6;
float u_xlat8;
bool u_xlatb9;
vec2 u_xlat11;
float u_xlat12;
void main()
{
    u_xlat0.xy = _MainTex_TexelSize.yy * vec2(-0.0, -1.0);
    u_xlat1 = (-_MainTex_TexelSize.xyyy) * vec4(1.0, 0.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat12 = texture(_CoCTex, u_xlat1.xy).x;
    u_xlat0.z = texture(_CoCTex, u_xlat1.zw).x;
    u_xlat1.xy = vs_TEXCOORD0.xy + (-_TaaParams.xxyz.yz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat1.x = texture(_CoCTex, u_xlat1.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat12<u_xlat1.x);
#else
    u_xlatb5 = u_xlat12<u_xlat1.x;
#endif
    u_xlat2.z = (u_xlatb5) ? u_xlat12 : u_xlat1.x;
    u_xlat12 = max(u_xlat12, u_xlat1.x);
    u_xlat12 = max(u_xlat0.z, u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat0.z<u_xlat2.z);
#else
    u_xlatb9 = u_xlat0.z<u_xlat2.z;
#endif
    u_xlat3.xy = _MainTex_TexelSize.xy * vec2(1.0, 0.0);
    u_xlat11.xy = (-u_xlat3.xy);
    u_xlat2.xy = mix(vec2(0.0, 0.0), u_xlat11.xy, vec2(bvec2(u_xlatb5)));
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat2 = _MainTex_TexelSize.yyxy * vec4(0.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat5.z = texture(_CoCTex, u_xlat2.xy).x;
    u_xlat2.x = texture(_CoCTex, u_xlat2.zw).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat5.z<u_xlat0.z);
#else
    u_xlatb6 = u_xlat5.z<u_xlat0.z;
#endif
    u_xlat5.xy = _MainTex_TexelSize.yy * vec2(0.0, 1.0);
    u_xlat12 = max(u_xlat12, u_xlat5.z);
    u_xlat12 = max(u_xlat2.x, u_xlat12);
    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat5.xyz : u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat2.x<u_xlat0.z);
#else
    u_xlatb5 = u_xlat2.x<u_xlat0.z;
#endif
    u_xlat8 = min(u_xlat2.x, u_xlat0.z);
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat3.xy : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0.xy = texture(_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat0.xy = (-u_xlat16_0.xy) + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0.x = texture(_MainTex, u_xlat0.xy).x;
    u_xlat0.x = max(u_xlat8, u_xlat16_0.x);
    u_xlat0.x = min(u_xlat12, u_xlat0.x);
    u_xlat0.x = (-u_xlat1.x) + u_xlat0.x;
    SV_Target0 = vec4(_TaaParams.z, _TaaParams.z, _TaaParams.z, _TaaParams.z) * u_xlat0.xxxx + u_xlat1.xxxx;
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec3 _TaaParams;
uniform mediump sampler2D _CoCTex;
uniform mediump sampler2D _CameraMotionVectorsTexture;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec3 u_xlat5;
bool u_xlatb5;
bool u_xlatb6;
float u_xlat8;
bool u_xlatb9;
vec2 u_xlat11;
float u_xlat12;
void main()
{
    u_xlat0.xy = _MainTex_TexelSize.yy * vec2(-0.0, -1.0);
    u_xlat1 = (-_MainTex_TexelSize.xyyy) * vec4(1.0, 0.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat12 = texture(_CoCTex, u_xlat1.xy).x;
    u_xlat0.z = texture(_CoCTex, u_xlat1.zw).x;
    u_xlat1.xy = vs_TEXCOORD0.xy + (-_TaaParams.xxyz.yz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat1.x = texture(_CoCTex, u_xlat1.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat12<u_xlat1.x);
#else
    u_xlatb5 = u_xlat12<u_xlat1.x;
#endif
    u_xlat2.z = (u_xlatb5) ? u_xlat12 : u_xlat1.x;
    u_xlat12 = max(u_xlat12, u_xlat1.x);
    u_xlat12 = max(u_xlat0.z, u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat0.z<u_xlat2.z);
#else
    u_xlatb9 = u_xlat0.z<u_xlat2.z;
#endif
    u_xlat3.xy = _MainTex_TexelSize.xy * vec2(1.0, 0.0);
    u_xlat11.xy = (-u_xlat3.xy);
    u_xlat2.xy = mix(vec2(0.0, 0.0), u_xlat11.xy, vec2(bvec2(u_xlatb5)));
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat2 = _MainTex_TexelSize.yyxy * vec4(0.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat5.z = texture(_CoCTex, u_xlat2.xy).x;
    u_xlat2.x = texture(_CoCTex, u_xlat2.zw).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat5.z<u_xlat0.z);
#else
    u_xlatb6 = u_xlat5.z<u_xlat0.z;
#endif
    u_xlat5.xy = _MainTex_TexelSize.yy * vec2(0.0, 1.0);
    u_xlat12 = max(u_xlat12, u_xlat5.z);
    u_xlat12 = max(u_xlat2.x, u_xlat12);
    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat5.xyz : u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat2.x<u_xlat0.z);
#else
    u_xlatb5 = u_xlat2.x<u_xlat0.z;
#endif
    u_xlat8 = min(u_xlat2.x, u_xlat0.z);
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat3.xy : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0.xy = texture(_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat0.xy = (-u_xlat16_0.xy) + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0.x = texture(_MainTex, u_xlat0.xy).x;
    u_xlat0.x = max(u_xlat8, u_xlat16_0.x);
    u_xlat0.x = min(u_xlat12, u_xlat0.x);
    u_xlat0.x = (-u_xlat1.x) + u_xlat0.x;
    SV_Target0 = vec4(_TaaParams.z, _TaaParams.z, _TaaParams.z, _TaaParams.z) * u_xlat0.xxxx + u_xlat1.xxxx;
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
 Pass {
  Name "Downsample and Prefilter"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 830832
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CoCTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec3 u_xlat10_3;
float u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
void main()
{
    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat10_1.xyz = texture2D(_MainTex, u_xlat0.zw).xyz;
    u_xlat16_13 = max(u_xlat10_1.y, u_xlat10_1.x);
    u_xlat16_13 = max(u_xlat10_1.z, u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 + 1.0;
    u_xlat10_8 = texture2D(_CoCTex, u_xlat0.zw).x;
    u_xlat16_8 = u_xlat10_8 * 2.0 + -1.0;
    u_xlat16_12 = abs(u_xlat16_8) / u_xlat16_13;
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat10_1.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat10_0 = texture2D(_CoCTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * 2.0 + -1.0;
    u_xlat16_4 = max(u_xlat10_2.y, u_xlat10_2.x);
    u_xlat16_4 = max(u_xlat10_2.z, u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_4 = abs(u_xlat16_0) / u_xlat16_4;
    u_xlat16_1.xyz = u_xlat10_2.xyz * vec3(u_xlat16_4) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat10_3.xyz = texture2D(_MainTex, u_xlat2.xy).xyz;
    u_xlat16_12 = max(u_xlat10_3.y, u_xlat10_3.x);
    u_xlat16_12 = max(u_xlat10_3.z, u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 + 1.0;
    u_xlat10_13 = texture2D(_CoCTex, u_xlat2.xy).x;
    u_xlat16_13 = u_xlat10_13 * 2.0 + -1.0;
    u_xlat16_12 = abs(u_xlat16_13) / u_xlat16_12;
    u_xlat16_1.xyz = u_xlat10_3.xyz * vec3(u_xlat16_12) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat10_3.xyz = texture2D(_MainTex, u_xlat2.zw).xyz;
    u_xlat10_12 = texture2D(_CoCTex, u_xlat2.zw).x;
    u_xlat16_12 = u_xlat10_12 * 2.0 + -1.0;
    u_xlat16_2 = max(u_xlat10_3.y, u_xlat10_3.x);
    u_xlat16_2 = max(u_xlat10_3.z, u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 + 1.0;
    u_xlat16_2 = abs(u_xlat16_12) / u_xlat16_2;
    u_xlat16_1.xyz = u_xlat10_3.xyz * vec3(u_xlat16_2) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_4 + u_xlat16_2;
    u_xlat16_4 = max(u_xlat16_4, 9.99999975e-06);
    u_xlat16_1.xyz = u_xlat16_1.xyz / vec3(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_12, u_xlat16_8);
    u_xlat16_4 = min(u_xlat16_12, u_xlat16_4);
    u_xlat4 = min(u_xlat16_4, u_xlat16_0);
    u_xlat0.x = max(u_xlat16_8, u_xlat16_0);
    u_xlatb8 = u_xlat0.x<(-u_xlat4);
    u_xlat0.x = (u_xlatb8) ? u_xlat4 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaxCoC;
    u_xlat4 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat4 = u_xlat4 * abs(u_xlat0.x);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    SV_Target0.w = u_xlat0.x;
    u_xlat0.x = u_xlat4 * -2.0 + 3.0;
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat0.xyz;
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CoCTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec3 u_xlat10_3;
float u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
void main()
{
    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat10_1.xyz = texture2D(_MainTex, u_xlat0.zw).xyz;
    u_xlat16_13 = max(u_xlat10_1.y, u_xlat10_1.x);
    u_xlat16_13 = max(u_xlat10_1.z, u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 + 1.0;
    u_xlat10_8 = texture2D(_CoCTex, u_xlat0.zw).x;
    u_xlat16_8 = u_xlat10_8 * 2.0 + -1.0;
    u_xlat16_12 = abs(u_xlat16_8) / u_xlat16_13;
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat10_1.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat10_0 = texture2D(_CoCTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * 2.0 + -1.0;
    u_xlat16_4 = max(u_xlat10_2.y, u_xlat10_2.x);
    u_xlat16_4 = max(u_xlat10_2.z, u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_4 = abs(u_xlat16_0) / u_xlat16_4;
    u_xlat16_1.xyz = u_xlat10_2.xyz * vec3(u_xlat16_4) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat10_3.xyz = texture2D(_MainTex, u_xlat2.xy).xyz;
    u_xlat16_12 = max(u_xlat10_3.y, u_xlat10_3.x);
    u_xlat16_12 = max(u_xlat10_3.z, u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 + 1.0;
    u_xlat10_13 = texture2D(_CoCTex, u_xlat2.xy).x;
    u_xlat16_13 = u_xlat10_13 * 2.0 + -1.0;
    u_xlat16_12 = abs(u_xlat16_13) / u_xlat16_12;
    u_xlat16_1.xyz = u_xlat10_3.xyz * vec3(u_xlat16_12) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat10_3.xyz = texture2D(_MainTex, u_xlat2.zw).xyz;
    u_xlat10_12 = texture2D(_CoCTex, u_xlat2.zw).x;
    u_xlat16_12 = u_xlat10_12 * 2.0 + -1.0;
    u_xlat16_2 = max(u_xlat10_3.y, u_xlat10_3.x);
    u_xlat16_2 = max(u_xlat10_3.z, u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 + 1.0;
    u_xlat16_2 = abs(u_xlat16_12) / u_xlat16_2;
    u_xlat16_1.xyz = u_xlat10_3.xyz * vec3(u_xlat16_2) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_4 + u_xlat16_2;
    u_xlat16_4 = max(u_xlat16_4, 9.99999975e-06);
    u_xlat16_1.xyz = u_xlat16_1.xyz / vec3(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_12, u_xlat16_8);
    u_xlat16_4 = min(u_xlat16_12, u_xlat16_4);
    u_xlat4 = min(u_xlat16_4, u_xlat16_0);
    u_xlat0.x = max(u_xlat16_8, u_xlat16_0);
    u_xlatb8 = u_xlat0.x<(-u_xlat4);
    u_xlat0.x = (u_xlatb8) ? u_xlat4 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaxCoC;
    u_xlat4 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat4 = u_xlat4 * abs(u_xlat0.x);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    SV_Target0.w = u_xlat0.x;
    u_xlat0.x = u_xlat4 * -2.0 + 3.0;
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat0.xyz;
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CoCTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec3 u_xlat10_3;
float u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
void main()
{
    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat10_1.xyz = texture2D(_MainTex, u_xlat0.zw).xyz;
    u_xlat16_13 = max(u_xlat10_1.y, u_xlat10_1.x);
    u_xlat16_13 = max(u_xlat10_1.z, u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 + 1.0;
    u_xlat10_8 = texture2D(_CoCTex, u_xlat0.zw).x;
    u_xlat16_8 = u_xlat10_8 * 2.0 + -1.0;
    u_xlat16_12 = abs(u_xlat16_8) / u_xlat16_13;
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat10_1.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat10_0 = texture2D(_CoCTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * 2.0 + -1.0;
    u_xlat16_4 = max(u_xlat10_2.y, u_xlat10_2.x);
    u_xlat16_4 = max(u_xlat10_2.z, u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_4 = abs(u_xlat16_0) / u_xlat16_4;
    u_xlat16_1.xyz = u_xlat10_2.xyz * vec3(u_xlat16_4) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat10_3.xyz = texture2D(_MainTex, u_xlat2.xy).xyz;
    u_xlat16_12 = max(u_xlat10_3.y, u_xlat10_3.x);
    u_xlat16_12 = max(u_xlat10_3.z, u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 + 1.0;
    u_xlat10_13 = texture2D(_CoCTex, u_xlat2.xy).x;
    u_xlat16_13 = u_xlat10_13 * 2.0 + -1.0;
    u_xlat16_12 = abs(u_xlat16_13) / u_xlat16_12;
    u_xlat16_1.xyz = u_xlat10_3.xyz * vec3(u_xlat16_12) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat10_3.xyz = texture2D(_MainTex, u_xlat2.zw).xyz;
    u_xlat10_12 = texture2D(_CoCTex, u_xlat2.zw).x;
    u_xlat16_12 = u_xlat10_12 * 2.0 + -1.0;
    u_xlat16_2 = max(u_xlat10_3.y, u_xlat10_3.x);
    u_xlat16_2 = max(u_xlat10_3.z, u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 + 1.0;
    u_xlat16_2 = abs(u_xlat16_12) / u_xlat16_2;
    u_xlat16_1.xyz = u_xlat10_3.xyz * vec3(u_xlat16_2) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_4 + u_xlat16_2;
    u_xlat16_4 = max(u_xlat16_4, 9.99999975e-06);
    u_xlat16_1.xyz = u_xlat16_1.xyz / vec3(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_12, u_xlat16_8);
    u_xlat16_4 = min(u_xlat16_12, u_xlat16_4);
    u_xlat4 = min(u_xlat16_4, u_xlat16_0);
    u_xlat0.x = max(u_xlat16_8, u_xlat16_0);
    u_xlatb8 = u_xlat0.x<(-u_xlat4);
    u_xlat0.x = (u_xlatb8) ? u_xlat4 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaxCoC;
    u_xlat4 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat4 = u_xlat4 * abs(u_xlat0.x);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    SV_Target0.w = u_xlat0.x;
    u_xlat0.x = u_xlat4 * -2.0 + 3.0;
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat0.xyz;
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CoCTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_8;
bool u_xlatb8;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_MainTex, u_xlat0.zw).xyz;
    u_xlat16_13 = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_13 = max(u_xlat16_1.z, u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 + 1.0;
    u_xlat16_8 = texture(_CoCTex, u_xlat0.zw).x;
    u_xlat16_8 = u_xlat16_8 * 2.0 + -1.0;
    u_xlat16_12 = abs(u_xlat16_8) / u_xlat16_13;
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0 = texture(_CoCTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat16_0 * 2.0 + -1.0;
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_4 = abs(u_xlat16_0) / u_xlat16_4;
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_4) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat16_3.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat16_12 = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_12 = max(u_xlat16_3.z, u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 + 1.0;
    u_xlat16_13 = texture(_CoCTex, u_xlat2.xy).x;
    u_xlat16_13 = u_xlat16_13 * 2.0 + -1.0;
    u_xlat16_12 = abs(u_xlat16_13) / u_xlat16_12;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_12) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat16_3.xyz = texture(_MainTex, u_xlat2.zw).xyz;
    u_xlat16_12 = texture(_CoCTex, u_xlat2.zw).x;
    u_xlat16_12 = u_xlat16_12 * 2.0 + -1.0;
    u_xlat16_2.x = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_2.x = max(u_xlat16_3.z, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = abs(u_xlat16_12) / u_xlat16_2.x;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_2.xxx + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_4 + u_xlat16_2.x;
    u_xlat16_4 = max(u_xlat16_4, 9.99999975e-06);
    u_xlat16_1.xyz = u_xlat16_1.xyz / vec3(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_12, u_xlat16_8);
    u_xlat16_4 = min(u_xlat16_12, u_xlat16_4);
    u_xlat4 = min(u_xlat16_4, u_xlat16_0);
    u_xlat0.x = max(u_xlat16_8, u_xlat16_0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x<(-u_xlat4));
#else
    u_xlatb8 = u_xlat0.x<(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaxCoC;
    u_xlat4 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat4 = u_xlat4 * abs(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    u_xlat0.x = u_xlat4 * -2.0 + 3.0;
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat0.xyz;
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CoCTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_8;
bool u_xlatb8;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_MainTex, u_xlat0.zw).xyz;
    u_xlat16_13 = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_13 = max(u_xlat16_1.z, u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 + 1.0;
    u_xlat16_8 = texture(_CoCTex, u_xlat0.zw).x;
    u_xlat16_8 = u_xlat16_8 * 2.0 + -1.0;
    u_xlat16_12 = abs(u_xlat16_8) / u_xlat16_13;
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0 = texture(_CoCTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat16_0 * 2.0 + -1.0;
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_4 = abs(u_xlat16_0) / u_xlat16_4;
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_4) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat16_3.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat16_12 = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_12 = max(u_xlat16_3.z, u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 + 1.0;
    u_xlat16_13 = texture(_CoCTex, u_xlat2.xy).x;
    u_xlat16_13 = u_xlat16_13 * 2.0 + -1.0;
    u_xlat16_12 = abs(u_xlat16_13) / u_xlat16_12;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_12) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat16_3.xyz = texture(_MainTex, u_xlat2.zw).xyz;
    u_xlat16_12 = texture(_CoCTex, u_xlat2.zw).x;
    u_xlat16_12 = u_xlat16_12 * 2.0 + -1.0;
    u_xlat16_2.x = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_2.x = max(u_xlat16_3.z, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = abs(u_xlat16_12) / u_xlat16_2.x;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_2.xxx + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_4 + u_xlat16_2.x;
    u_xlat16_4 = max(u_xlat16_4, 9.99999975e-06);
    u_xlat16_1.xyz = u_xlat16_1.xyz / vec3(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_12, u_xlat16_8);
    u_xlat16_4 = min(u_xlat16_12, u_xlat16_4);
    u_xlat4 = min(u_xlat16_4, u_xlat16_0);
    u_xlat0.x = max(u_xlat16_8, u_xlat16_0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x<(-u_xlat4));
#else
    u_xlatb8 = u_xlat0.x<(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaxCoC;
    u_xlat4 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat4 = u_xlat4 * abs(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    u_xlat0.x = u_xlat4 * -2.0 + 3.0;
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat0.xyz;
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CoCTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_8;
bool u_xlatb8;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_MainTex, u_xlat0.zw).xyz;
    u_xlat16_13 = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_13 = max(u_xlat16_1.z, u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 + 1.0;
    u_xlat16_8 = texture(_CoCTex, u_xlat0.zw).x;
    u_xlat16_8 = u_xlat16_8 * 2.0 + -1.0;
    u_xlat16_12 = abs(u_xlat16_8) / u_xlat16_13;
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0 = texture(_CoCTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat16_0 * 2.0 + -1.0;
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_4 = abs(u_xlat16_0) / u_xlat16_4;
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_4) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat2 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat16_3.xyz = texture(_MainTex, u_xlat2.xy).xyz;
    u_xlat16_12 = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_12 = max(u_xlat16_3.z, u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 + 1.0;
    u_xlat16_13 = texture(_CoCTex, u_xlat2.xy).x;
    u_xlat16_13 = u_xlat16_13 * 2.0 + -1.0;
    u_xlat16_12 = abs(u_xlat16_13) / u_xlat16_12;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_12) + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat16_3.xyz = texture(_MainTex, u_xlat2.zw).xyz;
    u_xlat16_12 = texture(_CoCTex, u_xlat2.zw).x;
    u_xlat16_12 = u_xlat16_12 * 2.0 + -1.0;
    u_xlat16_2.x = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_2.x = max(u_xlat16_3.z, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = abs(u_xlat16_12) / u_xlat16_2.x;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_2.xxx + u_xlat16_1.xyz;
    u_xlat16_4 = u_xlat16_4 + u_xlat16_2.x;
    u_xlat16_4 = max(u_xlat16_4, 9.99999975e-06);
    u_xlat16_1.xyz = u_xlat16_1.xyz / vec3(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_12, u_xlat16_8);
    u_xlat16_4 = min(u_xlat16_12, u_xlat16_4);
    u_xlat4 = min(u_xlat16_4, u_xlat16_0);
    u_xlat0.x = max(u_xlat16_8, u_xlat16_0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x<(-u_xlat4));
#else
    u_xlatb8 = u_xlat0.x<(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaxCoC;
    u_xlat4 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat4 = u_xlat4 * abs(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    u_xlat0.x = u_xlat4 * -2.0 + 3.0;
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat0.xyz;
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
 Pass {
  Name "Bokeh Filter (small)"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 904069
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
vec2 ImmCB_0_0_0[16];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec2 ImmCB_0_0_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0_0_0[i];
#else
#define d_ar ImmCB_0_0_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6]; else if (i == 7) return d_ar[7]; else if (i == 8) return d_ar[8]; else if (i == 9) return d_ar[9]; else if (i == 10) return d_ar[10]; else if (i == 11) return d_ar[11]; else if (i == 12) return d_ar[12]; else if (i == 13) return d_ar[13]; else if (i == 14) return d_ar[14]; else if (i == 15) return d_ar[15];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.545454562, 0.0);
	ImmCB_0_0_0[2] = vec2(0.168554723, 0.518758118);
	ImmCB_0_0_0[3] = vec2(-0.441282034, 0.320610106);
	ImmCB_0_0_0[4] = vec2(-0.441281974, -0.320610195);
	ImmCB_0_0_0[5] = vec2(0.168554798, -0.518758118);
	ImmCB_0_0_0[6] = vec2(1.0, 0.0);
	ImmCB_0_0_0[7] = vec2(0.809017003, 0.587785244);
	ImmCB_0_0_0[8] = vec2(0.309016973, 0.95105654);
	ImmCB_0_0_0[9] = vec2(-0.309017032, 0.95105648);
	ImmCB_0_0_0[10] = vec2(-0.809017062, 0.587785184);
	ImmCB_0_0_0[11] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[12] = vec2(-0.809016943, -0.587785363);
	ImmCB_0_0_0[13] = vec2(-0.309016645, -0.9510566);
	ImmCB_0_0_0[14] = vec2(0.309017122, -0.95105648);
	ImmCB_0_0_0[15] = vec2(0.809016943, -0.587785304);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<16 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0DynamicIndex(u_xlati_loop_1).xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat10_4 = texture2D(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat10_0, u_xlat10_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
        u_xlat18 = (-u_xlat18) + (-u_xlat10_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
        u_xlatb22 = (-u_xlat10_4.w)>=_MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat10_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.196349546;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[16];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec2 ImmCB_0_0_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0_0_0[i];
#else
#define d_ar ImmCB_0_0_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6]; else if (i == 7) return d_ar[7]; else if (i == 8) return d_ar[8]; else if (i == 9) return d_ar[9]; else if (i == 10) return d_ar[10]; else if (i == 11) return d_ar[11]; else if (i == 12) return d_ar[12]; else if (i == 13) return d_ar[13]; else if (i == 14) return d_ar[14]; else if (i == 15) return d_ar[15];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.545454562, 0.0);
	ImmCB_0_0_0[2] = vec2(0.168554723, 0.518758118);
	ImmCB_0_0_0[3] = vec2(-0.441282034, 0.320610106);
	ImmCB_0_0_0[4] = vec2(-0.441281974, -0.320610195);
	ImmCB_0_0_0[5] = vec2(0.168554798, -0.518758118);
	ImmCB_0_0_0[6] = vec2(1.0, 0.0);
	ImmCB_0_0_0[7] = vec2(0.809017003, 0.587785244);
	ImmCB_0_0_0[8] = vec2(0.309016973, 0.95105654);
	ImmCB_0_0_0[9] = vec2(-0.309017032, 0.95105648);
	ImmCB_0_0_0[10] = vec2(-0.809017062, 0.587785184);
	ImmCB_0_0_0[11] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[12] = vec2(-0.809016943, -0.587785363);
	ImmCB_0_0_0[13] = vec2(-0.309016645, -0.9510566);
	ImmCB_0_0_0[14] = vec2(0.309017122, -0.95105648);
	ImmCB_0_0_0[15] = vec2(0.809016943, -0.587785304);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<16 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0DynamicIndex(u_xlati_loop_1).xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat10_4 = texture2D(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat10_0, u_xlat10_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
        u_xlat18 = (-u_xlat18) + (-u_xlat10_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
        u_xlatb22 = (-u_xlat10_4.w)>=_MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat10_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.196349546;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[16];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec2 ImmCB_0_0_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0_0_0[i];
#else
#define d_ar ImmCB_0_0_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6]; else if (i == 7) return d_ar[7]; else if (i == 8) return d_ar[8]; else if (i == 9) return d_ar[9]; else if (i == 10) return d_ar[10]; else if (i == 11) return d_ar[11]; else if (i == 12) return d_ar[12]; else if (i == 13) return d_ar[13]; else if (i == 14) return d_ar[14]; else if (i == 15) return d_ar[15];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.545454562, 0.0);
	ImmCB_0_0_0[2] = vec2(0.168554723, 0.518758118);
	ImmCB_0_0_0[3] = vec2(-0.441282034, 0.320610106);
	ImmCB_0_0_0[4] = vec2(-0.441281974, -0.320610195);
	ImmCB_0_0_0[5] = vec2(0.168554798, -0.518758118);
	ImmCB_0_0_0[6] = vec2(1.0, 0.0);
	ImmCB_0_0_0[7] = vec2(0.809017003, 0.587785244);
	ImmCB_0_0_0[8] = vec2(0.309016973, 0.95105654);
	ImmCB_0_0_0[9] = vec2(-0.309017032, 0.95105648);
	ImmCB_0_0_0[10] = vec2(-0.809017062, 0.587785184);
	ImmCB_0_0_0[11] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[12] = vec2(-0.809016943, -0.587785363);
	ImmCB_0_0_0[13] = vec2(-0.309016645, -0.9510566);
	ImmCB_0_0_0[14] = vec2(0.309017122, -0.95105648);
	ImmCB_0_0_0[15] = vec2(0.809016943, -0.587785304);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<16 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0DynamicIndex(u_xlati_loop_1).xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat10_4 = texture2D(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat10_0, u_xlat10_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
        u_xlat18 = (-u_xlat18) + (-u_xlat10_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
        u_xlatb22 = (-u_xlat10_4.w)>=_MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat10_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.196349546;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[16];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.545454562, 0.0);
	ImmCB_0_0_0[2] = vec2(0.168554723, 0.518758118);
	ImmCB_0_0_0[3] = vec2(-0.441282034, 0.320610106);
	ImmCB_0_0_0[4] = vec2(-0.441281974, -0.320610195);
	ImmCB_0_0_0[5] = vec2(0.168554798, -0.518758118);
	ImmCB_0_0_0[6] = vec2(1.0, 0.0);
	ImmCB_0_0_0[7] = vec2(0.809017003, 0.587785244);
	ImmCB_0_0_0[8] = vec2(0.309016973, 0.95105654);
	ImmCB_0_0_0[9] = vec2(-0.309017032, 0.95105648);
	ImmCB_0_0_0[10] = vec2(-0.809017062, 0.587785184);
	ImmCB_0_0_0[11] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[12] = vec2(-0.809016943, -0.587785363);
	ImmCB_0_0_0[13] = vec2(-0.309016645, -0.9510566);
	ImmCB_0_0_0[14] = vec2(0.309017122, -0.95105648);
	ImmCB_0_0_0[15] = vec2(0.809016943, -0.587785304);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<16 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.196349546;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[16];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.545454562, 0.0);
	ImmCB_0_0_0[2] = vec2(0.168554723, 0.518758118);
	ImmCB_0_0_0[3] = vec2(-0.441282034, 0.320610106);
	ImmCB_0_0_0[4] = vec2(-0.441281974, -0.320610195);
	ImmCB_0_0_0[5] = vec2(0.168554798, -0.518758118);
	ImmCB_0_0_0[6] = vec2(1.0, 0.0);
	ImmCB_0_0_0[7] = vec2(0.809017003, 0.587785244);
	ImmCB_0_0_0[8] = vec2(0.309016973, 0.95105654);
	ImmCB_0_0_0[9] = vec2(-0.309017032, 0.95105648);
	ImmCB_0_0_0[10] = vec2(-0.809017062, 0.587785184);
	ImmCB_0_0_0[11] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[12] = vec2(-0.809016943, -0.587785363);
	ImmCB_0_0_0[13] = vec2(-0.309016645, -0.9510566);
	ImmCB_0_0_0[14] = vec2(0.309017122, -0.95105648);
	ImmCB_0_0_0[15] = vec2(0.809016943, -0.587785304);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<16 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.196349546;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[16];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.545454562, 0.0);
	ImmCB_0_0_0[2] = vec2(0.168554723, 0.518758118);
	ImmCB_0_0_0[3] = vec2(-0.441282034, 0.320610106);
	ImmCB_0_0_0[4] = vec2(-0.441281974, -0.320610195);
	ImmCB_0_0_0[5] = vec2(0.168554798, -0.518758118);
	ImmCB_0_0_0[6] = vec2(1.0, 0.0);
	ImmCB_0_0_0[7] = vec2(0.809017003, 0.587785244);
	ImmCB_0_0_0[8] = vec2(0.309016973, 0.95105654);
	ImmCB_0_0_0[9] = vec2(-0.309017032, 0.95105648);
	ImmCB_0_0_0[10] = vec2(-0.809017062, 0.587785184);
	ImmCB_0_0_0[11] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[12] = vec2(-0.809016943, -0.587785363);
	ImmCB_0_0_0[13] = vec2(-0.309016645, -0.9510566);
	ImmCB_0_0_0[14] = vec2(0.309017122, -0.95105648);
	ImmCB_0_0_0[15] = vec2(0.809016943, -0.587785304);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<16 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.196349546;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
 Pass {
  Name "Bokeh Filter (medium)"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 923021
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
vec2 ImmCB_0_0_0[22];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec2 ImmCB_0_0_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0_0_0[i];
#else
#define d_ar ImmCB_0_0_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6]; else if (i == 7) return d_ar[7]; else if (i == 8) return d_ar[8]; else if (i == 9) return d_ar[9]; else if (i == 10) return d_ar[10]; else if (i == 11) return d_ar[11]; else if (i == 12) return d_ar[12]; else if (i == 13) return d_ar[13]; else if (i == 14) return d_ar[14]; else if (i == 15) return d_ar[15]; else if (i == 16) return d_ar[16]; else if (i == 17) return d_ar[17]; else if (i == 18) return d_ar[18]; else if (i == 19) return d_ar[19]; else if (i == 20) return d_ar[20]; else if (i == 21) return d_ar[21];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.533333361, 0.0);
	ImmCB_0_0_0[2] = vec2(0.332527906, 0.41697681);
	ImmCB_0_0_0[3] = vec2(-0.118677847, 0.519961596);
	ImmCB_0_0_0[4] = vec2(-0.480516732, 0.231404707);
	ImmCB_0_0_0[5] = vec2(-0.480516732, -0.231404677);
	ImmCB_0_0_0[6] = vec2(-0.118677631, -0.519961655);
	ImmCB_0_0_0[7] = vec2(0.332527846, -0.416976899);
	ImmCB_0_0_0[8] = vec2(1.0, 0.0);
	ImmCB_0_0_0[9] = vec2(0.90096885, 0.433883756);
	ImmCB_0_0_0[10] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[11] = vec2(0.222520977, 0.974927902);
	ImmCB_0_0_0[12] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[13] = vec2(-0.623489976, 0.781831384);
	ImmCB_0_0_0[14] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[15] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[17] = vec2(-0.623489618, -0.781831622);
	ImmCB_0_0_0[18] = vec2(-0.222520545, -0.974928021);
	ImmCB_0_0_0[19] = vec2(0.222521499, -0.974927783);
	ImmCB_0_0_0[20] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[21] = vec2(0.90096885, -0.433883756);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<22 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0DynamicIndex(u_xlati_loop_1).xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat10_4 = texture2D(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat10_0, u_xlat10_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
        u_xlat18 = (-u_xlat18) + (-u_xlat10_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
        u_xlatb22 = (-u_xlat10_4.w)>=_MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat10_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.142799661;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[22];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec2 ImmCB_0_0_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0_0_0[i];
#else
#define d_ar ImmCB_0_0_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6]; else if (i == 7) return d_ar[7]; else if (i == 8) return d_ar[8]; else if (i == 9) return d_ar[9]; else if (i == 10) return d_ar[10]; else if (i == 11) return d_ar[11]; else if (i == 12) return d_ar[12]; else if (i == 13) return d_ar[13]; else if (i == 14) return d_ar[14]; else if (i == 15) return d_ar[15]; else if (i == 16) return d_ar[16]; else if (i == 17) return d_ar[17]; else if (i == 18) return d_ar[18]; else if (i == 19) return d_ar[19]; else if (i == 20) return d_ar[20]; else if (i == 21) return d_ar[21];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.533333361, 0.0);
	ImmCB_0_0_0[2] = vec2(0.332527906, 0.41697681);
	ImmCB_0_0_0[3] = vec2(-0.118677847, 0.519961596);
	ImmCB_0_0_0[4] = vec2(-0.480516732, 0.231404707);
	ImmCB_0_0_0[5] = vec2(-0.480516732, -0.231404677);
	ImmCB_0_0_0[6] = vec2(-0.118677631, -0.519961655);
	ImmCB_0_0_0[7] = vec2(0.332527846, -0.416976899);
	ImmCB_0_0_0[8] = vec2(1.0, 0.0);
	ImmCB_0_0_0[9] = vec2(0.90096885, 0.433883756);
	ImmCB_0_0_0[10] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[11] = vec2(0.222520977, 0.974927902);
	ImmCB_0_0_0[12] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[13] = vec2(-0.623489976, 0.781831384);
	ImmCB_0_0_0[14] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[15] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[17] = vec2(-0.623489618, -0.781831622);
	ImmCB_0_0_0[18] = vec2(-0.222520545, -0.974928021);
	ImmCB_0_0_0[19] = vec2(0.222521499, -0.974927783);
	ImmCB_0_0_0[20] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[21] = vec2(0.90096885, -0.433883756);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<22 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0DynamicIndex(u_xlati_loop_1).xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat10_4 = texture2D(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat10_0, u_xlat10_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
        u_xlat18 = (-u_xlat18) + (-u_xlat10_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
        u_xlatb22 = (-u_xlat10_4.w)>=_MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat10_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.142799661;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[22];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec2 ImmCB_0_0_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0_0_0[i];
#else
#define d_ar ImmCB_0_0_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6]; else if (i == 7) return d_ar[7]; else if (i == 8) return d_ar[8]; else if (i == 9) return d_ar[9]; else if (i == 10) return d_ar[10]; else if (i == 11) return d_ar[11]; else if (i == 12) return d_ar[12]; else if (i == 13) return d_ar[13]; else if (i == 14) return d_ar[14]; else if (i == 15) return d_ar[15]; else if (i == 16) return d_ar[16]; else if (i == 17) return d_ar[17]; else if (i == 18) return d_ar[18]; else if (i == 19) return d_ar[19]; else if (i == 20) return d_ar[20]; else if (i == 21) return d_ar[21];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.533333361, 0.0);
	ImmCB_0_0_0[2] = vec2(0.332527906, 0.41697681);
	ImmCB_0_0_0[3] = vec2(-0.118677847, 0.519961596);
	ImmCB_0_0_0[4] = vec2(-0.480516732, 0.231404707);
	ImmCB_0_0_0[5] = vec2(-0.480516732, -0.231404677);
	ImmCB_0_0_0[6] = vec2(-0.118677631, -0.519961655);
	ImmCB_0_0_0[7] = vec2(0.332527846, -0.416976899);
	ImmCB_0_0_0[8] = vec2(1.0, 0.0);
	ImmCB_0_0_0[9] = vec2(0.90096885, 0.433883756);
	ImmCB_0_0_0[10] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[11] = vec2(0.222520977, 0.974927902);
	ImmCB_0_0_0[12] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[13] = vec2(-0.623489976, 0.781831384);
	ImmCB_0_0_0[14] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[15] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[17] = vec2(-0.623489618, -0.781831622);
	ImmCB_0_0_0[18] = vec2(-0.222520545, -0.974928021);
	ImmCB_0_0_0[19] = vec2(0.222521499, -0.974927783);
	ImmCB_0_0_0[20] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[21] = vec2(0.90096885, -0.433883756);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<22 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0DynamicIndex(u_xlati_loop_1).xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat10_4 = texture2D(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat10_0, u_xlat10_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
        u_xlat18 = (-u_xlat18) + (-u_xlat10_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
        u_xlatb22 = (-u_xlat10_4.w)>=_MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat10_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.142799661;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[22];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.533333361, 0.0);
	ImmCB_0_0_0[2] = vec2(0.332527906, 0.41697681);
	ImmCB_0_0_0[3] = vec2(-0.118677847, 0.519961596);
	ImmCB_0_0_0[4] = vec2(-0.480516732, 0.231404707);
	ImmCB_0_0_0[5] = vec2(-0.480516732, -0.231404677);
	ImmCB_0_0_0[6] = vec2(-0.118677631, -0.519961655);
	ImmCB_0_0_0[7] = vec2(0.332527846, -0.416976899);
	ImmCB_0_0_0[8] = vec2(1.0, 0.0);
	ImmCB_0_0_0[9] = vec2(0.90096885, 0.433883756);
	ImmCB_0_0_0[10] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[11] = vec2(0.222520977, 0.974927902);
	ImmCB_0_0_0[12] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[13] = vec2(-0.623489976, 0.781831384);
	ImmCB_0_0_0[14] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[15] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[17] = vec2(-0.623489618, -0.781831622);
	ImmCB_0_0_0[18] = vec2(-0.222520545, -0.974928021);
	ImmCB_0_0_0[19] = vec2(0.222521499, -0.974927783);
	ImmCB_0_0_0[20] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[21] = vec2(0.90096885, -0.433883756);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<22 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.142799661;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[22];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.533333361, 0.0);
	ImmCB_0_0_0[2] = vec2(0.332527906, 0.41697681);
	ImmCB_0_0_0[3] = vec2(-0.118677847, 0.519961596);
	ImmCB_0_0_0[4] = vec2(-0.480516732, 0.231404707);
	ImmCB_0_0_0[5] = vec2(-0.480516732, -0.231404677);
	ImmCB_0_0_0[6] = vec2(-0.118677631, -0.519961655);
	ImmCB_0_0_0[7] = vec2(0.332527846, -0.416976899);
	ImmCB_0_0_0[8] = vec2(1.0, 0.0);
	ImmCB_0_0_0[9] = vec2(0.90096885, 0.433883756);
	ImmCB_0_0_0[10] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[11] = vec2(0.222520977, 0.974927902);
	ImmCB_0_0_0[12] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[13] = vec2(-0.623489976, 0.781831384);
	ImmCB_0_0_0[14] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[15] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[17] = vec2(-0.623489618, -0.781831622);
	ImmCB_0_0_0[18] = vec2(-0.222520545, -0.974928021);
	ImmCB_0_0_0[19] = vec2(0.222521499, -0.974927783);
	ImmCB_0_0_0[20] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[21] = vec2(0.90096885, -0.433883756);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<22 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.142799661;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[22];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.533333361, 0.0);
	ImmCB_0_0_0[2] = vec2(0.332527906, 0.41697681);
	ImmCB_0_0_0[3] = vec2(-0.118677847, 0.519961596);
	ImmCB_0_0_0[4] = vec2(-0.480516732, 0.231404707);
	ImmCB_0_0_0[5] = vec2(-0.480516732, -0.231404677);
	ImmCB_0_0_0[6] = vec2(-0.118677631, -0.519961655);
	ImmCB_0_0_0[7] = vec2(0.332527846, -0.416976899);
	ImmCB_0_0_0[8] = vec2(1.0, 0.0);
	ImmCB_0_0_0[9] = vec2(0.90096885, 0.433883756);
	ImmCB_0_0_0[10] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[11] = vec2(0.222520977, 0.974927902);
	ImmCB_0_0_0[12] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[13] = vec2(-0.623489976, 0.781831384);
	ImmCB_0_0_0[14] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[15] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[17] = vec2(-0.623489618, -0.781831622);
	ImmCB_0_0_0[18] = vec2(-0.222520545, -0.974928021);
	ImmCB_0_0_0[19] = vec2(0.222521499, -0.974927783);
	ImmCB_0_0_0[20] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[21] = vec2(0.90096885, -0.433883756);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<22 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.142799661;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
 Pass {
  Name "Bokeh Filter (large)"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 992690
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
vec2 ImmCB_0_0_0[43];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec2 ImmCB_0_0_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0_0_0[i];
#else
#define d_ar ImmCB_0_0_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6]; else if (i == 7) return d_ar[7]; else if (i == 8) return d_ar[8]; else if (i == 9) return d_ar[9]; else if (i == 10) return d_ar[10]; else if (i == 11) return d_ar[11]; else if (i == 12) return d_ar[12]; else if (i == 13) return d_ar[13]; else if (i == 14) return d_ar[14]; else if (i == 15) return d_ar[15]; else if (i == 16) return d_ar[16]; else if (i == 17) return d_ar[17]; else if (i == 18) return d_ar[18]; else if (i == 19) return d_ar[19]; else if (i == 20) return d_ar[20]; else if (i == 21) return d_ar[21]; else if (i == 22) return d_ar[22]; else if (i == 23) return d_ar[23]; else if (i == 24) return d_ar[24]; else if (i == 25) return d_ar[25]; else if (i == 26) return d_ar[26]; else if (i == 27) return d_ar[27]; else if (i == 28) return d_ar[28]; else if (i == 29) return d_ar[29]; else if (i == 30) return d_ar[30]; else if (i == 31) return d_ar[31]; else if (i == 32) return d_ar[32]; else if (i == 33) return d_ar[33]; else if (i == 34) return d_ar[34]; else if (i == 35) return d_ar[35]; else if (i == 36) return d_ar[36]; else if (i == 37) return d_ar[37]; else if (i == 38) return d_ar[38]; else if (i == 39) return d_ar[39]; else if (i == 40) return d_ar[40]; else if (i == 41) return d_ar[41]; else if (i == 42) return d_ar[42];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.363636374, 0.0);
	ImmCB_0_0_0[2] = vec2(0.226723567, 0.284302384);
	ImmCB_0_0_0[3] = vec2(-0.0809167102, 0.354519248);
	ImmCB_0_0_0[4] = vec2(-0.327625036, 0.157775939);
	ImmCB_0_0_0[5] = vec2(-0.327625036, -0.157775909);
	ImmCB_0_0_0[6] = vec2(-0.0809165612, -0.354519278);
	ImmCB_0_0_0[7] = vec2(0.226723522, -0.284302413);
	ImmCB_0_0_0[8] = vec2(0.681818187, 0.0);
	ImmCB_0_0_0[9] = vec2(0.614296973, 0.295829833);
	ImmCB_0_0_0[10] = vec2(0.425106674, 0.533066928);
	ImmCB_0_0_0[11] = vec2(0.151718855, 0.664723575);
	ImmCB_0_0_0[12] = vec2(-0.151718825, 0.664723575);
	ImmCB_0_0_0[13] = vec2(-0.425106794, 0.533066869);
	ImmCB_0_0_0[14] = vec2(-0.614296973, 0.295829862);
	ImmCB_0_0_0[15] = vec2(-0.681818187, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.614296973, -0.295829833);
	ImmCB_0_0_0[17] = vec2(-0.425106555, -0.533067048);
	ImmCB_0_0_0[18] = vec2(-0.151718557, -0.664723635);
	ImmCB_0_0_0[19] = vec2(0.151719198, -0.664723516);
	ImmCB_0_0_0[20] = vec2(0.425106615, -0.533067048);
	ImmCB_0_0_0[21] = vec2(0.614296973, -0.295829833);
	ImmCB_0_0_0[22] = vec2(1.0, 0.0);
	ImmCB_0_0_0[23] = vec2(0.955572784, 0.294755191);
	ImmCB_0_0_0[24] = vec2(0.826238751, 0.5633201);
	ImmCB_0_0_0[25] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[26] = vec2(0.365340978, 0.930873752);
	ImmCB_0_0_0[27] = vec2(0.0747300014, 0.997203827);
	ImmCB_0_0_0[28] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[29] = vec2(-0.50000006, 0.866025388);
	ImmCB_0_0_0[30] = vec2(-0.733051956, 0.680172682);
	ImmCB_0_0_0[31] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[32] = vec2(-0.988830864, 0.149042085);
	ImmCB_0_0_0[33] = vec2(-0.988830805, -0.149042487);
	ImmCB_0_0_0[34] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[35] = vec2(-0.733051836, -0.680172801);
	ImmCB_0_0_0[36] = vec2(-0.499999911, -0.866025448);
	ImmCB_0_0_0[37] = vec2(-0.222521007, -0.974927902);
	ImmCB_0_0_0[38] = vec2(0.074730292, -0.997203767);
	ImmCB_0_0_0[39] = vec2(0.365341485, -0.930873573);
	ImmCB_0_0_0[40] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[41] = vec2(0.826238811, -0.563319981);
	ImmCB_0_0_0[42] = vec2(0.955572903, -0.294754833);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<43 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0DynamicIndex(u_xlati_loop_1).xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat10_4 = texture2D(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat10_0, u_xlat10_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
        u_xlat18 = (-u_xlat18) + (-u_xlat10_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
        u_xlatb22 = (-u_xlat10_4.w)>=_MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat10_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0730602965;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[43];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec2 ImmCB_0_0_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0_0_0[i];
#else
#define d_ar ImmCB_0_0_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6]; else if (i == 7) return d_ar[7]; else if (i == 8) return d_ar[8]; else if (i == 9) return d_ar[9]; else if (i == 10) return d_ar[10]; else if (i == 11) return d_ar[11]; else if (i == 12) return d_ar[12]; else if (i == 13) return d_ar[13]; else if (i == 14) return d_ar[14]; else if (i == 15) return d_ar[15]; else if (i == 16) return d_ar[16]; else if (i == 17) return d_ar[17]; else if (i == 18) return d_ar[18]; else if (i == 19) return d_ar[19]; else if (i == 20) return d_ar[20]; else if (i == 21) return d_ar[21]; else if (i == 22) return d_ar[22]; else if (i == 23) return d_ar[23]; else if (i == 24) return d_ar[24]; else if (i == 25) return d_ar[25]; else if (i == 26) return d_ar[26]; else if (i == 27) return d_ar[27]; else if (i == 28) return d_ar[28]; else if (i == 29) return d_ar[29]; else if (i == 30) return d_ar[30]; else if (i == 31) return d_ar[31]; else if (i == 32) return d_ar[32]; else if (i == 33) return d_ar[33]; else if (i == 34) return d_ar[34]; else if (i == 35) return d_ar[35]; else if (i == 36) return d_ar[36]; else if (i == 37) return d_ar[37]; else if (i == 38) return d_ar[38]; else if (i == 39) return d_ar[39]; else if (i == 40) return d_ar[40]; else if (i == 41) return d_ar[41]; else if (i == 42) return d_ar[42];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.363636374, 0.0);
	ImmCB_0_0_0[2] = vec2(0.226723567, 0.284302384);
	ImmCB_0_0_0[3] = vec2(-0.0809167102, 0.354519248);
	ImmCB_0_0_0[4] = vec2(-0.327625036, 0.157775939);
	ImmCB_0_0_0[5] = vec2(-0.327625036, -0.157775909);
	ImmCB_0_0_0[6] = vec2(-0.0809165612, -0.354519278);
	ImmCB_0_0_0[7] = vec2(0.226723522, -0.284302413);
	ImmCB_0_0_0[8] = vec2(0.681818187, 0.0);
	ImmCB_0_0_0[9] = vec2(0.614296973, 0.295829833);
	ImmCB_0_0_0[10] = vec2(0.425106674, 0.533066928);
	ImmCB_0_0_0[11] = vec2(0.151718855, 0.664723575);
	ImmCB_0_0_0[12] = vec2(-0.151718825, 0.664723575);
	ImmCB_0_0_0[13] = vec2(-0.425106794, 0.533066869);
	ImmCB_0_0_0[14] = vec2(-0.614296973, 0.295829862);
	ImmCB_0_0_0[15] = vec2(-0.681818187, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.614296973, -0.295829833);
	ImmCB_0_0_0[17] = vec2(-0.425106555, -0.533067048);
	ImmCB_0_0_0[18] = vec2(-0.151718557, -0.664723635);
	ImmCB_0_0_0[19] = vec2(0.151719198, -0.664723516);
	ImmCB_0_0_0[20] = vec2(0.425106615, -0.533067048);
	ImmCB_0_0_0[21] = vec2(0.614296973, -0.295829833);
	ImmCB_0_0_0[22] = vec2(1.0, 0.0);
	ImmCB_0_0_0[23] = vec2(0.955572784, 0.294755191);
	ImmCB_0_0_0[24] = vec2(0.826238751, 0.5633201);
	ImmCB_0_0_0[25] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[26] = vec2(0.365340978, 0.930873752);
	ImmCB_0_0_0[27] = vec2(0.0747300014, 0.997203827);
	ImmCB_0_0_0[28] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[29] = vec2(-0.50000006, 0.866025388);
	ImmCB_0_0_0[30] = vec2(-0.733051956, 0.680172682);
	ImmCB_0_0_0[31] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[32] = vec2(-0.988830864, 0.149042085);
	ImmCB_0_0_0[33] = vec2(-0.988830805, -0.149042487);
	ImmCB_0_0_0[34] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[35] = vec2(-0.733051836, -0.680172801);
	ImmCB_0_0_0[36] = vec2(-0.499999911, -0.866025448);
	ImmCB_0_0_0[37] = vec2(-0.222521007, -0.974927902);
	ImmCB_0_0_0[38] = vec2(0.074730292, -0.997203767);
	ImmCB_0_0_0[39] = vec2(0.365341485, -0.930873573);
	ImmCB_0_0_0[40] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[41] = vec2(0.826238811, -0.563319981);
	ImmCB_0_0_0[42] = vec2(0.955572903, -0.294754833);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<43 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0DynamicIndex(u_xlati_loop_1).xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat10_4 = texture2D(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat10_0, u_xlat10_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
        u_xlat18 = (-u_xlat18) + (-u_xlat10_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
        u_xlatb22 = (-u_xlat10_4.w)>=_MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat10_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0730602965;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[43];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec2 ImmCB_0_0_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0_0_0[i];
#else
#define d_ar ImmCB_0_0_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6]; else if (i == 7) return d_ar[7]; else if (i == 8) return d_ar[8]; else if (i == 9) return d_ar[9]; else if (i == 10) return d_ar[10]; else if (i == 11) return d_ar[11]; else if (i == 12) return d_ar[12]; else if (i == 13) return d_ar[13]; else if (i == 14) return d_ar[14]; else if (i == 15) return d_ar[15]; else if (i == 16) return d_ar[16]; else if (i == 17) return d_ar[17]; else if (i == 18) return d_ar[18]; else if (i == 19) return d_ar[19]; else if (i == 20) return d_ar[20]; else if (i == 21) return d_ar[21]; else if (i == 22) return d_ar[22]; else if (i == 23) return d_ar[23]; else if (i == 24) return d_ar[24]; else if (i == 25) return d_ar[25]; else if (i == 26) return d_ar[26]; else if (i == 27) return d_ar[27]; else if (i == 28) return d_ar[28]; else if (i == 29) return d_ar[29]; else if (i == 30) return d_ar[30]; else if (i == 31) return d_ar[31]; else if (i == 32) return d_ar[32]; else if (i == 33) return d_ar[33]; else if (i == 34) return d_ar[34]; else if (i == 35) return d_ar[35]; else if (i == 36) return d_ar[36]; else if (i == 37) return d_ar[37]; else if (i == 38) return d_ar[38]; else if (i == 39) return d_ar[39]; else if (i == 40) return d_ar[40]; else if (i == 41) return d_ar[41]; else if (i == 42) return d_ar[42];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.363636374, 0.0);
	ImmCB_0_0_0[2] = vec2(0.226723567, 0.284302384);
	ImmCB_0_0_0[3] = vec2(-0.0809167102, 0.354519248);
	ImmCB_0_0_0[4] = vec2(-0.327625036, 0.157775939);
	ImmCB_0_0_0[5] = vec2(-0.327625036, -0.157775909);
	ImmCB_0_0_0[6] = vec2(-0.0809165612, -0.354519278);
	ImmCB_0_0_0[7] = vec2(0.226723522, -0.284302413);
	ImmCB_0_0_0[8] = vec2(0.681818187, 0.0);
	ImmCB_0_0_0[9] = vec2(0.614296973, 0.295829833);
	ImmCB_0_0_0[10] = vec2(0.425106674, 0.533066928);
	ImmCB_0_0_0[11] = vec2(0.151718855, 0.664723575);
	ImmCB_0_0_0[12] = vec2(-0.151718825, 0.664723575);
	ImmCB_0_0_0[13] = vec2(-0.425106794, 0.533066869);
	ImmCB_0_0_0[14] = vec2(-0.614296973, 0.295829862);
	ImmCB_0_0_0[15] = vec2(-0.681818187, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.614296973, -0.295829833);
	ImmCB_0_0_0[17] = vec2(-0.425106555, -0.533067048);
	ImmCB_0_0_0[18] = vec2(-0.151718557, -0.664723635);
	ImmCB_0_0_0[19] = vec2(0.151719198, -0.664723516);
	ImmCB_0_0_0[20] = vec2(0.425106615, -0.533067048);
	ImmCB_0_0_0[21] = vec2(0.614296973, -0.295829833);
	ImmCB_0_0_0[22] = vec2(1.0, 0.0);
	ImmCB_0_0_0[23] = vec2(0.955572784, 0.294755191);
	ImmCB_0_0_0[24] = vec2(0.826238751, 0.5633201);
	ImmCB_0_0_0[25] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[26] = vec2(0.365340978, 0.930873752);
	ImmCB_0_0_0[27] = vec2(0.0747300014, 0.997203827);
	ImmCB_0_0_0[28] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[29] = vec2(-0.50000006, 0.866025388);
	ImmCB_0_0_0[30] = vec2(-0.733051956, 0.680172682);
	ImmCB_0_0_0[31] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[32] = vec2(-0.988830864, 0.149042085);
	ImmCB_0_0_0[33] = vec2(-0.988830805, -0.149042487);
	ImmCB_0_0_0[34] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[35] = vec2(-0.733051836, -0.680172801);
	ImmCB_0_0_0[36] = vec2(-0.499999911, -0.866025448);
	ImmCB_0_0_0[37] = vec2(-0.222521007, -0.974927902);
	ImmCB_0_0_0[38] = vec2(0.074730292, -0.997203767);
	ImmCB_0_0_0[39] = vec2(0.365341485, -0.930873573);
	ImmCB_0_0_0[40] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[41] = vec2(0.826238811, -0.563319981);
	ImmCB_0_0_0[42] = vec2(0.955572903, -0.294754833);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<43 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0DynamicIndex(u_xlati_loop_1).xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat10_4 = texture2D(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat10_0, u_xlat10_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
        u_xlat18 = (-u_xlat18) + (-u_xlat10_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
        u_xlatb22 = (-u_xlat10_4.w)>=_MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat10_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0730602965;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[43];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.363636374, 0.0);
	ImmCB_0_0_0[2] = vec2(0.226723567, 0.284302384);
	ImmCB_0_0_0[3] = vec2(-0.0809167102, 0.354519248);
	ImmCB_0_0_0[4] = vec2(-0.327625036, 0.157775939);
	ImmCB_0_0_0[5] = vec2(-0.327625036, -0.157775909);
	ImmCB_0_0_0[6] = vec2(-0.0809165612, -0.354519278);
	ImmCB_0_0_0[7] = vec2(0.226723522, -0.284302413);
	ImmCB_0_0_0[8] = vec2(0.681818187, 0.0);
	ImmCB_0_0_0[9] = vec2(0.614296973, 0.295829833);
	ImmCB_0_0_0[10] = vec2(0.425106674, 0.533066928);
	ImmCB_0_0_0[11] = vec2(0.151718855, 0.664723575);
	ImmCB_0_0_0[12] = vec2(-0.151718825, 0.664723575);
	ImmCB_0_0_0[13] = vec2(-0.425106794, 0.533066869);
	ImmCB_0_0_0[14] = vec2(-0.614296973, 0.295829862);
	ImmCB_0_0_0[15] = vec2(-0.681818187, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.614296973, -0.295829833);
	ImmCB_0_0_0[17] = vec2(-0.425106555, -0.533067048);
	ImmCB_0_0_0[18] = vec2(-0.151718557, -0.664723635);
	ImmCB_0_0_0[19] = vec2(0.151719198, -0.664723516);
	ImmCB_0_0_0[20] = vec2(0.425106615, -0.533067048);
	ImmCB_0_0_0[21] = vec2(0.614296973, -0.295829833);
	ImmCB_0_0_0[22] = vec2(1.0, 0.0);
	ImmCB_0_0_0[23] = vec2(0.955572784, 0.294755191);
	ImmCB_0_0_0[24] = vec2(0.826238751, 0.5633201);
	ImmCB_0_0_0[25] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[26] = vec2(0.365340978, 0.930873752);
	ImmCB_0_0_0[27] = vec2(0.0747300014, 0.997203827);
	ImmCB_0_0_0[28] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[29] = vec2(-0.50000006, 0.866025388);
	ImmCB_0_0_0[30] = vec2(-0.733051956, 0.680172682);
	ImmCB_0_0_0[31] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[32] = vec2(-0.988830864, 0.149042085);
	ImmCB_0_0_0[33] = vec2(-0.988830805, -0.149042487);
	ImmCB_0_0_0[34] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[35] = vec2(-0.733051836, -0.680172801);
	ImmCB_0_0_0[36] = vec2(-0.499999911, -0.866025448);
	ImmCB_0_0_0[37] = vec2(-0.222521007, -0.974927902);
	ImmCB_0_0_0[38] = vec2(0.074730292, -0.997203767);
	ImmCB_0_0_0[39] = vec2(0.365341485, -0.930873573);
	ImmCB_0_0_0[40] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[41] = vec2(0.826238811, -0.563319981);
	ImmCB_0_0_0[42] = vec2(0.955572903, -0.294754833);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<43 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0730602965;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[43];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.363636374, 0.0);
	ImmCB_0_0_0[2] = vec2(0.226723567, 0.284302384);
	ImmCB_0_0_0[3] = vec2(-0.0809167102, 0.354519248);
	ImmCB_0_0_0[4] = vec2(-0.327625036, 0.157775939);
	ImmCB_0_0_0[5] = vec2(-0.327625036, -0.157775909);
	ImmCB_0_0_0[6] = vec2(-0.0809165612, -0.354519278);
	ImmCB_0_0_0[7] = vec2(0.226723522, -0.284302413);
	ImmCB_0_0_0[8] = vec2(0.681818187, 0.0);
	ImmCB_0_0_0[9] = vec2(0.614296973, 0.295829833);
	ImmCB_0_0_0[10] = vec2(0.425106674, 0.533066928);
	ImmCB_0_0_0[11] = vec2(0.151718855, 0.664723575);
	ImmCB_0_0_0[12] = vec2(-0.151718825, 0.664723575);
	ImmCB_0_0_0[13] = vec2(-0.425106794, 0.533066869);
	ImmCB_0_0_0[14] = vec2(-0.614296973, 0.295829862);
	ImmCB_0_0_0[15] = vec2(-0.681818187, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.614296973, -0.295829833);
	ImmCB_0_0_0[17] = vec2(-0.425106555, -0.533067048);
	ImmCB_0_0_0[18] = vec2(-0.151718557, -0.664723635);
	ImmCB_0_0_0[19] = vec2(0.151719198, -0.664723516);
	ImmCB_0_0_0[20] = vec2(0.425106615, -0.533067048);
	ImmCB_0_0_0[21] = vec2(0.614296973, -0.295829833);
	ImmCB_0_0_0[22] = vec2(1.0, 0.0);
	ImmCB_0_0_0[23] = vec2(0.955572784, 0.294755191);
	ImmCB_0_0_0[24] = vec2(0.826238751, 0.5633201);
	ImmCB_0_0_0[25] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[26] = vec2(0.365340978, 0.930873752);
	ImmCB_0_0_0[27] = vec2(0.0747300014, 0.997203827);
	ImmCB_0_0_0[28] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[29] = vec2(-0.50000006, 0.866025388);
	ImmCB_0_0_0[30] = vec2(-0.733051956, 0.680172682);
	ImmCB_0_0_0[31] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[32] = vec2(-0.988830864, 0.149042085);
	ImmCB_0_0_0[33] = vec2(-0.988830805, -0.149042487);
	ImmCB_0_0_0[34] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[35] = vec2(-0.733051836, -0.680172801);
	ImmCB_0_0_0[36] = vec2(-0.499999911, -0.866025448);
	ImmCB_0_0_0[37] = vec2(-0.222521007, -0.974927902);
	ImmCB_0_0_0[38] = vec2(0.074730292, -0.997203767);
	ImmCB_0_0_0[39] = vec2(0.365341485, -0.930873573);
	ImmCB_0_0_0[40] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[41] = vec2(0.826238811, -0.563319981);
	ImmCB_0_0_0[42] = vec2(0.955572903, -0.294754833);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<43 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0730602965;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[43];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.363636374, 0.0);
	ImmCB_0_0_0[2] = vec2(0.226723567, 0.284302384);
	ImmCB_0_0_0[3] = vec2(-0.0809167102, 0.354519248);
	ImmCB_0_0_0[4] = vec2(-0.327625036, 0.157775939);
	ImmCB_0_0_0[5] = vec2(-0.327625036, -0.157775909);
	ImmCB_0_0_0[6] = vec2(-0.0809165612, -0.354519278);
	ImmCB_0_0_0[7] = vec2(0.226723522, -0.284302413);
	ImmCB_0_0_0[8] = vec2(0.681818187, 0.0);
	ImmCB_0_0_0[9] = vec2(0.614296973, 0.295829833);
	ImmCB_0_0_0[10] = vec2(0.425106674, 0.533066928);
	ImmCB_0_0_0[11] = vec2(0.151718855, 0.664723575);
	ImmCB_0_0_0[12] = vec2(-0.151718825, 0.664723575);
	ImmCB_0_0_0[13] = vec2(-0.425106794, 0.533066869);
	ImmCB_0_0_0[14] = vec2(-0.614296973, 0.295829862);
	ImmCB_0_0_0[15] = vec2(-0.681818187, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.614296973, -0.295829833);
	ImmCB_0_0_0[17] = vec2(-0.425106555, -0.533067048);
	ImmCB_0_0_0[18] = vec2(-0.151718557, -0.664723635);
	ImmCB_0_0_0[19] = vec2(0.151719198, -0.664723516);
	ImmCB_0_0_0[20] = vec2(0.425106615, -0.533067048);
	ImmCB_0_0_0[21] = vec2(0.614296973, -0.295829833);
	ImmCB_0_0_0[22] = vec2(1.0, 0.0);
	ImmCB_0_0_0[23] = vec2(0.955572784, 0.294755191);
	ImmCB_0_0_0[24] = vec2(0.826238751, 0.5633201);
	ImmCB_0_0_0[25] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[26] = vec2(0.365340978, 0.930873752);
	ImmCB_0_0_0[27] = vec2(0.0747300014, 0.997203827);
	ImmCB_0_0_0[28] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[29] = vec2(-0.50000006, 0.866025388);
	ImmCB_0_0_0[30] = vec2(-0.733051956, 0.680172682);
	ImmCB_0_0_0[31] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[32] = vec2(-0.988830864, 0.149042085);
	ImmCB_0_0_0[33] = vec2(-0.988830805, -0.149042487);
	ImmCB_0_0_0[34] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[35] = vec2(-0.733051836, -0.680172801);
	ImmCB_0_0_0[36] = vec2(-0.499999911, -0.866025448);
	ImmCB_0_0_0[37] = vec2(-0.222521007, -0.974927902);
	ImmCB_0_0_0[38] = vec2(0.074730292, -0.997203767);
	ImmCB_0_0_0[39] = vec2(0.365341485, -0.930873573);
	ImmCB_0_0_0[40] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[41] = vec2(0.826238811, -0.563319981);
	ImmCB_0_0_0[42] = vec2(0.955572903, -0.294754833);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<43 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0730602965;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
 Pass {
  Name "Bokeh Filter (very large)"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 1091549
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
vec2 ImmCB_0_0_0[71];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec2 ImmCB_0_0_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0_0_0[i];
#else
#define d_ar ImmCB_0_0_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6]; else if (i == 7) return d_ar[7]; else if (i == 8) return d_ar[8]; else if (i == 9) return d_ar[9]; else if (i == 10) return d_ar[10]; else if (i == 11) return d_ar[11]; else if (i == 12) return d_ar[12]; else if (i == 13) return d_ar[13]; else if (i == 14) return d_ar[14]; else if (i == 15) return d_ar[15]; else if (i == 16) return d_ar[16]; else if (i == 17) return d_ar[17]; else if (i == 18) return d_ar[18]; else if (i == 19) return d_ar[19]; else if (i == 20) return d_ar[20]; else if (i == 21) return d_ar[21]; else if (i == 22) return d_ar[22]; else if (i == 23) return d_ar[23]; else if (i == 24) return d_ar[24]; else if (i == 25) return d_ar[25]; else if (i == 26) return d_ar[26]; else if (i == 27) return d_ar[27]; else if (i == 28) return d_ar[28]; else if (i == 29) return d_ar[29]; else if (i == 30) return d_ar[30]; else if (i == 31) return d_ar[31]; else if (i == 32) return d_ar[32]; else if (i == 33) return d_ar[33]; else if (i == 34) return d_ar[34]; else if (i == 35) return d_ar[35]; else if (i == 36) return d_ar[36]; else if (i == 37) return d_ar[37]; else if (i == 38) return d_ar[38]; else if (i == 39) return d_ar[39]; else if (i == 40) return d_ar[40]; else if (i == 41) return d_ar[41]; else if (i == 42) return d_ar[42]; else if (i == 43) return d_ar[43]; else if (i == 44) return d_ar[44]; else if (i == 45) return d_ar[45]; else if (i == 46) return d_ar[46]; else if (i == 47) return d_ar[47]; else if (i == 48) return d_ar[48]; else if (i == 49) return d_ar[49]; else if (i == 50) return d_ar[50]; else if (i == 51) return d_ar[51]; else if (i == 52) return d_ar[52]; else if (i == 53) return d_ar[53]; else if (i == 54) return d_ar[54]; else if (i == 55) return d_ar[55]; else if (i == 56) return d_ar[56]; else if (i == 57) return d_ar[57]; else if (i == 58) return d_ar[58]; else if (i == 59) return d_ar[59]; else if (i == 60) return d_ar[60]; else if (i == 61) return d_ar[61]; else if (i == 62) return d_ar[62]; else if (i == 63) return d_ar[63]; else if (i == 64) return d_ar[64]; else if (i == 65) return d_ar[65]; else if (i == 66) return d_ar[66]; else if (i == 67) return d_ar[67]; else if (i == 68) return d_ar[68]; else if (i == 69) return d_ar[69]; else if (i == 70) return d_ar[70];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.275862098, 0.0);
	ImmCB_0_0_0[2] = vec2(0.171997204, 0.215677679);
	ImmCB_0_0_0[3] = vec2(-0.0613850951, 0.268945664);
	ImmCB_0_0_0[4] = vec2(-0.248543158, 0.119692102);
	ImmCB_0_0_0[5] = vec2(-0.248543158, -0.11969208);
	ImmCB_0_0_0[6] = vec2(-0.0613849834, -0.268945694);
	ImmCB_0_0_0[7] = vec2(0.171997175, -0.215677708);
	ImmCB_0_0_0[8] = vec2(0.517241359, 0.0);
	ImmCB_0_0_0[9] = vec2(0.466018349, 0.224422619);
	ImmCB_0_0_0[10] = vec2(0.322494715, 0.40439558);
	ImmCB_0_0_0[11] = vec2(0.115097053, 0.504273057);
	ImmCB_0_0_0[12] = vec2(-0.115097038, 0.504273057);
	ImmCB_0_0_0[13] = vec2(-0.322494805, 0.404395521);
	ImmCB_0_0_0[14] = vec2(-0.466018349, 0.224422649);
	ImmCB_0_0_0[15] = vec2(-0.517241359, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.466018349, -0.224422619);
	ImmCB_0_0_0[17] = vec2(-0.322494626, -0.40439564);
	ImmCB_0_0_0[18] = vec2(-0.11509683, -0.504273117);
	ImmCB_0_0_0[19] = vec2(0.115097322, -0.504272997);
	ImmCB_0_0_0[20] = vec2(0.322494656, -0.40439564);
	ImmCB_0_0_0[21] = vec2(0.466018349, -0.224422619);
	ImmCB_0_0_0[22] = vec2(0.758620679, 0.0);
	ImmCB_0_0_0[23] = vec2(0.724917293, 0.223607376);
	ImmCB_0_0_0[24] = vec2(0.626801789, 0.427346289);
	ImmCB_0_0_0[25] = vec2(0.472992241, 0.593113542);
	ImmCB_0_0_0[26] = vec2(0.277155221, 0.706180096);
	ImmCB_0_0_0[27] = vec2(0.0566917248, 0.756499469);
	ImmCB_0_0_0[28] = vec2(-0.168808997, 0.73960048);
	ImmCB_0_0_0[29] = vec2(-0.379310399, 0.656984746);
	ImmCB_0_0_0[30] = vec2(-0.556108356, 0.515993059);
	ImmCB_0_0_0[31] = vec2(-0.683493614, 0.32915324);
	ImmCB_0_0_0[32] = vec2(-0.750147521, 0.113066405);
	ImmCB_0_0_0[33] = vec2(-0.750147521, -0.113066711);
	ImmCB_0_0_0[34] = vec2(-0.683493614, -0.32915318);
	ImmCB_0_0_0[35] = vec2(-0.556108296, -0.515993178);
	ImmCB_0_0_0[36] = vec2(-0.37931028, -0.656984806);
	ImmCB_0_0_0[37] = vec2(-0.168809041, -0.73960048);
	ImmCB_0_0_0[38] = vec2(0.0566919446, -0.75649941);
	ImmCB_0_0_0[39] = vec2(0.277155608, -0.706179917);
	ImmCB_0_0_0[40] = vec2(0.472992152, -0.593113661);
	ImmCB_0_0_0[41] = vec2(0.626801848, -0.4273462);
	ImmCB_0_0_0[42] = vec2(0.724917352, -0.223607108);
	ImmCB_0_0_0[43] = vec2(1.0, 0.0);
	ImmCB_0_0_0[44] = vec2(0.974927902, 0.222520933);
	ImmCB_0_0_0[45] = vec2(0.90096885, 0.433883756);
	ImmCB_0_0_0[46] = vec2(0.781831503, 0.623489797);
	ImmCB_0_0_0[47] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[48] = vec2(0.433883637, 0.900968909);
	ImmCB_0_0_0[49] = vec2(0.222520977, 0.974927902);
	ImmCB_0_0_0[50] = vec2(0.0, 1.0);
	ImmCB_0_0_0[51] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[52] = vec2(-0.433883846, 0.90096885);
	ImmCB_0_0_0[53] = vec2(-0.623489976, 0.781831384);
	ImmCB_0_0_0[54] = vec2(-0.781831682, 0.623489559);
	ImmCB_0_0_0[55] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[56] = vec2(-0.974927902, 0.222520933);
	ImmCB_0_0_0[57] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[58] = vec2(-0.974927902, -0.222520873);
	ImmCB_0_0_0[59] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[60] = vec2(-0.781831384, -0.623489916);
	ImmCB_0_0_0[61] = vec2(-0.623489618, -0.781831622);
	ImmCB_0_0_0[62] = vec2(-0.433883458, -0.900969028);
	ImmCB_0_0_0[63] = vec2(-0.222520545, -0.974928021);
	ImmCB_0_0_0[64] = vec2(0.0, -1.0);
	ImmCB_0_0_0[65] = vec2(0.222521499, -0.974927783);
	ImmCB_0_0_0[66] = vec2(0.433883488, -0.900968969);
	ImmCB_0_0_0[67] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[68] = vec2(0.781831443, -0.623489857);
	ImmCB_0_0_0[69] = vec2(0.90096885, -0.433883756);
	ImmCB_0_0_0[70] = vec2(0.974927902, -0.222520858);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<71 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0DynamicIndex(u_xlati_loop_1).xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat10_4 = texture2D(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat10_0, u_xlat10_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
        u_xlat18 = (-u_xlat18) + (-u_xlat10_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
        u_xlatb22 = (-u_xlat10_4.w)>=_MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat10_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0442477837;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[71];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec2 ImmCB_0_0_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0_0_0[i];
#else
#define d_ar ImmCB_0_0_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6]; else if (i == 7) return d_ar[7]; else if (i == 8) return d_ar[8]; else if (i == 9) return d_ar[9]; else if (i == 10) return d_ar[10]; else if (i == 11) return d_ar[11]; else if (i == 12) return d_ar[12]; else if (i == 13) return d_ar[13]; else if (i == 14) return d_ar[14]; else if (i == 15) return d_ar[15]; else if (i == 16) return d_ar[16]; else if (i == 17) return d_ar[17]; else if (i == 18) return d_ar[18]; else if (i == 19) return d_ar[19]; else if (i == 20) return d_ar[20]; else if (i == 21) return d_ar[21]; else if (i == 22) return d_ar[22]; else if (i == 23) return d_ar[23]; else if (i == 24) return d_ar[24]; else if (i == 25) return d_ar[25]; else if (i == 26) return d_ar[26]; else if (i == 27) return d_ar[27]; else if (i == 28) return d_ar[28]; else if (i == 29) return d_ar[29]; else if (i == 30) return d_ar[30]; else if (i == 31) return d_ar[31]; else if (i == 32) return d_ar[32]; else if (i == 33) return d_ar[33]; else if (i == 34) return d_ar[34]; else if (i == 35) return d_ar[35]; else if (i == 36) return d_ar[36]; else if (i == 37) return d_ar[37]; else if (i == 38) return d_ar[38]; else if (i == 39) return d_ar[39]; else if (i == 40) return d_ar[40]; else if (i == 41) return d_ar[41]; else if (i == 42) return d_ar[42]; else if (i == 43) return d_ar[43]; else if (i == 44) return d_ar[44]; else if (i == 45) return d_ar[45]; else if (i == 46) return d_ar[46]; else if (i == 47) return d_ar[47]; else if (i == 48) return d_ar[48]; else if (i == 49) return d_ar[49]; else if (i == 50) return d_ar[50]; else if (i == 51) return d_ar[51]; else if (i == 52) return d_ar[52]; else if (i == 53) return d_ar[53]; else if (i == 54) return d_ar[54]; else if (i == 55) return d_ar[55]; else if (i == 56) return d_ar[56]; else if (i == 57) return d_ar[57]; else if (i == 58) return d_ar[58]; else if (i == 59) return d_ar[59]; else if (i == 60) return d_ar[60]; else if (i == 61) return d_ar[61]; else if (i == 62) return d_ar[62]; else if (i == 63) return d_ar[63]; else if (i == 64) return d_ar[64]; else if (i == 65) return d_ar[65]; else if (i == 66) return d_ar[66]; else if (i == 67) return d_ar[67]; else if (i == 68) return d_ar[68]; else if (i == 69) return d_ar[69]; else if (i == 70) return d_ar[70];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.275862098, 0.0);
	ImmCB_0_0_0[2] = vec2(0.171997204, 0.215677679);
	ImmCB_0_0_0[3] = vec2(-0.0613850951, 0.268945664);
	ImmCB_0_0_0[4] = vec2(-0.248543158, 0.119692102);
	ImmCB_0_0_0[5] = vec2(-0.248543158, -0.11969208);
	ImmCB_0_0_0[6] = vec2(-0.0613849834, -0.268945694);
	ImmCB_0_0_0[7] = vec2(0.171997175, -0.215677708);
	ImmCB_0_0_0[8] = vec2(0.517241359, 0.0);
	ImmCB_0_0_0[9] = vec2(0.466018349, 0.224422619);
	ImmCB_0_0_0[10] = vec2(0.322494715, 0.40439558);
	ImmCB_0_0_0[11] = vec2(0.115097053, 0.504273057);
	ImmCB_0_0_0[12] = vec2(-0.115097038, 0.504273057);
	ImmCB_0_0_0[13] = vec2(-0.322494805, 0.404395521);
	ImmCB_0_0_0[14] = vec2(-0.466018349, 0.224422649);
	ImmCB_0_0_0[15] = vec2(-0.517241359, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.466018349, -0.224422619);
	ImmCB_0_0_0[17] = vec2(-0.322494626, -0.40439564);
	ImmCB_0_0_0[18] = vec2(-0.11509683, -0.504273117);
	ImmCB_0_0_0[19] = vec2(0.115097322, -0.504272997);
	ImmCB_0_0_0[20] = vec2(0.322494656, -0.40439564);
	ImmCB_0_0_0[21] = vec2(0.466018349, -0.224422619);
	ImmCB_0_0_0[22] = vec2(0.758620679, 0.0);
	ImmCB_0_0_0[23] = vec2(0.724917293, 0.223607376);
	ImmCB_0_0_0[24] = vec2(0.626801789, 0.427346289);
	ImmCB_0_0_0[25] = vec2(0.472992241, 0.593113542);
	ImmCB_0_0_0[26] = vec2(0.277155221, 0.706180096);
	ImmCB_0_0_0[27] = vec2(0.0566917248, 0.756499469);
	ImmCB_0_0_0[28] = vec2(-0.168808997, 0.73960048);
	ImmCB_0_0_0[29] = vec2(-0.379310399, 0.656984746);
	ImmCB_0_0_0[30] = vec2(-0.556108356, 0.515993059);
	ImmCB_0_0_0[31] = vec2(-0.683493614, 0.32915324);
	ImmCB_0_0_0[32] = vec2(-0.750147521, 0.113066405);
	ImmCB_0_0_0[33] = vec2(-0.750147521, -0.113066711);
	ImmCB_0_0_0[34] = vec2(-0.683493614, -0.32915318);
	ImmCB_0_0_0[35] = vec2(-0.556108296, -0.515993178);
	ImmCB_0_0_0[36] = vec2(-0.37931028, -0.656984806);
	ImmCB_0_0_0[37] = vec2(-0.168809041, -0.73960048);
	ImmCB_0_0_0[38] = vec2(0.0566919446, -0.75649941);
	ImmCB_0_0_0[39] = vec2(0.277155608, -0.706179917);
	ImmCB_0_0_0[40] = vec2(0.472992152, -0.593113661);
	ImmCB_0_0_0[41] = vec2(0.626801848, -0.4273462);
	ImmCB_0_0_0[42] = vec2(0.724917352, -0.223607108);
	ImmCB_0_0_0[43] = vec2(1.0, 0.0);
	ImmCB_0_0_0[44] = vec2(0.974927902, 0.222520933);
	ImmCB_0_0_0[45] = vec2(0.90096885, 0.433883756);
	ImmCB_0_0_0[46] = vec2(0.781831503, 0.623489797);
	ImmCB_0_0_0[47] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[48] = vec2(0.433883637, 0.900968909);
	ImmCB_0_0_0[49] = vec2(0.222520977, 0.974927902);
	ImmCB_0_0_0[50] = vec2(0.0, 1.0);
	ImmCB_0_0_0[51] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[52] = vec2(-0.433883846, 0.90096885);
	ImmCB_0_0_0[53] = vec2(-0.623489976, 0.781831384);
	ImmCB_0_0_0[54] = vec2(-0.781831682, 0.623489559);
	ImmCB_0_0_0[55] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[56] = vec2(-0.974927902, 0.222520933);
	ImmCB_0_0_0[57] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[58] = vec2(-0.974927902, -0.222520873);
	ImmCB_0_0_0[59] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[60] = vec2(-0.781831384, -0.623489916);
	ImmCB_0_0_0[61] = vec2(-0.623489618, -0.781831622);
	ImmCB_0_0_0[62] = vec2(-0.433883458, -0.900969028);
	ImmCB_0_0_0[63] = vec2(-0.222520545, -0.974928021);
	ImmCB_0_0_0[64] = vec2(0.0, -1.0);
	ImmCB_0_0_0[65] = vec2(0.222521499, -0.974927783);
	ImmCB_0_0_0[66] = vec2(0.433883488, -0.900968969);
	ImmCB_0_0_0[67] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[68] = vec2(0.781831443, -0.623489857);
	ImmCB_0_0_0[69] = vec2(0.90096885, -0.433883756);
	ImmCB_0_0_0[70] = vec2(0.974927902, -0.222520858);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<71 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0DynamicIndex(u_xlati_loop_1).xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat10_4 = texture2D(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat10_0, u_xlat10_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
        u_xlat18 = (-u_xlat18) + (-u_xlat10_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
        u_xlatb22 = (-u_xlat10_4.w)>=_MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat10_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0442477837;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[71];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec2 ImmCB_0_0_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0_0_0[i];
#else
#define d_ar ImmCB_0_0_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6]; else if (i == 7) return d_ar[7]; else if (i == 8) return d_ar[8]; else if (i == 9) return d_ar[9]; else if (i == 10) return d_ar[10]; else if (i == 11) return d_ar[11]; else if (i == 12) return d_ar[12]; else if (i == 13) return d_ar[13]; else if (i == 14) return d_ar[14]; else if (i == 15) return d_ar[15]; else if (i == 16) return d_ar[16]; else if (i == 17) return d_ar[17]; else if (i == 18) return d_ar[18]; else if (i == 19) return d_ar[19]; else if (i == 20) return d_ar[20]; else if (i == 21) return d_ar[21]; else if (i == 22) return d_ar[22]; else if (i == 23) return d_ar[23]; else if (i == 24) return d_ar[24]; else if (i == 25) return d_ar[25]; else if (i == 26) return d_ar[26]; else if (i == 27) return d_ar[27]; else if (i == 28) return d_ar[28]; else if (i == 29) return d_ar[29]; else if (i == 30) return d_ar[30]; else if (i == 31) return d_ar[31]; else if (i == 32) return d_ar[32]; else if (i == 33) return d_ar[33]; else if (i == 34) return d_ar[34]; else if (i == 35) return d_ar[35]; else if (i == 36) return d_ar[36]; else if (i == 37) return d_ar[37]; else if (i == 38) return d_ar[38]; else if (i == 39) return d_ar[39]; else if (i == 40) return d_ar[40]; else if (i == 41) return d_ar[41]; else if (i == 42) return d_ar[42]; else if (i == 43) return d_ar[43]; else if (i == 44) return d_ar[44]; else if (i == 45) return d_ar[45]; else if (i == 46) return d_ar[46]; else if (i == 47) return d_ar[47]; else if (i == 48) return d_ar[48]; else if (i == 49) return d_ar[49]; else if (i == 50) return d_ar[50]; else if (i == 51) return d_ar[51]; else if (i == 52) return d_ar[52]; else if (i == 53) return d_ar[53]; else if (i == 54) return d_ar[54]; else if (i == 55) return d_ar[55]; else if (i == 56) return d_ar[56]; else if (i == 57) return d_ar[57]; else if (i == 58) return d_ar[58]; else if (i == 59) return d_ar[59]; else if (i == 60) return d_ar[60]; else if (i == 61) return d_ar[61]; else if (i == 62) return d_ar[62]; else if (i == 63) return d_ar[63]; else if (i == 64) return d_ar[64]; else if (i == 65) return d_ar[65]; else if (i == 66) return d_ar[66]; else if (i == 67) return d_ar[67]; else if (i == 68) return d_ar[68]; else if (i == 69) return d_ar[69]; else if (i == 70) return d_ar[70];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.275862098, 0.0);
	ImmCB_0_0_0[2] = vec2(0.171997204, 0.215677679);
	ImmCB_0_0_0[3] = vec2(-0.0613850951, 0.268945664);
	ImmCB_0_0_0[4] = vec2(-0.248543158, 0.119692102);
	ImmCB_0_0_0[5] = vec2(-0.248543158, -0.11969208);
	ImmCB_0_0_0[6] = vec2(-0.0613849834, -0.268945694);
	ImmCB_0_0_0[7] = vec2(0.171997175, -0.215677708);
	ImmCB_0_0_0[8] = vec2(0.517241359, 0.0);
	ImmCB_0_0_0[9] = vec2(0.466018349, 0.224422619);
	ImmCB_0_0_0[10] = vec2(0.322494715, 0.40439558);
	ImmCB_0_0_0[11] = vec2(0.115097053, 0.504273057);
	ImmCB_0_0_0[12] = vec2(-0.115097038, 0.504273057);
	ImmCB_0_0_0[13] = vec2(-0.322494805, 0.404395521);
	ImmCB_0_0_0[14] = vec2(-0.466018349, 0.224422649);
	ImmCB_0_0_0[15] = vec2(-0.517241359, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.466018349, -0.224422619);
	ImmCB_0_0_0[17] = vec2(-0.322494626, -0.40439564);
	ImmCB_0_0_0[18] = vec2(-0.11509683, -0.504273117);
	ImmCB_0_0_0[19] = vec2(0.115097322, -0.504272997);
	ImmCB_0_0_0[20] = vec2(0.322494656, -0.40439564);
	ImmCB_0_0_0[21] = vec2(0.466018349, -0.224422619);
	ImmCB_0_0_0[22] = vec2(0.758620679, 0.0);
	ImmCB_0_0_0[23] = vec2(0.724917293, 0.223607376);
	ImmCB_0_0_0[24] = vec2(0.626801789, 0.427346289);
	ImmCB_0_0_0[25] = vec2(0.472992241, 0.593113542);
	ImmCB_0_0_0[26] = vec2(0.277155221, 0.706180096);
	ImmCB_0_0_0[27] = vec2(0.0566917248, 0.756499469);
	ImmCB_0_0_0[28] = vec2(-0.168808997, 0.73960048);
	ImmCB_0_0_0[29] = vec2(-0.379310399, 0.656984746);
	ImmCB_0_0_0[30] = vec2(-0.556108356, 0.515993059);
	ImmCB_0_0_0[31] = vec2(-0.683493614, 0.32915324);
	ImmCB_0_0_0[32] = vec2(-0.750147521, 0.113066405);
	ImmCB_0_0_0[33] = vec2(-0.750147521, -0.113066711);
	ImmCB_0_0_0[34] = vec2(-0.683493614, -0.32915318);
	ImmCB_0_0_0[35] = vec2(-0.556108296, -0.515993178);
	ImmCB_0_0_0[36] = vec2(-0.37931028, -0.656984806);
	ImmCB_0_0_0[37] = vec2(-0.168809041, -0.73960048);
	ImmCB_0_0_0[38] = vec2(0.0566919446, -0.75649941);
	ImmCB_0_0_0[39] = vec2(0.277155608, -0.706179917);
	ImmCB_0_0_0[40] = vec2(0.472992152, -0.593113661);
	ImmCB_0_0_0[41] = vec2(0.626801848, -0.4273462);
	ImmCB_0_0_0[42] = vec2(0.724917352, -0.223607108);
	ImmCB_0_0_0[43] = vec2(1.0, 0.0);
	ImmCB_0_0_0[44] = vec2(0.974927902, 0.222520933);
	ImmCB_0_0_0[45] = vec2(0.90096885, 0.433883756);
	ImmCB_0_0_0[46] = vec2(0.781831503, 0.623489797);
	ImmCB_0_0_0[47] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[48] = vec2(0.433883637, 0.900968909);
	ImmCB_0_0_0[49] = vec2(0.222520977, 0.974927902);
	ImmCB_0_0_0[50] = vec2(0.0, 1.0);
	ImmCB_0_0_0[51] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[52] = vec2(-0.433883846, 0.90096885);
	ImmCB_0_0_0[53] = vec2(-0.623489976, 0.781831384);
	ImmCB_0_0_0[54] = vec2(-0.781831682, 0.623489559);
	ImmCB_0_0_0[55] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[56] = vec2(-0.974927902, 0.222520933);
	ImmCB_0_0_0[57] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[58] = vec2(-0.974927902, -0.222520873);
	ImmCB_0_0_0[59] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[60] = vec2(-0.781831384, -0.623489916);
	ImmCB_0_0_0[61] = vec2(-0.623489618, -0.781831622);
	ImmCB_0_0_0[62] = vec2(-0.433883458, -0.900969028);
	ImmCB_0_0_0[63] = vec2(-0.222520545, -0.974928021);
	ImmCB_0_0_0[64] = vec2(0.0, -1.0);
	ImmCB_0_0_0[65] = vec2(0.222521499, -0.974927783);
	ImmCB_0_0_0[66] = vec2(0.433883488, -0.900968969);
	ImmCB_0_0_0[67] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[68] = vec2(0.781831443, -0.623489857);
	ImmCB_0_0_0[69] = vec2(0.90096885, -0.433883756);
	ImmCB_0_0_0[70] = vec2(0.974927902, -0.222520858);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<71 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0DynamicIndex(u_xlati_loop_1).xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat10_4 = texture2D(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat10_0, u_xlat10_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
        u_xlat18 = (-u_xlat18) + (-u_xlat10_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
        u_xlatb22 = (-u_xlat10_4.w)>=_MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat10_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0442477837;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[71];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.275862098, 0.0);
	ImmCB_0_0_0[2] = vec2(0.171997204, 0.215677679);
	ImmCB_0_0_0[3] = vec2(-0.0613850951, 0.268945664);
	ImmCB_0_0_0[4] = vec2(-0.248543158, 0.119692102);
	ImmCB_0_0_0[5] = vec2(-0.248543158, -0.11969208);
	ImmCB_0_0_0[6] = vec2(-0.0613849834, -0.268945694);
	ImmCB_0_0_0[7] = vec2(0.171997175, -0.215677708);
	ImmCB_0_0_0[8] = vec2(0.517241359, 0.0);
	ImmCB_0_0_0[9] = vec2(0.466018349, 0.224422619);
	ImmCB_0_0_0[10] = vec2(0.322494715, 0.40439558);
	ImmCB_0_0_0[11] = vec2(0.115097053, 0.504273057);
	ImmCB_0_0_0[12] = vec2(-0.115097038, 0.504273057);
	ImmCB_0_0_0[13] = vec2(-0.322494805, 0.404395521);
	ImmCB_0_0_0[14] = vec2(-0.466018349, 0.224422649);
	ImmCB_0_0_0[15] = vec2(-0.517241359, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.466018349, -0.224422619);
	ImmCB_0_0_0[17] = vec2(-0.322494626, -0.40439564);
	ImmCB_0_0_0[18] = vec2(-0.11509683, -0.504273117);
	ImmCB_0_0_0[19] = vec2(0.115097322, -0.504272997);
	ImmCB_0_0_0[20] = vec2(0.322494656, -0.40439564);
	ImmCB_0_0_0[21] = vec2(0.466018349, -0.224422619);
	ImmCB_0_0_0[22] = vec2(0.758620679, 0.0);
	ImmCB_0_0_0[23] = vec2(0.724917293, 0.223607376);
	ImmCB_0_0_0[24] = vec2(0.626801789, 0.427346289);
	ImmCB_0_0_0[25] = vec2(0.472992241, 0.593113542);
	ImmCB_0_0_0[26] = vec2(0.277155221, 0.706180096);
	ImmCB_0_0_0[27] = vec2(0.0566917248, 0.756499469);
	ImmCB_0_0_0[28] = vec2(-0.168808997, 0.73960048);
	ImmCB_0_0_0[29] = vec2(-0.379310399, 0.656984746);
	ImmCB_0_0_0[30] = vec2(-0.556108356, 0.515993059);
	ImmCB_0_0_0[31] = vec2(-0.683493614, 0.32915324);
	ImmCB_0_0_0[32] = vec2(-0.750147521, 0.113066405);
	ImmCB_0_0_0[33] = vec2(-0.750147521, -0.113066711);
	ImmCB_0_0_0[34] = vec2(-0.683493614, -0.32915318);
	ImmCB_0_0_0[35] = vec2(-0.556108296, -0.515993178);
	ImmCB_0_0_0[36] = vec2(-0.37931028, -0.656984806);
	ImmCB_0_0_0[37] = vec2(-0.168809041, -0.73960048);
	ImmCB_0_0_0[38] = vec2(0.0566919446, -0.75649941);
	ImmCB_0_0_0[39] = vec2(0.277155608, -0.706179917);
	ImmCB_0_0_0[40] = vec2(0.472992152, -0.593113661);
	ImmCB_0_0_0[41] = vec2(0.626801848, -0.4273462);
	ImmCB_0_0_0[42] = vec2(0.724917352, -0.223607108);
	ImmCB_0_0_0[43] = vec2(1.0, 0.0);
	ImmCB_0_0_0[44] = vec2(0.974927902, 0.222520933);
	ImmCB_0_0_0[45] = vec2(0.90096885, 0.433883756);
	ImmCB_0_0_0[46] = vec2(0.781831503, 0.623489797);
	ImmCB_0_0_0[47] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[48] = vec2(0.433883637, 0.900968909);
	ImmCB_0_0_0[49] = vec2(0.222520977, 0.974927902);
	ImmCB_0_0_0[50] = vec2(0.0, 1.0);
	ImmCB_0_0_0[51] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[52] = vec2(-0.433883846, 0.90096885);
	ImmCB_0_0_0[53] = vec2(-0.623489976, 0.781831384);
	ImmCB_0_0_0[54] = vec2(-0.781831682, 0.623489559);
	ImmCB_0_0_0[55] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[56] = vec2(-0.974927902, 0.222520933);
	ImmCB_0_0_0[57] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[58] = vec2(-0.974927902, -0.222520873);
	ImmCB_0_0_0[59] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[60] = vec2(-0.781831384, -0.623489916);
	ImmCB_0_0_0[61] = vec2(-0.623489618, -0.781831622);
	ImmCB_0_0_0[62] = vec2(-0.433883458, -0.900969028);
	ImmCB_0_0_0[63] = vec2(-0.222520545, -0.974928021);
	ImmCB_0_0_0[64] = vec2(0.0, -1.0);
	ImmCB_0_0_0[65] = vec2(0.222521499, -0.974927783);
	ImmCB_0_0_0[66] = vec2(0.433883488, -0.900968969);
	ImmCB_0_0_0[67] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[68] = vec2(0.781831443, -0.623489857);
	ImmCB_0_0_0[69] = vec2(0.90096885, -0.433883756);
	ImmCB_0_0_0[70] = vec2(0.974927902, -0.222520858);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<71 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0442477837;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[71];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.275862098, 0.0);
	ImmCB_0_0_0[2] = vec2(0.171997204, 0.215677679);
	ImmCB_0_0_0[3] = vec2(-0.0613850951, 0.268945664);
	ImmCB_0_0_0[4] = vec2(-0.248543158, 0.119692102);
	ImmCB_0_0_0[5] = vec2(-0.248543158, -0.11969208);
	ImmCB_0_0_0[6] = vec2(-0.0613849834, -0.268945694);
	ImmCB_0_0_0[7] = vec2(0.171997175, -0.215677708);
	ImmCB_0_0_0[8] = vec2(0.517241359, 0.0);
	ImmCB_0_0_0[9] = vec2(0.466018349, 0.224422619);
	ImmCB_0_0_0[10] = vec2(0.322494715, 0.40439558);
	ImmCB_0_0_0[11] = vec2(0.115097053, 0.504273057);
	ImmCB_0_0_0[12] = vec2(-0.115097038, 0.504273057);
	ImmCB_0_0_0[13] = vec2(-0.322494805, 0.404395521);
	ImmCB_0_0_0[14] = vec2(-0.466018349, 0.224422649);
	ImmCB_0_0_0[15] = vec2(-0.517241359, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.466018349, -0.224422619);
	ImmCB_0_0_0[17] = vec2(-0.322494626, -0.40439564);
	ImmCB_0_0_0[18] = vec2(-0.11509683, -0.504273117);
	ImmCB_0_0_0[19] = vec2(0.115097322, -0.504272997);
	ImmCB_0_0_0[20] = vec2(0.322494656, -0.40439564);
	ImmCB_0_0_0[21] = vec2(0.466018349, -0.224422619);
	ImmCB_0_0_0[22] = vec2(0.758620679, 0.0);
	ImmCB_0_0_0[23] = vec2(0.724917293, 0.223607376);
	ImmCB_0_0_0[24] = vec2(0.626801789, 0.427346289);
	ImmCB_0_0_0[25] = vec2(0.472992241, 0.593113542);
	ImmCB_0_0_0[26] = vec2(0.277155221, 0.706180096);
	ImmCB_0_0_0[27] = vec2(0.0566917248, 0.756499469);
	ImmCB_0_0_0[28] = vec2(-0.168808997, 0.73960048);
	ImmCB_0_0_0[29] = vec2(-0.379310399, 0.656984746);
	ImmCB_0_0_0[30] = vec2(-0.556108356, 0.515993059);
	ImmCB_0_0_0[31] = vec2(-0.683493614, 0.32915324);
	ImmCB_0_0_0[32] = vec2(-0.750147521, 0.113066405);
	ImmCB_0_0_0[33] = vec2(-0.750147521, -0.113066711);
	ImmCB_0_0_0[34] = vec2(-0.683493614, -0.32915318);
	ImmCB_0_0_0[35] = vec2(-0.556108296, -0.515993178);
	ImmCB_0_0_0[36] = vec2(-0.37931028, -0.656984806);
	ImmCB_0_0_0[37] = vec2(-0.168809041, -0.73960048);
	ImmCB_0_0_0[38] = vec2(0.0566919446, -0.75649941);
	ImmCB_0_0_0[39] = vec2(0.277155608, -0.706179917);
	ImmCB_0_0_0[40] = vec2(0.472992152, -0.593113661);
	ImmCB_0_0_0[41] = vec2(0.626801848, -0.4273462);
	ImmCB_0_0_0[42] = vec2(0.724917352, -0.223607108);
	ImmCB_0_0_0[43] = vec2(1.0, 0.0);
	ImmCB_0_0_0[44] = vec2(0.974927902, 0.222520933);
	ImmCB_0_0_0[45] = vec2(0.90096885, 0.433883756);
	ImmCB_0_0_0[46] = vec2(0.781831503, 0.623489797);
	ImmCB_0_0_0[47] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[48] = vec2(0.433883637, 0.900968909);
	ImmCB_0_0_0[49] = vec2(0.222520977, 0.974927902);
	ImmCB_0_0_0[50] = vec2(0.0, 1.0);
	ImmCB_0_0_0[51] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[52] = vec2(-0.433883846, 0.90096885);
	ImmCB_0_0_0[53] = vec2(-0.623489976, 0.781831384);
	ImmCB_0_0_0[54] = vec2(-0.781831682, 0.623489559);
	ImmCB_0_0_0[55] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[56] = vec2(-0.974927902, 0.222520933);
	ImmCB_0_0_0[57] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[58] = vec2(-0.974927902, -0.222520873);
	ImmCB_0_0_0[59] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[60] = vec2(-0.781831384, -0.623489916);
	ImmCB_0_0_0[61] = vec2(-0.623489618, -0.781831622);
	ImmCB_0_0_0[62] = vec2(-0.433883458, -0.900969028);
	ImmCB_0_0_0[63] = vec2(-0.222520545, -0.974928021);
	ImmCB_0_0_0[64] = vec2(0.0, -1.0);
	ImmCB_0_0_0[65] = vec2(0.222521499, -0.974927783);
	ImmCB_0_0_0[66] = vec2(0.433883488, -0.900968969);
	ImmCB_0_0_0[67] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[68] = vec2(0.781831443, -0.623489857);
	ImmCB_0_0_0[69] = vec2(0.90096885, -0.433883756);
	ImmCB_0_0_0[70] = vec2(0.974927902, -0.222520858);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<71 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0442477837;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
vec2 ImmCB_0_0_0[71];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform 	float _RcpAspect;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati12;
float u_xlat18;
bool u_xlatb18;
float u_xlat22;
bool u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec2(0.0, 0.0);
	ImmCB_0_0_0[1] = vec2(0.275862098, 0.0);
	ImmCB_0_0_0[2] = vec2(0.171997204, 0.215677679);
	ImmCB_0_0_0[3] = vec2(-0.0613850951, 0.268945664);
	ImmCB_0_0_0[4] = vec2(-0.248543158, 0.119692102);
	ImmCB_0_0_0[5] = vec2(-0.248543158, -0.11969208);
	ImmCB_0_0_0[6] = vec2(-0.0613849834, -0.268945694);
	ImmCB_0_0_0[7] = vec2(0.171997175, -0.215677708);
	ImmCB_0_0_0[8] = vec2(0.517241359, 0.0);
	ImmCB_0_0_0[9] = vec2(0.466018349, 0.224422619);
	ImmCB_0_0_0[10] = vec2(0.322494715, 0.40439558);
	ImmCB_0_0_0[11] = vec2(0.115097053, 0.504273057);
	ImmCB_0_0_0[12] = vec2(-0.115097038, 0.504273057);
	ImmCB_0_0_0[13] = vec2(-0.322494805, 0.404395521);
	ImmCB_0_0_0[14] = vec2(-0.466018349, 0.224422649);
	ImmCB_0_0_0[15] = vec2(-0.517241359, 0.0);
	ImmCB_0_0_0[16] = vec2(-0.466018349, -0.224422619);
	ImmCB_0_0_0[17] = vec2(-0.322494626, -0.40439564);
	ImmCB_0_0_0[18] = vec2(-0.11509683, -0.504273117);
	ImmCB_0_0_0[19] = vec2(0.115097322, -0.504272997);
	ImmCB_0_0_0[20] = vec2(0.322494656, -0.40439564);
	ImmCB_0_0_0[21] = vec2(0.466018349, -0.224422619);
	ImmCB_0_0_0[22] = vec2(0.758620679, 0.0);
	ImmCB_0_0_0[23] = vec2(0.724917293, 0.223607376);
	ImmCB_0_0_0[24] = vec2(0.626801789, 0.427346289);
	ImmCB_0_0_0[25] = vec2(0.472992241, 0.593113542);
	ImmCB_0_0_0[26] = vec2(0.277155221, 0.706180096);
	ImmCB_0_0_0[27] = vec2(0.0566917248, 0.756499469);
	ImmCB_0_0_0[28] = vec2(-0.168808997, 0.73960048);
	ImmCB_0_0_0[29] = vec2(-0.379310399, 0.656984746);
	ImmCB_0_0_0[30] = vec2(-0.556108356, 0.515993059);
	ImmCB_0_0_0[31] = vec2(-0.683493614, 0.32915324);
	ImmCB_0_0_0[32] = vec2(-0.750147521, 0.113066405);
	ImmCB_0_0_0[33] = vec2(-0.750147521, -0.113066711);
	ImmCB_0_0_0[34] = vec2(-0.683493614, -0.32915318);
	ImmCB_0_0_0[35] = vec2(-0.556108296, -0.515993178);
	ImmCB_0_0_0[36] = vec2(-0.37931028, -0.656984806);
	ImmCB_0_0_0[37] = vec2(-0.168809041, -0.73960048);
	ImmCB_0_0_0[38] = vec2(0.0566919446, -0.75649941);
	ImmCB_0_0_0[39] = vec2(0.277155608, -0.706179917);
	ImmCB_0_0_0[40] = vec2(0.472992152, -0.593113661);
	ImmCB_0_0_0[41] = vec2(0.626801848, -0.4273462);
	ImmCB_0_0_0[42] = vec2(0.724917352, -0.223607108);
	ImmCB_0_0_0[43] = vec2(1.0, 0.0);
	ImmCB_0_0_0[44] = vec2(0.974927902, 0.222520933);
	ImmCB_0_0_0[45] = vec2(0.90096885, 0.433883756);
	ImmCB_0_0_0[46] = vec2(0.781831503, 0.623489797);
	ImmCB_0_0_0[47] = vec2(0.623489797, 0.781831503);
	ImmCB_0_0_0[48] = vec2(0.433883637, 0.900968909);
	ImmCB_0_0_0[49] = vec2(0.222520977, 0.974927902);
	ImmCB_0_0_0[50] = vec2(0.0, 1.0);
	ImmCB_0_0_0[51] = vec2(-0.222520947, 0.974927902);
	ImmCB_0_0_0[52] = vec2(-0.433883846, 0.90096885);
	ImmCB_0_0_0[53] = vec2(-0.623489976, 0.781831384);
	ImmCB_0_0_0[54] = vec2(-0.781831682, 0.623489559);
	ImmCB_0_0_0[55] = vec2(-0.90096885, 0.433883816);
	ImmCB_0_0_0[56] = vec2(-0.974927902, 0.222520933);
	ImmCB_0_0_0[57] = vec2(-1.0, 0.0);
	ImmCB_0_0_0[58] = vec2(-0.974927902, -0.222520873);
	ImmCB_0_0_0[59] = vec2(-0.90096885, -0.433883756);
	ImmCB_0_0_0[60] = vec2(-0.781831384, -0.623489916);
	ImmCB_0_0_0[61] = vec2(-0.623489618, -0.781831622);
	ImmCB_0_0_0[62] = vec2(-0.433883458, -0.900969028);
	ImmCB_0_0_0[63] = vec2(-0.222520545, -0.974928021);
	ImmCB_0_0_0[64] = vec2(0.0, -1.0);
	ImmCB_0_0_0[65] = vec2(0.222521499, -0.974927783);
	ImmCB_0_0_0[66] = vec2(0.433883488, -0.900968969);
	ImmCB_0_0_0[67] = vec2(0.623489678, -0.781831622);
	ImmCB_0_0_0[68] = vec2(0.781831443, -0.623489857);
	ImmCB_0_0_0[69] = vec2(0.90096885, -0.433883756);
	ImmCB_0_0_0[70] = vec2(0.974927902, -0.222520858);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat6 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<71 ; u_xlati_loop_1++)
    {
        u_xlat4.yz = vec2(vec2(_MaxCoC, _MaxCoC)) * ImmCB_0_0_0[u_xlati_loop_1].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * _RcpAspect;
        u_xlat4.xy = u_xlat4.xz + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
        u_xlat4.xy = u_xlat4.xy * vec2(_RenderViewportScaleFactor);
        u_xlat16_4 = texture(_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, 0.0);
        u_xlat5 = (-u_xlat18) + u_xlat16_5;
        u_xlat5 = _MainTex_TexelSize.y * 2.0 + u_xlat5;
        u_xlat5 = u_xlat5 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
        u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat18) + (-u_xlat16_4.w);
        u_xlat18 = _MainTex_TexelSize.y * 2.0 + u_xlat18;
        u_xlat18 = u_xlat18 / u_xlat6;
#ifdef UNITY_ADRENO_ES3
        u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!((-u_xlat16_4.w)>=_MainTex_TexelSize.y);
#else
        u_xlatb22 = (-u_xlat16_4.w)>=_MainTex_TexelSize.y;
#endif
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = u_xlat16_4.xyz;
        u_xlat2 = u_xlat1 * vec4(u_xlat5) + u_xlat2;
        u_xlat3 = u_xlat1 * vec4(u_xlat18) + u_xlat3;
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.w==0.0);
#else
    u_xlatb0 = u_xlat2.w==0.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat3.w==0.0);
#else
    u_xlatb18 = u_xlat3.w==0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / vec3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0442477837;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat18;
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
 Pass {
  Name "Postfilter"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 1131532
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat10_1 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat10_1 + u_xlat16_0;
    SV_Target0 = u_xlat16_0 * vec4(0.25, 0.25, 0.25, 0.25);
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat10_1 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat10_1 + u_xlat16_0;
    SV_Target0 = u_xlat16_0 * vec4(0.25, 0.25, 0.25, 0.25);
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat10_1 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat10_1 + u_xlat16_0;
    SV_Target0 = u_xlat16_0 * vec4(0.25, 0.25, 0.25, 0.25);
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat16_1 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = texture(_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    SV_Target0 = u_xlat16_0 * vec4(0.25, 0.25, 0.25, 0.25);
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat16_1 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = texture(_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    SV_Target0 = u_xlat16_0 * vec4(0.25, 0.25, 0.25, 0.25);
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = (-_MainTex_TexelSize.xyxy) * vec4(0.5, 0.5, -0.5, 0.5) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat16_1 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = texture(_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, 0.5) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    SV_Target0 = u_xlat16_0 * vec4(0.25, 0.25, 0.25, 0.25);
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
 Pass {
  Name "Combine"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 1184146
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
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform lowp sampler2D _DepthOfFieldTex;
uniform lowp sampler2D _CoCTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture2D(_CoCTex, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat10_0 + -0.5;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat3 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat0.x = u_xlat16_0 * _MaxCoC + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat0.x * u_xlat3;
    u_xlat1 = texture2D(_DepthOfFieldTex, vs_TEXCOORD1.xy);
    u_xlat0.x = u_xlat3 * u_xlat0.x + u_xlat1.w;
    u_xlat0.x = (-u_xlat6) * u_xlat1.w + u_xlat0.x;
    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
    u_xlat1.w = max(u_xlat1.z, u_xlat3);
    u_xlat2 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat2.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
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
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform lowp sampler2D _DepthOfFieldTex;
uniform lowp sampler2D _CoCTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture2D(_CoCTex, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat10_0 + -0.5;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat3 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat0.x = u_xlat16_0 * _MaxCoC + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat0.x * u_xlat3;
    u_xlat1 = texture2D(_DepthOfFieldTex, vs_TEXCOORD1.xy);
    u_xlat0.x = u_xlat3 * u_xlat0.x + u_xlat1.w;
    u_xlat0.x = (-u_xlat6) * u_xlat1.w + u_xlat0.x;
    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
    u_xlat1.w = max(u_xlat1.z, u_xlat3);
    u_xlat2 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat2.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
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
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform lowp sampler2D _DepthOfFieldTex;
uniform lowp sampler2D _CoCTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture2D(_CoCTex, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat10_0 + -0.5;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat3 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat0.x = u_xlat16_0 * _MaxCoC + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat0.x * u_xlat3;
    u_xlat1 = texture2D(_DepthOfFieldTex, vs_TEXCOORD1.xy);
    u_xlat0.x = u_xlat3 * u_xlat0.x + u_xlat1.w;
    u_xlat0.x = (-u_xlat6) * u_xlat1.w + u_xlat0.x;
    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
    u_xlat1.w = max(u_xlat1.z, u_xlat3);
    u_xlat2 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat2.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
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
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform mediump sampler2D _DepthOfFieldTex;
uniform mediump sampler2D _CoCTex;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat16_0 = texture(_CoCTex, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat16_0 + -0.5;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat3 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat0.x = u_xlat16_0 * _MaxCoC + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat0.x * u_xlat3;
    u_xlat1 = texture(_DepthOfFieldTex, vs_TEXCOORD1.xy);
    u_xlat0.x = u_xlat3 * u_xlat0.x + u_xlat1.w;
    u_xlat0.x = (-u_xlat6) * u_xlat1.w + u_xlat0.x;
    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
    u_xlat1.w = max(u_xlat1.z, u_xlat3);
    u_xlat2 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat2.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
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
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform mediump sampler2D _DepthOfFieldTex;
uniform mediump sampler2D _CoCTex;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat16_0 = texture(_CoCTex, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat16_0 + -0.5;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat3 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat0.x = u_xlat16_0 * _MaxCoC + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat0.x * u_xlat3;
    u_xlat1 = texture(_DepthOfFieldTex, vs_TEXCOORD1.xy);
    u_xlat0.x = u_xlat3 * u_xlat0.x + u_xlat1.w;
    u_xlat0.x = (-u_xlat6) * u_xlat1.w + u_xlat0.x;
    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
    u_xlat1.w = max(u_xlat1.z, u_xlat3);
    u_xlat2 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat2.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
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
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _MaxCoC;
uniform mediump sampler2D _DepthOfFieldTex;
uniform mediump sampler2D _CoCTex;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat16_0 = texture(_CoCTex, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat16_0 + -0.5;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat3 = _MainTex_TexelSize.y + _MainTex_TexelSize.y;
    u_xlat0.x = u_xlat16_0 * _MaxCoC + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat0.x * u_xlat3;
    u_xlat1 = texture(_DepthOfFieldTex, vs_TEXCOORD1.xy);
    u_xlat0.x = u_xlat3 * u_xlat0.x + u_xlat1.w;
    u_xlat0.x = (-u_xlat6) * u_xlat1.w + u_xlat0.x;
    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
    u_xlat1.w = max(u_xlat1.z, u_xlat3);
    u_xlat2 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat2.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
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
 Pass {
  Name "Debug Overlay"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 1295376
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
uniform 	vec4 _ZBufferParams;
uniform 	float _Distance;
uniform 	float _LensCoeff;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
float u_xlat2;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = texture2D(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat0.x + (-_Distance);
    u_xlat2 = u_xlat2 * _LensCoeff;
    u_xlat0.x = u_xlat2 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 80.0;
    u_xlat2 = u_xlat0.x;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat0.x = (-u_xlat0.x);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.xzw = u_xlat0.xxx * vec3(0.0, 1.0, 1.0) + vec3(1.0, 0.0, 0.0);
    u_xlat1.xyz = (-u_xlat0.xww) + vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat0.xyz = vec3(u_xlat2) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat10_1.xyz = texture2D(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_6 = dot(u_xlat10_1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat16_6 = u_xlat16_6 + 0.5;
    SV_Target0.xyz = vec3(u_xlat16_6) * u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _Distance;
uniform 	float _LensCoeff;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
float u_xlat2;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = texture2D(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat0.x + (-_Distance);
    u_xlat2 = u_xlat2 * _LensCoeff;
    u_xlat0.x = u_xlat2 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 80.0;
    u_xlat2 = u_xlat0.x;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat0.x = (-u_xlat0.x);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.xzw = u_xlat0.xxx * vec3(0.0, 1.0, 1.0) + vec3(1.0, 0.0, 0.0);
    u_xlat1.xyz = (-u_xlat0.xww) + vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat0.xyz = vec3(u_xlat2) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat10_1.xyz = texture2D(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_6 = dot(u_xlat10_1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat16_6 = u_xlat16_6 + 0.5;
    SV_Target0.xyz = vec3(u_xlat16_6) * u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _Distance;
uniform 	float _LensCoeff;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
float u_xlat2;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = texture2D(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat0.x + (-_Distance);
    u_xlat2 = u_xlat2 * _LensCoeff;
    u_xlat0.x = u_xlat2 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 80.0;
    u_xlat2 = u_xlat0.x;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat0.x = (-u_xlat0.x);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.xzw = u_xlat0.xxx * vec3(0.0, 1.0, 1.0) + vec3(1.0, 0.0, 0.0);
    u_xlat1.xyz = (-u_xlat0.xww) + vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat0.xyz = vec3(u_xlat2) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat10_1.xyz = texture2D(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_6 = dot(u_xlat10_1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat16_6 = u_xlat16_6 + 0.5;
    SV_Target0.xyz = vec3(u_xlat16_6) * u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _Distance;
uniform 	float _LensCoeff;
uniform mediump sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat0.x + (-_Distance);
    u_xlat2 = u_xlat2 * _LensCoeff;
    u_xlat0.x = u_xlat2 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 80.0;
    u_xlat2 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xzw = u_xlat0.xxx * vec3(0.0, 1.0, 1.0) + vec3(1.0, 0.0, 0.0);
    u_xlat1.xyz = (-u_xlat0.xww) + vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat0.xyz = vec3(u_xlat2) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_6 = dot(u_xlat16_1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat16_6 = u_xlat16_6 + 0.5;
    SV_Target0.xyz = vec3(u_xlat16_6) * u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _Distance;
uniform 	float _LensCoeff;
uniform mediump sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat0.x + (-_Distance);
    u_xlat2 = u_xlat2 * _LensCoeff;
    u_xlat0.x = u_xlat2 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 80.0;
    u_xlat2 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xzw = u_xlat0.xxx * vec3(0.0, 1.0, 1.0) + vec3(1.0, 0.0, 0.0);
    u_xlat1.xyz = (-u_xlat0.xww) + vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat0.xyz = vec3(u_xlat2) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_6 = dot(u_xlat16_1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat16_6 = u_xlat16_6 + 0.5;
    SV_Target0.xyz = vec3(u_xlat16_6) * u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _Distance;
uniform 	float _LensCoeff;
uniform mediump sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat0.x + (-_Distance);
    u_xlat2 = u_xlat2 * _LensCoeff;
    u_xlat0.x = u_xlat2 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 80.0;
    u_xlat2 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xzw = u_xlat0.xxx * vec3(0.0, 1.0, 1.0) + vec3(1.0, 0.0, 0.0);
    u_xlat1.xyz = (-u_xlat0.xww) + vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat0.xyz = vec3(u_xlat2) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_6 = dot(u_xlat16_1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat16_6 = u_xlat16_6 + 0.5;
    SV_Target0.xyz = vec3(u_xlat16_6) * u_xlat0.xyz;
    SV_Target0.w = 1.0;
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