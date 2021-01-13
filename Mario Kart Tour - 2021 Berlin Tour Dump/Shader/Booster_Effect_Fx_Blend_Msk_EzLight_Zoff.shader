//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Blend_Msk_EzLight_Zoff" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
[Header(Simple Lighting)] _reflectance ("Reflectance", Range(0, 1)) = 1
_Occlusion ("Occlusion", Range(0, 1)) = 1
[KeywordEnum(DISABLE, ENABLE)] _FOG ("Fog", Float) = 0
_AlphaTexture ("A(UV0)", 2D) = "black" { }
[Header(Z Offset)] _zOffset ("Z Offset", Float) = 0
}
SubShader {
 LOD 200
 Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 16551
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "_FOG_DISABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat10_1) + 1.0;
    SV_Target0.w = u_xlat16_1 * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_FOG_DISABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat10_1) + 1.0;
    SV_Target0.w = u_xlat16_1 * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_FOG_DISABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat10_1) + 1.0;
    SV_Target0.w = u_xlat16_1 * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_FOG_DISABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1 = texture(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    SV_Target0.w = u_xlat16_1 * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_FOG_DISABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1 = texture(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    SV_Target0.w = u_xlat16_1 * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_FOG_DISABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1 = texture(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    SV_Target0.w = u_xlat16_1 * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "_FOG_DISABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat10_1) + 1.0;
    SV_Target0.w = u_xlat16_1 * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "_FOG_DISABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat10_1) + 1.0;
    SV_Target0.w = u_xlat16_1 * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "_FOG_DISABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat10_1) + 1.0;
    SV_Target0.w = u_xlat16_1 * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "_FOG_DISABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1 = texture(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    SV_Target0.w = u_xlat16_1 * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "_FOG_DISABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1 = texture(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    SV_Target0.w = u_xlat16_1 * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "_FOG_DISABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1 = texture(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    SV_Target0.w = u_xlat16_1 * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_FOG_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat10_1) + 1.0;
    SV_Target0.w = u_xlat16_1 * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_FOG_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat10_1) + 1.0;
    SV_Target0.w = u_xlat16_1 * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_FOG_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat10_1) + 1.0;
    SV_Target0.w = u_xlat16_1 * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_FOG_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1 = texture(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    SV_Target0.w = u_xlat16_1 * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_FOG_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1 = texture(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    SV_Target0.w = u_xlat16_1 * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_FOG_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1 = texture(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    SV_Target0.w = u_xlat16_1 * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "_FOG_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD5;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat16_1.xyz + unity_FogColor.xyz;
    u_xlat10_1 = texture2D(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = (-u_xlat10_1) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "_FOG_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD5;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat16_1.xyz + unity_FogColor.xyz;
    u_xlat10_1 = texture2D(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = (-u_xlat10_1) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "_FOG_ENABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD5;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat16_1.xyz + unity_FogColor.xyz;
    u_xlat10_1 = texture2D(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = (-u_xlat10_1) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "_FOG_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD5;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat16_1.xyz + unity_FogColor.xyz;
    u_xlat16_1.x = texture(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "_FOG_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD5;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat16_1.xyz + unity_FogColor.xyz;
    u_xlat16_1.x = texture(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "_FOG_ENABLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp float vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD5;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = _LightColor0.xyz * vec3(_reflectance) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat16_1.xyz + unity_FogColor.xyz;
    u_xlat16_1.x = texture(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat1.w;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "_FOG_DISABLE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_FOG_DISABLE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_FOG_DISABLE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_FOG_DISABLE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_FOG_DISABLE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_FOG_DISABLE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "_FOG_DISABLE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "_FOG_DISABLE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "_FOG_DISABLE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "_FOG_DISABLE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "_FOG_DISABLE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "_FOG_DISABLE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_FOG_ENABLE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_FOG_ENABLE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_FOG_ENABLE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_FOG_ENABLE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_FOG_ENABLE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_FOG_ENABLE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "_FOG_ENABLE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "_FOG_ENABLE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "_FOG_ENABLE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "_FOG_ENABLE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "_FOG_ENABLE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "_FOG_ENABLE" }
""
}
}
}
}
}