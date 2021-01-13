//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Nature/Tree Soft Occlusion Leaves" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Main Texture", 2D) = "white" { }
_Cutoff ("Alpha cutoff", Range(0.25, 0.9)) = 0.5
_BaseLight ("Base Light", Range(0, 1)) = 0.35
_AO ("Amb. Occlusion", Range(0, 10)) = 2.4
_Occlusion ("Dir Occlusion", Range(0, 20)) = 7.5
_TreeInstanceColor ("TreeInstanceColor", Vector) = (1,1,1,1)
_TreeInstanceScale ("TreeInstanceScale", Vector) = (1,1,1,1)
_SquashAmount ("Squash", Float) = 1
}
SubShader {
 Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TreeTransparentCutout" }
 Pass {
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TreeTransparentCutout" }
  Cull Off
  Lighting On
  GpuProgramID 62944
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	vec4 hlslcc_mtx4x4_CameraToWorld[4];
uniform 	float _HalfOverCutoff;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
float u_xlat16;
float u_xlat18;
int u_xlati19;
float u_xlat20;
bool u_xlatb20;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat18 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat18)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat16_3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat0.w = _AO;
    u_xlat2.xyz = u_xlat16_3.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<4 ; u_xlati_loop_1++)
    {
        u_xlat4.xyz = (-u_xlat1.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat4.w = (-u_xlat4.z);
        u_xlat20 = dot(u_xlat4.xyw, u_xlat4.xyw);
        u_xlat16 = inversesqrt(u_xlat20);
        u_xlat4.xyz = vec3(u_xlat16) * u_xlat4.xyw;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4_CameraToWorld[1].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4_CameraToWorld[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4_CameraToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat20 = u_xlat20 * unity_LightAtten[u_xlati_loop_1].z + 1.0;
        u_xlat20 = float(1.0) / u_xlat20;
        u_xlat0.xyz = u_xlat4.xyz * vec3(_Occlusion);
        u_xlat0.x = dot(in_TANGENT0, u_xlat0);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + _BaseLight;
        u_xlat0.x = u_xlat20 * u_xlat0.x;
        u_xlat2.xyz = unity_LightColor[u_xlati_loop_1].xyz * u_xlat0.xxx + u_xlat2.xyz;
    }
    u_xlat0.xyz = u_xlat2.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _TreeInstanceColor.xyz;
    vs_TEXCOORD0 = in_TEXCOORD0;
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
mediump float u_xlat16_1;
bool u_xlatb2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlatb2 = u_xlat16_1<0.0;
    if(((int(u_xlatb2) * -1))!=0){discard;}
    SV_Target0.xyz = u_xlat10_0.xyz * vs_TEXCOORD1.xyz;
    SV_Target0.w = u_xlat10_0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	vec4 hlslcc_mtx4x4_CameraToWorld[4];
uniform 	float _HalfOverCutoff;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
float u_xlat16;
float u_xlat18;
int u_xlati19;
float u_xlat20;
bool u_xlatb20;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat18 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat18)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat16_3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat0.w = _AO;
    u_xlat2.xyz = u_xlat16_3.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<4 ; u_xlati_loop_1++)
    {
        u_xlat4.xyz = (-u_xlat1.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat4.w = (-u_xlat4.z);
        u_xlat20 = dot(u_xlat4.xyw, u_xlat4.xyw);
        u_xlat16 = inversesqrt(u_xlat20);
        u_xlat4.xyz = vec3(u_xlat16) * u_xlat4.xyw;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4_CameraToWorld[1].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4_CameraToWorld[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4_CameraToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat20 = u_xlat20 * unity_LightAtten[u_xlati_loop_1].z + 1.0;
        u_xlat20 = float(1.0) / u_xlat20;
        u_xlat0.xyz = u_xlat4.xyz * vec3(_Occlusion);
        u_xlat0.x = dot(in_TANGENT0, u_xlat0);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + _BaseLight;
        u_xlat0.x = u_xlat20 * u_xlat0.x;
        u_xlat2.xyz = unity_LightColor[u_xlati_loop_1].xyz * u_xlat0.xxx + u_xlat2.xyz;
    }
    u_xlat0.xyz = u_xlat2.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _TreeInstanceColor.xyz;
    vs_TEXCOORD0 = in_TEXCOORD0;
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
mediump float u_xlat16_1;
bool u_xlatb2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlatb2 = u_xlat16_1<0.0;
    if(((int(u_xlatb2) * -1))!=0){discard;}
    SV_Target0.xyz = u_xlat10_0.xyz * vs_TEXCOORD1.xyz;
    SV_Target0.w = u_xlat10_0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	vec4 hlslcc_mtx4x4_CameraToWorld[4];
uniform 	float _HalfOverCutoff;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
float u_xlat16;
float u_xlat18;
int u_xlati19;
float u_xlat20;
bool u_xlatb20;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat18 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat18)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat16_3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat0.w = _AO;
    u_xlat2.xyz = u_xlat16_3.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<4 ; u_xlati_loop_1++)
    {
        u_xlat4.xyz = (-u_xlat1.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat4.w = (-u_xlat4.z);
        u_xlat20 = dot(u_xlat4.xyw, u_xlat4.xyw);
        u_xlat16 = inversesqrt(u_xlat20);
        u_xlat4.xyz = vec3(u_xlat16) * u_xlat4.xyw;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4_CameraToWorld[1].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4_CameraToWorld[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4_CameraToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat20 = u_xlat20 * unity_LightAtten[u_xlati_loop_1].z + 1.0;
        u_xlat20 = float(1.0) / u_xlat20;
        u_xlat0.xyz = u_xlat4.xyz * vec3(_Occlusion);
        u_xlat0.x = dot(in_TANGENT0, u_xlat0);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + _BaseLight;
        u_xlat0.x = u_xlat20 * u_xlat0.x;
        u_xlat2.xyz = unity_LightColor[u_xlati_loop_1].xyz * u_xlat0.xxx + u_xlat2.xyz;
    }
    u_xlat0.xyz = u_xlat2.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _TreeInstanceColor.xyz;
    vs_TEXCOORD0 = in_TEXCOORD0;
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
mediump float u_xlat16_1;
bool u_xlatb2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlatb2 = u_xlat16_1<0.0;
    if(((int(u_xlatb2) * -1))!=0){discard;}
    SV_Target0.xyz = u_xlat10_0.xyz * vs_TEXCOORD1.xyz;
    SV_Target0.w = u_xlat10_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	vec4 hlslcc_mtx4x4_CameraToWorld[4];
uniform 	float _HalfOverCutoff;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
float u_xlat16;
float u_xlat18;
int u_xlati19;
float u_xlat20;
bool u_xlatb20;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat18 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat18)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat16_3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat0.w = _AO;
    u_xlat2.xyz = u_xlat16_3.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<4 ; u_xlati_loop_1++)
    {
        u_xlat4.xyz = (-u_xlat1.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat4.w = (-u_xlat4.z);
        u_xlat20 = dot(u_xlat4.xyw, u_xlat4.xyw);
        u_xlat16 = inversesqrt(u_xlat20);
        u_xlat4.xyz = vec3(u_xlat16) * u_xlat4.xyw;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4_CameraToWorld[1].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4_CameraToWorld[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4_CameraToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat20 = u_xlat20 * unity_LightAtten[u_xlati_loop_1].z + 1.0;
        u_xlat20 = float(1.0) / u_xlat20;
        u_xlat0.xyz = u_xlat4.xyz * vec3(_Occlusion);
        u_xlat0.x = dot(in_TANGENT0, u_xlat0);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + _BaseLight;
        u_xlat0.x = u_xlat20 * u_xlat0.x;
        u_xlat2.xyz = unity_LightColor[u_xlati_loop_1].xyz * u_xlat0.xxx + u_xlat2.xyz;
    }
    u_xlat0.xyz = u_xlat2.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _TreeInstanceColor.xyz;
    vs_TEXCOORD0 = in_TEXCOORD0;
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
mediump float u_xlat16_1;
bool u_xlatb2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1<0.0);
#else
    u_xlatb2 = u_xlat16_1<0.0;
#endif
    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
    SV_Target0.xyz = u_xlat16_0.xyz * vs_TEXCOORD1.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	vec4 hlslcc_mtx4x4_CameraToWorld[4];
uniform 	float _HalfOverCutoff;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
float u_xlat16;
float u_xlat18;
int u_xlati19;
float u_xlat20;
bool u_xlatb20;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat18 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat18)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat16_3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat0.w = _AO;
    u_xlat2.xyz = u_xlat16_3.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<4 ; u_xlati_loop_1++)
    {
        u_xlat4.xyz = (-u_xlat1.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat4.w = (-u_xlat4.z);
        u_xlat20 = dot(u_xlat4.xyw, u_xlat4.xyw);
        u_xlat16 = inversesqrt(u_xlat20);
        u_xlat4.xyz = vec3(u_xlat16) * u_xlat4.xyw;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4_CameraToWorld[1].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4_CameraToWorld[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4_CameraToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat20 = u_xlat20 * unity_LightAtten[u_xlati_loop_1].z + 1.0;
        u_xlat20 = float(1.0) / u_xlat20;
        u_xlat0.xyz = u_xlat4.xyz * vec3(_Occlusion);
        u_xlat0.x = dot(in_TANGENT0, u_xlat0);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + _BaseLight;
        u_xlat0.x = u_xlat20 * u_xlat0.x;
        u_xlat2.xyz = unity_LightColor[u_xlati_loop_1].xyz * u_xlat0.xxx + u_xlat2.xyz;
    }
    u_xlat0.xyz = u_xlat2.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _TreeInstanceColor.xyz;
    vs_TEXCOORD0 = in_TEXCOORD0;
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
mediump float u_xlat16_1;
bool u_xlatb2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1<0.0);
#else
    u_xlatb2 = u_xlat16_1<0.0;
#endif
    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
    SV_Target0.xyz = u_xlat16_0.xyz * vs_TEXCOORD1.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	vec4 hlslcc_mtx4x4_CameraToWorld[4];
uniform 	float _HalfOverCutoff;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
float u_xlat16;
float u_xlat18;
int u_xlati19;
float u_xlat20;
bool u_xlatb20;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat18 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat18)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat16_3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat0.w = _AO;
    u_xlat2.xyz = u_xlat16_3.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<4 ; u_xlati_loop_1++)
    {
        u_xlat4.xyz = (-u_xlat1.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat4.w = (-u_xlat4.z);
        u_xlat20 = dot(u_xlat4.xyw, u_xlat4.xyw);
        u_xlat16 = inversesqrt(u_xlat20);
        u_xlat4.xyz = vec3(u_xlat16) * u_xlat4.xyw;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4_CameraToWorld[1].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4_CameraToWorld[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4_CameraToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat20 = u_xlat20 * unity_LightAtten[u_xlati_loop_1].z + 1.0;
        u_xlat20 = float(1.0) / u_xlat20;
        u_xlat0.xyz = u_xlat4.xyz * vec3(_Occlusion);
        u_xlat0.x = dot(in_TANGENT0, u_xlat0);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + _BaseLight;
        u_xlat0.x = u_xlat20 * u_xlat0.x;
        u_xlat2.xyz = unity_LightColor[u_xlati_loop_1].xyz * u_xlat0.xxx + u_xlat2.xyz;
    }
    u_xlat0.xyz = u_xlat2.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _TreeInstanceColor.xyz;
    vs_TEXCOORD0 = in_TEXCOORD0;
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
mediump float u_xlat16_1;
bool u_xlatb2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1<0.0);
#else
    u_xlatb2 = u_xlat16_1<0.0;
#endif
    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
    SV_Target0.xyz = u_xlat16_0.xyz * vs_TEXCOORD1.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _TreeInstanceColor;
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
uniform 	float _Occlusion;
uniform 	float _AO;
uniform 	float _BaseLight;
uniform 	mediump vec4 _Color;
uniform 	vec4 hlslcc_mtx4x4_CameraToWorld[4];
uniform 	float _HalfOverCutoff;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
float u_xlat19;
float u_xlat21;
int u_xlati22;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat21 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat21)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat16_3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat2.w = _AO;
    u_xlat4.xyz = u_xlat16_3.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<4 ; u_xlati_loop_1++)
    {
        u_xlat5.xyz = (-u_xlat1.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat5.w = (-u_xlat5.z);
        u_xlat25 = dot(u_xlat5.xyw, u_xlat5.xyw);
        u_xlat19 = inversesqrt(u_xlat25);
        u_xlat5.xyz = vec3(u_xlat19) * u_xlat5.xyw;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4_CameraToWorld[1].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4_CameraToWorld[0].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4_CameraToWorld[2].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat25 = u_xlat25 * unity_LightAtten[u_xlati_loop_1].z + 1.0;
        u_xlat25 = float(1.0) / u_xlat25;
        u_xlat2.xyz = u_xlat5.xyz * vec3(_Occlusion);
        u_xlat2.x = dot(in_TANGENT0, u_xlat2);
        u_xlat2.x = max(u_xlat2.x, 0.0);
        u_xlat2.x = u_xlat2.x + _BaseLight;
        u_xlat2.x = u_xlat25 * u_xlat2.x;
        u_xlat4.xyz = unity_LightColor[u_xlati_loop_1].xyz * u_xlat2.xxx + u_xlat4.xyz;
    }
    u_xlat1.xyz = u_xlat4.xyz * _Color.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _TreeInstanceColor.xyz;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat1.w = _HalfOverCutoff * 0.5;
    vs_TEXCOORD1 = u_xlat1;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat11;
void main()
{
    u_xlat0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat0.w + (-_Cutoff);
    u_xlatb2 = u_xlat16_1<0.0;
    if(((int(u_xlatb2) * -1))!=0){discard;}
    u_xlat2.xyz = u_xlat0.xyz * vs_TEXCOORD1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD2;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _TreeInstanceColor;
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
uniform 	float _Occlusion;
uniform 	float _AO;
uniform 	float _BaseLight;
uniform 	mediump vec4 _Color;
uniform 	vec4 hlslcc_mtx4x4_CameraToWorld[4];
uniform 	float _HalfOverCutoff;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
float u_xlat19;
float u_xlat21;
int u_xlati22;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat21 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat21)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat16_3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat2.w = _AO;
    u_xlat4.xyz = u_xlat16_3.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<4 ; u_xlati_loop_1++)
    {
        u_xlat5.xyz = (-u_xlat1.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat5.w = (-u_xlat5.z);
        u_xlat25 = dot(u_xlat5.xyw, u_xlat5.xyw);
        u_xlat19 = inversesqrt(u_xlat25);
        u_xlat5.xyz = vec3(u_xlat19) * u_xlat5.xyw;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4_CameraToWorld[1].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4_CameraToWorld[0].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4_CameraToWorld[2].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat25 = u_xlat25 * unity_LightAtten[u_xlati_loop_1].z + 1.0;
        u_xlat25 = float(1.0) / u_xlat25;
        u_xlat2.xyz = u_xlat5.xyz * vec3(_Occlusion);
        u_xlat2.x = dot(in_TANGENT0, u_xlat2);
        u_xlat2.x = max(u_xlat2.x, 0.0);
        u_xlat2.x = u_xlat2.x + _BaseLight;
        u_xlat2.x = u_xlat25 * u_xlat2.x;
        u_xlat4.xyz = unity_LightColor[u_xlati_loop_1].xyz * u_xlat2.xxx + u_xlat4.xyz;
    }
    u_xlat1.xyz = u_xlat4.xyz * _Color.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _TreeInstanceColor.xyz;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat1.w = _HalfOverCutoff * 0.5;
    vs_TEXCOORD1 = u_xlat1;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat11;
void main()
{
    u_xlat0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat0.w + (-_Cutoff);
    u_xlatb2 = u_xlat16_1<0.0;
    if(((int(u_xlatb2) * -1))!=0){discard;}
    u_xlat2.xyz = u_xlat0.xyz * vs_TEXCOORD1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD2;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _TreeInstanceColor;
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
uniform 	float _Occlusion;
uniform 	float _AO;
uniform 	float _BaseLight;
uniform 	mediump vec4 _Color;
uniform 	vec4 hlslcc_mtx4x4_CameraToWorld[4];
uniform 	float _HalfOverCutoff;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
float u_xlat19;
float u_xlat21;
int u_xlati22;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat21 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat21)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat16_3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat2.w = _AO;
    u_xlat4.xyz = u_xlat16_3.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<4 ; u_xlati_loop_1++)
    {
        u_xlat5.xyz = (-u_xlat1.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat5.w = (-u_xlat5.z);
        u_xlat25 = dot(u_xlat5.xyw, u_xlat5.xyw);
        u_xlat19 = inversesqrt(u_xlat25);
        u_xlat5.xyz = vec3(u_xlat19) * u_xlat5.xyw;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4_CameraToWorld[1].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4_CameraToWorld[0].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4_CameraToWorld[2].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat25 = u_xlat25 * unity_LightAtten[u_xlati_loop_1].z + 1.0;
        u_xlat25 = float(1.0) / u_xlat25;
        u_xlat2.xyz = u_xlat5.xyz * vec3(_Occlusion);
        u_xlat2.x = dot(in_TANGENT0, u_xlat2);
        u_xlat2.x = max(u_xlat2.x, 0.0);
        u_xlat2.x = u_xlat2.x + _BaseLight;
        u_xlat2.x = u_xlat25 * u_xlat2.x;
        u_xlat4.xyz = unity_LightColor[u_xlati_loop_1].xyz * u_xlat2.xxx + u_xlat4.xyz;
    }
    u_xlat1.xyz = u_xlat4.xyz * _Color.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _TreeInstanceColor.xyz;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat1.w = _HalfOverCutoff * 0.5;
    vs_TEXCOORD1 = u_xlat1;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat11;
void main()
{
    u_xlat0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat0.w + (-_Cutoff);
    u_xlatb2 = u_xlat16_1<0.0;
    if(((int(u_xlatb2) * -1))!=0){discard;}
    u_xlat2.xyz = u_xlat0.xyz * vs_TEXCOORD1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD2;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _TreeInstanceColor;
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
uniform 	float _Occlusion;
uniform 	float _AO;
uniform 	float _BaseLight;
uniform 	mediump vec4 _Color;
uniform 	vec4 hlslcc_mtx4x4_CameraToWorld[4];
uniform 	float _HalfOverCutoff;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
float u_xlat19;
float u_xlat21;
int u_xlati22;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat21 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat21)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat16_3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat2.w = _AO;
    u_xlat4.xyz = u_xlat16_3.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<4 ; u_xlati_loop_1++)
    {
        u_xlat5.xyz = (-u_xlat1.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat5.w = (-u_xlat5.z);
        u_xlat25 = dot(u_xlat5.xyw, u_xlat5.xyw);
        u_xlat19 = inversesqrt(u_xlat25);
        u_xlat5.xyz = vec3(u_xlat19) * u_xlat5.xyw;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4_CameraToWorld[1].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4_CameraToWorld[0].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4_CameraToWorld[2].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat25 = u_xlat25 * unity_LightAtten[u_xlati_loop_1].z + 1.0;
        u_xlat25 = float(1.0) / u_xlat25;
        u_xlat2.xyz = u_xlat5.xyz * vec3(_Occlusion);
        u_xlat2.x = dot(in_TANGENT0, u_xlat2);
        u_xlat2.x = max(u_xlat2.x, 0.0);
        u_xlat2.x = u_xlat2.x + _BaseLight;
        u_xlat2.x = u_xlat25 * u_xlat2.x;
        u_xlat4.xyz = unity_LightColor[u_xlati_loop_1].xyz * u_xlat2.xxx + u_xlat4.xyz;
    }
    u_xlat1.xyz = u_xlat4.xyz * _Color.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _TreeInstanceColor.xyz;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat1.w = _HalfOverCutoff * 0.5;
    vs_TEXCOORD1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat11;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1<0.0);
