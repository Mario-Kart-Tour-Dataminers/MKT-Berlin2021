//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Add_CameraLoop" {
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
_CamVecPower ("Camera Vector Power", Float) = 1
_CamNearFadeAlphaZeroDist ("Camera Near Alpha Zero Distance", Float) = 1
_CamNearFadeAlphaOneDist ("Camera Near Alpha One Distance", Float) = 1
_CamFarFadeAlphaZeroDist ("Camera Far Alpha Zero Distance", Float) = 1000
_CamFarFadeAlphaOneDist ("Camera Far Alpha One Distance", Float) = 1000
_CamScaleLimitDist ("Camera Scale Limit Distance", Float) = 1
_BoxEdgeFadeXZ ("BoxEdgeFade XZ", Range(0, 1)) = 0.1
_BoxEdgeFadeY ("BoxEdgeFade Y", Range(0, 1)) = 0.1
_CameraMove ("CameraMove", Vector) = (0,0,0,0)
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 38071
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
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
uniform 	float _CamVecPower;
uniform 	vec4 _CameraMove;
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
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec4 u_xlat6;
vec2 u_xlat7;
vec2 u_xlat14;
float u_xlat21;
float u_xlat22;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat14.xy = vec2(ivec2(_TileX, _TileY));
    u_xlat0.xy = u_xlat0.xy / u_xlat14.xy;
    u_xlat14.xy = u_xlat14.xy * in_TEXCOORD0.xy;
    u_xlat14.xy = trunc(u_xlat14.xy);
    u_xlat0.xy = u_xlat14.xy * vec2(0.5, 0.5) + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _CameraMove.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _CameraMove.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _CameraMove.zzz + u_xlat0.xyz;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat21 = (-_PtclScaleRnd) * in_TEXCOORD1.x + 1.0;
    u_xlat4.xy = in_POSITION0.xy * vec2(_PtclScaleX, _PtclScaleY);
    u_xlat4.z = in_POSITION0.z;
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.yyy;
    u_xlat2.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat4.zzz * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat21 = (-_RotSpeed.w) * in_TEXCOORD0.y + 1.0;
    u_xlat2.xyz = vec3(u_xlat21) * _RotSpeed.xyz;
    u_xlat21 = in_TEXCOORD1.y + in_TEXCOORD1.x;
    u_xlat21 = u_xlat21 + _Time.y;
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xyz = cos(u_xlat2.xyz);
    u_xlat2.xyz = sin(u_xlat2.xyz);
    u_xlat21 = u_xlat2.z * u_xlat2.x;
    u_xlat4.xyz = u_xlat3.zzy * u_xlat3.xyx;
    u_xlat5.y = u_xlat21 * u_xlat2.y + u_xlat4.x;
    u_xlat6.z = u_xlat4.x * u_xlat2.y + u_xlat21;
    u_xlat3 = u_xlat2.zxxz * u_xlat3.xyzy;
    u_xlat6.xy = u_xlat3.zx * u_xlat2.yy + (-u_xlat3.xz);
    u_xlat3.x = (-u_xlat2.y);
    u_xlat5.z = u_xlat6.y;
    u_xlat5.x = u_xlat3.w;
    u_xlat2.y = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat6.w = u_xlat4.y;
    u_xlat3.z = u_xlat4.z;
    u_xlat2.z = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat1.yzx, u_xlat6.xzw);
    u_xlat21 = in_POSITION0.y + in_POSITION0.y;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat21 = u_xlat21 * _CamVecPower;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.z = in_TEXCOORD1.x;
    u_xlat1.xyz = u_xlat1.xyz * vec3(10.0, 10.0, 10.0);
    u_xlat21 = (-_Speed.w) * in_TEXCOORD0.x + 1.0;
    u_xlat2.xyz = vec3(u_xlat21) * _Speed.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _Time.yyy;
    u_xlat21 = _BoxSize.y + _BoxSize.x;
    u_xlat21 = u_xlat21 + _BoxSize.z;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat21 = (-_SinCycle.w) * in_TEXCOORD1.x + 1.0;
    u_xlat2.xyz = vec3(u_xlat21) * _SinCycle.xyz;
    u_xlat21 = in_TEXCOORD0.x + _Time.y;
    u_xlat22 = in_TEXCOORD0.y + in_TEXCOORD0.x;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat21) + vec3(u_xlat22);
    u_xlat2.xyz = sin(u_xlat2.xyz);
    u_xlat21 = (-_SinAmp.w) * in_TEXCOORD1.y + 1.0;
    u_xlat3.xyz = vec3(u_xlat21) * _SinAmp.xyz;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat1.xyz = u_xlat1.xyz / _BoxSize.xyz;
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat2.xyz = _BoxSize.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat2.xyz = u_xlat1.xyz * _BoxSize.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.xyz = -abs(u_xlat1.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ));
    u_xlat1.xyz = u_xlat1.xyz / vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat2.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = min(u_xlat21, _CamScaleLimitDist);
    u_xlat3.xy = vec2(u_xlat21) + (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist));
    u_xlat21 = u_xlat22 / _CamScaleLimitDist;
    u_xlat21 = u_xlat21 + 0.00100000005;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.x = u_xlat1.y * u_xlat1.x;
    u_xlat0.x = u_xlat1.z * u_xlat0.x;
    u_xlat7.xy = (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist)) + vec2(_CamNearFadeAlphaOneDist, _CamFarFadeAlphaZeroDist);
    u_xlat7.xy = u_xlat3.xy / u_xlat7.xy;
    u_xlat7.xy = clamp(u_xlat7.xy, 0.0, 1.0);
    u_xlat14.x = (-u_xlat7.y) + 1.0;
    u_xlat7.x = u_xlat14.x * u_xlat7.x;
    u_xlat0.w = u_xlat0.x * u_xlat7.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
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
uniform 	float _CamVecPower;
uniform 	vec4 _CameraMove;
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
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec4 u_xlat6;
vec2 u_xlat7;
vec2 u_xlat14;
float u_xlat21;
float u_xlat22;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat14.xy = vec2(ivec2(_TileX, _TileY));
    u_xlat0.xy = u_xlat0.xy / u_xlat14.xy;
    u_xlat14.xy = u_xlat14.xy * in_TEXCOORD0.xy;
    u_xlat14.xy = trunc(u_xlat14.xy);
    u_xlat0.xy = u_xlat14.xy * vec2(0.5, 0.5) + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _CameraMove.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _CameraMove.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _CameraMove.zzz + u_xlat0.xyz;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat21 = (-_PtclScaleRnd) * in_TEXCOORD1.x + 1.0;
    u_xlat4.xy = in_POSITION0.xy * vec2(_PtclScaleX, _PtclScaleY);
    u_xlat4.z = in_POSITION0.z;
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.yyy;
    u_xlat2.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat4.zzz * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat21 = (-_RotSpeed.w) * in_TEXCOORD0.y + 1.0;
    u_xlat2.xyz = vec3(u_xlat21) * _RotSpeed.xyz;
    u_xlat21 = in_TEXCOORD1.y + in_TEXCOORD1.x;
    u_xlat21 = u_xlat21 + _Time.y;
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xyz = cos(u_xlat2.xyz);
    u_xlat2.xyz = sin(u_xlat2.xyz);
    u_xlat21 = u_xlat2.z * u_xlat2.x;
    u_xlat4.xyz = u_xlat3.zzy * u_xlat3.xyx;
    u_xlat5.y = u_xlat21 * u_xlat2.y + u_xlat4.x;
    u_xlat6.z = u_xlat4.x * u_xlat2.y + u_xlat21;
    u_xlat3 = u_xlat2.zxxz * u_xlat3.xyzy;
    u_xlat6.xy = u_xlat3.zx * u_xlat2.yy + (-u_xlat3.xz);
    u_xlat3.x = (-u_xlat2.y);
    u_xlat5.z = u_xlat6.y;
    u_xlat5.x = u_xlat3.w;
    u_xlat2.y = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat6.w = u_xlat4.y;
    u_xlat3.z = u_xlat4.z;
    u_xlat2.z = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat1.yzx, u_xlat6.xzw);
    u_xlat21 = in_POSITION0.y + in_POSITION0.y;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat21 = u_xlat21 * _CamVecPower;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.z = in_TEXCOORD1.x;
    u_xlat1.xyz = u_xlat1.xyz * vec3(10.0, 10.0, 10.0);
    u_xlat21 = (-_Speed.w) * in_TEXCOORD0.x + 1.0;
    u_xlat2.xyz = vec3(u_xlat21) * _Speed.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _Time.yyy;
    u_xlat21 = _BoxSize.y + _BoxSize.x;
    u_xlat21 = u_xlat21 + _BoxSize.z;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat21 = (-_SinCycle.w) * in_TEXCOORD1.x + 1.0;
    u_xlat2.xyz = vec3(u_xlat21) * _SinCycle.xyz;
    u_xlat21 = in_TEXCOORD0.x + _Time.y;
    u_xlat22 = in_TEXCOORD0.y + in_TEXCOORD0.x;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat21) + vec3(u_xlat22);
    u_xlat2.xyz = sin(u_xlat2.xyz);
    u_xlat21 = (-_SinAmp.w) * in_TEXCOORD1.y + 1.0;
    u_xlat3.xyz = vec3(u_xlat21) * _SinAmp.xyz;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat1.xyz = u_xlat1.xyz / _BoxSize.xyz;
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat2.xyz = _BoxSize.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat2.xyz = u_xlat1.xyz * _BoxSize.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.xyz = -abs(u_xlat1.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ));
    u_xlat1.xyz = u_xlat1.xyz / vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat2.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = min(u_xlat21, _CamScaleLimitDist);
    u_xlat3.xy = vec2(u_xlat21) + (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist));
    u_xlat21 = u_xlat22 / _CamScaleLimitDist;
    u_xlat21 = u_xlat21 + 0.00100000005;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.x = u_xlat1.y * u_xlat1.x;
    u_xlat0.x = u_xlat1.z * u_xlat0.x;
    u_xlat7.xy = (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist)) + vec2(_CamNearFadeAlphaOneDist, _CamFarFadeAlphaZeroDist);
    u_xlat7.xy = u_xlat3.xy / u_xlat7.xy;
    u_xlat7.xy = clamp(u_xlat7.xy, 0.0, 1.0);
    u_xlat14.x = (-u_xlat7.y) + 1.0;
    u_xlat7.x = u_xlat14.x * u_xlat7.x;
    u_xlat0.w = u_xlat0.x * u_xlat7.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
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
uniform 	float _CamVecPower;
uniform 	vec4 _CameraMove;
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
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec4 u_xlat6;
vec2 u_xlat7;
vec2 u_xlat14;
float u_xlat21;
float u_xlat22;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat14.xy = vec2(ivec2(_TileX, _TileY));
    u_xlat0.xy = u_xlat0.xy / u_xlat14.xy;
    u_xlat14.xy = u_xlat14.xy * in_TEXCOORD0.xy;
    u_xlat14.xy = trunc(u_xlat14.xy);
    u_xlat0.xy = u_xlat14.xy * vec2(0.5, 0.5) + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _CameraMove.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _CameraMove.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _CameraMove.zzz + u_xlat0.xyz;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat21 = (-_PtclScaleRnd) * in_TEXCOORD1.x + 1.0;
    u_xlat4.xy = in_POSITION0.xy * vec2(_PtclScaleX, _PtclScaleY);
    u_xlat4.z = in_POSITION0.z;
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.yyy;
    u_xlat2.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat4.zzz * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat21 = (-_RotSpeed.w) * in_TEXCOORD0.y + 1.0;
    u_xlat2.xyz = vec3(u_xlat21) * _RotSpeed.xyz;
    u_xlat21 = in_TEXCOORD1.y + in_TEXCOORD1.x;
    u_xlat21 = u_xlat21 + _Time.y;
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xyz = cos(u_xlat2.xyz);
    u_xlat2.xyz = sin(u_xlat2.xyz);
    u_xlat21 = u_xlat2.z * u_xlat2.x;
    u_xlat4.xyz = u_xlat3.zzy * u_xlat3.xyx;
    u_xlat5.y = u_xlat21 * u_xlat2.y + u_xlat4.x;
    u_xlat6.z = u_xlat4.x * u_xlat2.y + u_xlat21;
    u_xlat3 = u_xlat2.zxxz * u_xlat3.xyzy;
    u_xlat6.xy = u_xlat3.zx * u_xlat2.yy + (-u_xlat3.xz);
    u_xlat3.x = (-u_xlat2.y);
    u_xlat5.z = u_xlat6.y;
    u_xlat5.x = u_xlat3.w;
    u_xlat2.y = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat6.w = u_xlat4.y;
    u_xlat3.z = u_xlat4.z;
    u_xlat2.z = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat1.yzx, u_xlat6.xzw);
    u_xlat21 = in_POSITION0.y + in_POSITION0.y;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat21 = u_xlat21 * _CamVecPower;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.z = in_TEXCOORD1.x;
    u_xlat1.xyz = u_xlat1.xyz * vec3(10.0, 10.0, 10.0);
    u_xlat21 = (-_Speed.w) * in_TEXCOORD0.x + 1.0;
    u_xlat2.xyz = vec3(u_xlat21) * _Speed.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _Time.yyy;
    u_xlat21 = _BoxSize.y + _BoxSize.x;
    u_xlat21 = u_xlat21 + _BoxSize.z;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat21 = (-_SinCycle.w) * in_TEXCOORD1.x + 1.0;
    u_xlat2.xyz = vec3(u_xlat21) * _SinCycle.xyz;
    u_xlat21 = in_TEXCOORD0.x + _Time.y;
    u_xlat22 = in_TEXCOORD0.y + in_TEXCOORD0.x;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat21) + vec3(u_xlat22);
    u_xlat2.xyz = sin(u_xlat2.xyz);
    u_xlat21 = (-_SinAmp.w) * in_TEXCOORD1.y + 1.0;
    u_xlat3.xyz = vec3(u_xlat21) * _SinAmp.xyz;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat1.xyz = u_xlat1.xyz / _BoxSize.xyz;
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat2.xyz = _BoxSize.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat2.xyz = u_xlat1.xyz * _BoxSize.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.xyz = -abs(u_xlat1.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ));
    u_xlat1.xyz = u_xlat1.xyz / vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat2.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = min(u_xlat21, _CamScaleLimitDist);
    u_xlat3.xy = vec2(u_xlat21) + (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist));
    u_xlat21 = u_xlat22 / _CamScaleLimitDist;
    u_xlat21 = u_xlat21 + 0.00100000005;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.x = u_xlat1.y * u_xlat1.x;
    u_xlat0.x = u_xlat1.z * u_xlat0.x;
    u_xlat7.xy = (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist)) + vec2(_CamNearFadeAlphaOneDist, _CamFarFadeAlphaZeroDist);
    u_xlat7.xy = u_xlat3.xy / u_xlat7.xy;
    u_xlat7.xy = clamp(u_xlat7.xy, 0.0, 1.0);
    u_xlat14.x = (-u_xlat7.y) + 1.0;
    u_xlat7.x = u_xlat14.x * u_xlat7.x;
    u_xlat0.w = u_xlat0.x * u_xlat7.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
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
uniform 	float _CamVecPower;
uniform 	vec4 _CameraMove;
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
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec4 u_xlat6;
vec2 u_xlat7;
vec2 u_xlat14;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat14.xy = vec2(ivec2(_TileX, _TileY));
    u_xlat0.xy = u_xlat0.xy / u_xlat14.xy;
    u_xlat14.xy = u_xlat14.xy * in_TEXCOORD0.xy;
    u_xlat14.xy = trunc(u_xlat14.xy);
    u_xlat0.xy = u_xlat14.xy * vec2(0.5, 0.5) + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _CameraMove.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _CameraMove.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _CameraMove.zzz + u_xlat0.xyz;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat21 = (-_PtclScaleRnd) * in_TEXCOORD1.x + 1.0;
    u_xlat4.xy = in_POSITION0.xy * vec2(_PtclScaleX, _PtclScaleY);
    u_xlat4.z = in_POSITION0.z;
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.yyy;
    u_xlat2.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat4.zzz * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat21 = (-_RotSpeed.w) * in_TEXCOORD0.y + 1.0;
    u_xlat2.xyz = vec3(u_xlat21) * _RotSpeed.xyz;
    u_xlat21 = in_TEXCOORD1.y + in_TEXCOORD1.x;
    u_xlat21 = u_xlat21 + _Time.y;
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xyz = cos(u_xlat2.xyz);
    u_xlat2.xyz = sin(u_xlat2.xyz);
    u_xlat21 = u_xlat2.z * u_xlat2.x;
    u_xlat4.xyz = u_xlat3.zzy * u_xlat3.xyx;
    u_xlat5.y = u_xlat21 * u_xlat2.y + u_xlat4.x;
    u_xlat6.z = u_xlat4.x * u_xlat2.y + u_xlat21;
    u_xlat3 = u_xlat2.zxxz * u_xlat3.xyzy;
    u_xlat6.xy = u_xlat3.zx * u_xlat2.yy + (-u_xlat3.xz);
    u_xlat3.x = (-u_xlat2.y);
    u_xlat5.z = u_xlat6.y;
    u_xlat5.x = u_xlat3.w;
    u_xlat2.y = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat6.w = u_xlat4.y;
    u_xlat3.z = u_xlat4.z;
    u_xlat2.z = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat1.yzx, u_xlat6.xzw);
    u_xlat21 = in_POSITION0.y + in_POSITION0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat21 = u_xlat21 * _CamVecPower;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.z = in_TEXCOORD1.x;
    u_xlat1.xyz = u_xlat1.xyz * vec3(10.0, 10.0, 10.0);
    u_xlat21 = (-_Speed.w) * in_TEXCOORD0.x + 1.0;
    u_xlat2.xyz = vec3(u_xlat21) * _Speed.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _Time.yyy;
    u_xlat21 = _BoxSize.y + _BoxSize.x;
    u_xlat21 = u_xlat21 + _BoxSize.z;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat21 = (-_SinCycle.w) * in_TEXCOORD1.x + 1.0;
    u_xlat2.xyz = vec3(u_xlat21) * _SinCycle.xyz;
    u_xlat21 = in_TEXCOORD0.x + _Time.y;
    u_xlat22 = in_TEXCOORD0.y + in_TEXCOORD0.x;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat21) + vec3(u_xlat22);
    u_xlat2.xyz = sin(u_xlat2.xyz);
    u_xlat21 = (-_SinAmp.w) * in_TEXCOORD1.y + 1.0;
    u_xlat3.xyz = vec3(u_xlat21) * _SinAmp.xyz;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat1.xyz = u_xlat1.xyz / _BoxSize.xyz;
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat2.xyz = _BoxSize.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat2.xyz = u_xlat1.xyz * _BoxSize.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.xyz = -abs(u_xlat1.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ));
    u_xlat1.xyz = u_xlat1.xyz / vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xyz = min(max(u_xlat1.xyz, 0.0), 1.0);
