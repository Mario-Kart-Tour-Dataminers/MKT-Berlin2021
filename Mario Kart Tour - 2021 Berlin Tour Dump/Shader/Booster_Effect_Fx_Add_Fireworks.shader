//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Add_Fireworks" {
Properties {
_MainTex ("RGB(UV0)", 2D) = "white" { }
_AlphaTex ("A(UV0)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_TileX ("TileX", Float) = 1
_TileY ("TileY", Float) = 1
_PtclScaleX ("ParticleScaleX", Float) = 1
_PtclScaleY ("ParticleScaleY", Float) = 1
_PtclScaleRnd ("ParticleScaleRnd", Float) = 1
_EmitRadius ("EmitRadius", Float) = 0
_Speed ("Speed", Vector) = (0,0,0,0)
_RndSpeed ("RndSpeed", Float) = 1
_Gravity ("Gravity", Float) = -1
_PtclLife ("Life", Float) = 3
_FinalScale ("FinalScale", Float) = 0
_EmitterTime ("Time", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 53714
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

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
uniform 	float _EmitRadius;
uniform 	vec4 _Speed;
uniform 	float _RndSpeed;
uniform 	float _Gravity;
uniform 	float _PtclLife;
uniform 	float _FinalScale;
uniform 	float _EmitterTime;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
int u_xlati8;
vec2 u_xlat9;
float u_xlat12;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.x = _EmitterTime / _PtclLife;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = min(u_xlat0.xx, vec2(1.0, 0.999000013));
    u_xlati8 = _TileY * _TileX;
    u_xlat8 = float(u_xlati8);
    u_xlat4.x = u_xlat8 * u_xlat0.y;
    u_xlat8 = u_xlat4.x / u_xlat8;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat8 = max(u_xlat8, 0.0);
    u_xlat8 = min(u_xlat8, 0.999000013);
    u_xlat1.xy = vec2(ivec2(_TileX, _TileY));
    u_xlat4.y = u_xlat8 * u_xlat1.y;
    u_xlat4.xy = trunc(u_xlat4.xy);
    u_xlat9.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat9.xy = u_xlat9.xy / u_xlat1.xy;
    u_xlat1.xy = vec2(1.0, 1.0) / u_xlat1.xy;
    u_xlat2.y = u_xlat1.y * u_xlat4.y + u_xlat9.y;
    u_xlat2.x = u_xlat1.x * u_xlat4.x + u_xlat9.x;
    vs_TEXCOORD0.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.x = _FinalScale + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat4.x + 1.0;
    u_xlat4.x = in_TEXCOORD0.y + in_TEXCOORD0.x;
    u_xlat8 = in_TEXCOORD1.y + in_TEXCOORD1.x;
    u_xlat4.x = u_xlat8 + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _PtclScaleRnd;
    u_xlat4.x = (-u_xlat4.x) * 0.25 + 1.0;
    u_xlat1.xy = in_POSITION0.xy * vec2(_PtclScaleX, _PtclScaleY);
    u_xlat1.z = in_POSITION0.z;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat2.xyz = u_xlat0.yyy * u_xlat2.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat3.xyz = u_xlat4.xxx * u_xlat3.xyz;
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.zzz * u_xlat1.xyz + u_xlat0.xyw;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.z = in_TEXCOORD1.x;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = vec3(_RndSpeed) * u_xlat1.xyz + _Speed.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EmitterTime);
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_EmitRadius, _EmitRadius, _EmitRadius));
    u_xlat12 = (-_Speed.w) * in_TEXCOORD1.y + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat12 = _EmitterTime * _EmitterTime;
    u_xlat1.w = u_xlat12 * _Gravity + u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xwz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0.x = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = (-u_xlat10_0.x) + 1.0;
    SV_Target0.w = u_xlat16_1 * _Color.w;
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

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
uniform 	float _EmitRadius;
uniform 	vec4 _Speed;
uniform 	float _RndSpeed;
uniform 	float _Gravity;
uniform 	float _PtclLife;
uniform 	float _FinalScale;
uniform 	float _EmitterTime;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
int u_xlati8;
vec2 u_xlat9;
float u_xlat12;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.x = _EmitterTime / _PtclLife;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = min(u_xlat0.xx, vec2(1.0, 0.999000013));
    u_xlati8 = _TileY * _TileX;
    u_xlat8 = float(u_xlati8);
    u_xlat4.x = u_xlat8 * u_xlat0.y;
    u_xlat8 = u_xlat4.x / u_xlat8;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat8 = max(u_xlat8, 0.0);
    u_xlat8 = min(u_xlat8, 0.999000013);
    u_xlat1.xy = vec2(ivec2(_TileX, _TileY));
    u_xlat4.y = u_xlat8 * u_xlat1.y;
    u_xlat4.xy = trunc(u_xlat4.xy);
    u_xlat9.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat9.xy = u_xlat9.xy / u_xlat1.xy;
    u_xlat1.xy = vec2(1.0, 1.0) / u_xlat1.xy;
    u_xlat2.y = u_xlat1.y * u_xlat4.y + u_xlat9.y;
    u_xlat2.x = u_xlat1.x * u_xlat4.x + u_xlat9.x;
    vs_TEXCOORD0.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.x = _FinalScale + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat4.x + 1.0;
    u_xlat4.x = in_TEXCOORD0.y + in_TEXCOORD0.x;
    u_xlat8 = in_TEXCOORD1.y + in_TEXCOORD1.x;
    u_xlat4.x = u_xlat8 + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _PtclScaleRnd;
    u_xlat4.x = (-u_xlat4.x) * 0.25 + 1.0;
    u_xlat1.xy = in_POSITION0.xy * vec2(_PtclScaleX, _PtclScaleY);
    u_xlat1.z = in_POSITION0.z;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat2.xyz = u_xlat0.yyy * u_xlat2.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat3.xyz = u_xlat4.xxx * u_xlat3.xyz;
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.zzz * u_xlat1.xyz + u_xlat0.xyw;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.z = in_TEXCOORD1.x;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = vec3(_RndSpeed) * u_xlat1.xyz + _Speed.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EmitterTime);
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_EmitRadius, _EmitRadius, _EmitRadius));
    u_xlat12 = (-_Speed.w) * in_TEXCOORD1.y + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat12 = _EmitterTime * _EmitterTime;
    u_xlat1.w = u_xlat12 * _Gravity + u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xwz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0.x = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = (-u_xlat10_0.x) + 1.0;
    SV_Target0.w = u_xlat16_1 * _Color.w;
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

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
uniform 	float _EmitRadius;
uniform 	vec4 _Speed;
uniform 	float _RndSpeed;
uniform 	float _Gravity;
uniform 	float _PtclLife;
uniform 	float _FinalScale;
uniform 	float _EmitterTime;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
int u_xlati8;
vec2 u_xlat9;
float u_xlat12;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.x = _EmitterTime / _PtclLife;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = min(u_xlat0.xx, vec2(1.0, 0.999000013));
    u_xlati8 = _TileY * _TileX;
    u_xlat8 = float(u_xlati8);
    u_xlat4.x = u_xlat8 * u_xlat0.y;
    u_xlat8 = u_xlat4.x / u_xlat8;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat8 = max(u_xlat8, 0.0);
    u_xlat8 = min(u_xlat8, 0.999000013);
    u_xlat1.xy = vec2(ivec2(_TileX, _TileY));
    u_xlat4.y = u_xlat8 * u_xlat1.y;
    u_xlat4.xy = trunc(u_xlat4.xy);
    u_xlat9.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat9.xy = u_xlat9.xy / u_xlat1.xy;
    u_xlat1.xy = vec2(1.0, 1.0) / u_xlat1.xy;
    u_xlat2.y = u_xlat1.y * u_xlat4.y + u_xlat9.y;
    u_xlat2.x = u_xlat1.x * u_xlat4.x + u_xlat9.x;
    vs_TEXCOORD0.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.x = _FinalScale + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat4.x + 1.0;
    u_xlat4.x = in_TEXCOORD0.y + in_TEXCOORD0.x;
    u_xlat8 = in_TEXCOORD1.y + in_TEXCOORD1.x;
    u_xlat4.x = u_xlat8 + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _PtclScaleRnd;
    u_xlat4.x = (-u_xlat4.x) * 0.25 + 1.0;
    u_xlat1.xy = in_POSITION0.xy * vec2(_PtclScaleX, _PtclScaleY);
    u_xlat1.z = in_POSITION0.z;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat2.xyz = u_xlat0.yyy * u_xlat2.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat3.xyz = u_xlat4.xxx * u_xlat3.xyz;
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.zzz * u_xlat1.xyz + u_xlat0.xyw;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.z = in_TEXCOORD1.x;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = vec3(_RndSpeed) * u_xlat1.xyz + _Speed.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EmitterTime);
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_EmitRadius, _EmitRadius, _EmitRadius));
    u_xlat12 = (-_Speed.w) * in_TEXCOORD1.y + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat12 = _EmitterTime * _EmitterTime;
    u_xlat1.w = u_xlat12 * _Gravity + u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xwz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0.x = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = (-u_xlat10_0.x) + 1.0;
    SV_Target0.w = u_xlat16_1 * _Color.w;
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

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
uniform 	float _EmitRadius;
uniform 	vec4 _Speed;
uniform 	float _RndSpeed;
uniform 	float _Gravity;
uniform 	float _PtclLife;
uniform 	float _FinalScale;
uniform 	float _EmitterTime;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
int u_xlati8;
vec2 u_xlat9;
float u_xlat12;
void main()
{
    u_xlat0.x = _EmitterTime / _PtclLife;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = min(u_xlat0.xx, vec2(1.0, 0.999000013));
    u_xlati8 = _TileY * _TileX;
    u_xlat8 = float(u_xlati8);
    u_xlat4.x = u_xlat8 * u_xlat0.y;
    u_xlat8 = u_xlat4.x / u_xlat8;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat8 = max(u_xlat8, 0.0);
    u_xlat8 = min(u_xlat8, 0.999000013);
    u_xlat1.xy = vec2(ivec2(_TileX, _TileY));
    u_xlat4.y = u_xlat8 * u_xlat1.y;
    u_xlat4.xy = trunc(u_xlat4.xy);
    u_xlat9.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat9.xy = u_xlat9.xy / u_xlat1.xy;
    u_xlat1.xy = vec2(1.0, 1.0) / u_xlat1.xy;
    u_xlat2.y = u_xlat1.y * u_xlat4.y + u_xlat9.y;
    u_xlat2.x = u_xlat1.x * u_xlat4.x + u_xlat9.x;
    vs_TEXCOORD0.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.x = _FinalScale + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat4.x + 1.0;
    u_xlat4.x = in_TEXCOORD0.y + in_TEXCOORD0.x;
    u_xlat8 = in_TEXCOORD1.y + in_TEXCOORD1.x;
    u_xlat4.x = u_xlat8 + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _PtclScaleRnd;
    u_xlat4.x = (-u_xlat4.x) * 0.25 + 1.0;
    u_xlat1.xy = in_POSITION0.xy * vec2(_PtclScaleX, _PtclScaleY);
    u_xlat1.z = in_POSITION0.z;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat2.xyz = u_xlat0.yyy * u_xlat2.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat3.xyz = u_xlat4.xxx * u_xlat3.xyz;
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.zzz * u_xlat1.xyz + u_xlat0.xyw;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.z = in_TEXCOORD1.x;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = vec3(_RndSpeed) * u_xlat1.xyz + _Speed.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EmitterTime);
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_EmitRadius, _EmitRadius, _EmitRadius));
    u_xlat12 = (-_Speed.w) * in_TEXCOORD1.y + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat12 = _EmitterTime * _EmitterTime;
    u_xlat1.w = u_xlat12 * _Gravity + u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xwz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0.x = texture(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = (-u_xlat16_0.x) + 1.0;
    SV_Target0.w = u_xlat16_1 * _Color.w;
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

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
uniform 	float _EmitRadius;
uniform 	vec4 _Speed;
uniform 	float _RndSpeed;
uniform 	float _Gravity;
uniform 	float _PtclLife;
uniform 	float _FinalScale;
uniform 	float _EmitterTime;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
int u_xlati8;
vec2 u_xlat9;
float u_xlat12;
void main()
{
    u_xlat0.x = _EmitterTime / _PtclLife;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = min(u_xlat0.xx, vec2(1.0, 0.999000013));
    u_xlati8 = _TileY * _TileX;
    u_xlat8 = float(u_xlati8);
    u_xlat4.x = u_xlat8 * u_xlat0.y;
    u_xlat8 = u_xlat4.x / u_xlat8;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat8 = max(u_xlat8, 0.0);
    u_xlat8 = min(u_xlat8, 0.999000013);
    u_xlat1.xy = vec2(ivec2(_TileX, _TileY));
    u_xlat4.y = u_xlat8 * u_xlat1.y;
    u_xlat4.xy = trunc(u_xlat4.xy);
    u_xlat9.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat9.xy = u_xlat9.xy / u_xlat1.xy;
    u_xlat1.xy = vec2(1.0, 1.0) / u_xlat1.xy;
    u_xlat2.y = u_xlat1.y * u_xlat4.y + u_xlat9.y;
    u_xlat2.x = u_xlat1.x * u_xlat4.x + u_xlat9.x;
    vs_TEXCOORD0.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.x = _FinalScale + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat4.x + 1.0;
    u_xlat4.x = in_TEXCOORD0.y + in_TEXCOORD0.x;
    u_xlat8 = in_TEXCOORD1.y + in_TEXCOORD1.x;
    u_xlat4.x = u_xlat8 + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _PtclScaleRnd;
    u_xlat4.x = (-u_xlat4.x) * 0.25 + 1.0;
    u_xlat1.xy = in_POSITION0.xy * vec2(_PtclScaleX, _PtclScaleY);
    u_xlat1.z = in_POSITION0.z;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat2.xyz = u_xlat0.yyy * u_xlat2.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat3.xyz = u_xlat4.xxx * u_xlat3.xyz;
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.zzz * u_xlat1.xyz + u_xlat0.xyw;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.z = in_TEXCOORD1.x;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = vec3(_RndSpeed) * u_xlat1.xyz + _Speed.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EmitterTime);
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_EmitRadius, _EmitRadius, _EmitRadius));
    u_xlat12 = (-_Speed.w) * in_TEXCOORD1.y + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat12 = _EmitterTime * _EmitterTime;
    u_xlat1.w = u_xlat12 * _Gravity + u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xwz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0.x = texture(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = (-u_xlat16_0.x) + 1.0;
    SV_Target0.w = u_xlat16_1 * _Color.w;
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

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
uniform 	float _EmitRadius;
uniform 	vec4 _Speed;
uniform 	float _RndSpeed;
uniform 	float _Gravity;
uniform 	float _PtclLife;
uniform 	float _FinalScale;
uniform 	float _EmitterTime;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
int u_xlati8;
vec2 u_xlat9;
float u_xlat12;
void main()
{
    u_xlat0.x = _EmitterTime / _PtclLife;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = min(u_xlat0.xx, vec2(1.0, 0.999000013));
    u_xlati8 = _TileY * _TileX;
    u_xlat8 = float(u_xlati8);
    u_xlat4.x = u_xlat8 * u_xlat0.y;
    u_xlat8 = u_xlat4.x / u_xlat8;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat8 = max(u_xlat8, 0.0);
    u_xlat8 = min(u_xlat8, 0.999000013);
    u_xlat1.xy = vec2(ivec2(_TileX, _TileY));
    u_xlat4.y = u_xlat8 * u_xlat1.y;
    u_xlat4.xy = trunc(u_xlat4.xy);
    u_xlat9.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat9.xy = u_xlat9.xy / u_xlat1.xy;
    u_xlat1.xy = vec2(1.0, 1.0) / u_xlat1.xy;
    u_xlat2.y = u_xlat1.y * u_xlat4.y + u_xlat9.y;
    u_xlat2.x = u_xlat1.x * u_xlat4.x + u_xlat9.x;
    vs_TEXCOORD0.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.x = _FinalScale + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat4.x + 1.0;
    u_xlat4.x = in_TEXCOORD0.y + in_TEXCOORD0.x;
    u_xlat8 = in_TEXCOORD1.y + in_TEXCOORD1.x;
    u_xlat4.x = u_xlat8 + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _PtclScaleRnd;
    u_xlat4.x = (-u_xlat4.x) * 0.25 + 1.0;
    u_xlat1.xy = in_POSITION0.xy * vec2(_PtclScaleX, _PtclScaleY);
    u_xlat1.z = in_POSITION0.z;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat2.xyz = u_xlat0.yyy * u_xlat2.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat3.xyz = u_xlat4.xxx * u_xlat3.xyz;
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.zzz * u_xlat1.xyz + u_xlat0.xyw;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.z = in_TEXCOORD1.x;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = vec3(_RndSpeed) * u_xlat1.xyz + _Speed.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EmitterTime);
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_EmitRadius, _EmitRadius, _EmitRadius));
    u_xlat12 = (-_Speed.w) * in_TEXCOORD1.y + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat12 = _EmitterTime * _EmitterTime;
    u_xlat1.w = u_xlat12 * _Gravity + u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xwz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0.x = texture(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = (-u_xlat16_0.x) + 1.0;
    SV_Target0.w = u_xlat16_1 * _Color.w;
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
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