#else
    u_xlatb2 = u_xlat16_1<0.0;
#endif
    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = u_xlat0.xyz * vs_TEXCOORD1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _TreeInstanceColor;
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
uniform 	float _Occlusion;
uniform 	float _AO;
uniform 	float _BaseLight;
uniform 	mediump vec4 _Color;
uniform 	vec4 hlslcc_mtx4x4_CameraToWorld[4];
uniform 	float _HalfOverCutoff;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
float u_xlat19;
float u_xlat21;
int u_xlati22;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat21 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat21)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat16_3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat2.w = _AO;
    u_xlat4.xyz = u_xlat16_3.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<4 ; u_xlati_loop_1++)
    {
        u_xlat5.xyz = (-u_xlat1.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat5.w = (-u_xlat5.z);
        u_xlat25 = dot(u_xlat5.xyw, u_xlat5.xyw);
        u_xlat19 = inversesqrt(u_xlat25);
        u_xlat5.xyz = vec3(u_xlat19) * u_xlat5.xyw;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4_CameraToWorld[1].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4_CameraToWorld[0].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4_CameraToWorld[2].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat25 = u_xlat25 * unity_LightAtten[u_xlati_loop_1].z + 1.0;
        u_xlat25 = float(1.0) / u_xlat25;
        u_xlat2.xyz = u_xlat5.xyz * vec3(_Occlusion);
        u_xlat2.x = dot(in_TANGENT0, u_xlat2);
        u_xlat2.x = max(u_xlat2.x, 0.0);
        u_xlat2.x = u_xlat2.x + _BaseLight;
        u_xlat2.x = u_xlat25 * u_xlat2.x;
        u_xlat4.xyz = unity_LightColor[u_xlati_loop_1].xyz * u_xlat2.xxx + u_xlat4.xyz;
    }
    u_xlat1.xyz = u_xlat4.xyz * _Color.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _TreeInstanceColor.xyz;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat1.w = _HalfOverCutoff * 0.5;
    vs_TEXCOORD1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat11;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1<0.0);
