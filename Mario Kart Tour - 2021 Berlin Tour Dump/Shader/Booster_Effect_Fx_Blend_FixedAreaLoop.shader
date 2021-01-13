//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Blend_FixedAreaLoop" {
Properties {
_MainTex ("RGB(UV0)", 2D) = "white" { }
_AlphaTex ("A(UV0)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_TileX ("TileX", Float) = 1
_TileY ("TileY", Float) = 1
_PtclScaleX ("ParticleScaleX", Float) = 1
_PtclScaleY ("ParticleScaleY", Float) = 1
_PtclScaleRnd ("ParticleScaleRnd", Float) = 1
_BoxSize ("BoxSize", Vector) = (10,10,10,0)
_Speed ("Speed", Vector) = (0,0,0,0)
_RotSpeed ("RotSpeed", Vector) = (0,0,0,0)
_SinCycle ("Sin Cycle", Vector) = (1,1,1,0)
_SinAmp ("Sin Amplitude", Vector) = (1,1,1,0)
_CamNearFadeAlphaZeroDist ("Camera Near Alpha Zero Distance", Float) = 1
_CamNearFadeAlphaOneDist ("Camera Near Alpha One Distance", Float) = 1
_CamFarFadeAlphaZeroDist ("Camera Far Alpha Zero Distance", Float) = 1000
_CamFarFadeAlphaOneDist ("Camera Far Alpha One Distance", Float) = 1000
_CamScaleLimitDist ("Camera Scale Limit Distance", Float) = 1
_BoxEdgeFadeXZ ("BoxEdgeFade XZ", Range(0, 1)) = 0.1
_BoxEdgeFadeY ("BoxEdgeFade Y", Range(0, 1)) = 0.1
}
SubShader {
 LOD 100
 Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 15590
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	int _TileX;
uniform 	int _TileY;
uniform 	float _PtclScaleX;
uniform 	float _PtclScaleY;
uniform 	float _PtclScaleRnd;
uniform 	vec4 _BoxSize;
uniform 	vec4 _Speed;
uniform 	vec4 _RotSpeed;
uniform 	vec4 _SinCycle;
uniform 	vec4 _SinAmp;
uniform 	float _CamNearFadeAlphaZeroDist;
uniform 	float _CamNearFadeAlphaOneDist;
uniform 	float _CamFarFadeAlphaZeroDist;
uniform 	float _CamFarFadeAlphaOneDist;
uniform 	float _CamScaleLimitDist;
uniform 	float _BoxEdgeFadeXZ;
uniform 	float _BoxEdgeFadeY;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec4 u_xlat8;
vec2 u_xlat9;
vec2 u_xlat18;
float u_xlat27;
float u_xlat28;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat18.xy = vec2(ivec2(_TileX, _TileY));
    u_xlat0.xy = u_xlat0.xy / u_xlat18.xy;
    u_xlat18.xy = u_xlat18.xy * in_TEXCOORD0.xy;
    u_xlat18.xy = trunc(u_xlat18.xy);
    u_xlat0.xy = u_xlat18.xy * vec2(0.5, 0.5) + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.z = in_TEXCOORD1.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(10.0, 10.0, 10.0);
    u_xlat27 = (-_Speed.w) * in_TEXCOORD0.x + 1.0;
    u_xlat1.xyz = vec3(u_xlat27) * _Speed.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _Time.yyy;
    u_xlat27 = _BoxSize.y + _BoxSize.x;
    u_xlat27 = u_xlat27 + _BoxSize.z;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat1.xyz;
    u_xlat27 = (-_SinCycle.w) * in_TEXCOORD1.x + 1.0;
    u_xlat1.xyz = vec3(u_xlat27) * _SinCycle.xyz;
    u_xlat27 = in_TEXCOORD0.x + _Time.y;
    u_xlat28 = in_TEXCOORD0.y + in_TEXCOORD0.x;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27) + vec3(u_xlat28);
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat27 = (-_SinAmp.w) * in_TEXCOORD1.y + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * _SinAmp.xyz;
    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz / _BoxSize.xyz;
    u_xlat0.xyz = fract(u_xlat0.xyz);
    u_xlat1.xyz = _BoxSize.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat1.xyz = u_xlat0.xyz * _BoxSize.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.xyz = -abs(u_xlat0.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ));
    u_xlat0.xyz = u_xlat0.xyz / vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ);
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat28 = min(u_xlat27, _CamScaleLimitDist);
    u_xlat2.xy = vec2(u_xlat27) + (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist));
    u_xlat27 = u_xlat28 / _CamScaleLimitDist;
    u_xlat27 = u_xlat27 + 0.00100000005;
    u_xlat28 = (-_PtclScaleRnd) * in_TEXCOORD1.x + 1.0;
    u_xlat3.xy = in_POSITION0.xy * vec2(_PtclScaleX, _PtclScaleY);
    u_xlat3.z = in_POSITION0.z;
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = (-_RotSpeed.w) * in_TEXCOORD0.y + 1.0;
    u_xlat4.xyz = vec3(u_xlat28) * _RotSpeed.xyz;
    u_xlat28 = in_TEXCOORD1.y + in_TEXCOORD1.x;
    u_xlat28 = u_xlat28 + _Time.y;
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat4.xyz;
    u_xlat5.xyz = cos(u_xlat4.xyz);
    u_xlat4.xyz = sin(u_xlat4.xyz);
    u_xlat28 = u_xlat4.z * u_xlat4.x;
    u_xlat6.xyz = u_xlat5.zzy * u_xlat5.xyx;
    u_xlat7.y = u_xlat28 * u_xlat4.y + u_xlat6.x;
    u_xlat8.z = u_xlat6.x * u_xlat4.y + u_xlat28;
    u_xlat5 = u_xlat4.zxxz * u_xlat5.xyzy;
    u_xlat8.xy = u_xlat5.zx * u_xlat4.yy + (-u_xlat5.xz);
    u_xlat5.x = (-u_xlat4.y);
    u_xlat7.z = u_xlat8.y;
    u_xlat7.x = u_xlat5.w;
    u_xlat4.y = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat8.w = u_xlat6.y;
    u_xlat5.z = u_xlat6.z;
    u_xlat4.z = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = dot(u_xlat3.yzx, u_xlat8.xzw);
    u_xlat1.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat1.xyz;
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat3;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat9.xy = (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist)) + vec2(_CamNearFadeAlphaOneDist, _CamFarFadeAlphaZeroDist);
    u_xlat9.xy = u_xlat2.xy / u_xlat9.xy;
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
    u_xlat18.x = (-u_xlat9.y) + 1.0;
    u_xlat9.x = u_xlat18.x * u_xlat9.x;
    u_xlat0.w = u_xlat0.x * u_xlat9.x;
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_COLOR0 = u_xlat0;
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
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = (-u_xlat10_0) + 1.0;
    u_xlat16_0.w = u_xlat16_1 * _Color.w;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * _Color.xyz;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	int _TileX;
