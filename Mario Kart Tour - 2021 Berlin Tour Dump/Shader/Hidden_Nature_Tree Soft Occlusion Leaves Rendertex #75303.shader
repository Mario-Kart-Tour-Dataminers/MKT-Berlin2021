//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Nature/Tree Soft Occlusion Leaves Rendertex" {
Properties {
_Color ("Main Color", Color) = (1,1,1,0)
_MainTex ("Main Texture", 2D) = "white" { }
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
_HalfOverCutoff ("0.5 / Alpha cutoff", Range(0, 1)) = 1
_BaseLight ("Base Light", Range(0, 1)) = 0.35
_AO ("Amb. Occlusion", Range(0, 10)) = 2.4
_Occlusion ("Dir Occlusion", Range(0, 20)) = 7.5
_TreeInstanceColor ("TreeInstanceColor", Vector) = (1,1,1,1)
_TreeInstanceScale ("TreeInstanceScale", Vector) = (1,1,1,1)
_SquashAmount ("Squash", Float) = 1
}
SubShader {
 Tags { "QUEUE" = "AlphaTest" }
 Pass {
  Tags { "QUEUE" = "AlphaTest" }
  Cull Off
  Lighting On
  GpuProgramID 49758
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _TreeInstanceColor;
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
uniform 	float _Occlusion;
uniform 	float _AO;
uniform 	float _BaseLight;
uniform 	mediump vec4 _Color;
uniform 	vec3 _TerrainTreeLightDirections[4];
uniform 	vec4 _TerrainTreeLightColors[4];
uniform 	float _HalfOverCutoff;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat9 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat9 = u_xlat9 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat9)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat0.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[0].xyz;
    u_xlat0.w = _AO;
    u_xlat0.x = dot(in_TANGENT0, u_xlat0);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x + _BaseLight;
    u_xlat16_2.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat0.xyz = _TerrainTreeLightColors[0].xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[1].xyz;
    u_xlat1.w = _AO;
    u_xlat9 = dot(in_TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + _BaseLight;
    u_xlat0.xyz = _TerrainTreeLightColors[1].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat1.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[2].xyz;
    u_xlat1.w = _AO;
    u_xlat9 = dot(in_TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + _BaseLight;
    u_xlat0.xyz = _TerrainTreeLightColors[2].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat1.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[3].xyz;
    u_xlat1.w = _AO;
    u_xlat9 = dot(in_TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + _BaseLight;
    u_xlat0.xyz = _TerrainTreeLightColors[3].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _TreeInstanceColor.xyz;
    u_xlat0.w = _HalfOverCutoff * 0.5;
    vs_TEXCOORD1 = u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    SV_Target0.xyz = u_xlat10_0.xyz * vs_TEXCOORD1.xyz;
    u_xlatb0 = u_xlat16_1<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _TreeInstanceColor;
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
uniform 	float _Occlusion;
uniform 	float _AO;
uniform 	float _BaseLight;
uniform 	mediump vec4 _Color;
uniform 	vec3 _TerrainTreeLightDirections[4];
uniform 	vec4 _TerrainTreeLightColors[4];
uniform 	float _HalfOverCutoff;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat9 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat9 = u_xlat9 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat9)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat0.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[0].xyz;
    u_xlat0.w = _AO;
    u_xlat0.x = dot(in_TANGENT0, u_xlat0);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x + _BaseLight;
    u_xlat16_2.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat0.xyz = _TerrainTreeLightColors[0].xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[1].xyz;
    u_xlat1.w = _AO;
    u_xlat9 = dot(in_TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + _BaseLight;
    u_xlat0.xyz = _TerrainTreeLightColors[1].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat1.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[2].xyz;
    u_xlat1.w = _AO;
    u_xlat9 = dot(in_TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + _BaseLight;
    u_xlat0.xyz = _TerrainTreeLightColors[2].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat1.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[3].xyz;
    u_xlat1.w = _AO;
    u_xlat9 = dot(in_TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + _BaseLight;
    u_xlat0.xyz = _TerrainTreeLightColors[3].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _TreeInstanceColor.xyz;
    u_xlat0.w = _HalfOverCutoff * 0.5;
    vs_TEXCOORD1 = u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    SV_Target0.xyz = u_xlat10_0.xyz * vs_TEXCOORD1.xyz;
    u_xlatb0 = u_xlat16_1<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _TreeInstanceColor;
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
uniform 	float _Occlusion;
uniform 	float _AO;
uniform 	float _BaseLight;
uniform 	mediump vec4 _Color;
uniform 	vec3 _TerrainTreeLightDirections[4];
uniform 	vec4 _TerrainTreeLightColors[4];
uniform 	float _HalfOverCutoff;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat9 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat9 = u_xlat9 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat9)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat0.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[0].xyz;
    u_xlat0.w = _AO;
    u_xlat0.x = dot(in_TANGENT0, u_xlat0);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x + _BaseLight;
    u_xlat16_2.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat0.xyz = _TerrainTreeLightColors[0].xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[1].xyz;
    u_xlat1.w = _AO;
    u_xlat9 = dot(in_TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + _BaseLight;
    u_xlat0.xyz = _TerrainTreeLightColors[1].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat1.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[2].xyz;
    u_xlat1.w = _AO;
    u_xlat9 = dot(in_TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + _BaseLight;
    u_xlat0.xyz = _TerrainTreeLightColors[2].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat1.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[3].xyz;
    u_xlat1.w = _AO;
    u_xlat9 = dot(in_TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + _BaseLight;
    u_xlat0.xyz = _TerrainTreeLightColors[3].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _TreeInstanceColor.xyz;
    u_xlat0.w = _HalfOverCutoff * 0.5;
    vs_TEXCOORD1 = u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    SV_Target0.xyz = u_xlat10_0.xyz * vs_TEXCOORD1.xyz;
    u_xlatb0 = u_xlat16_1<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _TreeInstanceColor;
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
uniform 	float _Occlusion;
uniform 	float _AO;
uniform 	float _BaseLight;
uniform 	mediump vec4 _Color;
uniform 	vec3 _TerrainTreeLightDirections[4];
uniform 	vec4 _TerrainTreeLightColors[4];
uniform 	float _HalfOverCutoff;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat9 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat9 = u_xlat9 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat9)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat0.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[0].xyz;
    u_xlat0.w = _AO;
    u_xlat0.x = dot(in_TANGENT0, u_xlat0);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x + _BaseLight;
    u_xlat16_2.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat0.xyz = _TerrainTreeLightColors[0].xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[1].xyz;
    u_xlat1.w = _AO;
    u_xlat9 = dot(in_TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + _BaseLight;
    u_xlat0.xyz = _TerrainTreeLightColors[1].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat1.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[2].xyz;
    u_xlat1.w = _AO;
    u_xlat9 = dot(in_TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + _BaseLight;
    u_xlat0.xyz = _TerrainTreeLightColors[2].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat1.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[3].xyz;
    u_xlat1.w = _AO;
    u_xlat9 = dot(in_TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + _BaseLight;
    u_xlat0.xyz = _TerrainTreeLightColors[3].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _TreeInstanceColor.xyz;
    u_xlat0.w = _HalfOverCutoff * 0.5;
    vs_TEXCOORD1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w + (-_Cutoff);
    SV_Target0.xyz = u_xlat16_0.xyz * vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _TreeInstanceColor;
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
uniform 	float _Occlusion;
uniform 	float _AO;
uniform 	float _BaseLight;
uniform 	mediump vec4 _Color;
uniform 	vec3 _TerrainTreeLightDirections[4];
uniform 	vec4 _TerrainTreeLightColors[4];
uniform 	float _HalfOverCutoff;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat9 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat9 = u_xlat9 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat9)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat0.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[0].xyz;
    u_xlat0.w = _AO;
    u_xlat0.x = dot(in_TANGENT0, u_xlat0);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x + _BaseLight;
    u_xlat16_2.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat0.xyz = _TerrainTreeLightColors[0].xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[1].xyz;
    u_xlat1.w = _AO;
    u_xlat9 = dot(in_TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + _BaseLight;
    u_xlat0.xyz = _TerrainTreeLightColors[1].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat1.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[2].xyz;
    u_xlat1.w = _AO;
    u_xlat9 = dot(in_TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + _BaseLight;
    u_xlat0.xyz = _TerrainTreeLightColors[2].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat1.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[3].xyz;
    u_xlat1.w = _AO;
    u_xlat9 = dot(in_TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + _BaseLight;
    u_xlat0.xyz = _TerrainTreeLightColors[3].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _TreeInstanceColor.xyz;
    u_xlat0.w = _HalfOverCutoff * 0.5;
    vs_TEXCOORD1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w + (-_Cutoff);
    SV_Target0.xyz = u_xlat16_0.xyz * vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _TreeInstanceColor;
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
uniform 	float _Occlusion;
uniform 	float _AO;
uniform 	float _BaseLight;
uniform 	mediump vec4 _Color;
uniform 	vec3 _TerrainTreeLightDirections[4];
uniform 	vec4 _TerrainTreeLightColors[4];
uniform 	float _HalfOverCutoff;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat9 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat9 = u_xlat9 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat9)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat0.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[0].xyz;
    u_xlat0.w = _AO;
    u_xlat0.x = dot(in_TANGENT0, u_xlat0);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x + _BaseLight;
    u_xlat16_2.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat0.xyz = _TerrainTreeLightColors[0].xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[1].xyz;
    u_xlat1.w = _AO;
    u_xlat9 = dot(in_TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + _BaseLight;
    u_xlat0.xyz = _TerrainTreeLightColors[1].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat1.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[2].xyz;
    u_xlat1.w = _AO;
    u_xlat9 = dot(in_TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + _BaseLight;
    u_xlat0.xyz = _TerrainTreeLightColors[2].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat1.xyz = vec3(_Occlusion) * _TerrainTreeLightDirections[3].xyz;
    u_xlat1.w = _AO;
    u_xlat9 = dot(in_TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + _BaseLight;
    u_xlat0.xyz = _TerrainTreeLightColors[3].xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _TreeInstanceColor.xyz;
    u_xlat0.w = _HalfOverCutoff * 0.5;
    vs_TEXCOORD1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w + (-_Cutoff);
    SV_Target0.xyz = u_xlat16_0.xyz * vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
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