#else
    u_xlatb2 = u_xlat16_1<0.0;
#endif
    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = u_xlat0.xyz * vs_TEXCOORD1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _TreeInstanceColor;
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
uniform 	float _Occlusion;
uniform 	float _AO;
uniform 	float _BaseLight;
uniform 	mediump vec4 _Color;
uniform 	vec4 hlslcc_mtx4x4_CameraToWorld[4];
uniform 	float _HalfOverCutoff;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
float u_xlat19;
float u_xlat21;
int u_xlati22;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat21 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat21)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat16_3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat2.w = _AO;
    u_xlat4.xyz = u_xlat16_3.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<4 ; u_xlati_loop_1++)
    {
        u_xlat5.xyz = (-u_xlat1.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat5.w = (-u_xlat5.z);
        u_xlat25 = dot(u_xlat5.xyw, u_xlat5.xyw);
        u_xlat19 = inversesqrt(u_xlat25);
        u_xlat5.xyz = vec3(u_xlat19) * u_xlat5.xyw;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4_CameraToWorld[1].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4_CameraToWorld[0].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4_CameraToWorld[2].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat25 = u_xlat25 * unity_LightAtten[u_xlati_loop_1].z + 1.0;
        u_xlat25 = float(1.0) / u_xlat25;
        u_xlat2.xyz = u_xlat5.xyz * vec3(_Occlusion);
        u_xlat2.x = dot(in_TANGENT0, u_xlat2);
        u_xlat2.x = max(u_xlat2.x, 0.0);
        u_xlat2.x = u_xlat2.x + _BaseLight;
        u_xlat2.x = u_xlat25 * u_xlat2.x;
        u_xlat4.xyz = unity_LightColor[u_xlati_loop_1].xyz * u_xlat2.xxx + u_xlat4.xyz;
    }
    u_xlat1.xyz = u_xlat4.xyz * _Color.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _TreeInstanceColor.xyz;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat1.w = _HalfOverCutoff * 0.5;
    vs_TEXCOORD1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat11;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1<0.0);
#else
    u_xlatb2 = u_xlat16_1<0.0;
#endif
    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = u_xlat0.xyz * vs_TEXCOORD1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
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
 Pass {
  Name "ShadowCaster"
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "AlphaTest" "RenderType" = "TreeTransparentCutout" "SHADOWSUPPORT" = "true" }
  Cull Off
  GpuProgramID 124597
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat6;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
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
    u_xlat1.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_LightShadowBias.z;
    u_xlat1.xyz = (-u_xlat2.xyz) * u_xlat1.xxx + u_xlat0.xyz;
    u_xlatb10 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
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
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_0 + (-_Cutoff);
    u_xlatb0 = u_xlat16_1<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat6;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
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
    u_xlat1.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_LightShadowBias.z;
    u_xlat1.xyz = (-u_xlat2.xyz) * u_xlat1.xxx + u_xlat0.xyz;
    u_xlatb10 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
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
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_0 + (-_Cutoff);
    u_xlatb0 = u_xlat16_1<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat6;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
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
    u_xlat1.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_LightShadowBias.z;
    u_xlat1.xyz = (-u_xlat2.xyz) * u_xlat1.xxx + u_xlat0.xyz;
    u_xlatb10 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
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
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_0 + (-_Cutoff);
    u_xlatb0 = u_xlat16_1<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat6;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
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
    u_xlat1.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_LightShadowBias.z;
    u_xlat1.xyz = (-u_xlat2.xyz) * u_xlat1.xxx + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb10 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat6;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
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
    u_xlat1.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_LightShadowBias.z;
    u_xlat1.xyz = (-u_xlat2.xyz) * u_xlat1.xxx + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb10 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat6;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
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
    u_xlat1.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_LightShadowBias.z;
    u_xlat1.xyz = (-u_xlat2.xyz) * u_xlat1.xxx + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb10 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat6 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat6 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat6)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz + (-_LightPositionRange.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying highp vec3 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_0 + (-_Cutoff);
    u_xlatb0 = u_xlat16_1<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    SV_Target0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat6 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat6 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat6)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz + (-_LightPositionRange.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying highp vec3 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_0 + (-_Cutoff);
    u_xlatb0 = u_xlat16_1<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    SV_Target0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * _TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _TreeInstanceScale.xyz + u_xlat1.xyz;
    u_xlat0.xyz = in_COLOR0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat6 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat6 + _SquashPlaneNormal.w;
    u_xlat1.xyz = (-vec3(u_xlat6)) * _SquashPlaneNormal.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(_SquashAmount) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz + (-_LightPositionRange.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying highp vec3 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_0 + (-_Cutoff);
    u_xlatb0 = u_xlat16_1<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    SV_Target0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
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
    u_xlat1.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_LightShadowBias.z;
    u_xlat1.xyz = (-u_xlat2.xyz) * u_xlat1.xxx + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb10 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
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
    u_xlat1.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_LightShadowBias.z;
    u_xlat1.xyz = (-u_xlat2.xyz) * u_xlat1.xxx + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb10 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _TreeInstanceScale;
uniform 	vec4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
uniform 	vec4 _SquashPlaneNormal;
uniform 	float _SquashAmount;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
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
    u_xlat1.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_LightShadowBias.z;
    u_xlat1.xyz = (-u_xlat2.xyz) * u_xlat1.xxx + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb10 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
""
}
}
}
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "Vertex" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  Cull Off
  GpuProgramID 148057
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec3 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat1.xyz;
    u_xlat0.z = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, unity_LightPosition[0].xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * unity_LightColor[0].xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_2.xyz = min(u_xlat16_2.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + u_xlat16_2.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[1].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[1].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[2].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[2].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[3].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[3].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[4].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[4].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[5].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[5].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[6].xyz);
    u_xlat16_3.x = dot(u_xlat0.xyz, unity_LightPosition[7].xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[7].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_4.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * unity_LightColor[6].xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_4.xyz;
    vs_COLOR0.xyz = u_xlat16_3.xyz + u_xlat16_2.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat10_0.w<_Cutoff;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_2.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec3 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat1.xyz;
    u_xlat0.z = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, unity_LightPosition[0].xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * unity_LightColor[0].xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_2.xyz = min(u_xlat16_2.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + u_xlat16_2.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[1].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[1].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[2].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[2].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[3].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[3].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[4].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[4].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[5].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[5].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[6].xyz);
    u_xlat16_3.x = dot(u_xlat0.xyz, unity_LightPosition[7].xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[7].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_4.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * unity_LightColor[6].xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_4.xyz;
    vs_COLOR0.xyz = u_xlat16_3.xyz + u_xlat16_2.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat10_0.w<_Cutoff;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_2.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec3 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat1.xyz;
    u_xlat0.z = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, unity_LightPosition[0].xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * unity_LightColor[0].xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_2.xyz = min(u_xlat16_2.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + u_xlat16_2.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[1].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[1].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[2].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[2].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[3].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[3].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[4].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[4].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[5].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[5].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[6].xyz);
    u_xlat16_3.x = dot(u_xlat0.xyz, unity_LightPosition[7].xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[7].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_4.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * unity_LightColor[6].xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_4.xyz;
    vs_COLOR0.xyz = u_xlat16_3.xyz + u_xlat16_2.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat10_0.w<_Cutoff;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_2.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
int u_xlati18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat0.z = dot(u_xlat2.xyz, in_NORMAL0.xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_3.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat16_21 = dot(u_xlat0.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
        u_xlat16_21 = max(u_xlat16_21, 0.0);
        u_xlat16_5.xyz = vec3(u_xlat16_21) * _Color.xyz;
        u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[u_xlati_loop_1].xyz;
        u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.5, 0.5, 0.5);
        u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    }
    vs_COLOR0.xyz = u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.w<_Cutoff);
#else
    u_xlatb1 = u_xlat16_0.w<_Cutoff;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
int u_xlati18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat0.z = dot(u_xlat2.xyz, in_NORMAL0.xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_3.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat16_21 = dot(u_xlat0.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
        u_xlat16_21 = max(u_xlat16_21, 0.0);
        u_xlat16_5.xyz = vec3(u_xlat16_21) * _Color.xyz;
        u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[u_xlati_loop_1].xyz;
        u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.5, 0.5, 0.5);
        u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    }
    vs_COLOR0.xyz = u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.w<_Cutoff);
#else
    u_xlatb1 = u_xlat16_0.w<_Cutoff;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
int u_xlati18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat0.z = dot(u_xlat2.xyz, in_NORMAL0.xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_3.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat16_21 = dot(u_xlat0.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
        u_xlat16_21 = max(u_xlat16_21, 0.0);
        u_xlat16_5.xyz = vec3(u_xlat16_21) * _Color.xyz;
        u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[u_xlati_loop_1].xyz;
        u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.5, 0.5, 0.5);
        u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    }
    vs_COLOR0.xyz = u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.w<_Cutoff);
#else
    u_xlatb1 = u_xlat16_0.w<_Cutoff;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec3 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
bool u_xlatb13;
float u_xlat30;
int u_xlati30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<8 ; u_xlati_loop_1++)
    {
        u_xlat2.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = unity_LightAtten[u_xlati_loop_1].z * u_xlat31 + 1.0;
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
        u_xlatb13 = unity_LightAtten[u_xlati_loop_1].w<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = inversesqrt(u_xlat31);
        u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = u_xlat32 * 0.5;
        u_xlat16_37 = (u_xlatb3) ? 0.0 : u_xlat31;
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_38) * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[u_xlati_loop_1].xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    }
    vs_COLOR0.xyz = u_xlat16_8.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat10_0.w<_Cutoff;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_2.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec3 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
bool u_xlatb13;
float u_xlat30;
int u_xlati30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<8 ; u_xlati_loop_1++)
    {
        u_xlat2.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = unity_LightAtten[u_xlati_loop_1].z * u_xlat31 + 1.0;
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
        u_xlatb13 = unity_LightAtten[u_xlati_loop_1].w<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = inversesqrt(u_xlat31);
        u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = u_xlat32 * 0.5;
        u_xlat16_37 = (u_xlatb3) ? 0.0 : u_xlat31;
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_38) * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[u_xlati_loop_1].xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    }
    vs_COLOR0.xyz = u_xlat16_8.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat10_0.w<_Cutoff;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_2.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec3 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
bool u_xlatb13;
float u_xlat30;
int u_xlati30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<8 ; u_xlati_loop_1++)
    {
        u_xlat2.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = unity_LightAtten[u_xlati_loop_1].z * u_xlat31 + 1.0;
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
        u_xlatb13 = unity_LightAtten[u_xlati_loop_1].w<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = inversesqrt(u_xlat31);
        u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = u_xlat32 * 0.5;
        u_xlat16_37 = (u_xlatb3) ? 0.0 : u_xlat31;
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_38) * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[u_xlati_loop_1].xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    }
    vs_COLOR0.xyz = u_xlat16_8.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat10_0.w<_Cutoff;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_2.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_10;