#else
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat2.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = min(u_xlat21, _CamScaleLimitDist);
    u_xlat3.xy = vec2(u_xlat21) + (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist));
    u_xlat21 = u_xlat22 / _CamScaleLimitDist;
    u_xlat21 = u_xlat21 + 0.00100000005;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.x = u_xlat1.y * u_xlat1.x;
    u_xlat0.x = u_xlat1.z * u_xlat0.x;
    u_xlat7.xy = (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist)) + vec2(_CamNearFadeAlphaOneDist, _CamFarFadeAlphaZeroDist);
    u_xlat7.xy = u_xlat3.xy / u_xlat7.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.xy = min(max(u_xlat7.xy, 0.0), 1.0);
#else
    u_xlat7.xy = clamp(u_xlat7.xy, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.y) + 1.0;
    u_xlat7.x = u_xlat14.x * u_xlat7.x;
    u_xlat0.w = u_xlat0.x * u_xlat7.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
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
uniform 	float _CamVecPower;
uniform 	vec4 _CameraMove;
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
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec4 u_xlat6;
vec2 u_xlat7;
vec2 u_xlat14;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat14.xy = vec2(ivec2(_TileX, _TileY));
    u_xlat0.xy = u_xlat0.xy / u_xlat14.xy;
    u_xlat14.xy = u_xlat14.xy * in_TEXCOORD0.xy;
    u_xlat14.xy = trunc(u_xlat14.xy);
    u_xlat0.xy = u_xlat14.xy * vec2(0.5, 0.5) + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _CameraMove.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _CameraMove.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _CameraMove.zzz + u_xlat0.xyz;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat21 = (-_PtclScaleRnd) * in_TEXCOORD1.x + 1.0;
    u_xlat4.xy = in_POSITION0.xy * vec2(_PtclScaleX, _PtclScaleY);
    u_xlat4.z = in_POSITION0.z;
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.yyy;
    u_xlat2.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat4.zzz * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat21 = (-_RotSpeed.w) * in_TEXCOORD0.y + 1.0;
    u_xlat2.xyz = vec3(u_xlat21) * _RotSpeed.xyz;
    u_xlat21 = in_TEXCOORD1.y + in_TEXCOORD1.x;
    u_xlat21 = u_xlat21 + _Time.y;
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xyz = cos(u_xlat2.xyz);
    u_xlat2.xyz = sin(u_xlat2.xyz);
    u_xlat21 = u_xlat2.z * u_xlat2.x;
    u_xlat4.xyz = u_xlat3.zzy * u_xlat3.xyx;
    u_xlat5.y = u_xlat21 * u_xlat2.y + u_xlat4.x;
    u_xlat6.z = u_xlat4.x * u_xlat2.y + u_xlat21;
    u_xlat3 = u_xlat2.zxxz * u_xlat3.xyzy;
    u_xlat6.xy = u_xlat3.zx * u_xlat2.yy + (-u_xlat3.xz);
    u_xlat3.x = (-u_xlat2.y);
    u_xlat5.z = u_xlat6.y;
    u_xlat5.x = u_xlat3.w;
    u_xlat2.y = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat6.w = u_xlat4.y;
    u_xlat3.z = u_xlat4.z;
    u_xlat2.z = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat1.yzx, u_xlat6.xzw);
    u_xlat21 = in_POSITION0.y + in_POSITION0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat21 = u_xlat21 * _CamVecPower;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.z = in_TEXCOORD1.x;
    u_xlat1.xyz = u_xlat1.xyz * vec3(10.0, 10.0, 10.0);
    u_xlat21 = (-_Speed.w) * in_TEXCOORD0.x + 1.0;
    u_xlat2.xyz = vec3(u_xlat21) * _Speed.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _Time.yyy;
    u_xlat21 = _BoxSize.y + _BoxSize.x;
    u_xlat21 = u_xlat21 + _BoxSize.z;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat21 = (-_SinCycle.w) * in_TEXCOORD1.x + 1.0;
    u_xlat2.xyz = vec3(u_xlat21) * _SinCycle.xyz;
    u_xlat21 = in_TEXCOORD0.x + _Time.y;
    u_xlat22 = in_TEXCOORD0.y + in_TEXCOORD0.x;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat21) + vec3(u_xlat22);
    u_xlat2.xyz = sin(u_xlat2.xyz);
    u_xlat21 = (-_SinAmp.w) * in_TEXCOORD1.y + 1.0;
    u_xlat3.xyz = vec3(u_xlat21) * _SinAmp.xyz;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat1.xyz = u_xlat1.xyz / _BoxSize.xyz;
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat2.xyz = _BoxSize.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat2.xyz = u_xlat1.xyz * _BoxSize.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.xyz = -abs(u_xlat1.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ));
    u_xlat1.xyz = u_xlat1.xyz / vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xyz = min(max(u_xlat1.xyz, 0.0), 1.0);
