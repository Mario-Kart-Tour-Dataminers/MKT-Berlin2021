//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Blend_AlbScr_MskScr_EzLight_Zoff" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("RGB(UV0)", 2D) = "white" { }
[Header(RGB UV Scroll)] _AlbedoScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AlbedoScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
[Header(Simple Lighting)] _reflectance ("Reflectance", Range(0, 1)) = 1
_Occlusion ("Occlusion", Range(0, 1)) = 1
[KeywordEnum(DISABLE, ENABLE)] _FOG ("Fog", Float) = 0
_AlphaTexture ("A(UV0)", 2D) = "black" { }
[Header(A UV Scroll)] _AlphaTextureScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AlphaTextureScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
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
  GpuProgramID 53942
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "_FOG_DISABLE" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat10_4.xyz = texture2D(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat10_4.xyz = texture2D(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat10_4.xyz = texture2D(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat16_4.xyz = texture(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat16_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat16_4.xyz = texture(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat16_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat16_4.xyz = texture(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat16_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat10_4.xyz = texture2D(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat10_4.xyz = texture2D(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat10_4.xyz = texture2D(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat16_4.xyz = texture(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat16_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat16_4.xyz = texture(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat16_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat16_4.xyz = texture(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat16_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat10_4.xyz = texture2D(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat10_4.xyz = texture2D(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat10_4.xyz = texture2D(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat16_4.xyz = texture(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat16_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat16_4.xyz = texture(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat16_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat16_4.xyz = texture(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat16_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0 * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat12;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0.x = (-u_xlat10_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat10_4.xyz = texture2D(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0.x * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + (-unity_FogColor.xyz);
    u_xlat12 = vs_TEXCOORD5;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat12;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0.x = (-u_xlat10_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat10_4.xyz = texture2D(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0.x * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + (-unity_FogColor.xyz);
    u_xlat12 = vs_TEXCOORD5;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat12;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0.x = (-u_xlat10_0) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat10_4.xyz = texture2D(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0.x * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + (-unity_FogColor.xyz);
    u_xlat12 = vs_TEXCOORD5;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD5;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
float u_xlat12;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat16_0.x = texture(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat16_4.xyz = texture(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat16_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0.x * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + (-unity_FogColor.xyz);
    u_xlat12 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD5;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
float u_xlat12;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat16_0.x = texture(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat16_4.xyz = texture(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat16_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0.x * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + (-unity_FogColor.xyz);
    u_xlat12 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	float _zOffset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _reflectance;
uniform 	mediump float _Occlusion;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp float vs_TEXCOORD5;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
float u_xlat12;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat4.xy = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD1.xy;
    u_xlat16_0.x = texture(_AlphaTexture, u_xlat0.xw).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat16_4.xyz = texture(_MainTex, u_xlat4.xy).xyz;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat4.xyz = u_xlat16_4.xyz * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0.x * u_xlat1.w;
    u_xlat16_2.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = _LightColor0.xyz * vec3(vec3(_reflectance, _reflectance, _reflectance)) + vec3(vec3(_Occlusion, _Occlusion, _Occlusion));
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + (-unity_FogColor.xyz);
    u_xlat12 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
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