bool u_xlatb14;
float u_xlat15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightAtten[1].w<u_xlat21);
#else
    u_xlatb22 = unity_LightAtten[1].w<u_xlat21;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_LightPosition[1].w!=0.0);
#else
    u_xlatb2 = unity_LightPosition[1].w!=0.0;
#endif
    u_xlatb22 = u_xlatb22 && u_xlatb2;
    u_xlat2.x = unity_LightAtten[1].z * u_xlat21 + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999997e-07);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = float(1.0) / u_xlat2.x;
    u_xlat21 = u_xlat21 * 0.5;
    u_xlat16_3.x = (u_xlatb22) ? 0.0 : u_xlat21;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
    u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
    u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_10.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlat16_10.xyz = u_xlat16_10.xxx * _Color.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[1].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightAtten[0].w<u_xlat21);
#else
    u_xlatb22 = unity_LightAtten[0].w<u_xlat21;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(unity_LightPosition[0].w!=0.0);
#else
    u_xlatb23 = unity_LightPosition[0].w!=0.0;
#endif
    u_xlatb22 = u_xlatb22 && u_xlatb23;
    u_xlat23 = unity_LightAtten[0].z * u_xlat21 + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999997e-07);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[0].xyz;
    u_xlat21 = float(1.0) / u_xlat23;
    u_xlat21 = u_xlat21 * 0.5;
    u_xlat16_24 = (u_xlatb22) ? 0.0 : u_xlat21;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + u_xlat16_5.xyz;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0<unity_VertexLightParams.x);
#else
    u_xlatb21 = 0<unity_VertexLightParams.x;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb21)) ? u_xlat16_5.xyz : u_xlat16_6.xyz;
    u_xlati21 = u_xlatb21 ? 1 : int(0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb1 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlati21 = (u_xlatb1) ? 2 : u_xlati21;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[2].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[2].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[2].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[2].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[2].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[2].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[3].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[3].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[3].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[3].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[3].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[3].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 3 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[4].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[4].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[4].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[4].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[4].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[4].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 4 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[5].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[5].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[5].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[5].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[5].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[5].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 5 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[6].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[6].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[6].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[6].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[6].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[6].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 6 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = max(u_xlat8.x, 9.99999997e-07);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[7].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_LightAtten[7].w<u_xlat8.x);
#else
    u_xlatb0 = unity_LightAtten[7].w<u_xlat8.x;
#endif
    u_xlat7 = unity_LightAtten[7].z * u_xlat8.x + 1.0;
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat7 = u_xlat7 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(unity_LightPosition[7].w!=0.0);
#else
    u_xlatb14 = unity_LightPosition[7].w!=0.0;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb14;
    u_xlat16_24 = (u_xlatb0) ? 0.0 : u_xlat7;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 7 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb1;
    vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.w<_Cutoff);
#else
    u_xlatb1 = u_xlat16_0.w<_Cutoff;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_10;
bool u_xlatb14;
float u_xlat15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightAtten[1].w<u_xlat21);
#else
    u_xlatb22 = unity_LightAtten[1].w<u_xlat21;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_LightPosition[1].w!=0.0);
#else
    u_xlatb2 = unity_LightPosition[1].w!=0.0;
#endif
    u_xlatb22 = u_xlatb22 && u_xlatb2;
    u_xlat2.x = unity_LightAtten[1].z * u_xlat21 + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999997e-07);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = float(1.0) / u_xlat2.x;
    u_xlat21 = u_xlat21 * 0.5;
    u_xlat16_3.x = (u_xlatb22) ? 0.0 : u_xlat21;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
    u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
    u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_10.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlat16_10.xyz = u_xlat16_10.xxx * _Color.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[1].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightAtten[0].w<u_xlat21);
#else
    u_xlatb22 = unity_LightAtten[0].w<u_xlat21;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(unity_LightPosition[0].w!=0.0);
#else
    u_xlatb23 = unity_LightPosition[0].w!=0.0;
#endif
    u_xlatb22 = u_xlatb22 && u_xlatb23;
    u_xlat23 = unity_LightAtten[0].z * u_xlat21 + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999997e-07);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[0].xyz;
    u_xlat21 = float(1.0) / u_xlat23;
    u_xlat21 = u_xlat21 * 0.5;
    u_xlat16_24 = (u_xlatb22) ? 0.0 : u_xlat21;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + u_xlat16_5.xyz;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0<unity_VertexLightParams.x);
#else
    u_xlatb21 = 0<unity_VertexLightParams.x;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb21)) ? u_xlat16_5.xyz : u_xlat16_6.xyz;
    u_xlati21 = u_xlatb21 ? 1 : int(0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb1 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlati21 = (u_xlatb1) ? 2 : u_xlati21;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[2].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[2].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[2].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[2].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[2].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[2].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[3].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[3].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[3].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[3].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[3].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[3].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 3 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[4].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[4].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[4].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[4].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[4].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[4].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 4 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[5].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[5].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[5].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[5].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[5].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[5].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 5 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[6].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[6].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[6].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[6].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[6].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[6].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 6 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = max(u_xlat8.x, 9.99999997e-07);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[7].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_LightAtten[7].w<u_xlat8.x);
#else
    u_xlatb0 = unity_LightAtten[7].w<u_xlat8.x;
#endif
    u_xlat7 = unity_LightAtten[7].z * u_xlat8.x + 1.0;
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat7 = u_xlat7 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(unity_LightPosition[7].w!=0.0);
#else
    u_xlatb14 = unity_LightPosition[7].w!=0.0;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb14;
    u_xlat16_24 = (u_xlatb0) ? 0.0 : u_xlat7;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 7 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb1;
    vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.w<_Cutoff);
#else
    u_xlatb1 = u_xlat16_0.w<_Cutoff;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_10;
bool u_xlatb14;
float u_xlat15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightAtten[1].w<u_xlat21);
#else
    u_xlatb22 = unity_LightAtten[1].w<u_xlat21;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_LightPosition[1].w!=0.0);
#else
    u_xlatb2 = unity_LightPosition[1].w!=0.0;
#endif
    u_xlatb22 = u_xlatb22 && u_xlatb2;
    u_xlat2.x = unity_LightAtten[1].z * u_xlat21 + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999997e-07);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = float(1.0) / u_xlat2.x;
    u_xlat21 = u_xlat21 * 0.5;
    u_xlat16_3.x = (u_xlatb22) ? 0.0 : u_xlat21;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
    u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
    u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_10.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlat16_10.xyz = u_xlat16_10.xxx * _Color.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[1].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightAtten[0].w<u_xlat21);
#else
    u_xlatb22 = unity_LightAtten[0].w<u_xlat21;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(unity_LightPosition[0].w!=0.0);
#else
    u_xlatb23 = unity_LightPosition[0].w!=0.0;
#endif
    u_xlatb22 = u_xlatb22 && u_xlatb23;
    u_xlat23 = unity_LightAtten[0].z * u_xlat21 + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999997e-07);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[0].xyz;
    u_xlat21 = float(1.0) / u_xlat23;
    u_xlat21 = u_xlat21 * 0.5;
    u_xlat16_24 = (u_xlatb22) ? 0.0 : u_xlat21;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + u_xlat16_5.xyz;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0<unity_VertexLightParams.x);
#else
    u_xlatb21 = 0<unity_VertexLightParams.x;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb21)) ? u_xlat16_5.xyz : u_xlat16_6.xyz;
    u_xlati21 = u_xlatb21 ? 1 : int(0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb1 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlati21 = (u_xlatb1) ? 2 : u_xlati21;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[2].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[2].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[2].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[2].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[2].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[2].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[3].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[3].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[3].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[3].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[3].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[3].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 3 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[4].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[4].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[4].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[4].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[4].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[4].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 4 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[5].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[5].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[5].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[5].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[5].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[5].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 5 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[6].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[6].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[6].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[6].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[6].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[6].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 6 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = max(u_xlat8.x, 9.99999997e-07);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[7].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_LightAtten[7].w<u_xlat8.x);
#else
    u_xlatb0 = unity_LightAtten[7].w<u_xlat8.x;
#endif
    u_xlat7 = unity_LightAtten[7].z * u_xlat8.x + 1.0;
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat7 = u_xlat7 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(unity_LightPosition[7].w!=0.0);
#else
    u_xlatb14 = unity_LightPosition[7].w!=0.0;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb14;
    u_xlat16_24 = (u_xlatb0) ? 0.0 : u_xlat7;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 7 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb1;
    vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.w<_Cutoff);
#else
    u_xlatb1 = u_xlat16_0.w<_Cutoff;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec3 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
bool u_xlatb13;
float u_xlat30;
int u_xlati30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<8 ; u_xlati_loop_1++)
    {
        u_xlat2.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = unity_LightAtten[u_xlati_loop_1].z * u_xlat31 + 1.0;
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
        u_xlatb13 = unity_LightAtten[u_xlati_loop_1].w<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat16_37 = (u_xlatb3) ? 0.0 : u_xlat32;
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = inversesqrt(u_xlat31);
        u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = dot(u_xlat2.xyz, unity_SpotDirection[u_xlati_loop_1].xyz);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat16_38 = u_xlat31 + (-unity_LightAtten[u_xlati_loop_1].x);
        u_xlat16_38 = u_xlat16_38 * unity_LightAtten[u_xlati_loop_1].y;
        u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
        u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
        u_xlat16_37 = u_xlat16_37 * 0.5;
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_38) * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[u_xlati_loop_1].xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    }
    vs_COLOR0.xyz = u_xlat16_8.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat10_0.w<_Cutoff;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_2.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec3 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
bool u_xlatb13;
float u_xlat30;
int u_xlati30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<8 ; u_xlati_loop_1++)
    {
        u_xlat2.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = unity_LightAtten[u_xlati_loop_1].z * u_xlat31 + 1.0;
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
        u_xlatb13 = unity_LightAtten[u_xlati_loop_1].w<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat16_37 = (u_xlatb3) ? 0.0 : u_xlat32;
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = inversesqrt(u_xlat31);
        u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = dot(u_xlat2.xyz, unity_SpotDirection[u_xlati_loop_1].xyz);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat16_38 = u_xlat31 + (-unity_LightAtten[u_xlati_loop_1].x);
        u_xlat16_38 = u_xlat16_38 * unity_LightAtten[u_xlati_loop_1].y;
        u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
        u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
        u_xlat16_37 = u_xlat16_37 * 0.5;
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_38) * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[u_xlati_loop_1].xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    }
    vs_COLOR0.xyz = u_xlat16_8.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat10_0.w<_Cutoff;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_2.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec3 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