uniform 	int _TileY;
uniform 	float _PtclScaleX;
uniform 	float _PtclScaleY;
uniform 	float _PtclScaleRnd;
uniform 	vec4 _BoxSize;
uniform 	vec4 _Speed;
uniform 	vec4 _RotSpeed;
uniform 	vec4 _SinCycle;
uniform 	vec4 _SinAmp;
uniform 	float _CamNearFadeAlphaZeroDist;
uniform 	float _CamNearFadeAlphaOneDist;
uniform 	float _CamFarFadeAlphaZeroDist;
uniform 	float _CamFarFadeAlphaOneDist;
uniform 	float _CamScaleLimitDist;
uniform 	float _BoxEdgeFadeXZ;
uniform 	float _BoxEdgeFadeY;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec4 u_xlat8;
vec2 u_xlat9;
vec2 u_xlat18;
float u_xlat27;
float u_xlat28;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat18.xy = vec2(ivec2(_TileX, _TileY));
    u_xlat0.xy = u_xlat0.xy / u_xlat18.xy;
    u_xlat18.xy = u_xlat18.xy * in_TEXCOORD0.xy;
    u_xlat18.xy = trunc(u_xlat18.xy);
    u_xlat0.xy = u_xlat18.xy * vec2(0.5, 0.5) + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.z = in_TEXCOORD1.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(10.0, 10.0, 10.0);
    u_xlat27 = (-_Speed.w) * in_TEXCOORD0.x + 1.0;
    u_xlat1.xyz = vec3(u_xlat27) * _Speed.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _Time.yyy;
    u_xlat27 = _BoxSize.y + _BoxSize.x;
    u_xlat27 = u_xlat27 + _BoxSize.z;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat1.xyz;
    u_xlat27 = (-_SinCycle.w) * in_TEXCOORD1.x + 1.0;
    u_xlat1.xyz = vec3(u_xlat27) * _SinCycle.xyz;
    u_xlat27 = in_TEXCOORD0.x + _Time.y;
    u_xlat28 = in_TEXCOORD0.y + in_TEXCOORD0.x;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27) + vec3(u_xlat28);
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat27 = (-_SinAmp.w) * in_TEXCOORD1.y + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * _SinAmp.xyz;
    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz / _BoxSize.xyz;
    u_xlat0.xyz = fract(u_xlat0.xyz);
    u_xlat1.xyz = _BoxSize.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat1.xyz = u_xlat0.xyz * _BoxSize.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.xyz = -abs(u_xlat0.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ));
    u_xlat0.xyz = u_xlat0.xyz / vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ);
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat28 = min(u_xlat27, _CamScaleLimitDist);
    u_xlat2.xy = vec2(u_xlat27) + (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist));
    u_xlat27 = u_xlat28 / _CamScaleLimitDist;
    u_xlat27 = u_xlat27 + 0.00100000005;
    u_xlat28 = (-_PtclScaleRnd) * in_TEXCOORD1.x + 1.0;
    u_xlat3.xy = in_POSITION0.xy * vec2(_PtclScaleX, _PtclScaleY);
    u_xlat3.z = in_POSITION0.z;
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = (-_RotSpeed.w) * in_TEXCOORD0.y + 1.0;
    u_xlat4.xyz = vec3(u_xlat28) * _RotSpeed.xyz;
    u_xlat28 = in_TEXCOORD1.y + in_TEXCOORD1.x;
    u_xlat28 = u_xlat28 + _Time.y;
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat4.xyz;
    u_xlat5.xyz = cos(u_xlat4.xyz);
    u_xlat4.xyz = sin(u_xlat4.xyz);
    u_xlat28 = u_xlat4.z * u_xlat4.x;
    u_xlat6.xyz = u_xlat5.zzy * u_xlat5.xyx;
    u_xlat7.y = u_xlat28 * u_xlat4.y + u_xlat6.x;
    u_xlat8.z = u_xlat6.x * u_xlat4.y + u_xlat28;
    u_xlat5 = u_xlat4.zxxz * u_xlat5.xyzy;
    u_xlat8.xy = u_xlat5.zx * u_xlat4.yy + (-u_xlat5.xz);
    u_xlat5.x = (-u_xlat4.y);
    u_xlat7.z = u_xlat8.y;
    u_xlat7.x = u_xlat5.w;
    u_xlat4.y = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat8.w = u_xlat6.y;
    u_xlat5.z = u_xlat6.z;
    u_xlat4.z = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = dot(u_xlat3.yzx, u_xlat8.xzw);
    u_xlat1.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat1.xyz;
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat3;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat9.xy = (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist)) + vec2(_CamNearFadeAlphaOneDist, _CamFarFadeAlphaZeroDist);
    u_xlat9.xy = u_xlat2.xy / u_xlat9.xy;
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
    u_xlat18.x = (-u_xlat9.y) + 1.0;
    u_xlat9.x = u_xlat18.x * u_xlat9.x;
    u_xlat0.w = u_xlat0.x * u_xlat9.x;
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_COLOR0 = u_xlat0;
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
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = (-u_xlat10_0) + 1.0;
    u_xlat16_0.w = u_xlat16_1 * _Color.w;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * _Color.xyz;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	int _TileX;