#else
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat2.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = min(u_xlat21, _CamScaleLimitDist);
    u_xlat3.xy = vec2(u_xlat21) + (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist));
    u_xlat21 = u_xlat22 / _CamScaleLimitDist;
    u_xlat21 = u_xlat21 + 0.00100000005;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.x = u_xlat1.y * u_xlat1.x;
    u_xlat0.x = u_xlat1.z * u_xlat0.x;
    u_xlat7.xy = (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist)) + vec2(_CamNearFadeAlphaOneDist, _CamFarFadeAlphaZeroDist);
    u_xlat7.xy = u_xlat3.xy / u_xlat7.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.xy = min(max(u_xlat7.xy, 0.0), 1.0);
#else
    u_xlat7.xy = clamp(u_xlat7.xy, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.y) + 1.0;
    u_xlat7.x = u_xlat14.x * u_xlat7.x;
    u_xlat0.w = u_xlat0.x * u_xlat7.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
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
uniform 	float _CamVecPower;
uniform 	vec4 _CameraMove;
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
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec4 u_xlat6;
vec2 u_xlat7;
vec2 u_xlat14;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat14.xy = vec2(ivec2(_TileX, _TileY));
    u_xlat0.xy = u_xlat0.xy / u_xlat14.xy;
    u_xlat14.xy = u_xlat14.xy * in_TEXCOORD0.xy;
    u_xlat14.xy = trunc(u_xlat14.xy);
    u_xlat0.xy = u_xlat14.xy * vec2(0.5, 0.5) + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _CameraMove.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _CameraMove.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _CameraMove.zzz + u_xlat0.xyz;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat21 = (-_PtclScaleRnd) * in_TEXCOORD1.x + 1.0;
    u_xlat4.xy = in_POSITION0.xy * vec2(_PtclScaleX, _PtclScaleY);
    u_xlat4.z = in_POSITION0.z;
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.yyy;
    u_xlat2.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat4.zzz * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat21 = (-_RotSpeed.w) * in_TEXCOORD0.y + 1.0;
    u_xlat2.xyz = vec3(u_xlat21) * _RotSpeed.xyz;
    u_xlat21 = in_TEXCOORD1.y + in_TEXCOORD1.x;
    u_xlat21 = u_xlat21 + _Time.y;
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xyz = cos(u_xlat2.xyz);
    u_xlat2.xyz = sin(u_xlat2.xyz);
    u_xlat21 = u_xlat2.z * u_xlat2.x;
    u_xlat4.xyz = u_xlat3.zzy * u_xlat3.xyx;
    u_xlat5.y = u_xlat21 * u_xlat2.y + u_xlat4.x;
    u_xlat6.z = u_xlat4.x * u_xlat2.y + u_xlat21;
    u_xlat3 = u_xlat2.zxxz * u_xlat3.xyzy;
    u_xlat6.xy = u_xlat3.zx * u_xlat2.yy + (-u_xlat3.xz);
    u_xlat3.x = (-u_xlat2.y);
    u_xlat5.z = u_xlat6.y;
    u_xlat5.x = u_xlat3.w;
    u_xlat2.y = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat6.w = u_xlat4.y;
    u_xlat3.z = u_xlat4.z;
    u_xlat2.z = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat1.yzx, u_xlat6.xzw);
    u_xlat21 = in_POSITION0.y + in_POSITION0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat21 = u_xlat21 * _CamVecPower;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.z = in_TEXCOORD1.x;
    u_xlat1.xyz = u_xlat1.xyz * vec3(10.0, 10.0, 10.0);
    u_xlat21 = (-_Speed.w) * in_TEXCOORD0.x + 1.0;
    u_xlat2.xyz = vec3(u_xlat21) * _Speed.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _Time.yyy;
    u_xlat21 = _BoxSize.y + _BoxSize.x;
    u_xlat21 = u_xlat21 + _BoxSize.z;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat21 = (-_SinCycle.w) * in_TEXCOORD1.x + 1.0;
    u_xlat2.xyz = vec3(u_xlat21) * _SinCycle.xyz;
    u_xlat21 = in_TEXCOORD0.x + _Time.y;
    u_xlat22 = in_TEXCOORD0.y + in_TEXCOORD0.x;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat21) + vec3(u_xlat22);
    u_xlat2.xyz = sin(u_xlat2.xyz);
    u_xlat21 = (-_SinAmp.w) * in_TEXCOORD1.y + 1.0;
    u_xlat3.xyz = vec3(u_xlat21) * _SinAmp.xyz;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat1.xyz = u_xlat1.xyz / _BoxSize.xyz;
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat2.xyz = _BoxSize.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat2.xyz = u_xlat1.xyz * _BoxSize.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.xyz = -abs(u_xlat1.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ));
    u_xlat1.xyz = u_xlat1.xyz / vec3(_BoxEdgeFadeXZ, _BoxEdgeFadeY, _BoxEdgeFadeXZ);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xyz = min(max(u_xlat1.xyz, 0.0), 1.0);
#else
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat2.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = min(u_xlat21, _CamScaleLimitDist);
    u_xlat3.xy = vec2(u_xlat21) + (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist));
    u_xlat21 = u_xlat22 / _CamScaleLimitDist;
    u_xlat21 = u_xlat21 + 0.00100000005;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.x = u_xlat1.y * u_xlat1.x;
    u_xlat0.x = u_xlat1.z * u_xlat0.x;
    u_xlat7.xy = (-vec2(_CamNearFadeAlphaZeroDist, _CamFarFadeAlphaOneDist)) + vec2(_CamNearFadeAlphaOneDist, _CamFarFadeAlphaZeroDist);
    u_xlat7.xy = u_xlat3.xy / u_xlat7.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.xy = min(max(u_xlat7.xy, 0.0), 1.0);
#else
    u_xlat7.xy = clamp(u_xlat7.xy, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.y) + 1.0;
    u_xlat7.x = u_xlat14.x * u_xlat7.x;
    u_xlat0.w = u_xlat0.x * u_xlat7.x;
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