bool u_xlatb13;
float u_xlat30;
int u_xlati30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<8 ; u_xlati_loop_1++)
    {
        u_xlat2.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = unity_LightAtten[u_xlati_loop_1].z * u_xlat31 + 1.0;
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
        u_xlatb13 = unity_LightAtten[u_xlati_loop_1].w<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat16_37 = (u_xlatb3) ? 0.0 : u_xlat32;
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = inversesqrt(u_xlat31);
        u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = dot(u_xlat2.xyz, unity_SpotDirection[u_xlati_loop_1].xyz);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat16_38 = u_xlat31 + (-unity_LightAtten[u_xlati_loop_1].x);
        u_xlat16_38 = u_xlat16_38 * unity_LightAtten[u_xlati_loop_1].y;
        u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
        u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
        u_xlat16_37 = u_xlat16_37 * 0.5;
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_38) * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[u_xlati_loop_1].xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    }
    vs_COLOR0.xyz = u_xlat16_8.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat10_0.w<_Cutoff;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_2.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
bool u_xlatb14;
float u_xlat15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightAtten[1].w<u_xlat21);
#else
    u_xlatb22 = unity_LightAtten[1].w<u_xlat21;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_LightPosition[1].w!=0.0);
#else
    u_xlatb2 = unity_LightPosition[1].w!=0.0;
#endif
    u_xlatb22 = u_xlatb22 && u_xlatb2;
    u_xlat2.x = unity_LightAtten[1].z * u_xlat21 + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999997e-07);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = float(1.0) / u_xlat2.x;
    u_xlat16_3.x = (u_xlatb22) ? 0.0 : u_xlat21;
    u_xlat21 = dot(u_xlat1.xyz, unity_SpotDirection[1].xyz);
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat16_10.x = u_xlat21 + (-unity_LightAtten[1].x);
    u_xlat16_10.x = u_xlat16_10.x * unity_LightAtten[1].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10.x = min(max(u_xlat16_10.x, 0.0), 1.0);
#else
    u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_10.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.5;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
    u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
    u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_10.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlat16_10.xyz = u_xlat16_10.xxx * _Color.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[1].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightAtten[0].w<u_xlat21);
#else
    u_xlatb22 = unity_LightAtten[0].w<u_xlat21;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(unity_LightPosition[0].w!=0.0);
#else
    u_xlatb23 = unity_LightPosition[0].w!=0.0;
#endif
    u_xlatb22 = u_xlatb22 && u_xlatb23;
    u_xlat23 = unity_LightAtten[0].z * u_xlat21 + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999997e-07);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = float(1.0) / u_xlat23;
    u_xlat16_24 = (u_xlatb22) ? 0.0 : u_xlat21;
    u_xlat21 = dot(u_xlat1.xyz, unity_SpotDirection[0].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[0].xyz;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat16_26 = u_xlat21 + (-unity_LightAtten[0].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[0].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + u_xlat16_5.xyz;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0<unity_VertexLightParams.x);
#else
    u_xlatb21 = 0<unity_VertexLightParams.x;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb21)) ? u_xlat16_5.xyz : u_xlat16_6.xyz;
    u_xlati21 = u_xlatb21 ? 1 : int(0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb1 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlati21 = (u_xlatb1) ? 2 : u_xlati21;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[2].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[2].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[2].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[2].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[2].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[2].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[2].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[2].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[2].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[3].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[3].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[3].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[3].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[3].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[3].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[3].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[3].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[3].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 3 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[4].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[4].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[4].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[4].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[4].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[4].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[4].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[4].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[4].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 4 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[5].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[5].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[5].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[5].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[5].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[5].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[5].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[5].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[5].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 5 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[6].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[6].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[6].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[6].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[6].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[6].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[6].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[6].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[6].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 6 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = max(u_xlat8.x, 9.99999997e-07);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat15 = dot(u_xlat0.xyz, unity_SpotDirection[7].xyz);
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[7].xyz;
    u_xlat0.x = max(u_xlat15, 0.0);
    u_xlat16_24 = u_xlat0.x + (-unity_LightAtten[7].x);
    u_xlat16_24 = u_xlat16_24 * unity_LightAtten[7].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_LightAtten[7].w<u_xlat8.x);
#else
    u_xlatb0 = unity_LightAtten[7].w<u_xlat8.x;
#endif
    u_xlat7 = unity_LightAtten[7].z * u_xlat8.x + 1.0;
    u_xlat7 = float(1.0) / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(unity_LightPosition[7].w!=0.0);
#else
    u_xlatb14 = unity_LightPosition[7].w!=0.0;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb14;
    u_xlat16_26 = (u_xlatb0) ? 0.0 : u_xlat7;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 7 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb1;
    vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.w<_Cutoff);
#else
    u_xlatb1 = u_xlat16_0.w<_Cutoff;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
bool u_xlatb14;
float u_xlat15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightAtten[1].w<u_xlat21);
#else
    u_xlatb22 = unity_LightAtten[1].w<u_xlat21;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_LightPosition[1].w!=0.0);
#else
    u_xlatb2 = unity_LightPosition[1].w!=0.0;
#endif
    u_xlatb22 = u_xlatb22 && u_xlatb2;
    u_xlat2.x = unity_LightAtten[1].z * u_xlat21 + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999997e-07);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = float(1.0) / u_xlat2.x;
    u_xlat16_3.x = (u_xlatb22) ? 0.0 : u_xlat21;
    u_xlat21 = dot(u_xlat1.xyz, unity_SpotDirection[1].xyz);
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat16_10.x = u_xlat21 + (-unity_LightAtten[1].x);
    u_xlat16_10.x = u_xlat16_10.x * unity_LightAtten[1].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10.x = min(max(u_xlat16_10.x, 0.0), 1.0);
#else
    u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_10.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.5;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
    u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
    u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_10.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlat16_10.xyz = u_xlat16_10.xxx * _Color.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[1].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightAtten[0].w<u_xlat21);
#else
    u_xlatb22 = unity_LightAtten[0].w<u_xlat21;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(unity_LightPosition[0].w!=0.0);
#else
    u_xlatb23 = unity_LightPosition[0].w!=0.0;
#endif
    u_xlatb22 = u_xlatb22 && u_xlatb23;
    u_xlat23 = unity_LightAtten[0].z * u_xlat21 + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999997e-07);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = float(1.0) / u_xlat23;
    u_xlat16_24 = (u_xlatb22) ? 0.0 : u_xlat21;
    u_xlat21 = dot(u_xlat1.xyz, unity_SpotDirection[0].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[0].xyz;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat16_26 = u_xlat21 + (-unity_LightAtten[0].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[0].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + u_xlat16_5.xyz;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0<unity_VertexLightParams.x);
#else
    u_xlatb21 = 0<unity_VertexLightParams.x;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb21)) ? u_xlat16_5.xyz : u_xlat16_6.xyz;
    u_xlati21 = u_xlatb21 ? 1 : int(0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb1 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlati21 = (u_xlatb1) ? 2 : u_xlati21;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[2].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[2].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[2].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[2].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[2].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[2].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[2].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[2].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[2].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[3].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[3].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[3].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[3].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[3].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[3].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[3].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[3].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[3].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 3 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[4].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[4].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[4].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[4].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[4].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[4].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[4].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[4].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[4].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 4 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[5].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[5].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[5].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[5].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[5].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[5].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[5].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[5].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[5].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 5 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[6].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[6].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[6].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[6].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[6].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[6].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[6].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[6].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[6].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 6 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = max(u_xlat8.x, 9.99999997e-07);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat15 = dot(u_xlat0.xyz, unity_SpotDirection[7].xyz);
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[7].xyz;
    u_xlat0.x = max(u_xlat15, 0.0);
    u_xlat16_24 = u_xlat0.x + (-unity_LightAtten[7].x);
    u_xlat16_24 = u_xlat16_24 * unity_LightAtten[7].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_LightAtten[7].w<u_xlat8.x);
#else
    u_xlatb0 = unity_LightAtten[7].w<u_xlat8.x;
#endif
    u_xlat7 = unity_LightAtten[7].z * u_xlat8.x + 1.0;
    u_xlat7 = float(1.0) / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(unity_LightPosition[7].w!=0.0);
#else
    u_xlatb14 = unity_LightPosition[7].w!=0.0;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb14;
    u_xlat16_26 = (u_xlatb0) ? 0.0 : u_xlat7;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 7 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb1;
    vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.w<_Cutoff);
#else
    u_xlatb1 = u_xlat16_0.w<_Cutoff;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
bool u_xlatb14;
float u_xlat15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightAtten[1].w<u_xlat21);
#else
    u_xlatb22 = unity_LightAtten[1].w<u_xlat21;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_LightPosition[1].w!=0.0);
#else
    u_xlatb2 = unity_LightPosition[1].w!=0.0;
#endif
    u_xlatb22 = u_xlatb22 && u_xlatb2;
    u_xlat2.x = unity_LightAtten[1].z * u_xlat21 + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999997e-07);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = float(1.0) / u_xlat2.x;
    u_xlat16_3.x = (u_xlatb22) ? 0.0 : u_xlat21;
    u_xlat21 = dot(u_xlat1.xyz, unity_SpotDirection[1].xyz);
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat16_10.x = u_xlat21 + (-unity_LightAtten[1].x);
    u_xlat16_10.x = u_xlat16_10.x * unity_LightAtten[1].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10.x = min(max(u_xlat16_10.x, 0.0), 1.0);
#else
    u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_10.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.5;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
    u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
    u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_10.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlat16_10.xyz = u_xlat16_10.xxx * _Color.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[1].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightAtten[0].w<u_xlat21);
#else
    u_xlatb22 = unity_LightAtten[0].w<u_xlat21;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(unity_LightPosition[0].w!=0.0);
#else
    u_xlatb23 = unity_LightPosition[0].w!=0.0;
#endif
    u_xlatb22 = u_xlatb22 && u_xlatb23;
    u_xlat23 = unity_LightAtten[0].z * u_xlat21 + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999997e-07);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = float(1.0) / u_xlat23;
    u_xlat16_24 = (u_xlatb22) ? 0.0 : u_xlat21;
    u_xlat21 = dot(u_xlat1.xyz, unity_SpotDirection[0].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[0].xyz;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat16_26 = u_xlat21 + (-unity_LightAtten[0].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[0].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + u_xlat16_5.xyz;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0<unity_VertexLightParams.x);
#else
    u_xlatb21 = 0<unity_VertexLightParams.x;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb21)) ? u_xlat16_5.xyz : u_xlat16_6.xyz;
    u_xlati21 = u_xlatb21 ? 1 : int(0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb1 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlati21 = (u_xlatb1) ? 2 : u_xlati21;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[2].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[2].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[2].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[2].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[2].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[2].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[2].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[2].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[2].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[3].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[3].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[3].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[3].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[3].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[3].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[3].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[3].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[3].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 3 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[4].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[4].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[4].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[4].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[4].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[4].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[4].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[4].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[4].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 4 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[5].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[5].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[5].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[5].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[5].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[5].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[5].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[5].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[5].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 5 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat0.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[6].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[6].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[6].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[6].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[6].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[6].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[6].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[6].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[6].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati21 = (u_xlatb1) ? 6 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati21<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati21<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = max(u_xlat8.x, 9.99999997e-07);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    u_xlat15 = dot(u_xlat0.xyz, unity_SpotDirection[7].xyz);
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[7].xyz;
    u_xlat0.x = max(u_xlat15, 0.0);
    u_xlat16_24 = u_xlat0.x + (-unity_LightAtten[7].x);
    u_xlat16_24 = u_xlat16_24 * unity_LightAtten[7].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_LightAtten[7].w<u_xlat8.x);