uniform 	int _TileY;
uniform 	float _PtclScaleX;
uniform 	float _PtclScaleY;
uniform 	float _PtclScaleRnd;
uniform 	vec4 _BoxSize;
uniform 	vec4 _Speed;
uniform 	vec4 _RotSpeed;
uniform 	vec4 _SinCycle;
uniform 	vec4 _SinAmp;
uniform 	float _CamNearFadeAlphaZeroDist;
uniform 	float _CamNearFadeAlphaOneDist;
uniform 	float _CamFarFadeAlphaZeroDist;
uniform 	float _CamFarFadeAlphaOneDist;
uniform 	float _CamScaleLimitDist;
uniform 	float _BoxEdgeFadeXZ;
uniform 	float _BoxEdgeFadeY;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec4 u_xlat8;
vec2 u_xlat9;
vec2 u_xlat18;
float u_xlat27;
float u_xlat28;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat18.xy = vec2(ivec2(_TileX, _TileY));
    u_xlat0.xy = u_xlat0.xy / u_xlat18.xy;
    u_xlat18.xy = u_xlat18.xy * in_TEXCOORD0.xy;
    u_xlat18.xy = trunc(u_xlat18.xy);
    u_xlat0.xy = u_xlat18.xy * vec2(0.5, 0.5) + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.z = in_TEXCOORD1.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(10.0, 10.0, 10.0);
    u_xlat27 = (-_Speed.w) * in_TEXCOORD0.x + 1.0;
    u_xlat1.xyz = vec3(u_xlat27) * _Speed.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _Time.yyy;
    u_xlat27 = _BoxSize.y + _BoxSize.x;
    u_xlat27 = u_xlat27 + _BoxSize.z;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat1.xyz;
    u_xlat27 = (-_SinCycle.w) * in_TEXCOORD1.x + 1.0;
    u_xlat1.xyz = vec3(u_xlat27) * _SinCycle.xyz;
    u_xlat27 = in_TEXCOORD0.x + _Time.y;
    u_xlat28 = in_TEXCOORD0.y + in_TEXCOORD0.x;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27) + vec3(u_xlat28);
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat27 = (-_SinAmp.w) * in_TEXCOORD1.y + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * _SinAmp.xyz;
    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz / _BoxSize.xyz;
    u_xlat0.xyz = fract(u_xlat0.xyz);
    u_xlat1.xyz = _BoxSize.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat1.xyz = u_xlat0.xyz * _BoxSize.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.xyz = -abs(u_xlat0.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ));
    u_xlat0.xyz = u_xlat0.xyz / vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ);
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat28 = min(u_xlat27, _CamScaleLimitDist);
    u_xlat2.xy = vec2(u_xlat27) + (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist));
    u_xlat27 = u_xlat28 / _CamScaleLimitDist;
    u_xlat27 = u_xlat27 + 0.00100000005;
    u_xlat28 = (-_PtclScaleRnd) * in_TEXCOORD1.x + 1.0;
    u_xlat3.xy = in_POSITION0.xy * vec2(_PtclScaleX, _PtclScaleY);
    u_xlat3.z = in_POSITION0.z;
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = (-_RotSpeed.w) * in_TEXCOORD0.y + 1.0;
    u_xlat4.xyz = vec3(u_xlat28) * _RotSpeed.xyz;
    u_xlat28 = in_TEXCOORD1.y + in_TEXCOORD1.x;
    u_xlat28 = u_xlat28 + _Time.y;
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat4.xyz;
    u_xlat5.xyz = cos(u_xlat4.xyz);
    u_xlat4.xyz = sin(u_xlat4.xyz);
    u_xlat28 = u_xlat4.z * u_xlat4.x;
    u_xlat6.xyz = u_xlat5.zzy * u_xlat5.xyx;
    u_xlat7.y = u_xlat28 * u_xlat4.y + u_xlat6.x;
    u_xlat8.z = u_xlat6.x * u_xlat4.y + u_xlat28;
    u_xlat5 = u_xlat4.zxxz * u_xlat5.xyzy;
    u_xlat8.xy = u_xlat5.zx * u_xlat4.yy + (-u_xlat5.xz);
    u_xlat5.x = (-u_xlat4.y);
    u_xlat7.z = u_xlat8.y;
    u_xlat7.x = u_xlat5.w;
    u_xlat4.y = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat8.w = u_xlat6.y;
    u_xlat5.z = u_xlat6.z;
    u_xlat4.z = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = dot(u_xlat3.yzx, u_xlat8.xzw);
    u_xlat1.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat1.xyz;
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat3;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat9.xy = (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist)) + vec2(_CamNearFadeAlphaOneDist, _CamFarFadeAlphaZeroDist);
    u_xlat9.xy = u_xlat2.xy / u_xlat9.xy;
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
    u_xlat18.x = (-u_xlat9.y) + 1.0;
    u_xlat9.x = u_xlat18.x * u_xlat9.x;
    u_xlat0.w = u_xlat0.x * u_xlat9.x;
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_COLOR0 = u_xlat0;
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
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = (-u_xlat10_0) + 1.0;
    u_xlat16_0.w = u_xlat16_1 * _Color.w;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * _Color.xyz;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	int _TileX;