#else
    u_xlatb0 = unity_LightAtten[7].w<u_xlat8.x;
#endif
    u_xlat7 = unity_LightAtten[7].z * u_xlat8.x + 1.0;
    u_xlat7 = float(1.0) / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(unity_LightPosition[7].w!=0.0);
#else
    u_xlatb14 = unity_LightPosition[7].w!=0.0;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb14;
    u_xlat16_26 = (u_xlatb0) ? 0.0 : u_xlat7;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 7 : u_xlati21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb1;
    vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.w<_Cutoff);
#else
    u_xlatb1 = u_xlat16_0.w<_Cutoff;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec3 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat1.xyz;
    u_xlat0.z = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, unity_LightPosition[0].xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * unity_LightColor[0].xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_2.xyz = min(u_xlat16_2.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + u_xlat16_2.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[1].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[1].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[2].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[2].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[3].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[3].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[4].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[4].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[5].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[5].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[6].xyz);
    u_xlat16_3.x = dot(u_xlat0.xyz, unity_LightPosition[7].xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[7].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_4.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * unity_LightColor[6].xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_4.xyz;
    vs_COLOR0.xyz = u_xlat16_3.xyz + u_xlat16_2.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD1 = u_xlat0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat10_0.w<_Cutoff;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_2.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_2.xyz + unity_FogColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec3 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat1.xyz;
    u_xlat0.z = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, unity_LightPosition[0].xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * unity_LightColor[0].xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_2.xyz = min(u_xlat16_2.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + u_xlat16_2.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[1].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[1].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[2].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[2].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[3].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[3].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[4].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[4].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[5].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[5].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[6].xyz);
    u_xlat16_3.x = dot(u_xlat0.xyz, unity_LightPosition[7].xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[7].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_4.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * unity_LightColor[6].xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_4.xyz;
    vs_COLOR0.xyz = u_xlat16_3.xyz + u_xlat16_2.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD1 = u_xlat0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat10_0.w<_Cutoff;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_2.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_2.xyz + unity_FogColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec3 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat1.xyz;
    u_xlat0.z = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, unity_LightPosition[0].xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * unity_LightColor[0].xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_2.xyz = min(u_xlat16_2.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + u_xlat16_2.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[1].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[1].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[2].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[2].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[3].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[3].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[4].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[4].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[5].xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[5].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat0.xyz, unity_LightPosition[6].xyz);
    u_xlat16_3.x = dot(u_xlat0.xyz, unity_LightPosition[7].xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * unity_LightColor[7].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17 = max(u_xlat16_17, 0.0);
    u_xlat16_4.xyz = vec3(u_xlat16_17) * _Color.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * unity_LightColor[6].xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_4.xyz;
    vs_COLOR0.xyz = u_xlat16_3.xyz + u_xlat16_2.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD1 = u_xlat0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat10_0.w<_Cutoff;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_2.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_2.xyz + unity_FogColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat30;
int u_xlati30;
bool u_xlatb31;
mediump float u_xlat16_37;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat16_37 = dot(u_xlat1.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
        u_xlat16_37 = max(u_xlat16_37, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_37) * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[u_xlati_loop_1].xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(0.5, 0.5, 0.5);
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    }
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.w<_Cutoff);
#else
    u_xlatb1 = u_xlat16_0.w<_Cutoff;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_2.xyz + unity_FogColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat30;
int u_xlati30;
bool u_xlatb31;
mediump float u_xlat16_37;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat16_37 = dot(u_xlat1.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
        u_xlat16_37 = max(u_xlat16_37, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_37) * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[u_xlati_loop_1].xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(0.5, 0.5, 0.5);
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    }
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.w<_Cutoff);
#else
    u_xlatb1 = u_xlat16_0.w<_Cutoff;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_2.xyz + unity_FogColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat30;
int u_xlati30;
bool u_xlatb31;
mediump float u_xlat16_37;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat16_37 = dot(u_xlat1.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
        u_xlat16_37 = max(u_xlat16_37, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_37) * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[u_xlati_loop_1].xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(0.5, 0.5, 0.5);
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    }
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.w<_Cutoff);
#else
    u_xlatb1 = u_xlat16_0.w<_Cutoff;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_2.xyz + unity_FogColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec3 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
bool u_xlatb13;
float u_xlat30;
int u_xlati30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<8 ; u_xlati_loop_1++)
    {
        u_xlat2.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = unity_LightAtten[u_xlati_loop_1].z * u_xlat31 + 1.0;
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
        u_xlatb13 = unity_LightAtten[u_xlati_loop_1].w<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = inversesqrt(u_xlat31);
        u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = u_xlat32 * 0.5;
        u_xlat16_37 = (u_xlatb3) ? 0.0 : u_xlat31;
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_38) * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[u_xlati_loop_1].xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    }
    vs_COLOR0.xyz = u_xlat16_8.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat10_0.w<_Cutoff;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_2.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_2.xyz + unity_FogColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec3 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
bool u_xlatb13;
float u_xlat30;
int u_xlati30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<8 ; u_xlati_loop_1++)
    {
        u_xlat2.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = unity_LightAtten[u_xlati_loop_1].z * u_xlat31 + 1.0;
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
        u_xlatb13 = unity_LightAtten[u_xlati_loop_1].w<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = inversesqrt(u_xlat31);
        u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = u_xlat32 * 0.5;
        u_xlat16_37 = (u_xlatb3) ? 0.0 : u_xlat31;
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_38) * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[u_xlati_loop_1].xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    }
    vs_COLOR0.xyz = u_xlat16_8.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat10_0.w<_Cutoff;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_2.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_2.xyz + unity_FogColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec3 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
bool u_xlatb13;
float u_xlat30;
int u_xlati30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<8 ; u_xlati_loop_1++)
    {
        u_xlat2.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = unity_LightAtten[u_xlati_loop_1].z * u_xlat31 + 1.0;
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
        u_xlatb13 = unity_LightAtten[u_xlati_loop_1].w<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = inversesqrt(u_xlat31);
        u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = u_xlat32 * 0.5;
        u_xlat16_37 = (u_xlatb3) ? 0.0 : u_xlat31;
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_38) * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[u_xlati_loop_1].xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    }
    vs_COLOR0.xyz = u_xlat16_8.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat10_0.w<_Cutoff;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_2.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_2.xyz + unity_FogColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_10;
float u_xlat14;
bool u_xlatb14;
float u_xlat15;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_24;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_LightPosition[1].w!=0.0);
#else
    u_xlatb0 = unity_LightPosition[1].w!=0.0;
#endif
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat7.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat7.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat7.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat7.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_LightAtten[1].w<u_xlat22);
#else
    u_xlatb2 = unity_LightAtten[1].w<u_xlat22;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb2;
    u_xlat2.x = unity_LightAtten[1].z * u_xlat22 + 1.0;
    u_xlat22 = max(u_xlat22, 9.99999997e-07);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = float(1.0) / u_xlat2.x;
    u_xlat22 = u_xlat22 * 0.5;
    u_xlat16_3.x = (u_xlatb0) ? 0.0 : u_xlat22;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
    u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
    u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_10.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlat16_10.xyz = u_xlat16_10.xxx * _Color.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[1].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.xyz = (-u_xlat7.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = max(u_xlat0.x, 9.99999997e-07);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[0].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(unity_LightAtten[0].w<u_xlat0.x);
#else
    u_xlatb1 = unity_LightAtten[0].w<u_xlat0.x;
#endif
    u_xlat0.x = unity_LightAtten[0].z * u_xlat0.x + 1.0;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightPosition[0].w!=0.0);
#else
    u_xlatb8 = unity_LightPosition[0].w!=0.0;
#endif
    u_xlatb1 = u_xlatb1 && u_xlatb8;
    u_xlat16_24 = (u_xlatb1) ? 0.0 : u_xlat0.x;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + u_xlat16_5.xyz;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0<unity_VertexLightParams.x);
#else
    u_xlatb0 = 0<unity_VertexLightParams.x;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_6.xyz;
    u_xlati0 = u_xlatb0 ? 1 : int(0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb1 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlati0 = (u_xlatb1) ? 2 : u_xlati0;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[2].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[2].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[2].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[2].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[2].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[2].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[3].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[3].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[3].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[3].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[3].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[3].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 3 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[4].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[4].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[4].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[4].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[4].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[4].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 4 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[5].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[5].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[5].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[5].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[5].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[5].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 5 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[6].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[6].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[6].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[6].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[6].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[6].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 6 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    vs_TEXCOORD1 = u_xlat7.x;
    u_xlat7.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat14 = max(u_xlat7.x, 9.99999997e-07);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat8.xyz = vec3(u_xlat14) * u_xlat8.xyz;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[7].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(unity_LightAtten[7].w<u_xlat7.x);
#else
    u_xlatb14 = unity_LightAtten[7].w<u_xlat7.x;
#endif
    u_xlat7.x = unity_LightAtten[7].z * u_xlat7.x + 1.0;
    u_xlat7.x = float(1.0) / u_xlat7.x;
    u_xlat7.x = u_xlat7.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_LightPosition[7].w!=0.0);
#else
    u_xlatb21 = unity_LightPosition[7].w!=0.0;
#endif
    u_xlatb14 = u_xlatb14 && u_xlatb21;
    u_xlat16_24 = (u_xlatb14) ? 0.0 : u_xlat7.x;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 7 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb1;
    vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.w<_Cutoff);
#else
    u_xlatb1 = u_xlat16_0.w<_Cutoff;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_2.xyz + unity_FogColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_10;
float u_xlat14;
bool u_xlatb14;
float u_xlat15;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_24;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_LightPosition[1].w!=0.0);
#else
    u_xlatb0 = unity_LightPosition[1].w!=0.0;
#endif
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat7.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat7.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat7.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat7.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_LightAtten[1].w<u_xlat22);
#else
    u_xlatb2 = unity_LightAtten[1].w<u_xlat22;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb2;
    u_xlat2.x = unity_LightAtten[1].z * u_xlat22 + 1.0;
    u_xlat22 = max(u_xlat22, 9.99999997e-07);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = float(1.0) / u_xlat2.x;
    u_xlat22 = u_xlat22 * 0.5;
    u_xlat16_3.x = (u_xlatb0) ? 0.0 : u_xlat22;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
    u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
    u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_10.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlat16_10.xyz = u_xlat16_10.xxx * _Color.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[1].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.xyz = (-u_xlat7.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = max(u_xlat0.x, 9.99999997e-07);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[0].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(unity_LightAtten[0].w<u_xlat0.x);
#else
    u_xlatb1 = unity_LightAtten[0].w<u_xlat0.x;
#endif
    u_xlat0.x = unity_LightAtten[0].z * u_xlat0.x + 1.0;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightPosition[0].w!=0.0);
#else
    u_xlatb8 = unity_LightPosition[0].w!=0.0;
#endif
    u_xlatb1 = u_xlatb1 && u_xlatb8;
    u_xlat16_24 = (u_xlatb1) ? 0.0 : u_xlat0.x;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + u_xlat16_5.xyz;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0<unity_VertexLightParams.x);
#else
    u_xlatb0 = 0<unity_VertexLightParams.x;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_6.xyz;
    u_xlati0 = u_xlatb0 ? 1 : int(0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb1 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlati0 = (u_xlatb1) ? 2 : u_xlati0;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[2].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[2].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[2].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[2].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[2].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[2].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[3].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[3].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[3].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[3].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[3].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[3].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 3 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[4].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[4].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[4].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[4].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[4].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[4].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 4 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[5].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[5].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[5].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[5].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[5].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[5].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 5 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[6].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[6].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[6].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[6].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[6].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[6].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 6 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    vs_TEXCOORD1 = u_xlat7.x;
    u_xlat7.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat14 = max(u_xlat7.x, 9.99999997e-07);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat8.xyz = vec3(u_xlat14) * u_xlat8.xyz;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[7].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(unity_LightAtten[7].w<u_xlat7.x);
#else
    u_xlatb14 = unity_LightAtten[7].w<u_xlat7.x;
#endif
    u_xlat7.x = unity_LightAtten[7].z * u_xlat7.x + 1.0;
    u_xlat7.x = float(1.0) / u_xlat7.x;
    u_xlat7.x = u_xlat7.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_LightPosition[7].w!=0.0);
#else
    u_xlatb21 = unity_LightPosition[7].w!=0.0;
#endif
    u_xlatb14 = u_xlatb14 && u_xlatb21;
    u_xlat16_24 = (u_xlatb14) ? 0.0 : u_xlat7.x;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 7 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb1;
    vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.w<_Cutoff);
#else
    u_xlatb1 = u_xlat16_0.w<_Cutoff;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_2.xyz + unity_FogColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_10;
float u_xlat14;
bool u_xlatb14;
float u_xlat15;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_24;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_LightPosition[1].w!=0.0);
#else
    u_xlatb0 = unity_LightPosition[1].w!=0.0;
#endif
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat7.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat7.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat7.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat7.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_LightAtten[1].w<u_xlat22);
#else
    u_xlatb2 = unity_LightAtten[1].w<u_xlat22;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb2;
    u_xlat2.x = unity_LightAtten[1].z * u_xlat22 + 1.0;
    u_xlat22 = max(u_xlat22, 9.99999997e-07);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = float(1.0) / u_xlat2.x;
    u_xlat22 = u_xlat22 * 0.5;
    u_xlat16_3.x = (u_xlatb0) ? 0.0 : u_xlat22;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
    u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
    u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_10.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlat16_10.xyz = u_xlat16_10.xxx * _Color.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[1].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.xyz = (-u_xlat7.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = max(u_xlat0.x, 9.99999997e-07);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[0].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(unity_LightAtten[0].w<u_xlat0.x);
#else
    u_xlatb1 = unity_LightAtten[0].w<u_xlat0.x;
#endif
    u_xlat0.x = unity_LightAtten[0].z * u_xlat0.x + 1.0;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightPosition[0].w!=0.0);
#else
    u_xlatb8 = unity_LightPosition[0].w!=0.0;
#endif
    u_xlatb1 = u_xlatb1 && u_xlatb8;
    u_xlat16_24 = (u_xlatb1) ? 0.0 : u_xlat0.x;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + u_xlat16_5.xyz;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0<unity_VertexLightParams.x);
#else
    u_xlatb0 = 0<unity_VertexLightParams.x;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_6.xyz;
    u_xlati0 = u_xlatb0 ? 1 : int(0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb1 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlati0 = (u_xlatb1) ? 2 : u_xlati0;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[2].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[2].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[2].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[2].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[2].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[2].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[3].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[3].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[3].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[3].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[3].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[3].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 3 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[4].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[4].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[4].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[4].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[4].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[4].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 4 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[5].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[5].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[5].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[5].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[5].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[5].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 5 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat4.x = max(u_xlat23, 9.99999997e-07);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat4.xxx;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[6].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(unity_LightAtten[6].w<u_xlat23);
#else
    u_xlatb8 = unity_LightAtten[6].w<u_xlat23;
#endif
    u_xlat15 = unity_LightAtten[6].z * u_xlat23 + 1.0;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightPosition[6].w!=0.0);
#else
    u_xlatb22 = unity_LightPosition[6].w!=0.0;
#endif
    u_xlatb8 = u_xlatb8 && u_xlatb22;
    u_xlat16_24 = (u_xlatb8) ? 0.0 : u_xlat15;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 6 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    vs_TEXCOORD1 = u_xlat7.x;
    u_xlat7.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat14 = max(u_xlat7.x, 9.99999997e-07);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat8.xyz = vec3(u_xlat14) * u_xlat8.xyz;
    u_xlat16_24 = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[7].xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(unity_LightAtten[7].w<u_xlat7.x);
#else
    u_xlatb14 = unity_LightAtten[7].w<u_xlat7.x;
#endif
    u_xlat7.x = unity_LightAtten[7].z * u_xlat7.x + 1.0;
    u_xlat7.x = float(1.0) / u_xlat7.x;
    u_xlat7.x = u_xlat7.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_LightPosition[7].w!=0.0);
#else
    u_xlatb21 = unity_LightPosition[7].w!=0.0;
#endif
    u_xlatb14 = u_xlatb14 && u_xlatb21;
    u_xlat16_24 = (u_xlatb14) ? 0.0 : u_xlat7.x;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 7 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb1;
    vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.w<_Cutoff);
#else
    u_xlatb1 = u_xlat16_0.w<_Cutoff;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_2.xyz + unity_FogColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec3 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
bool u_xlatb13;
float u_xlat30;
int u_xlati30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<8 ; u_xlati_loop_1++)
    {
        u_xlat2.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = unity_LightAtten[u_xlati_loop_1].z * u_xlat31 + 1.0;
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
        u_xlatb13 = unity_LightAtten[u_xlati_loop_1].w<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat16_37 = (u_xlatb3) ? 0.0 : u_xlat32;
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = inversesqrt(u_xlat31);
        u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = dot(u_xlat2.xyz, unity_SpotDirection[u_xlati_loop_1].xyz);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat16_38 = u_xlat31 + (-unity_LightAtten[u_xlati_loop_1].x);
        u_xlat16_38 = u_xlat16_38 * unity_LightAtten[u_xlati_loop_1].y;
        u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
        u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
        u_xlat16_37 = u_xlat16_37 * 0.5;
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_38) * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[u_xlati_loop_1].xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    }
    vs_COLOR0.xyz = u_xlat16_8.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat10_0.w<_Cutoff;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_2.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_2.xyz + unity_FogColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec3 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
bool u_xlatb13;
float u_xlat30;
int u_xlati30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<8 ; u_xlati_loop_1++)
    {
        u_xlat2.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = unity_LightAtten[u_xlati_loop_1].z * u_xlat31 + 1.0;
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
        u_xlatb13 = unity_LightAtten[u_xlati_loop_1].w<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat16_37 = (u_xlatb3) ? 0.0 : u_xlat32;
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = inversesqrt(u_xlat31);
        u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = dot(u_xlat2.xyz, unity_SpotDirection[u_xlati_loop_1].xyz);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat16_38 = u_xlat31 + (-unity_LightAtten[u_xlati_loop_1].x);
        u_xlat16_38 = u_xlat16_38 * unity_LightAtten[u_xlati_loop_1].y;
        u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
        u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
        u_xlat16_37 = u_xlat16_37 * 0.5;
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_38) * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[u_xlati_loop_1].xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    }
    vs_COLOR0.xyz = u_xlat16_8.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat10_0.w<_Cutoff;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_2.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_2.xyz + unity_FogColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec3 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
bool u_xlatb13;
float u_xlat30;
int u_xlati30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<8 ; u_xlati_loop_1++)
    {
        u_xlat2.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = unity_LightAtten[u_xlati_loop_1].z * u_xlat31 + 1.0;
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
        u_xlatb13 = unity_LightAtten[u_xlati_loop_1].w<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat16_37 = (u_xlatb3) ? 0.0 : u_xlat32;
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = inversesqrt(u_xlat31);
        u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = dot(u_xlat2.xyz, unity_SpotDirection[u_xlati_loop_1].xyz);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat16_38 = u_xlat31 + (-unity_LightAtten[u_xlati_loop_1].x);
        u_xlat16_38 = u_xlat16_38 * unity_LightAtten[u_xlati_loop_1].y;
        u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
        u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
        u_xlat16_37 = u_xlat16_37 * 0.5;
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_38) * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[u_xlati_loop_1].xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    }
    vs_COLOR0.xyz = u_xlat16_8.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x;
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
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat10_0.w<_Cutoff;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_2.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_2.xyz + unity_FogColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
bool u_xlatb14;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_LightPosition[1].w!=0.0);
#else
    u_xlatb0 = unity_LightPosition[1].w!=0.0;