uniform 	int _TileY;
uniform 	float _PtclScaleX;
uniform 	float _PtclScaleY;
uniform 	float _PtclScaleRnd;
uniform 	vec4 _BoxSize;
uniform 	vec4 _Speed;
uniform 	vec4 _RotSpeed;
uniform 	vec4 _SinCycle;
uniform 	vec4 _SinAmp;
uniform 	float _CamNearFadeAlphaZeroDist;
uniform 	float _CamNearFadeAlphaOneDist;
uniform 	float _CamFarFadeAlphaZeroDist;
uniform 	float _CamFarFadeAlphaOneDist;
uniform 	float _CamScaleLimitDist;
uniform 	float _BoxEdgeFadeXZ;
uniform 	float _BoxEdgeFadeY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec4 u_xlat8;
vec2 u_xlat9;
vec2 u_xlat18;
float u_xlat27;
float u_xlat28;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat18.xy = vec2(ivec2(_TileX, _TileY));
    u_xlat0.xy = u_xlat0.xy / u_xlat18.xy;
    u_xlat18.xy = u_xlat18.xy * in_TEXCOORD0.xy;
    u_xlat18.xy = trunc(u_xlat18.xy);
    u_xlat0.xy = u_xlat18.xy * vec2(0.5, 0.5) + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.z = in_TEXCOORD1.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(10.0, 10.0, 10.0);
    u_xlat27 = (-_Speed.w) * in_TEXCOORD0.x + 1.0;
    u_xlat1.xyz = vec3(u_xlat27) * _Speed.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _Time.yyy;
    u_xlat27 = _BoxSize.y + _BoxSize.x;
    u_xlat27 = u_xlat27 + _BoxSize.z;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat1.xyz;
    u_xlat27 = (-_SinCycle.w) * in_TEXCOORD1.x + 1.0;
    u_xlat1.xyz = vec3(u_xlat27) * _SinCycle.xyz;
    u_xlat27 = in_TEXCOORD0.x + _Time.y;
    u_xlat28 = in_TEXCOORD0.y + in_TEXCOORD0.x;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27) + vec3(u_xlat28);
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat27 = (-_SinAmp.w) * in_TEXCOORD1.y + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * _SinAmp.xyz;
    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz / _BoxSize.xyz;
    u_xlat0.xyz = fract(u_xlat0.xyz);
    u_xlat1.xyz = _BoxSize.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat1.xyz = u_xlat0.xyz * _BoxSize.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.xyz = -abs(u_xlat0.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ));
    u_xlat0.xyz = u_xlat0.xyz / vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat28 = min(u_xlat27, _CamScaleLimitDist);
    u_xlat2.xy = vec2(u_xlat27) + (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist));
    u_xlat27 = u_xlat28 / _CamScaleLimitDist;
    u_xlat27 = u_xlat27 + 0.00100000005;
    u_xlat28 = (-_PtclScaleRnd) * in_TEXCOORD1.x + 1.0;
    u_xlat3.xy = in_POSITION0.xy * vec2(_PtclScaleX, _PtclScaleY);
    u_xlat3.z = in_POSITION0.z;
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = (-_RotSpeed.w) * in_TEXCOORD0.y + 1.0;
    u_xlat4.xyz = vec3(u_xlat28) * _RotSpeed.xyz;
    u_xlat28 = in_TEXCOORD1.y + in_TEXCOORD1.x;
    u_xlat28 = u_xlat28 + _Time.y;
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat4.xyz;
    u_xlat5.xyz = cos(u_xlat4.xyz);
    u_xlat4.xyz = sin(u_xlat4.xyz);
    u_xlat28 = u_xlat4.z * u_xlat4.x;
    u_xlat6.xyz = u_xlat5.zzy * u_xlat5.xyx;
    u_xlat7.y = u_xlat28 * u_xlat4.y + u_xlat6.x;
    u_xlat8.z = u_xlat6.x * u_xlat4.y + u_xlat28;
    u_xlat5 = u_xlat4.zxxz * u_xlat5.xyzy;
    u_xlat8.xy = u_xlat5.zx * u_xlat4.yy + (-u_xlat5.xz);
    u_xlat5.x = (-u_xlat4.y);
    u_xlat7.z = u_xlat8.y;
    u_xlat7.x = u_xlat5.w;
    u_xlat4.y = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat8.w = u_xlat6.y;
    u_xlat5.z = u_xlat6.z;
    u_xlat4.z = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = dot(u_xlat3.yzx, u_xlat8.xzw);
    u_xlat1.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat1.xyz;
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat3;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat9.xy = (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist)) + vec2(_CamNearFadeAlphaOneDist, _CamFarFadeAlphaZeroDist);
    u_xlat9.xy = u_xlat2.xy / u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat18.x = (-u_xlat9.y) + 1.0;
    u_xlat9.x = u_xlat18.x * u_xlat9.x;
    u_xlat0.w = u_xlat0.x * u_xlat9.x;
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_COLOR0 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.x = texture(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.w = u_xlat16_1 * _Color.w;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _Color.xyz;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	int _TileX;
uniform 	int _TileY;
uniform 	float _PtclScaleX;
uniform 	float _PtclScaleY;
uniform 	float _PtclScaleRnd;
uniform 	vec4 _BoxSize;
uniform 	vec4 _Speed;
uniform 	vec4 _RotSpeed;
uniform 	vec4 _SinCycle;
uniform 	vec4 _SinAmp;
uniform 	float _CamNearFadeAlphaZeroDist;
uniform 	float _CamNearFadeAlphaOneDist;
uniform 	float _CamFarFadeAlphaZeroDist;
uniform 	float _CamFarFadeAlphaOneDist;
uniform 	float _CamScaleLimitDist;
uniform 	float _BoxEdgeFadeXZ;
uniform 	float _BoxEdgeFadeY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec4 u_xlat8;
vec2 u_xlat9;
vec2 u_xlat18;
float u_xlat27;
float u_xlat28;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat18.xy = vec2(ivec2(_TileX, _TileY));
    u_xlat0.xy = u_xlat0.xy / u_xlat18.xy;
    u_xlat18.xy = u_xlat18.xy * in_TEXCOORD0.xy;
    u_xlat18.xy = trunc(u_xlat18.xy);
    u_xlat0.xy = u_xlat18.xy * vec2(0.5, 0.5) + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.z = in_TEXCOORD1.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(10.0, 10.0, 10.0);
    u_xlat27 = (-_Speed.w) * in_TEXCOORD0.x + 1.0;
    u_xlat1.xyz = vec3(u_xlat27) * _Speed.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _Time.yyy;
    u_xlat27 = _BoxSize.y + _BoxSize.x;
    u_xlat27 = u_xlat27 + _BoxSize.z;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat1.xyz;
    u_xlat27 = (-_SinCycle.w) * in_TEXCOORD1.x + 1.0;
    u_xlat1.xyz = vec3(u_xlat27) * _SinCycle.xyz;
    u_xlat27 = in_TEXCOORD0.x + _Time.y;
    u_xlat28 = in_TEXCOORD0.y + in_TEXCOORD0.x;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27) + vec3(u_xlat28);
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat27 = (-_SinAmp.w) * in_TEXCOORD1.y + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * _SinAmp.xyz;
    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz / _BoxSize.xyz;
    u_xlat0.xyz = fract(u_xlat0.xyz);
    u_xlat1.xyz = _BoxSize.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat1.xyz = u_xlat0.xyz * _BoxSize.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.xyz = -abs(u_xlat0.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ));
    u_xlat0.xyz = u_xlat0.xyz / vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat28 = min(u_xlat27, _CamScaleLimitDist);
    u_xlat2.xy = vec2(u_xlat27) + (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist));
    u_xlat27 = u_xlat28 / _CamScaleLimitDist;
    u_xlat27 = u_xlat27 + 0.00100000005;
    u_xlat28 = (-_PtclScaleRnd) * in_TEXCOORD1.x + 1.0;
    u_xlat3.xy = in_POSITION0.xy * vec2(_PtclScaleX, _PtclScaleY);
    u_xlat3.z = in_POSITION0.z;
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = (-_RotSpeed.w) * in_TEXCOORD0.y + 1.0;
    u_xlat4.xyz = vec3(u_xlat28) * _RotSpeed.xyz;
    u_xlat28 = in_TEXCOORD1.y + in_TEXCOORD1.x;
    u_xlat28 = u_xlat28 + _Time.y;
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat4.xyz;
    u_xlat5.xyz = cos(u_xlat4.xyz);
    u_xlat4.xyz = sin(u_xlat4.xyz);
    u_xlat28 = u_xlat4.z * u_xlat4.x;
    u_xlat6.xyz = u_xlat5.zzy * u_xlat5.xyx;
    u_xlat7.y = u_xlat28 * u_xlat4.y + u_xlat6.x;
    u_xlat8.z = u_xlat6.x * u_xlat4.y + u_xlat28;
    u_xlat5 = u_xlat4.zxxz * u_xlat5.xyzy;
    u_xlat8.xy = u_xlat5.zx * u_xlat4.yy + (-u_xlat5.xz);
    u_xlat5.x = (-u_xlat4.y);
    u_xlat7.z = u_xlat8.y;
    u_xlat7.x = u_xlat5.w;
    u_xlat4.y = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat8.w = u_xlat6.y;
    u_xlat5.z = u_xlat6.z;
    u_xlat4.z = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = dot(u_xlat3.yzx, u_xlat8.xzw);
    u_xlat1.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat1.xyz;
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat3;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat9.xy = (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist)) + vec2(_CamNearFadeAlphaOneDist, _CamFarFadeAlphaZeroDist);
    u_xlat9.xy = u_xlat2.xy / u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat18.x = (-u_xlat9.y) + 1.0;
    u_xlat9.x = u_xlat18.x * u_xlat9.x;
    u_xlat0.w = u_xlat0.x * u_xlat9.x;
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_COLOR0 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.x = texture(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.w = u_xlat16_1 * _Color.w;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _Color.xyz;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	int _TileX;
uniform 	int _TileY;
uniform 	float _PtclScaleX;
uniform 	float _PtclScaleY;
uniform 	float _PtclScaleRnd;
uniform 	vec4 _BoxSize;
uniform 	vec4 _Speed;
uniform 	vec4 _RotSpeed;
uniform 	vec4 _SinCycle;
uniform 	vec4 _SinAmp;
uniform 	float _CamNearFadeAlphaZeroDist;
uniform 	float _CamNearFadeAlphaOneDist;
uniform 	float _CamFarFadeAlphaZeroDist;
uniform 	float _CamFarFadeAlphaOneDist;
uniform 	float _CamScaleLimitDist;
uniform 	float _BoxEdgeFadeXZ;
uniform 	float _BoxEdgeFadeY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec4 u_xlat8;
vec2 u_xlat9;
vec2 u_xlat18;
float u_xlat27;
float u_xlat28;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat18.xy = vec2(ivec2(_TileX, _TileY));
    u_xlat0.xy = u_xlat0.xy / u_xlat18.xy;
    u_xlat18.xy = u_xlat18.xy * in_TEXCOORD0.xy;
    u_xlat18.xy = trunc(u_xlat18.xy);
    u_xlat0.xy = u_xlat18.xy * vec2(0.5, 0.5) + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.z = in_TEXCOORD1.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(10.0, 10.0, 10.0);
    u_xlat27 = (-_Speed.w) * in_TEXCOORD0.x + 1.0;
    u_xlat1.xyz = vec3(u_xlat27) * _Speed.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _Time.yyy;
    u_xlat27 = _BoxSize.y + _BoxSize.x;
    u_xlat27 = u_xlat27 + _BoxSize.z;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat1.xyz;
    u_xlat27 = (-_SinCycle.w) * in_TEXCOORD1.x + 1.0;
    u_xlat1.xyz = vec3(u_xlat27) * _SinCycle.xyz;
    u_xlat27 = in_TEXCOORD0.x + _Time.y;
    u_xlat28 = in_TEXCOORD0.y + in_TEXCOORD0.x;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27) + vec3(u_xlat28);
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat27 = (-_SinAmp.w) * in_TEXCOORD1.y + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * _SinAmp.xyz;
    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz / _BoxSize.xyz;
    u_xlat0.xyz = fract(u_xlat0.xyz);
    u_xlat1.xyz = _BoxSize.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat1.xyz = u_xlat0.xyz * _BoxSize.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.xyz = -abs(u_xlat0.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ));
    u_xlat0.xyz = u_xlat0.xyz / vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat28 = min(u_xlat27, _CamScaleLimitDist);
    u_xlat2.xy = vec2(u_xlat27) + (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist));
    u_xlat27 = u_xlat28 / _CamScaleLimitDist;
    u_xlat27 = u_xlat27 + 0.00100000005;
    u_xlat28 = (-_PtclScaleRnd) * in_TEXCOORD1.x + 1.0;
    u_xlat3.xy = in_POSITION0.xy * vec2(_PtclScaleX, _PtclScaleY);
    u_xlat3.z = in_POSITION0.z;
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = (-_RotSpeed.w) * in_TEXCOORD0.y + 1.0;
    u_xlat4.xyz = vec3(u_xlat28) * _RotSpeed.xyz;
    u_xlat28 = in_TEXCOORD1.y + in_TEXCOORD1.x;
    u_xlat28 = u_xlat28 + _Time.y;
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat4.xyz;
    u_xlat5.xyz = cos(u_xlat4.xyz);
    u_xlat4.xyz = sin(u_xlat4.xyz);
    u_xlat28 = u_xlat4.z * u_xlat4.x;
    u_xlat6.xyz = u_xlat5.zzy * u_xlat5.xyx;
    u_xlat7.y = u_xlat28 * u_xlat4.y + u_xlat6.x;
    u_xlat8.z = u_xlat6.x * u_xlat4.y + u_xlat28;
    u_xlat5 = u_xlat4.zxxz * u_xlat5.xyzy;
    u_xlat8.xy = u_xlat5.zx * u_xlat4.yy + (-u_xlat5.xz);
    u_xlat5.x = (-u_xlat4.y);
    u_xlat7.z = u_xlat8.y;
    u_xlat7.x = u_xlat5.w;
    u_xlat4.y = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat8.w = u_xlat6.y;
    u_xlat5.z = u_xlat6.z;
    u_xlat4.z = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = dot(u_xlat3.yzx, u_xlat8.xzw);
    u_xlat1.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat1.xyz;
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat3;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat9.xy = (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist)) + vec2(_CamNearFadeAlphaOneDist, _CamFarFadeAlphaZeroDist);
    u_xlat9.xy = u_xlat2.xy / u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat18.x = (-u_xlat9.y) + 1.0;
    u_xlat9.x = u_xlat18.x * u_xlat9.x;
    u_xlat0.w = u_xlat0.x * u_xlat9.x;
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_COLOR0 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.x = texture(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.w = u_xlat16_1 * _Color.w;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _Color.xyz;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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