#endif
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat7.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat7.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat7.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat7.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_LightAtten[1].w<u_xlat22);
#else
    u_xlatb2 = unity_LightAtten[1].w<u_xlat22;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb2;
    u_xlat2.x = unity_LightAtten[1].z * u_xlat22 + 1.0;
    u_xlat22 = max(u_xlat22, 9.99999997e-07);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = float(1.0) / u_xlat2.x;
    u_xlat16_3.x = (u_xlatb0) ? 0.0 : u_xlat22;
    u_xlat0.x = dot(u_xlat1.xyz, unity_SpotDirection[1].xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat16_10.x = u_xlat0.x + (-unity_LightAtten[1].x);
    u_xlat16_10.x = u_xlat16_10.x * unity_LightAtten[1].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10.x = min(max(u_xlat16_10.x, 0.0), 1.0);
#else
    u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_10.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.5;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
    u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
    u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_10.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlat16_10.xyz = u_xlat16_10.xxx * _Color.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[1].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.xyz = (-u_xlat7.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightAtten[0].w<u_xlat0.x);
#else
    u_xlatb22 = unity_LightAtten[0].w<u_xlat0.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(unity_LightPosition[0].w!=0.0);
#else
    u_xlatb23 = unity_LightPosition[0].w!=0.0;
#endif
    u_xlatb22 = u_xlatb22 && u_xlatb23;
    u_xlat23 = unity_LightAtten[0].z * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999997e-07);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = float(1.0) / u_xlat23;
    u_xlat16_24 = (u_xlatb22) ? 0.0 : u_xlat0.x;
    u_xlat0.x = dot(u_xlat1.xyz, unity_SpotDirection[0].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[0].xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat16_26 = u_xlat0.x + (-unity_LightAtten[0].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[0].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + u_xlat16_5.xyz;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0<unity_VertexLightParams.x);
#else
    u_xlatb0 = 0<unity_VertexLightParams.x;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_6.xyz;
    u_xlati0 = u_xlatb0 ? 1 : int(0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb1 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlati0 = (u_xlatb1) ? 2 : u_xlati0;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[2].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[2].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[2].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[2].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[2].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[2].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[2].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[2].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[2].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[3].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[3].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[3].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[3].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[3].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[3].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[3].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[3].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[3].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 3 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[4].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[4].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[4].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[4].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[4].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[4].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[4].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[4].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[4].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 4 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[5].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[5].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[5].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[5].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[5].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[5].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[5].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[5].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[5].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 5 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[6].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[6].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[6].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[6].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[6].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[6].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[6].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[6].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[6].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 6 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    vs_TEXCOORD1 = u_xlat7.x;
    u_xlat7.x = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(unity_LightAtten[7].w<u_xlat7.x);
#else
    u_xlatb14 = unity_LightAtten[7].w<u_xlat7.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_LightPosition[7].w!=0.0);
#else
    u_xlatb21 = unity_LightPosition[7].w!=0.0;
#endif
    u_xlatb14 = u_xlatb14 && u_xlatb21;
    u_xlat21 = unity_LightAtten[7].z * u_xlat7.x + 1.0;
    u_xlat7.x = max(u_xlat7.x, 9.99999997e-07);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat8.xyz = u_xlat7.xxx * u_xlat8.xyz;
    u_xlat7.x = float(1.0) / u_xlat21;
    u_xlat16_24 = (u_xlatb14) ? 0.0 : u_xlat7.x;
    u_xlat7.x = dot(u_xlat8.xyz, unity_SpotDirection[7].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[7].xyz;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat16_26 = u_xlat7.x + (-unity_LightAtten[7].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[7].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 7 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb1;
    vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.w<_Cutoff);
#else
    u_xlatb1 = u_xlat16_0.w<_Cutoff;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_2.xyz + unity_FogColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
bool u_xlatb14;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_LightPosition[1].w!=0.0);
#else
    u_xlatb0 = unity_LightPosition[1].w!=0.0;
#endif
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat7.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat7.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat7.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat7.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_LightAtten[1].w<u_xlat22);
#else
    u_xlatb2 = unity_LightAtten[1].w<u_xlat22;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb2;
    u_xlat2.x = unity_LightAtten[1].z * u_xlat22 + 1.0;
    u_xlat22 = max(u_xlat22, 9.99999997e-07);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = float(1.0) / u_xlat2.x;
    u_xlat16_3.x = (u_xlatb0) ? 0.0 : u_xlat22;
    u_xlat0.x = dot(u_xlat1.xyz, unity_SpotDirection[1].xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat16_10.x = u_xlat0.x + (-unity_LightAtten[1].x);
    u_xlat16_10.x = u_xlat16_10.x * unity_LightAtten[1].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10.x = min(max(u_xlat16_10.x, 0.0), 1.0);
#else
    u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_10.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.5;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
    u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
    u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_10.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlat16_10.xyz = u_xlat16_10.xxx * _Color.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[1].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.xyz = (-u_xlat7.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightAtten[0].w<u_xlat0.x);
#else
    u_xlatb22 = unity_LightAtten[0].w<u_xlat0.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(unity_LightPosition[0].w!=0.0);
#else
    u_xlatb23 = unity_LightPosition[0].w!=0.0;
#endif
    u_xlatb22 = u_xlatb22 && u_xlatb23;
    u_xlat23 = unity_LightAtten[0].z * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999997e-07);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = float(1.0) / u_xlat23;
    u_xlat16_24 = (u_xlatb22) ? 0.0 : u_xlat0.x;
    u_xlat0.x = dot(u_xlat1.xyz, unity_SpotDirection[0].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[0].xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat16_26 = u_xlat0.x + (-unity_LightAtten[0].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[0].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + u_xlat16_5.xyz;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0<unity_VertexLightParams.x);
#else
    u_xlatb0 = 0<unity_VertexLightParams.x;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_6.xyz;
    u_xlati0 = u_xlatb0 ? 1 : int(0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb1 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlati0 = (u_xlatb1) ? 2 : u_xlati0;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[2].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[2].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[2].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[2].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[2].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[2].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[2].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[2].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[2].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[3].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[3].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[3].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[3].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[3].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[3].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[3].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[3].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[3].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 3 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[4].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[4].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[4].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[4].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[4].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[4].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[4].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[4].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[4].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 4 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[5].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[5].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[5].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[5].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[5].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[5].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[5].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[5].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[5].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 5 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[6].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[6].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[6].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[6].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[6].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[6].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[6].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[6].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[6].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 6 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    vs_TEXCOORD1 = u_xlat7.x;
    u_xlat7.x = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(unity_LightAtten[7].w<u_xlat7.x);
#else
    u_xlatb14 = unity_LightAtten[7].w<u_xlat7.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_LightPosition[7].w!=0.0);
#else
    u_xlatb21 = unity_LightPosition[7].w!=0.0;
#endif
    u_xlatb14 = u_xlatb14 && u_xlatb21;
    u_xlat21 = unity_LightAtten[7].z * u_xlat7.x + 1.0;
    u_xlat7.x = max(u_xlat7.x, 9.99999997e-07);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat8.xyz = u_xlat7.xxx * u_xlat8.xyz;
    u_xlat7.x = float(1.0) / u_xlat21;
    u_xlat16_24 = (u_xlatb14) ? 0.0 : u_xlat7.x;
    u_xlat7.x = dot(u_xlat8.xyz, unity_SpotDirection[7].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[7].xyz;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat16_26 = u_xlat7.x + (-unity_LightAtten[7].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[7].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 7 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb1;
    vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.w<_Cutoff);
#else
    u_xlatb1 = u_xlat16_0.w<_Cutoff;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_2.xyz + unity_FogColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
bool u_xlatb14;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_LightPosition[1].w!=0.0);
#else
    u_xlatb0 = unity_LightPosition[1].w!=0.0;
#endif
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat7.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat7.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat7.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat7.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_LightAtten[1].w<u_xlat22);
#else
    u_xlatb2 = unity_LightAtten[1].w<u_xlat22;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb2;
    u_xlat2.x = unity_LightAtten[1].z * u_xlat22 + 1.0;
    u_xlat22 = max(u_xlat22, 9.99999997e-07);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = float(1.0) / u_xlat2.x;
    u_xlat16_3.x = (u_xlatb0) ? 0.0 : u_xlat22;
    u_xlat0.x = dot(u_xlat1.xyz, unity_SpotDirection[1].xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat16_10.x = u_xlat0.x + (-unity_LightAtten[1].x);
    u_xlat16_10.x = u_xlat16_10.x * unity_LightAtten[1].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10.x = min(max(u_xlat16_10.x, 0.0), 1.0);
#else
    u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_10.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.5;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
    u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
    u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_10.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlat16_10.xyz = u_xlat16_10.xxx * _Color.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[1].xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.xyz = (-u_xlat7.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(unity_LightAtten[0].w<u_xlat0.x);
#else
    u_xlatb22 = unity_LightAtten[0].w<u_xlat0.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(unity_LightPosition[0].w!=0.0);
#else
    u_xlatb23 = unity_LightPosition[0].w!=0.0;
#endif
    u_xlatb22 = u_xlatb22 && u_xlatb23;
    u_xlat23 = unity_LightAtten[0].z * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999997e-07);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = float(1.0) / u_xlat23;
    u_xlat16_24 = (u_xlatb22) ? 0.0 : u_xlat0.x;
    u_xlat0.x = dot(u_xlat1.xyz, unity_SpotDirection[0].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[0].xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat16_26 = u_xlat0.x + (-unity_LightAtten[0].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[0].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + u_xlat16_5.xyz;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0<unity_VertexLightParams.x);
#else
    u_xlatb0 = 0<unity_VertexLightParams.x;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_6.xyz;
    u_xlati0 = u_xlatb0 ? 1 : int(0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb1 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlati0 = (u_xlatb1) ? 2 : u_xlati0;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[2].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[2].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[2].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[2].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[2].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[2].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[2].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[2].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[2].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[3].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[3].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[3].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[3].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[3].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[3].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[3].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[3].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[3].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 3 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[4].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[4].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[4].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[4].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[4].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[4].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[4].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[4].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[4].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 4 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[5].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[5].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[5].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[5].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[5].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[5].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[5].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[5].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[5].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 5 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
    u_xlat23 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(unity_LightAtten[6].w<u_xlat23);
#else
    u_xlatb4 = unity_LightAtten[6].w<u_xlat23;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(unity_LightPosition[6].w!=0.0);
#else
    u_xlatb11 = unity_LightPosition[6].w!=0.0;
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb11;
    u_xlat11 = unity_LightAtten[6].z * u_xlat23 + 1.0;
    u_xlat23 = max(u_xlat23, 9.99999997e-07);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat23);
    u_xlat23 = float(1.0) / u_xlat11;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat23;
    u_xlat23 = dot(u_xlat8.xyz, unity_SpotDirection[6].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[6].xyz;
    u_xlat8.x = max(u_xlat23, 0.0);
    u_xlat16_26 = u_xlat8.x + (-unity_LightAtten[6].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[6].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 6 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb8 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb1 = u_xlatb8 && u_xlatb1;
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    vs_TEXCOORD1 = u_xlat7.x;
    u_xlat7.x = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(unity_LightAtten[7].w<u_xlat7.x);
#else
    u_xlatb14 = unity_LightAtten[7].w<u_xlat7.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_LightPosition[7].w!=0.0);
#else
    u_xlatb21 = unity_LightPosition[7].w!=0.0;
#endif
    u_xlatb14 = u_xlatb14 && u_xlatb21;
    u_xlat21 = unity_LightAtten[7].z * u_xlat7.x + 1.0;
    u_xlat7.x = max(u_xlat7.x, 9.99999997e-07);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat8.xyz = u_xlat7.xxx * u_xlat8.xyz;
    u_xlat7.x = float(1.0) / u_xlat21;
    u_xlat16_24 = (u_xlatb14) ? 0.0 : u_xlat7.x;
    u_xlat7.x = dot(u_xlat8.xyz, unity_SpotDirection[7].xyz);
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * unity_LightColor[7].xyz;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat16_26 = u_xlat7.x + (-unity_LightAtten[7].x);
    u_xlat16_26 = u_xlat16_26 * unity_LightAtten[7].y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_24 * 0.5;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlati0 = (u_xlatb1) ? 7 : u_xlati0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
#else
    u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb1;
    vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _Cutoff;
uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.w<_Cutoff);
#else
    u_xlatb1 = u_xlat16_0.w<_Cutoff;
#endif
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_2.xyz + unity_FogColor.xyz;
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
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" }
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
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
}
}
}
}