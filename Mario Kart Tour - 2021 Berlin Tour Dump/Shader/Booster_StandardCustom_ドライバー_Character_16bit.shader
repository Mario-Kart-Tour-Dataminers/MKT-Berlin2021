//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/ドライバー/Character_16bit" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_AddColor ("加算色", Color) = (0,0,0,0)
_MainTex ("Albedo(UV0)", 2D) = "white" { }
_TransparencyLM ("AlphaMask(UV0)", 2D) = "black" { }
_Metallic ("Metallic", Range(0, 1)) = 0
_Smoothness ("Smoothness", Range(0, 1)) = 0
_Occlusion ("Occlusion", Range(0, 1)) = 1
[Header(Dot Character)] _DotSplitU ("U方向：コマ割り数", Range(1, 32)) = 1
_DotSplitV ("V方向：コマ割り数", Range(1, 32)) = 1
_DotStarHueSpeed ("スター：色相遷移速度", Float) = 1
_DotStarLightnessSpeed ("スター：明度遷移速度", Float) = 1
_DotStarMinLightness ("スター：最小加算明度", Range(0, 1)) = 0.5
_DotStarMaxLightness ("スター：最大加算明度", Range(0, 1)) = 0.75
_DotStarAddedSaturation ("スター：加算される彩度", Range(0, 1)) = 0.75
_Cutout ("カットアウト値", Range(0, 1)) = 0.5
[Header(Booster Reflection Cube Map)] [KeywordEnum(NO,YES,FIXEDCOLOR)] _ReflectionProbeType ("個別リフレクションキューブマップ使用", Float) = 0
_HeuristicReflection ("個別リフレクションキューブマップ", Cube) = "_Skybox" { }
_NormalDiff ("疑似LOD反射の揺らぎ", Range(-1, 1)) = 0
_NormalRand ("疑似LOD乱数値", Vector) = (9993.169,5715.817,4488.509,34.2347)
_FixedReflColor ("単色リフレクションカラー", Color) = (1,1,1,1)
[Space(20)] [Enum(NO,0,YES,2)] _StencilOp ("置き影が落ちなくなる", Float) = 2
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "AlphaTest" "RenderType" = "DotDriver" }
 Pass {
  Name "FORWARD"
  Tags { "DisableBatching" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest" "RenderType" = "DotDriver" }
  Cull Off
  GpuProgramID 47870
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlatb2 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
bvec2 u_xlatb2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_10;
vec2 u_xlat12;
mediump vec3 u_xlat16_16;
float u_xlat20;
mediump float u_xlat16_20;
lowp float u_xlat10_20;
bool u_xlatb20;
float u_xlat30;
bool u_xlatb30;
float u_xlat32;
mediump float u_xlat16_35;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_20 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_20 = (-u_xlat10_20) + 1.0;
    u_xlat16_1.x = u_xlat16_20 + (-_Cutout);
    u_xlatb20 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb20) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat20 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb20 = u_xlat20<9.99999975e-06;
    u_xlat20 = (u_xlatb20) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat20 * u_xlat16_1.x;
    u_xlat4.x = u_xlat20 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat20 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat20 = sin(u_xlat20);
    u_xlat20 = u_xlat20 * _NormalRand.w;
    u_xlat20 = fract(u_xlat20);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat20) + u_xlat16_1.xyz;
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
    u_xlatb20 = u_xlat4.z<0.00499999989;
    u_xlat32 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb20) ? 0.0 : u_xlat32;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat20 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * vs_TEXCOORD1.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat32 = u_xlat20;
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
    u_xlat20 = u_xlat20 + u_xlat20;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat20)) + u_xlat2.xyz;
    u_xlat16_35 = (-u_xlat32) + 1.0;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_20;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_20;
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.x = (-u_xlat16_35) + _Smoothness;
    u_xlat16_6.x = u_xlat16_6.x + 1.0;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
    u_xlat16_7.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_16.xyz = u_xlat16_7.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_16.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = u_xlat16_6.xxx + (-u_xlat16_8.xyz);
    u_xlat16_9.xyz = vec3(u_xlat16_20) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat7.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat7.xyz = vec3(u_xlat20) * u_xlat7.xyz;
    u_xlat20 = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat7.xyz);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat4.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat2.x = u_xlat2.x * 16.0;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat2.xxx;
    u_xlat16_6.xyz = u_xlat16_16.xyz * vec3(u_xlat16_35) + u_xlat16_8.xyz;
    u_xlat16_2.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_2.xyz = u_xlat16_2.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = vec3(u_xlat20) * u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz + u_xlat16_5.xyz;
    u_xlat16_6.xyz = (-u_xlat16_5.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_10 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_10 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_6.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat30 = max(u_xlat0.y, u_xlat0.x);
    u_xlat30 = max(u_xlat30, u_xlat0.z);
    u_xlatb2.xy = equal(vec4(u_xlat30), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat3.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat3.y = float(4.0);
    u_xlat3.w = float(0.0);
    u_xlat12.xy = (u_xlatb2.y) ? u_xlat1.yw : u_xlat3.xy;
    u_xlat2.xy = (u_xlatb2.x) ? u_xlat3.zw : u_xlat12.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat30;
    u_xlat10.x = u_xlat2.x / u_xlat0.x;
    u_xlat10.x = u_xlat10.x + u_xlat2.y;
    u_xlatb20 = u_xlat10.x<0.0;
    u_xlat20 = u_xlatb20 ? 1.0 : float(0.0);
    u_xlat10.x = u_xlat10.x * 0.166666672 + u_xlat20;
    u_xlat10.x = booster_Env.x * _DotStarHueSpeed + u_xlat10.x;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat20 = u_xlat10.x * 6.0;
    u_xlat20 = floor(u_xlat20);
    u_xlatb1 = lessThan(vec4(u_xlat20), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb2.x = u_xlat20<5.0;
    u_xlat10.x = u_xlat10.x * 6.0 + (-u_xlat20);
    u_xlat20 = max(u_xlat30, 0.00100000005);
    u_xlat3.z = u_xlat30 + u_xlat30;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat20;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat20 = u_xlat0.x * u_xlat10.x + (-u_xlat0.x);
    u_xlat10.x = (-u_xlat0.x) * u_xlat10.x + 1.0;
    u_xlat3.y = u_xlat10.x * u_xlat3.z;
    u_xlat10.x = u_xlat20 + 1.0;
    u_xlat3.w = u_xlat10.x * u_xlat3.z;
    u_xlat2.xz = (u_xlatb2.x) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat2.y = u_xlat3.x;
    u_xlat10.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat2.xyz;
    u_xlat10.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat10.xyz;
    u_xlat10.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat10.xyz;
    u_xlat10.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat10.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat10.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_5.xyz;
    u_xlatb30 = 0.0>=_DotParams.w;
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD3.z;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb2 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
bvec2 u_xlatb2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_10;
vec2 u_xlat12;
mediump vec3 u_xlat16_16;
float u_xlat20;
mediump float u_xlat16_20;
bool u_xlatb20;
float u_xlat30;
bool u_xlatb30;
float u_xlat32;
mediump float u_xlat16_35;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_20 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat16_1.x = u_xlat16_20 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb20 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb20) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat20 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat20<9.99999975e-06);
#else
    u_xlatb20 = u_xlat20<9.99999975e-06;
#endif
    u_xlat20 = (u_xlatb20) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat20 * u_xlat16_1.x;
    u_xlat4.x = u_xlat20 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat20 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat20 = sin(u_xlat20);
    u_xlat20 = u_xlat20 * _NormalRand.w;
    u_xlat20 = fract(u_xlat20);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat20) + u_xlat16_1.xyz;
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb20 = u_xlat4.z<0.00499999989;
#endif
    u_xlat32 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb20) ? 0.0 : u_xlat32;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat20 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * vs_TEXCOORD1.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat32 = u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat20 = u_xlat20 + u_xlat20;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat20)) + u_xlat2.xyz;
    u_xlat16_35 = (-u_xlat32) + 1.0;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_20;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_20;
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.x = (-u_xlat16_35) + _Smoothness;
    u_xlat16_6.x = u_xlat16_6.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_16.xyz = u_xlat16_7.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_16.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = u_xlat16_6.xxx + (-u_xlat16_8.xyz);
    u_xlat16_9.xyz = vec3(u_xlat16_20) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat7.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat7.xyz = vec3(u_xlat20) * u_xlat7.xyz;
    u_xlat20 = dot(u_xlat3.xyz, u_xlat7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat7.xyz);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat4.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat2.x = u_xlat2.x * 16.0;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat2.xxx;
    u_xlat16_6.xyz = u_xlat16_16.xyz * vec3(u_xlat16_35) + u_xlat16_8.xyz;
    u_xlat16_2.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_2.xyz = u_xlat16_2.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = vec3(u_xlat20) * u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz + u_xlat16_5.xyz;
    u_xlat16_6.xyz = (-u_xlat16_5.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_10 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_10 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_6.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat30 = max(u_xlat0.y, u_xlat0.x);
    u_xlat30 = max(u_xlat30, u_xlat0.z);
    u_xlatb2.xy = equal(vec4(u_xlat30), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat3.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat3.y = float(4.0);
    u_xlat3.w = float(0.0);
    u_xlat12.xy = (u_xlatb2.y) ? u_xlat1.yw : u_xlat3.xy;
    u_xlat2.xy = (u_xlatb2.x) ? u_xlat3.zw : u_xlat12.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat30;
    u_xlat10.x = u_xlat2.x / u_xlat0.x;
    u_xlat10.x = u_xlat10.x + u_xlat2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat10.x<0.0);
#else
    u_xlatb20 = u_xlat10.x<0.0;
#endif
    u_xlat20 = u_xlatb20 ? 1.0 : float(0.0);
    u_xlat10.x = u_xlat10.x * 0.166666672 + u_xlat20;
    u_xlat10.x = booster_Env.x * _DotStarHueSpeed + u_xlat10.x;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat20 = u_xlat10.x * 6.0;
    u_xlat20 = floor(u_xlat20);
    u_xlatb1 = lessThan(vec4(u_xlat20), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(u_xlat20<5.0);
#else
    u_xlatb2.x = u_xlat20<5.0;
#endif
    u_xlat10.x = u_xlat10.x * 6.0 + (-u_xlat20);
    u_xlat20 = max(u_xlat30, 0.00100000005);
    u_xlat3.z = u_xlat30 + u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat20;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat20 = u_xlat0.x * u_xlat10.x + (-u_xlat0.x);
    u_xlat10.x = (-u_xlat0.x) * u_xlat10.x + 1.0;
    u_xlat3.y = u_xlat10.x * u_xlat3.z;
    u_xlat10.x = u_xlat20 + 1.0;
    u_xlat3.w = u_xlat10.x * u_xlat3.z;
    u_xlat2.xz = (u_xlatb2.x) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat2.y = u_xlat3.x;
    u_xlat10.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat2.xyz;
    u_xlat10.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat10.xyz;
    u_xlat10.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat10.xyz;
    u_xlat10.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat10.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat10.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.0>=_DotParams.w);
#else
    u_xlatb30 = 0.0>=_DotParams.w;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlatb2 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
mediump vec3 u_xlat16_15;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat20;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_18 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_18 = (-u_xlat10_18) + 1.0;
    u_xlat16_1.x = u_xlat16_18 + (-_Cutout);
    u_xlatb18 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb18) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb18 = u_xlat18<9.99999975e-06;
    u_xlat18 = (u_xlatb18) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat18 * u_xlat16_1.x;
    u_xlat4.x = u_xlat18 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat18 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat18 = sin(u_xlat18);
    u_xlat18 = u_xlat18 * _NormalRand.w;
    u_xlat18 = fract(u_xlat18);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat16_1.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlatb29 = u_xlat18<0.00499999989;
    u_xlat30 = u_xlat18 * 8.29800034;
    u_xlat16_1.x = (u_xlatb29) ? 0.0 : u_xlat30;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat29 = u_xlat18 * u_xlat18;
    u_xlat16_32 = u_xlat18 * u_xlat29;
    u_xlat18 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat16_32 = (-u_xlat30) + 1.0;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_6 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_15.x = (-u_xlat16_6) + _Smoothness;
    u_xlat16_15.x = u_xlat16_15.x + 1.0;
    u_xlat16_15.x = clamp(u_xlat16_15.x, 0.0, 1.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_15.xyz = u_xlat16_15.xxx + (-u_xlat16_8.xyz);
    u_xlat16_15.xyz = vec3(u_xlat16_32) * u_xlat16_15.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_15.xyz;
    u_xlat4.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat30) + u_xlat2.xyz;
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat11 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat20 = max(u_xlat30, 0.319999993);
    u_xlat18 = u_xlat18 * u_xlat20;
    u_xlat20 = u_xlat29 * u_xlat29 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat20 + 1.00001001;
    u_xlat18 = u_xlat18 * u_xlat2.x;
    u_xlat18 = u_xlat29 / u_xlat18;
    u_xlat18 = u_xlat18 + -9.99999975e-05;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = min(u_xlat18, 100.0);
    u_xlat2.xzw = u_xlat16_8.xyz * vec3(u_xlat18);
    u_xlat2.xzw = u_xlat16_7.xyz * vec3(u_xlat16_6) + u_xlat2.xzw;
    u_xlat16_3.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat2.xzw = u_xlat2.xzw * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat2.xzw * vec3(u_xlat11) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_9 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_9 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat27 = max(u_xlat0.y, u_xlat0.x);
    u_xlat27 = max(u_xlat27, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat27), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat12.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat12.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat27;
    u_xlat9.x = u_xlat3.x / u_xlat0.x;
    u_xlat9.x = u_xlat9.x + u_xlat3.y;
    u_xlatb18 = u_xlat9.x<0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat9.x = u_xlat9.x * 0.166666672 + u_xlat18;
    u_xlat9.x = booster_Env.x * _DotStarHueSpeed + u_xlat9.x;
    u_xlat9.x = fract(u_xlat9.x);
    u_xlat18 = u_xlat9.x * 6.0;
    u_xlat18 = floor(u_xlat18);
    u_xlatb1 = lessThan(vec4(u_xlat18), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb29 = u_xlat18<5.0;
    u_xlat9.x = u_xlat9.x * 6.0 + (-u_xlat18);
    u_xlat18 = max(u_xlat27, 0.00100000005);
    u_xlat3.z = u_xlat27 + u_xlat27;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat18;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat18 = u_xlat0.x * u_xlat9.x + (-u_xlat0.x);
    u_xlat9.x = (-u_xlat0.x) * u_xlat9.x + 1.0;
    u_xlat3.y = u_xlat9.x * u_xlat3.z;
    u_xlat9.x = u_xlat18 + 1.0;
    u_xlat3.w = u_xlat9.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb29)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat9.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat9.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat9.xyz;
    u_xlat9.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat9.xyz;
    u_xlat9.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat9.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb27 = 0.0>=_DotParams.w;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD3.z;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlatb2 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
mediump vec3 u_xlat16_15;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat20;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_18 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_18 = (-u_xlat10_18) + 1.0;
    u_xlat16_1.x = u_xlat16_18 + (-_Cutout);
    u_xlatb18 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb18) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb18 = u_xlat18<9.99999975e-06;
    u_xlat18 = (u_xlatb18) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat18 * u_xlat16_1.x;
    u_xlat4.x = u_xlat18 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat18 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat18 = sin(u_xlat18);
    u_xlat18 = u_xlat18 * _NormalRand.w;
    u_xlat18 = fract(u_xlat18);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat16_1.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlatb29 = u_xlat18<0.00499999989;
    u_xlat30 = u_xlat18 * 8.29800034;
    u_xlat16_1.x = (u_xlatb29) ? 0.0 : u_xlat30;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat29 = u_xlat18 * u_xlat18;
    u_xlat16_32 = u_xlat18 * u_xlat29;
    u_xlat18 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat16_32 = (-u_xlat30) + 1.0;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_6 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_15.x = (-u_xlat16_6) + _Smoothness;
    u_xlat16_15.x = u_xlat16_15.x + 1.0;
    u_xlat16_15.x = clamp(u_xlat16_15.x, 0.0, 1.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_15.xyz = u_xlat16_15.xxx + (-u_xlat16_8.xyz);
    u_xlat16_15.xyz = vec3(u_xlat16_32) * u_xlat16_15.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_15.xyz;
    u_xlat4.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat30) + u_xlat2.xyz;
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat11 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat20 = max(u_xlat30, 0.319999993);
    u_xlat18 = u_xlat18 * u_xlat20;
    u_xlat20 = u_xlat29 * u_xlat29 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat20 + 1.00001001;
    u_xlat18 = u_xlat18 * u_xlat2.x;
    u_xlat18 = u_xlat29 / u_xlat18;
    u_xlat18 = u_xlat18 + -9.99999975e-05;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = min(u_xlat18, 100.0);
    u_xlat2.xzw = u_xlat16_8.xyz * vec3(u_xlat18);
    u_xlat2.xzw = u_xlat16_7.xyz * vec3(u_xlat16_6) + u_xlat2.xzw;
    u_xlat16_3.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat2.xzw = u_xlat2.xzw * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat2.xzw * vec3(u_xlat11) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_9 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_9 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat27 = max(u_xlat0.y, u_xlat0.x);
    u_xlat27 = max(u_xlat27, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat27), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat12.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat12.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat27;
    u_xlat9.x = u_xlat3.x / u_xlat0.x;
    u_xlat9.x = u_xlat9.x + u_xlat3.y;
    u_xlatb18 = u_xlat9.x<0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat9.x = u_xlat9.x * 0.166666672 + u_xlat18;
    u_xlat9.x = booster_Env.x * _DotStarHueSpeed + u_xlat9.x;
    u_xlat9.x = fract(u_xlat9.x);
    u_xlat18 = u_xlat9.x * 6.0;
    u_xlat18 = floor(u_xlat18);
    u_xlatb1 = lessThan(vec4(u_xlat18), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb29 = u_xlat18<5.0;
    u_xlat9.x = u_xlat9.x * 6.0 + (-u_xlat18);
    u_xlat18 = max(u_xlat27, 0.00100000005);
    u_xlat3.z = u_xlat27 + u_xlat27;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat18;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat18 = u_xlat0.x * u_xlat9.x + (-u_xlat0.x);
    u_xlat9.x = (-u_xlat0.x) * u_xlat9.x + 1.0;
    u_xlat3.y = u_xlat9.x * u_xlat3.z;
    u_xlat9.x = u_xlat18 + 1.0;
    u_xlat3.w = u_xlat9.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb29)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat9.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat9.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat9.xyz;
    u_xlat9.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat9.xyz;
    u_xlat9.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat9.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb27 = 0.0>=_DotParams.w;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD3.z;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb2 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
mediump vec3 u_xlat16_15;
float u_xlat18;
mediump float u_xlat16_18;
bool u_xlatb18;
float u_xlat20;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_18 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_18 = (-u_xlat16_18) + 1.0;
    u_xlat16_1.x = u_xlat16_18 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb18 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<9.99999975e-06);
#else
    u_xlatb18 = u_xlat18<9.99999975e-06;
#endif
    u_xlat18 = (u_xlatb18) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat18 * u_xlat16_1.x;
    u_xlat4.x = u_xlat18 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat18 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat18 = sin(u_xlat18);
    u_xlat18 = u_xlat18 * _NormalRand.w;
    u_xlat18 = fract(u_xlat18);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat16_1.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat18 = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb29 = !!(u_xlat18<0.00499999989);
#else
    u_xlatb29 = u_xlat18<0.00499999989;
#endif
    u_xlat30 = u_xlat18 * 8.29800034;
    u_xlat16_1.x = (u_xlatb29) ? 0.0 : u_xlat30;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat29 = u_xlat18 * u_xlat18;
    u_xlat16_32 = u_xlat18 * u_xlat29;
    u_xlat18 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_32 = (-u_xlat30) + 1.0;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_6 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_15.x = (-u_xlat16_6) + _Smoothness;
    u_xlat16_15.x = u_xlat16_15.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15.x = min(max(u_xlat16_15.x, 0.0), 1.0);
#else
    u_xlat16_15.x = clamp(u_xlat16_15.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_15.xyz = u_xlat16_15.xxx + (-u_xlat16_8.xyz);
    u_xlat16_15.xyz = vec3(u_xlat16_32) * u_xlat16_15.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_15.xyz;
    u_xlat4.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat30) + u_xlat2.xyz;
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat11 = dot(u_xlat3.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat20 = max(u_xlat30, 0.319999993);
    u_xlat18 = u_xlat18 * u_xlat20;
    u_xlat20 = u_xlat29 * u_xlat29 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat20 + 1.00001001;
    u_xlat18 = u_xlat18 * u_xlat2.x;
    u_xlat18 = u_xlat29 / u_xlat18;
    u_xlat18 = u_xlat18 + -9.99999975e-05;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = min(u_xlat18, 100.0);
    u_xlat2.xzw = u_xlat16_8.xyz * vec3(u_xlat18);
    u_xlat2.xzw = u_xlat16_7.xyz * vec3(u_xlat16_6) + u_xlat2.xzw;
    u_xlat16_3.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat2.xzw = u_xlat2.xzw * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat2.xzw * vec3(u_xlat11) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_9 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_9 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat27 = max(u_xlat0.y, u_xlat0.x);
    u_xlat27 = max(u_xlat27, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat27), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat12.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat12.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat27;
    u_xlat9.x = u_xlat3.x / u_xlat0.x;
    u_xlat9.x = u_xlat9.x + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat9.x<0.0);
#else
    u_xlatb18 = u_xlat9.x<0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat9.x = u_xlat9.x * 0.166666672 + u_xlat18;
    u_xlat9.x = booster_Env.x * _DotStarHueSpeed + u_xlat9.x;
    u_xlat9.x = fract(u_xlat9.x);
    u_xlat18 = u_xlat9.x * 6.0;
    u_xlat18 = floor(u_xlat18);
    u_xlatb1 = lessThan(vec4(u_xlat18), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb29 = !!(u_xlat18<5.0);
#else
    u_xlatb29 = u_xlat18<5.0;
#endif
    u_xlat9.x = u_xlat9.x * 6.0 + (-u_xlat18);
    u_xlat18 = max(u_xlat27, 0.00100000005);
    u_xlat3.z = u_xlat27 + u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat18;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat0.x * u_xlat9.x + (-u_xlat0.x);
    u_xlat9.x = (-u_xlat0.x) * u_xlat9.x + 1.0;
    u_xlat3.y = u_xlat9.x * u_xlat3.z;
    u_xlat9.x = u_xlat18 + 1.0;
    u_xlat3.w = u_xlat9.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb29)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat4.y = u_xlat3.x;
    u_xlat9.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat9.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat9.xyz;
    u_xlat9.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat9.xyz;
    u_xlat9.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat9.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0>=_DotParams.w);
#else
    u_xlatb27 = 0.0>=_DotParams.w;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb2 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
mediump vec3 u_xlat16_15;
float u_xlat18;
mediump float u_xlat16_18;
bool u_xlatb18;
float u_xlat20;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_18 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_18 = (-u_xlat16_18) + 1.0;
    u_xlat16_1.x = u_xlat16_18 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb18 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<9.99999975e-06);
#else
    u_xlatb18 = u_xlat18<9.99999975e-06;
#endif
    u_xlat18 = (u_xlatb18) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat18 * u_xlat16_1.x;
    u_xlat4.x = u_xlat18 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat18 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat18 = sin(u_xlat18);
    u_xlat18 = u_xlat18 * _NormalRand.w;
    u_xlat18 = fract(u_xlat18);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat16_1.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat18 = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb29 = !!(u_xlat18<0.00499999989);
#else
    u_xlatb29 = u_xlat18<0.00499999989;
#endif
    u_xlat30 = u_xlat18 * 8.29800034;
    u_xlat16_1.x = (u_xlatb29) ? 0.0 : u_xlat30;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat29 = u_xlat18 * u_xlat18;
    u_xlat16_32 = u_xlat18 * u_xlat29;
    u_xlat18 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_32 = (-u_xlat30) + 1.0;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_6 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_15.x = (-u_xlat16_6) + _Smoothness;
    u_xlat16_15.x = u_xlat16_15.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15.x = min(max(u_xlat16_15.x, 0.0), 1.0);
#else
    u_xlat16_15.x = clamp(u_xlat16_15.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_15.xyz = u_xlat16_15.xxx + (-u_xlat16_8.xyz);
    u_xlat16_15.xyz = vec3(u_xlat16_32) * u_xlat16_15.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_15.xyz;
    u_xlat4.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat30) + u_xlat2.xyz;
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat11 = dot(u_xlat3.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat20 = max(u_xlat30, 0.319999993);
    u_xlat18 = u_xlat18 * u_xlat20;
    u_xlat20 = u_xlat29 * u_xlat29 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat20 + 1.00001001;
    u_xlat18 = u_xlat18 * u_xlat2.x;
    u_xlat18 = u_xlat29 / u_xlat18;
    u_xlat18 = u_xlat18 + -9.99999975e-05;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = min(u_xlat18, 100.0);
    u_xlat2.xzw = u_xlat16_8.xyz * vec3(u_xlat18);
    u_xlat2.xzw = u_xlat16_7.xyz * vec3(u_xlat16_6) + u_xlat2.xzw;
    u_xlat16_3.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat2.xzw = u_xlat2.xzw * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat2.xzw * vec3(u_xlat11) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_9 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_9 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat27 = max(u_xlat0.y, u_xlat0.x);
    u_xlat27 = max(u_xlat27, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat27), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat12.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat12.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat27;
    u_xlat9.x = u_xlat3.x / u_xlat0.x;
    u_xlat9.x = u_xlat9.x + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat9.x<0.0);
#else
    u_xlatb18 = u_xlat9.x<0.0;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat9.x = u_xlat9.x * 0.166666672 + u_xlat18;
    u_xlat9.x = booster_Env.x * _DotStarHueSpeed + u_xlat9.x;
    u_xlat9.x = fract(u_xlat9.x);
    u_xlat18 = u_xlat9.x * 6.0;
    u_xlat18 = floor(u_xlat18);
    u_xlatb1 = lessThan(vec4(u_xlat18), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb29 = !!(u_xlat18<5.0);
#else
    u_xlatb29 = u_xlat18<5.0;
#endif
    u_xlat9.x = u_xlat9.x * 6.0 + (-u_xlat18);
    u_xlat18 = max(u_xlat27, 0.00100000005);
    u_xlat3.z = u_xlat27 + u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat18;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat0.x * u_xlat9.x + (-u_xlat0.x);
    u_xlat9.x = (-u_xlat0.x) * u_xlat9.x + 1.0;
    u_xlat3.y = u_xlat9.x * u_xlat3.z;
    u_xlat9.x = u_xlat18 + 1.0;
    u_xlat3.w = u_xlat9.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb29)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat4.y = u_xlat3.x;
    u_xlat9.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat9.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat9.xyz;
    u_xlat9.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat9.xyz;
    u_xlat9.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat9.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0>=_DotParams.w);
#else
    u_xlatb27 = 0.0>=_DotParams.w;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat12 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat12;
    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
    u_xlatb1 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb1) ? u_xlat12 : 1.0;
    u_xlat12 = _DotParams.x / _DotSplitU;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.y = (-u_xlat12);
    u_xlat1.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat1.xy / vec2(_DotSplitU, _DotSplitV);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec2 u_xlat14;
float u_xlat22;
mediump float u_xlat16_22;
lowp float u_xlat10_22;
bool u_xlatb22;
float u_xlat33;
bool u_xlatb33;
mediump float u_xlat16_35;
float u_xlat36;
mediump float u_xlat16_37;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_22 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_22 = (-u_xlat10_22) + 1.0;
    u_xlat16_1 = u_xlat16_22 + (-_Cutout);
    u_xlatb22 = u_xlat16_1<0.0;
    if(((int(u_xlatb22) * -1))!=0){discard;}
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_35 = dot((-u_xlat3.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_35 = u_xlat16_35 + u_xlat16_35;
    u_xlat16_4.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_35)) + (-u_xlat3.xyz);
    u_xlat22 = dot(u_xlat16_4.zxy, (-u_xlat16_4.xyz));
    u_xlatb22 = u_xlat22<9.99999975e-06;
    u_xlat22 = (u_xlatb22) ? u_xlat16_4.z : (-u_xlat16_4.z);
    u_xlat5.z = u_xlat22 * u_xlat16_4.x;
    u_xlat6.x = u_xlat22 * u_xlat16_4.z;
    u_xlat5.xy = (-u_xlat16_4.xy) * u_xlat16_4.yz;
    u_xlat6.yz = (-u_xlat16_4.xy) * u_xlat16_4.xy;
    u_xlat5.xyz = u_xlat5.xyz + (-u_xlat6.xyz);
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_NormalDiff);
    u_xlat22 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat22 = sin(u_xlat22);
    u_xlat22 = u_xlat22 * _NormalRand.w;
    u_xlat22 = fract(u_xlat22);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat22) + u_xlat16_4.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * u_xlat5.xyz;
    u_xlat6.z = (-_Smoothness) + 1.0;
    u_xlatb22 = u_xlat6.z<0.00499999989;
    u_xlat36 = u_xlat6.z * 8.29800034;
    u_xlat16_35 = (u_xlatb22) ? 0.0 : u_xlat36;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat5.xyz, u_xlat16_35);
    u_xlat16_35 = u_xlat10_1.w + -1.0;
    u_xlat16_35 = unity_SpecCube0_HDR.w * u_xlat16_35 + 1.0;
    u_xlat16_35 = u_xlat16_35 * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(u_xlat16_35);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat36 = u_xlat22;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat22 = u_xlat22 + u_xlat22;
    u_xlat3.xyz = u_xlat5.xyz * (-vec3(u_xlat22)) + u_xlat3.xyz;
    u_xlat16_35 = (-u_xlat36) + 1.0;
    u_xlat16_22 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_22 = u_xlat16_35 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_35 * u_xlat16_22;
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_37 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_37 = u_xlat16_37 + 1.0;
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
    u_xlat16_7.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_9.xyz = u_xlat16_8.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz;
    u_xlat16_9.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_9.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_10.xyz = vec3(u_xlat16_37) + (-u_xlat16_9.xyz);
    u_xlat16_10.xyz = vec3(u_xlat16_22) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_10.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz + u_xlat16_4.xyz;
    u_xlat7.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat22 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat7.xyz = vec3(u_xlat22) * u_xlat7.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat6.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = texture2D(unity_NHxRoughness, u_xlat6.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_4.xyz = u_xlat3.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_3.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = vec3(u_xlat22) * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_2.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_11 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_4.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat33 = max(u_xlat0.y, u_xlat0.x);
    u_xlat33 = max(u_xlat33, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat33), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat14.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat14.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat33;
    u_xlat11.x = u_xlat3.x / u_xlat0.x;
    u_xlat11.x = u_xlat11.x + u_xlat3.y;
    u_xlatb22 = u_xlat11.x<0.0;
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat11.x = u_xlat11.x * 0.166666672 + u_xlat22;
    u_xlat11.x = booster_Env.x * _DotStarHueSpeed + u_xlat11.x;
    u_xlat11.x = fract(u_xlat11.x);
    u_xlat22 = u_xlat11.x * 6.0;
    u_xlat22 = floor(u_xlat22);
    u_xlatb1 = lessThan(vec4(u_xlat22), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb3.x = u_xlat22<5.0;
    u_xlat11.x = u_xlat11.x * 6.0 + (-u_xlat22);
    u_xlat22 = max(u_xlat33, 0.00100000005);
    u_xlat4.z = u_xlat33 + u_xlat33;
    u_xlat4.z = clamp(u_xlat4.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat22;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat22 = u_xlat0.x * u_xlat11.x + (-u_xlat0.x);
    u_xlat11.x = (-u_xlat0.x) * u_xlat11.x + 1.0;
    u_xlat4.y = u_xlat11.x * u_xlat4.z;
    u_xlat11.x = u_xlat22 + 1.0;
    u_xlat4.w = u_xlat11.x * u_xlat4.z;
    u_xlat3.xz = (u_xlatb3.x) ? u_xlat4.wz : u_xlat4.zy;
    u_xlat4.x = (-u_xlat4.z) * u_xlat0.x + u_xlat4.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat3.y = u_xlat4.x;
    u_xlat11.xyz = (u_xlatb1.w) ? u_xlat4.xyz : u_xlat3.xyz;
    u_xlat11.xyz = (u_xlatb1.z) ? u_xlat4.xzw : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb1.y) ? u_xlat4.yzx : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb1.x) ? u_xlat4.zwx : u_xlat11.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat4.zzz : u_xlat11.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat16_2.xyz;
    u_xlatb33 = 0.0>=_DotParams.w;
    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD3.z;
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat12 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat12;
    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb1 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb1) ? u_xlat12 : 1.0;
    u_xlat12 = _DotParams.x / _DotSplitU;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.y = (-u_xlat12);
    u_xlat1.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat1.xy / vec2(_DotSplitU, _DotSplitV);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec2 u_xlat14;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat33;
bool u_xlatb33;
mediump float u_xlat16_35;
float u_xlat36;
mediump float u_xlat16_37;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_22 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
    u_xlat16_1.x = u_xlat16_22 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb22 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb22) * int(0xffffffffu)))!=0){discard;}
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_35 = dot((-u_xlat3.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_35 = u_xlat16_35 + u_xlat16_35;
    u_xlat16_4.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_35)) + (-u_xlat3.xyz);
    u_xlat22 = dot(u_xlat16_4.zxy, (-u_xlat16_4.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat22<9.99999975e-06);
#else
    u_xlatb22 = u_xlat22<9.99999975e-06;
#endif
    u_xlat22 = (u_xlatb22) ? u_xlat16_4.z : (-u_xlat16_4.z);
    u_xlat5.z = u_xlat22 * u_xlat16_4.x;
    u_xlat6.x = u_xlat22 * u_xlat16_4.z;
    u_xlat5.xy = (-u_xlat16_4.xy) * u_xlat16_4.yz;
    u_xlat6.yz = (-u_xlat16_4.xy) * u_xlat16_4.xy;
    u_xlat5.xyz = u_xlat5.xyz + (-u_xlat6.xyz);
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_NormalDiff);
    u_xlat22 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat22 = sin(u_xlat22);
    u_xlat22 = u_xlat22 * _NormalRand.w;
    u_xlat22 = fract(u_xlat22);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat22) + u_xlat16_4.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * u_xlat5.xyz;
    u_xlat6.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat6.z<0.00499999989);
#else
    u_xlatb22 = u_xlat6.z<0.00499999989;
#endif
    u_xlat36 = u_xlat6.z * 8.29800034;
    u_xlat16_35 = (u_xlatb22) ? 0.0 : u_xlat36;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat5.xyz, u_xlat16_35);
    u_xlat16_35 = u_xlat16_1.w + -1.0;
    u_xlat16_35 = unity_SpecCube0_HDR.w * u_xlat16_35 + 1.0;
    u_xlat16_35 = u_xlat16_35 * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * vec3(u_xlat16_35);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat36 = u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat22 = u_xlat22 + u_xlat22;
    u_xlat3.xyz = u_xlat5.xyz * (-vec3(u_xlat22)) + u_xlat3.xyz;
    u_xlat16_35 = (-u_xlat36) + 1.0;
    u_xlat16_22 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_22 = u_xlat16_35 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_35 * u_xlat16_22;
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_37 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_37 = u_xlat16_37 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_9.xyz = u_xlat16_8.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz;
    u_xlat16_9.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_9.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_10.xyz = vec3(u_xlat16_37) + (-u_xlat16_9.xyz);
    u_xlat16_10.xyz = vec3(u_xlat16_22) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_10.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz + u_xlat16_4.xyz;
    u_xlat7.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat22 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat7.xyz = vec3(u_xlat22) * u_xlat7.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat6.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = texture(unity_NHxRoughness, u_xlat6.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_4.xyz = u_xlat3.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_3.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = vec3(u_xlat22) * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_2.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_11 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_4.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat33 = max(u_xlat0.y, u_xlat0.x);
    u_xlat33 = max(u_xlat33, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat33), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat14.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat14.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat33;
    u_xlat11.x = u_xlat3.x / u_xlat0.x;
    u_xlat11.x = u_xlat11.x + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat11.x<0.0);
#else
    u_xlatb22 = u_xlat11.x<0.0;
#endif
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat11.x = u_xlat11.x * 0.166666672 + u_xlat22;
    u_xlat11.x = booster_Env.x * _DotStarHueSpeed + u_xlat11.x;
    u_xlat11.x = fract(u_xlat11.x);
    u_xlat22 = u_xlat11.x * 6.0;
    u_xlat22 = floor(u_xlat22);
    u_xlatb1 = lessThan(vec4(u_xlat22), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat22<5.0);
#else
    u_xlatb3.x = u_xlat22<5.0;
#endif
    u_xlat11.x = u_xlat11.x * 6.0 + (-u_xlat22);
    u_xlat22 = max(u_xlat33, 0.00100000005);
    u_xlat4.z = u_xlat33 + u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.z = min(max(u_xlat4.z, 0.0), 1.0);
#else
    u_xlat4.z = clamp(u_xlat4.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat22;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat22 = u_xlat0.x * u_xlat11.x + (-u_xlat0.x);
    u_xlat11.x = (-u_xlat0.x) * u_xlat11.x + 1.0;
    u_xlat4.y = u_xlat11.x * u_xlat4.z;
    u_xlat11.x = u_xlat22 + 1.0;
    u_xlat4.w = u_xlat11.x * u_xlat4.z;
    u_xlat3.xz = (u_xlatb3.x) ? u_xlat4.wz : u_xlat4.zy;
    u_xlat4.x = (-u_xlat4.z) * u_xlat0.x + u_xlat4.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat3.y = u_xlat4.x;
    u_xlat11.xyz = (u_xlatb1.w) ? u_xlat4.xyz : u_xlat3.xyz;
    u_xlat11.xyz = (u_xlatb1.z) ? u_xlat4.xzw : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb1.y) ? u_xlat4.yzx : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb1.x) ? u_xlat4.zwx : u_xlat11.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat4.zzz : u_xlat11.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0.0>=_DotParams.w);
#else
    u_xlatb33 = 0.0>=_DotParams.w;
#endif
    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat12 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat12;
    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
    u_xlatb1 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb1) ? u_xlat12 : 1.0;
    u_xlat12 = _DotParams.x / _DotSplitU;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.y = (-u_xlat12);
    u_xlat1.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat1.xy / vec2(_DotSplitU, _DotSplitV);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat15;
float u_xlat24;
mediump float u_xlat16_24;
lowp float u_xlat10_24;
bool u_xlatb24;
float u_xlat36;
bool u_xlatb36;
float u_xlat38;
bool u_xlatb38;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_24 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat10_24) + 1.0;
    u_xlat16_1.x = u_xlat16_24 + (-_Cutout);
    u_xlatb24 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb24) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat24 * u_xlat16_1.x;
    u_xlat4.x = u_xlat24 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-_Smoothness) + 1.0;
    u_xlatb38 = u_xlat24<0.00499999989;
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? 0.0 : u_xlat39;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = u_xlat24 * u_xlat38;
    u_xlat24 = u_xlat24 * u_xlat24 + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat39) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat6.xyz = vec3(u_xlat39) * vs_TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat39 = u_xlat39 * u_xlat4.x + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_41);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_10.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_11.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_11.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_11.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_11.xyz = u_xlat16_11.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_41 = (-u_xlat2.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_12 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat36), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
    u_xlatb24 = u_xlat12.x<0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = u_xlat12.x * 0.166666672 + u_xlat24;
    u_xlat12.x = booster_Env.x * _DotStarHueSpeed + u_xlat12.x;
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = lessThan(vec4(u_xlat24), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb38 = u_xlat24<5.0;
    u_xlat12.x = u_xlat12.x * 6.0 + (-u_xlat24);
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat24 = u_xlat0.x * u_xlat12.x + (-u_xlat0.x);
    u_xlat12.x = (-u_xlat0.x) * u_xlat12.x + 1.0;
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb36 = 0.0>=_DotParams.w;
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.z;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat12 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat12;
    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
    u_xlatb1 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb1) ? u_xlat12 : 1.0;
    u_xlat12 = _DotParams.x / _DotSplitU;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.y = (-u_xlat12);
    u_xlat1.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat1.xy / vec2(_DotSplitU, _DotSplitV);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat15;
float u_xlat24;
mediump float u_xlat16_24;
lowp float u_xlat10_24;
bool u_xlatb24;
float u_xlat36;
bool u_xlatb36;
float u_xlat38;
bool u_xlatb38;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_24 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat10_24) + 1.0;
    u_xlat16_1.x = u_xlat16_24 + (-_Cutout);
    u_xlatb24 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb24) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat24 * u_xlat16_1.x;
    u_xlat4.x = u_xlat24 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-_Smoothness) + 1.0;
    u_xlatb38 = u_xlat24<0.00499999989;
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? 0.0 : u_xlat39;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = u_xlat24 * u_xlat38;
    u_xlat24 = u_xlat24 * u_xlat24 + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat39) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat6.xyz = vec3(u_xlat39) * vs_TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat39 = u_xlat39 * u_xlat4.x + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_41);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_10.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_11.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_11.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_11.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_11.xyz = u_xlat16_11.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_41 = (-u_xlat2.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_12 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat36), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
    u_xlatb24 = u_xlat12.x<0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = u_xlat12.x * 0.166666672 + u_xlat24;
    u_xlat12.x = booster_Env.x * _DotStarHueSpeed + u_xlat12.x;
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = lessThan(vec4(u_xlat24), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb38 = u_xlat24<5.0;
    u_xlat12.x = u_xlat12.x * 6.0 + (-u_xlat24);
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat24 = u_xlat0.x * u_xlat12.x + (-u_xlat0.x);
    u_xlat12.x = (-u_xlat0.x) * u_xlat12.x + 1.0;
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb36 = 0.0>=_DotParams.w;
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.z;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat12 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat12;
    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb1 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb1) ? u_xlat12 : 1.0;
    u_xlat12 = _DotParams.x / _DotSplitU;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.y = (-u_xlat12);
    u_xlat1.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat1.xy / vec2(_DotSplitU, _DotSplitV);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat15;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
float u_xlat36;
bool u_xlatb36;
float u_xlat38;
bool u_xlatb38;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_24 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_1.x = u_xlat16_24 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb24) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<9.99999975e-06);
#else
    u_xlatb24 = u_xlat24<9.99999975e-06;
#endif
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat24 * u_xlat16_1.x;
    u_xlat4.x = u_xlat24 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb38 = !!(u_xlat24<0.00499999989);
#else
    u_xlatb38 = u_xlat24<0.00499999989;
#endif
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? 0.0 : u_xlat39;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = u_xlat24 * u_xlat38;
    u_xlat24 = u_xlat24 * u_xlat24 + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat39) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat6.xyz = vec3(u_xlat39) * vs_TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat39 = u_xlat39 * u_xlat4.x + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_41);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_10.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_11.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_11.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_11.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_11.xyz = u_xlat16_11.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat2.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_12 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat36), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat12.x<0.0);
#else
    u_xlatb24 = u_xlat12.x<0.0;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = u_xlat12.x * 0.166666672 + u_xlat24;
    u_xlat12.x = booster_Env.x * _DotStarHueSpeed + u_xlat12.x;
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = lessThan(vec4(u_xlat24), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb38 = !!(u_xlat24<5.0);
#else
    u_xlatb38 = u_xlat24<5.0;
#endif
    u_xlat12.x = u_xlat12.x * 6.0 + (-u_xlat24);
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat0.x * u_xlat12.x + (-u_xlat0.x);
    u_xlat12.x = (-u_xlat0.x) * u_xlat12.x + 1.0;
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.0>=_DotParams.w);
#else
    u_xlatb36 = 0.0>=_DotParams.w;
#endif
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat12 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat12;
    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb1 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb1) ? u_xlat12 : 1.0;
    u_xlat12 = _DotParams.x / _DotSplitU;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.y = (-u_xlat12);
    u_xlat1.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat1.xy / vec2(_DotSplitU, _DotSplitV);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat15;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
float u_xlat36;
bool u_xlatb36;
float u_xlat38;
bool u_xlatb38;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_24 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_1.x = u_xlat16_24 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb24) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<9.99999975e-06);
#else
    u_xlatb24 = u_xlat24<9.99999975e-06;
#endif
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat24 * u_xlat16_1.x;
    u_xlat4.x = u_xlat24 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb38 = !!(u_xlat24<0.00499999989);
#else
    u_xlatb38 = u_xlat24<0.00499999989;
#endif
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? 0.0 : u_xlat39;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = u_xlat24 * u_xlat38;
    u_xlat24 = u_xlat24 * u_xlat24 + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat39) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat6.xyz = vec3(u_xlat39) * vs_TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat39 = u_xlat39 * u_xlat4.x + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_41);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_10.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_11.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_11.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_11.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_11.xyz = u_xlat16_11.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat2.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_12 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat36), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat12.x<0.0);
#else
    u_xlatb24 = u_xlat12.x<0.0;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = u_xlat12.x * 0.166666672 + u_xlat24;
    u_xlat12.x = booster_Env.x * _DotStarHueSpeed + u_xlat12.x;
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = lessThan(vec4(u_xlat24), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb38 = !!(u_xlat24<5.0);
#else
    u_xlatb38 = u_xlat24<5.0;
#endif
    u_xlat12.x = u_xlat12.x * 6.0 + (-u_xlat24);
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat0.x * u_xlat12.x + (-u_xlat0.x);
    u_xlat12.x = (-u_xlat0.x) * u_xlat12.x + 1.0;
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.0>=_DotParams.w);
#else
    u_xlatb36 = 0.0>=_DotParams.w;
#endif
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat12 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat12;
    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
    u_xlatb1 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb1) ? u_xlat12 : 1.0;
    u_xlat12 = _DotParams.x / _DotSplitU;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.y = (-u_xlat12);
    u_xlat1.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat1.xy / vec2(_DotSplitU, _DotSplitV);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec2 u_xlat14;
float u_xlat22;
mediump float u_xlat16_22;
lowp float u_xlat10_22;
bool u_xlatb22;
float u_xlat33;
bool u_xlatb33;
mediump float u_xlat16_35;
float u_xlat36;
mediump float u_xlat16_37;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_22 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_22 = (-u_xlat10_22) + 1.0;
    u_xlat16_1 = u_xlat16_22 + (-_Cutout);
    u_xlatb22 = u_xlat16_1<0.0;
    if(((int(u_xlatb22) * -1))!=0){discard;}
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_35 = dot((-u_xlat3.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_35 = u_xlat16_35 + u_xlat16_35;
    u_xlat16_4.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_35)) + (-u_xlat3.xyz);
    u_xlat22 = dot(u_xlat16_4.zxy, (-u_xlat16_4.xyz));
    u_xlatb22 = u_xlat22<9.99999975e-06;
    u_xlat22 = (u_xlatb22) ? u_xlat16_4.z : (-u_xlat16_4.z);
    u_xlat5.z = u_xlat22 * u_xlat16_4.x;
    u_xlat6.x = u_xlat22 * u_xlat16_4.z;
    u_xlat5.xy = (-u_xlat16_4.xy) * u_xlat16_4.yz;
    u_xlat6.yz = (-u_xlat16_4.xy) * u_xlat16_4.xy;
    u_xlat5.xyz = u_xlat5.xyz + (-u_xlat6.xyz);
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_NormalDiff);
    u_xlat22 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat22 = sin(u_xlat22);
    u_xlat22 = u_xlat22 * _NormalRand.w;
    u_xlat22 = fract(u_xlat22);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat22) + u_xlat16_4.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * u_xlat5.xyz;
    u_xlat6.z = (-_Smoothness) + 1.0;
    u_xlatb22 = u_xlat6.z<0.00499999989;
    u_xlat36 = u_xlat6.z * 8.29800034;
    u_xlat16_35 = (u_xlatb22) ? 0.0 : u_xlat36;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat5.xyz, u_xlat16_35);
    u_xlat16_35 = u_xlat10_1.w + -1.0;
    u_xlat16_35 = unity_SpecCube0_HDR.w * u_xlat16_35 + 1.0;
    u_xlat16_35 = u_xlat16_35 * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(u_xlat16_35);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat36 = u_xlat22;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat22 = u_xlat22 + u_xlat22;
    u_xlat3.xyz = u_xlat5.xyz * (-vec3(u_xlat22)) + u_xlat3.xyz;
    u_xlat16_35 = (-u_xlat36) + 1.0;
    u_xlat16_22 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_22 = u_xlat16_35 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_35 * u_xlat16_22;
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_37 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_37 = u_xlat16_37 + 1.0;
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
    u_xlat16_7.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_9.xyz = u_xlat16_8.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz;
    u_xlat16_9.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_9.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_10.xyz = vec3(u_xlat16_37) + (-u_xlat16_9.xyz);
    u_xlat16_10.xyz = vec3(u_xlat16_22) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_10.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz + u_xlat16_4.xyz;
    u_xlat7.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat22 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat7.xyz = vec3(u_xlat22) * u_xlat7.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat6.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = texture2D(unity_NHxRoughness, u_xlat6.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_4.xyz = u_xlat3.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_35 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_3.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = vec3(u_xlat16_35) * u_xlat16_3.xyz;
    u_xlat16_8.xyz = vec3(u_xlat22) * u_xlat16_8.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_2.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_11 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_4.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat33 = max(u_xlat0.y, u_xlat0.x);
    u_xlat33 = max(u_xlat33, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat33), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat14.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat14.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat33;
    u_xlat11.x = u_xlat3.x / u_xlat0.x;
    u_xlat11.x = u_xlat11.x + u_xlat3.y;
    u_xlatb22 = u_xlat11.x<0.0;
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat11.x = u_xlat11.x * 0.166666672 + u_xlat22;
    u_xlat11.x = booster_Env.x * _DotStarHueSpeed + u_xlat11.x;
    u_xlat11.x = fract(u_xlat11.x);
    u_xlat22 = u_xlat11.x * 6.0;
    u_xlat22 = floor(u_xlat22);
    u_xlatb1 = lessThan(vec4(u_xlat22), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb3.x = u_xlat22<5.0;
    u_xlat11.x = u_xlat11.x * 6.0 + (-u_xlat22);
    u_xlat22 = max(u_xlat33, 0.00100000005);
    u_xlat4.z = u_xlat33 + u_xlat33;
    u_xlat4.z = clamp(u_xlat4.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat22;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat22 = u_xlat0.x * u_xlat11.x + (-u_xlat0.x);
    u_xlat11.x = (-u_xlat0.x) * u_xlat11.x + 1.0;
    u_xlat4.y = u_xlat11.x * u_xlat4.z;
    u_xlat11.x = u_xlat22 + 1.0;
    u_xlat4.w = u_xlat11.x * u_xlat4.z;
    u_xlat3.xz = (u_xlatb3.x) ? u_xlat4.wz : u_xlat4.zy;
    u_xlat4.x = (-u_xlat4.z) * u_xlat0.x + u_xlat4.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat3.y = u_xlat4.x;
    u_xlat11.xyz = (u_xlatb1.w) ? u_xlat4.xyz : u_xlat3.xyz;
    u_xlat11.xyz = (u_xlatb1.z) ? u_xlat4.xzw : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb1.y) ? u_xlat4.yzx : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb1.x) ? u_xlat4.zwx : u_xlat11.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat4.zzz : u_xlat11.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat16_2.xyz;
    u_xlatb33 = 0.0>=_DotParams.w;
    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD3.z;
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat12 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat12;
    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb1 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb1) ? u_xlat12 : 1.0;
    u_xlat12 = _DotParams.x / _DotSplitU;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.y = (-u_xlat12);
    u_xlat1.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat1.xy / vec2(_DotSplitU, _DotSplitV);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec2 u_xlat14;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat33;
bool u_xlatb33;
mediump float u_xlat16_35;
float u_xlat36;
mediump float u_xlat16_37;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_22 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
    u_xlat16_1.x = u_xlat16_22 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb22 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb22) * int(0xffffffffu)))!=0){discard;}
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_35 = dot((-u_xlat3.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_35 = u_xlat16_35 + u_xlat16_35;
    u_xlat16_4.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_35)) + (-u_xlat3.xyz);
    u_xlat22 = dot(u_xlat16_4.zxy, (-u_xlat16_4.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat22<9.99999975e-06);
#else
    u_xlatb22 = u_xlat22<9.99999975e-06;
#endif
    u_xlat22 = (u_xlatb22) ? u_xlat16_4.z : (-u_xlat16_4.z);
    u_xlat5.z = u_xlat22 * u_xlat16_4.x;
    u_xlat6.x = u_xlat22 * u_xlat16_4.z;
    u_xlat5.xy = (-u_xlat16_4.xy) * u_xlat16_4.yz;
    u_xlat6.yz = (-u_xlat16_4.xy) * u_xlat16_4.xy;
    u_xlat5.xyz = u_xlat5.xyz + (-u_xlat6.xyz);
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_NormalDiff);
    u_xlat22 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat22 = sin(u_xlat22);
    u_xlat22 = u_xlat22 * _NormalRand.w;
    u_xlat22 = fract(u_xlat22);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat22) + u_xlat16_4.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * u_xlat5.xyz;
    u_xlat6.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat6.z<0.00499999989);
#else
    u_xlatb22 = u_xlat6.z<0.00499999989;
#endif
    u_xlat36 = u_xlat6.z * 8.29800034;
    u_xlat16_35 = (u_xlatb22) ? 0.0 : u_xlat36;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat5.xyz, u_xlat16_35);
    u_xlat16_35 = u_xlat16_1.w + -1.0;
    u_xlat16_35 = unity_SpecCube0_HDR.w * u_xlat16_35 + 1.0;
    u_xlat16_35 = u_xlat16_35 * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * vec3(u_xlat16_35);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat36 = u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat22 = u_xlat22 + u_xlat22;
    u_xlat3.xyz = u_xlat5.xyz * (-vec3(u_xlat22)) + u_xlat3.xyz;
    u_xlat16_35 = (-u_xlat36) + 1.0;
    u_xlat16_22 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_22 = u_xlat16_35 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_35 * u_xlat16_22;
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_37 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_37 = u_xlat16_37 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_9.xyz = u_xlat16_8.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz;
    u_xlat16_9.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_9.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_10.xyz = vec3(u_xlat16_37) + (-u_xlat16_9.xyz);
    u_xlat16_10.xyz = vec3(u_xlat16_22) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_10.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz + u_xlat16_4.xyz;
    u_xlat7.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat22 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat7.xyz = vec3(u_xlat22) * u_xlat7.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat6.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = texture(unity_NHxRoughness, u_xlat6.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_4.xyz = u_xlat3.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = vec3(u_xlat16_35) * u_xlat16_3.xyz;
    u_xlat16_8.xyz = vec3(u_xlat22) * u_xlat16_8.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_2.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_11 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_4.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat33 = max(u_xlat0.y, u_xlat0.x);
    u_xlat33 = max(u_xlat33, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat33), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat14.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat14.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat33;
    u_xlat11.x = u_xlat3.x / u_xlat0.x;
    u_xlat11.x = u_xlat11.x + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat11.x<0.0);
#else
    u_xlatb22 = u_xlat11.x<0.0;
#endif
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat11.x = u_xlat11.x * 0.166666672 + u_xlat22;
    u_xlat11.x = booster_Env.x * _DotStarHueSpeed + u_xlat11.x;
    u_xlat11.x = fract(u_xlat11.x);
    u_xlat22 = u_xlat11.x * 6.0;
    u_xlat22 = floor(u_xlat22);
    u_xlatb1 = lessThan(vec4(u_xlat22), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat22<5.0);
#else
    u_xlatb3.x = u_xlat22<5.0;
#endif
    u_xlat11.x = u_xlat11.x * 6.0 + (-u_xlat22);
    u_xlat22 = max(u_xlat33, 0.00100000005);
    u_xlat4.z = u_xlat33 + u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.z = min(max(u_xlat4.z, 0.0), 1.0);
#else
    u_xlat4.z = clamp(u_xlat4.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat22;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat22 = u_xlat0.x * u_xlat11.x + (-u_xlat0.x);
    u_xlat11.x = (-u_xlat0.x) * u_xlat11.x + 1.0;
    u_xlat4.y = u_xlat11.x * u_xlat4.z;
    u_xlat11.x = u_xlat22 + 1.0;
    u_xlat4.w = u_xlat11.x * u_xlat4.z;
    u_xlat3.xz = (u_xlatb3.x) ? u_xlat4.wz : u_xlat4.zy;
    u_xlat4.x = (-u_xlat4.z) * u_xlat0.x + u_xlat4.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat3.y = u_xlat4.x;
    u_xlat11.xyz = (u_xlatb1.w) ? u_xlat4.xyz : u_xlat3.xyz;
    u_xlat11.xyz = (u_xlatb1.z) ? u_xlat4.xzw : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb1.y) ? u_xlat4.yzx : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb1.x) ? u_xlat4.zwx : u_xlat11.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat4.zzz : u_xlat11.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0.0>=_DotParams.w);
#else
    u_xlatb33 = 0.0>=_DotParams.w;
#endif
    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat12 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat12;
    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
    u_xlatb1 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb1) ? u_xlat12 : 1.0;
    u_xlat12 = _DotParams.x / _DotSplitU;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.y = (-u_xlat12);
    u_xlat1.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat1.xy / vec2(_DotSplitU, _DotSplitV);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat15;
float u_xlat24;
mediump float u_xlat16_24;
lowp float u_xlat10_24;
bool u_xlatb24;
float u_xlat36;
bool u_xlatb36;
float u_xlat38;
bool u_xlatb38;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_24 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat10_24) + 1.0;
    u_xlat16_1.x = u_xlat16_24 + (-_Cutout);
    u_xlatb24 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb24) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat24 * u_xlat16_1.x;
    u_xlat4.x = u_xlat24 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-_Smoothness) + 1.0;
    u_xlatb38 = u_xlat24<0.00499999989;
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? 0.0 : u_xlat39;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = u_xlat24 * u_xlat38;
    u_xlat24 = u_xlat24 * u_xlat24 + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat39) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat6.xyz = vec3(u_xlat39) * vs_TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat39 = u_xlat39 * u_xlat4.x + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_41);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_41 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_11.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_11.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_11.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_11.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_11.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_11.xyz = u_xlat16_11.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_41 = (-u_xlat2.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_12 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat36), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
    u_xlatb24 = u_xlat12.x<0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = u_xlat12.x * 0.166666672 + u_xlat24;
    u_xlat12.x = booster_Env.x * _DotStarHueSpeed + u_xlat12.x;
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = lessThan(vec4(u_xlat24), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb38 = u_xlat24<5.0;
    u_xlat12.x = u_xlat12.x * 6.0 + (-u_xlat24);
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat24 = u_xlat0.x * u_xlat12.x + (-u_xlat0.x);
    u_xlat12.x = (-u_xlat0.x) * u_xlat12.x + 1.0;
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb36 = 0.0>=_DotParams.w;
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.z;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat12 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat12;
    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
    u_xlatb1 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb1) ? u_xlat12 : 1.0;
    u_xlat12 = _DotParams.x / _DotSplitU;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.y = (-u_xlat12);
    u_xlat1.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat1.xy / vec2(_DotSplitU, _DotSplitV);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat15;
float u_xlat24;
mediump float u_xlat16_24;
lowp float u_xlat10_24;
bool u_xlatb24;
float u_xlat36;
bool u_xlatb36;
float u_xlat38;
bool u_xlatb38;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_24 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat10_24) + 1.0;
    u_xlat16_1.x = u_xlat16_24 + (-_Cutout);
    u_xlatb24 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb24) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat24 * u_xlat16_1.x;
    u_xlat4.x = u_xlat24 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-_Smoothness) + 1.0;
    u_xlatb38 = u_xlat24<0.00499999989;
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? 0.0 : u_xlat39;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = u_xlat24 * u_xlat38;
    u_xlat24 = u_xlat24 * u_xlat24 + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat39) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat6.xyz = vec3(u_xlat39) * vs_TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat39 = u_xlat39 * u_xlat4.x + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_41);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_41 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_11.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_11.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_11.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_11.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_11.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_11.xyz = u_xlat16_11.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_41 = (-u_xlat2.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_12 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat36), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
    u_xlatb24 = u_xlat12.x<0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = u_xlat12.x * 0.166666672 + u_xlat24;
    u_xlat12.x = booster_Env.x * _DotStarHueSpeed + u_xlat12.x;
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = lessThan(vec4(u_xlat24), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb38 = u_xlat24<5.0;
    u_xlat12.x = u_xlat12.x * 6.0 + (-u_xlat24);
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat24 = u_xlat0.x * u_xlat12.x + (-u_xlat0.x);
    u_xlat12.x = (-u_xlat0.x) * u_xlat12.x + 1.0;
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb36 = 0.0>=_DotParams.w;
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.z;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat12 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat12;
    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb1 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb1) ? u_xlat12 : 1.0;
    u_xlat12 = _DotParams.x / _DotSplitU;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.y = (-u_xlat12);
    u_xlat1.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat1.xy / vec2(_DotSplitU, _DotSplitV);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat15;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
float u_xlat36;
bool u_xlatb36;
float u_xlat38;
bool u_xlatb38;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_24 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_1.x = u_xlat16_24 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb24) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<9.99999975e-06);
#else
    u_xlatb24 = u_xlat24<9.99999975e-06;
#endif
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat24 * u_xlat16_1.x;
    u_xlat4.x = u_xlat24 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb38 = !!(u_xlat24<0.00499999989);
#else
    u_xlatb38 = u_xlat24<0.00499999989;
#endif
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? 0.0 : u_xlat39;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = u_xlat24 * u_xlat38;
    u_xlat24 = u_xlat24 * u_xlat24 + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat39) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat6.xyz = vec3(u_xlat39) * vs_TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat39 = u_xlat39 * u_xlat4.x + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_41);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_41 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_11.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_11.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_11.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_11.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_11.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_11.xyz = u_xlat16_11.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat2.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_12 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat36), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat12.x<0.0);
#else
    u_xlatb24 = u_xlat12.x<0.0;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = u_xlat12.x * 0.166666672 + u_xlat24;
    u_xlat12.x = booster_Env.x * _DotStarHueSpeed + u_xlat12.x;
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = lessThan(vec4(u_xlat24), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb38 = !!(u_xlat24<5.0);
#else
    u_xlatb38 = u_xlat24<5.0;
#endif
    u_xlat12.x = u_xlat12.x * 6.0 + (-u_xlat24);
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat0.x * u_xlat12.x + (-u_xlat0.x);
    u_xlat12.x = (-u_xlat0.x) * u_xlat12.x + 1.0;
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.0>=_DotParams.w);
#else
    u_xlatb36 = 0.0>=_DotParams.w;
#endif
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat12 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat12;
    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb1 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb1) ? u_xlat12 : 1.0;
    u_xlat12 = _DotParams.x / _DotSplitU;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.y = (-u_xlat12);
    u_xlat1.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat1.xy / vec2(_DotSplitU, _DotSplitV);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat15;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
float u_xlat36;
bool u_xlatb36;
float u_xlat38;
bool u_xlatb38;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_24 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_1.x = u_xlat16_24 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb24) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<9.99999975e-06);
#else
    u_xlatb24 = u_xlat24<9.99999975e-06;
#endif
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat24 * u_xlat16_1.x;
    u_xlat4.x = u_xlat24 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb38 = !!(u_xlat24<0.00499999989);
#else
    u_xlatb38 = u_xlat24<0.00499999989;
#endif
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? 0.0 : u_xlat39;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = u_xlat24 * u_xlat38;
    u_xlat24 = u_xlat24 * u_xlat24 + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat39) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat6.xyz = vec3(u_xlat39) * vs_TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat39 = u_xlat39 * u_xlat4.x + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_41);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_41 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_11.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_11.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_11.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_11.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_11.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_11.xyz = u_xlat16_11.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat2.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_12 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat36), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat12.x<0.0);
#else
    u_xlatb24 = u_xlat12.x<0.0;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = u_xlat12.x * 0.166666672 + u_xlat24;
    u_xlat12.x = booster_Env.x * _DotStarHueSpeed + u_xlat12.x;
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = lessThan(vec4(u_xlat24), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb38 = !!(u_xlat24<5.0);
#else
    u_xlatb38 = u_xlat24<5.0;
#endif
    u_xlat12.x = u_xlat12.x * 6.0 + (-u_xlat24);
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat0.x * u_xlat12.x + (-u_xlat0.x);
    u_xlat12.x = (-u_xlat0.x) * u_xlat12.x + 1.0;
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.0>=_DotParams.w);
#else
    u_xlatb36 = 0.0>=_DotParams.w;
#endif
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlatb2 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
bvec2 u_xlatb2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_10;
vec2 u_xlat12;
mediump vec3 u_xlat16_16;
float u_xlat20;
mediump float u_xlat16_20;
lowp float u_xlat10_20;
bool u_xlatb20;
float u_xlat30;
bool u_xlatb30;
float u_xlat32;
mediump float u_xlat16_35;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_20 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_20 = (-u_xlat10_20) + 1.0;
    u_xlat16_1.x = u_xlat16_20 + (-_Cutout);
    u_xlatb20 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb20) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat20 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb20 = u_xlat20<9.99999975e-06;
    u_xlat20 = (u_xlatb20) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat20 * u_xlat16_1.x;
    u_xlat4.x = u_xlat20 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat20 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat20 = sin(u_xlat20);
    u_xlat20 = u_xlat20 * _NormalRand.w;
    u_xlat20 = fract(u_xlat20);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat20) + u_xlat16_1.xyz;
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
    u_xlatb20 = u_xlat4.z<0.00499999989;
    u_xlat32 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb20) ? 0.0 : u_xlat32;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat20 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * vs_TEXCOORD1.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat32 = u_xlat20;
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
    u_xlat20 = u_xlat20 + u_xlat20;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat20)) + u_xlat2.xyz;
    u_xlat16_35 = (-u_xlat32) + 1.0;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_20;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_20;
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.x = (-u_xlat16_35) + _Smoothness;
    u_xlat16_6.x = u_xlat16_6.x + 1.0;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
    u_xlat16_7.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_16.xyz = u_xlat16_7.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_16.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_16.xyz = vec3(u_xlat16_35) * u_xlat16_16.xyz;
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = u_xlat16_6.xxx + (-u_xlat16_8.xyz);
    u_xlat16_9.xyz = vec3(u_xlat16_20) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_7.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_7.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_5.xyz = u_xlat16_9.xyz * u_xlat16_16.xyz + u_xlat16_5.xyz;
    u_xlat7.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat7.xyz = vec3(u_xlat20) * u_xlat7.xyz;
    u_xlat20 = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat7.xyz);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat4.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat2.x = u_xlat2.x * 16.0;
    u_xlat16_6.xyz = u_xlat2.xxx * u_xlat16_8.xyz + u_xlat16_16.xyz;
    u_xlat16_2.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_2.xyz = u_xlat16_2.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = vec3(u_xlat20) * u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz + u_xlat16_5.xyz;
    u_xlat16_6.xyz = (-u_xlat16_5.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_10 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_10 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_6.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat30 = max(u_xlat0.y, u_xlat0.x);
    u_xlat30 = max(u_xlat30, u_xlat0.z);
    u_xlatb2.xy = equal(vec4(u_xlat30), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat3.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat3.y = float(4.0);
    u_xlat3.w = float(0.0);
    u_xlat12.xy = (u_xlatb2.y) ? u_xlat1.yw : u_xlat3.xy;
    u_xlat2.xy = (u_xlatb2.x) ? u_xlat3.zw : u_xlat12.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat30;
    u_xlat10.x = u_xlat2.x / u_xlat0.x;
    u_xlat10.x = u_xlat10.x + u_xlat2.y;
    u_xlatb20 = u_xlat10.x<0.0;
    u_xlat20 = u_xlatb20 ? 1.0 : float(0.0);
    u_xlat10.x = u_xlat10.x * 0.166666672 + u_xlat20;
    u_xlat10.x = booster_Env.x * _DotStarHueSpeed + u_xlat10.x;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat20 = u_xlat10.x * 6.0;
    u_xlat20 = floor(u_xlat20);
    u_xlatb1 = lessThan(vec4(u_xlat20), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb2.x = u_xlat20<5.0;
    u_xlat10.x = u_xlat10.x * 6.0 + (-u_xlat20);
    u_xlat20 = max(u_xlat30, 0.00100000005);
    u_xlat3.z = u_xlat30 + u_xlat30;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat20;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat20 = u_xlat0.x * u_xlat10.x + (-u_xlat0.x);
    u_xlat10.x = (-u_xlat0.x) * u_xlat10.x + 1.0;
    u_xlat3.y = u_xlat10.x * u_xlat3.z;
    u_xlat10.x = u_xlat20 + 1.0;
    u_xlat3.w = u_xlat10.x * u_xlat3.z;
    u_xlat2.xz = (u_xlatb2.x) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat2.y = u_xlat3.x;
    u_xlat10.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat2.xyz;
    u_xlat10.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat10.xyz;
    u_xlat10.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat10.xyz;
    u_xlat10.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat10.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat10.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_5.xyz;
    u_xlatb30 = 0.0>=_DotParams.w;
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD3.z;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb2 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
bvec2 u_xlatb2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_10;
vec2 u_xlat12;
mediump vec3 u_xlat16_16;
float u_xlat20;
mediump float u_xlat16_20;
bool u_xlatb20;
float u_xlat30;
bool u_xlatb30;
float u_xlat32;
mediump float u_xlat16_35;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_20 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat16_1.x = u_xlat16_20 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb20 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb20) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat20 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat20<9.99999975e-06);
#else
    u_xlatb20 = u_xlat20<9.99999975e-06;
#endif
    u_xlat20 = (u_xlatb20) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat20 * u_xlat16_1.x;
    u_xlat4.x = u_xlat20 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat20 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat20 = sin(u_xlat20);
    u_xlat20 = u_xlat20 * _NormalRand.w;
    u_xlat20 = fract(u_xlat20);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat20) + u_xlat16_1.xyz;
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb20 = u_xlat4.z<0.00499999989;
#endif
    u_xlat32 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb20) ? 0.0 : u_xlat32;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat20 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * vs_TEXCOORD1.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat32 = u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat20 = u_xlat20 + u_xlat20;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat20)) + u_xlat2.xyz;
    u_xlat16_35 = (-u_xlat32) + 1.0;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_20;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_20;
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.x = (-u_xlat16_35) + _Smoothness;
    u_xlat16_6.x = u_xlat16_6.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_16.xyz = u_xlat16_7.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_16.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_16.xyz = vec3(u_xlat16_35) * u_xlat16_16.xyz;
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = u_xlat16_6.xxx + (-u_xlat16_8.xyz);
    u_xlat16_9.xyz = vec3(u_xlat16_20) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_7.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_7.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_5.xyz = u_xlat16_9.xyz * u_xlat16_16.xyz + u_xlat16_5.xyz;
    u_xlat7.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat7.xyz = vec3(u_xlat20) * u_xlat7.xyz;
    u_xlat20 = dot(u_xlat3.xyz, u_xlat7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat7.xyz);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat4.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat2.x = u_xlat2.x * 16.0;
    u_xlat16_6.xyz = u_xlat2.xxx * u_xlat16_8.xyz + u_xlat16_16.xyz;
    u_xlat16_2.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_2.xyz = u_xlat16_2.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = vec3(u_xlat20) * u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz + u_xlat16_5.xyz;
    u_xlat16_6.xyz = (-u_xlat16_5.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_10 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_10 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_6.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat30 = max(u_xlat0.y, u_xlat0.x);
    u_xlat30 = max(u_xlat30, u_xlat0.z);
    u_xlatb2.xy = equal(vec4(u_xlat30), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat3.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat3.y = float(4.0);
    u_xlat3.w = float(0.0);
    u_xlat12.xy = (u_xlatb2.y) ? u_xlat1.yw : u_xlat3.xy;
    u_xlat2.xy = (u_xlatb2.x) ? u_xlat3.zw : u_xlat12.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat30;
    u_xlat10.x = u_xlat2.x / u_xlat0.x;
    u_xlat10.x = u_xlat10.x + u_xlat2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat10.x<0.0);
#else
    u_xlatb20 = u_xlat10.x<0.0;
#endif
    u_xlat20 = u_xlatb20 ? 1.0 : float(0.0);
    u_xlat10.x = u_xlat10.x * 0.166666672 + u_xlat20;
    u_xlat10.x = booster_Env.x * _DotStarHueSpeed + u_xlat10.x;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat20 = u_xlat10.x * 6.0;
    u_xlat20 = floor(u_xlat20);
    u_xlatb1 = lessThan(vec4(u_xlat20), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(u_xlat20<5.0);
#else
    u_xlatb2.x = u_xlat20<5.0;
#endif
    u_xlat10.x = u_xlat10.x * 6.0 + (-u_xlat20);
    u_xlat20 = max(u_xlat30, 0.00100000005);
    u_xlat3.z = u_xlat30 + u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat20;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat20 = u_xlat0.x * u_xlat10.x + (-u_xlat0.x);
    u_xlat10.x = (-u_xlat0.x) * u_xlat10.x + 1.0;
    u_xlat3.y = u_xlat10.x * u_xlat3.z;
    u_xlat10.x = u_xlat20 + 1.0;
    u_xlat3.w = u_xlat10.x * u_xlat3.z;
    u_xlat2.xz = (u_xlatb2.x) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat2.y = u_xlat3.x;
    u_xlat10.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat2.xyz;
    u_xlat10.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat10.xyz;
    u_xlat10.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat10.xyz;
    u_xlat10.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat10.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat10.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.0>=_DotParams.w);
#else
    u_xlatb30 = 0.0>=_DotParams.w;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlatb2 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat15;
float u_xlat24;
mediump float u_xlat16_24;
lowp float u_xlat10_24;
bool u_xlatb24;
float u_xlat36;
bool u_xlatb36;
float u_xlat38;
bool u_xlatb38;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_24 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat10_24) + 1.0;
    u_xlat16_1.x = u_xlat16_24 + (-_Cutout);
    u_xlatb24 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb24) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat24 * u_xlat16_1.x;
    u_xlat4.x = u_xlat24 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-_Smoothness) + 1.0;
    u_xlatb38 = u_xlat24<0.00499999989;
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? 0.0 : u_xlat39;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = u_xlat24 * u_xlat38;
    u_xlat24 = u_xlat24 * u_xlat24 + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat39) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat6.xyz = vec3(u_xlat39) * vs_TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat39 = u_xlat39 * u_xlat4.x + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_41);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_10.xyz;
    u_xlat16_10.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_10.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_41 = (-u_xlat2.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_12 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat36), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
    u_xlatb24 = u_xlat12.x<0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = u_xlat12.x * 0.166666672 + u_xlat24;
    u_xlat12.x = booster_Env.x * _DotStarHueSpeed + u_xlat12.x;
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = lessThan(vec4(u_xlat24), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb38 = u_xlat24<5.0;
    u_xlat12.x = u_xlat12.x * 6.0 + (-u_xlat24);
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat24 = u_xlat0.x * u_xlat12.x + (-u_xlat0.x);
    u_xlat12.x = (-u_xlat0.x) * u_xlat12.x + 1.0;
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb36 = 0.0>=_DotParams.w;
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.z;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlatb2 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat15;
float u_xlat24;
mediump float u_xlat16_24;
lowp float u_xlat10_24;
bool u_xlatb24;
float u_xlat36;
bool u_xlatb36;
float u_xlat38;
bool u_xlatb38;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_24 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat10_24) + 1.0;
    u_xlat16_1.x = u_xlat16_24 + (-_Cutout);
    u_xlatb24 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb24) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat24 * u_xlat16_1.x;
    u_xlat4.x = u_xlat24 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-_Smoothness) + 1.0;
    u_xlatb38 = u_xlat24<0.00499999989;
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? 0.0 : u_xlat39;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = u_xlat24 * u_xlat38;
    u_xlat24 = u_xlat24 * u_xlat24 + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat39) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat6.xyz = vec3(u_xlat39) * vs_TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat39 = u_xlat39 * u_xlat4.x + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_41);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_10.xyz;
    u_xlat16_10.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_10.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_41 = (-u_xlat2.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_12 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat36), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
    u_xlatb24 = u_xlat12.x<0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = u_xlat12.x * 0.166666672 + u_xlat24;
    u_xlat12.x = booster_Env.x * _DotStarHueSpeed + u_xlat12.x;
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = lessThan(vec4(u_xlat24), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb38 = u_xlat24<5.0;
    u_xlat12.x = u_xlat12.x * 6.0 + (-u_xlat24);
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat24 = u_xlat0.x * u_xlat12.x + (-u_xlat0.x);
    u_xlat12.x = (-u_xlat0.x) * u_xlat12.x + 1.0;
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb36 = 0.0>=_DotParams.w;
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.z;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb2 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat15;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
float u_xlat36;
bool u_xlatb36;
float u_xlat38;
bool u_xlatb38;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_24 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_1.x = u_xlat16_24 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb24) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<9.99999975e-06);
#else
    u_xlatb24 = u_xlat24<9.99999975e-06;
#endif
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat24 * u_xlat16_1.x;
    u_xlat4.x = u_xlat24 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb38 = !!(u_xlat24<0.00499999989);
#else
    u_xlatb38 = u_xlat24<0.00499999989;
#endif
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? 0.0 : u_xlat39;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = u_xlat24 * u_xlat38;
    u_xlat24 = u_xlat24 * u_xlat24 + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat39) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat6.xyz = vec3(u_xlat39) * vs_TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat39 = u_xlat39 * u_xlat4.x + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_41);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_10.xyz;
    u_xlat16_10.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_10.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat2.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_12 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat36), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat12.x<0.0);
#else
    u_xlatb24 = u_xlat12.x<0.0;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = u_xlat12.x * 0.166666672 + u_xlat24;
    u_xlat12.x = booster_Env.x * _DotStarHueSpeed + u_xlat12.x;
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = lessThan(vec4(u_xlat24), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb38 = !!(u_xlat24<5.0);
#else
    u_xlatb38 = u_xlat24<5.0;
#endif
    u_xlat12.x = u_xlat12.x * 6.0 + (-u_xlat24);
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat0.x * u_xlat12.x + (-u_xlat0.x);
    u_xlat12.x = (-u_xlat0.x) * u_xlat12.x + 1.0;
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.0>=_DotParams.w);
#else
    u_xlatb36 = 0.0>=_DotParams.w;
#endif
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb2 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat15;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
float u_xlat36;
bool u_xlatb36;
float u_xlat38;
bool u_xlatb38;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_24 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_1.x = u_xlat16_24 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb24) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<9.99999975e-06);
#else
    u_xlatb24 = u_xlat24<9.99999975e-06;
#endif
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat24 * u_xlat16_1.x;
    u_xlat4.x = u_xlat24 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb38 = !!(u_xlat24<0.00499999989);
#else
    u_xlatb38 = u_xlat24<0.00499999989;
#endif
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? 0.0 : u_xlat39;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = u_xlat24 * u_xlat38;
    u_xlat24 = u_xlat24 * u_xlat24 + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat39) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat6.xyz = vec3(u_xlat39) * vs_TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat39 = u_xlat39 * u_xlat4.x + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_41);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_10.xyz;
    u_xlat16_10.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_10.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat2.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_12 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat36), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat12.x<0.0);
#else
    u_xlatb24 = u_xlat12.x<0.0;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = u_xlat12.x * 0.166666672 + u_xlat24;
    u_xlat12.x = booster_Env.x * _DotStarHueSpeed + u_xlat12.x;
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = lessThan(vec4(u_xlat24), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb38 = !!(u_xlat24<5.0);
#else
    u_xlatb38 = u_xlat24<5.0;
#endif
    u_xlat12.x = u_xlat12.x * 6.0 + (-u_xlat24);
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat0.x * u_xlat12.x + (-u_xlat0.x);
    u_xlat12.x = (-u_xlat0.x) * u_xlat12.x + 1.0;
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.0>=_DotParams.w);
#else
    u_xlatb36 = 0.0>=_DotParams.w;
#endif
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlatb2 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
bvec2 u_xlatb4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec2 u_xlat15;
float u_xlat22;
mediump float u_xlat16_22;
lowp float u_xlat10_22;
bool u_xlatb22;
float u_xlat33;
bool u_xlatb33;
mediump float u_xlat16_34;
mediump float u_xlat16_36;
float u_xlat37;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_22 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_22 = (-u_xlat10_22) + 1.0;
    u_xlat16_1.x = u_xlat16_22 + (-_Cutout);
    u_xlatb22 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb22) * -1))!=0){discard;}
    u_xlat16_1.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_1.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_1.x);
    u_xlat16_2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_1.xyz = unity_SHC.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_34 = dot((-u_xlat4.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_34 = u_xlat16_34 + u_xlat16_34;
    u_xlat16_3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_34)) + (-u_xlat4.xyz);
    u_xlat22 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb22 = u_xlat22<9.99999975e-06;
    u_xlat22 = (u_xlatb22) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat5.z = u_xlat22 * u_xlat16_3.x;
    u_xlat6.x = u_xlat22 * u_xlat16_3.z;
    u_xlat5.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat6.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat5.xyz = u_xlat5.xyz + (-u_xlat6.xyz);
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_NormalDiff);
    u_xlat22 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat22 = sin(u_xlat22);
    u_xlat22 = u_xlat22 * _NormalRand.w;
    u_xlat22 = fract(u_xlat22);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * u_xlat5.xyz;
    u_xlat6.z = (-_Smoothness) + 1.0;
    u_xlatb22 = u_xlat6.z<0.00499999989;
    u_xlat37 = u_xlat6.z * 8.29800034;
    u_xlat16_34 = (u_xlatb22) ? 0.0 : u_xlat37;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat5.xyz, u_xlat16_34);
    u_xlat16_34 = u_xlat10_2.w + -1.0;
    u_xlat16_34 = unity_SpecCube0_HDR.w * u_xlat16_34 + 1.0;
    u_xlat16_34 = u_xlat16_34 * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(u_xlat16_34);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat37 = u_xlat22;
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
    u_xlat22 = u_xlat22 + u_xlat22;
    u_xlat4.xyz = u_xlat5.xyz * (-vec3(u_xlat22)) + u_xlat4.xyz;
    u_xlat16_34 = (-u_xlat37) + 1.0;
    u_xlat16_22 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_22 = u_xlat16_34 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_34 * u_xlat16_22;
    u_xlat16_34 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_36 = (-u_xlat16_34) + _Smoothness;
    u_xlat16_36 = u_xlat16_36 + 1.0;
    u_xlat16_36 = clamp(u_xlat16_36, 0.0, 1.0);
    u_xlat16_7.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_9.xyz = u_xlat16_8.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_34) * u_xlat16_8.xyz;
    u_xlat16_9.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_9.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_10.xyz = vec3(u_xlat16_36) + (-u_xlat16_9.xyz);
    u_xlat16_10.xyz = vec3(u_xlat16_22) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_10.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat22 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat7.xyz = vec3(u_xlat22) * u_xlat7.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat7.xyz);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat6.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = texture2D(unity_NHxRoughness, u_xlat6.xz).x;
    u_xlat4.x = u_xlat4.x * 16.0;
    u_xlat16_3.xyz = u_xlat4.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_4.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = vec3(u_xlat22) * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_11 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_3.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat33 = max(u_xlat0.y, u_xlat0.x);
    u_xlat33 = max(u_xlat33, u_xlat0.z);
    u_xlatb4.xy = equal(vec4(u_xlat33), u_xlat0.zxzz).xy;
    u_xlat2.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat3.xz = u_xlat2.zx;
    u_xlat2.w = 2.0;
    u_xlat3.y = float(4.0);
    u_xlat3.w = float(0.0);
    u_xlat15.xy = (u_xlatb4.y) ? u_xlat2.yw : u_xlat3.xy;
    u_xlat4.xy = (u_xlatb4.x) ? u_xlat3.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat33;
    u_xlat11.x = u_xlat4.x / u_xlat0.x;
    u_xlat11.x = u_xlat11.x + u_xlat4.y;
    u_xlatb22 = u_xlat11.x<0.0;
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat11.x = u_xlat11.x * 0.166666672 + u_xlat22;
    u_xlat11.x = booster_Env.x * _DotStarHueSpeed + u_xlat11.x;
    u_xlat11.x = fract(u_xlat11.x);
    u_xlat22 = u_xlat11.x * 6.0;
    u_xlat22 = floor(u_xlat22);
    u_xlatb2 = lessThan(vec4(u_xlat22), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb4.x = u_xlat22<5.0;
    u_xlat11.x = u_xlat11.x * 6.0 + (-u_xlat22);
    u_xlat22 = max(u_xlat33, 0.00100000005);
    u_xlat3.z = u_xlat33 + u_xlat33;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat22;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat22 = u_xlat0.x * u_xlat11.x + (-u_xlat0.x);
    u_xlat11.x = (-u_xlat0.x) * u_xlat11.x + 1.0;
    u_xlat3.y = u_xlat11.x * u_xlat3.z;
    u_xlat11.x = u_xlat22 + 1.0;
    u_xlat3.w = u_xlat11.x * u_xlat3.z;
    u_xlat4.xz = (u_xlatb4.x) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat11.xyz = (u_xlatb2.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat11.xyz = (u_xlatb2.z) ? u_xlat3.xzw : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb2.y) ? u_xlat3.yzx : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb2.x) ? u_xlat3.zwx : u_xlat11.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat11.xyz;
    u_xlat4.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlatb33 = 0.0>=_DotParams.w;
    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD3.z;
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb2 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
bvec2 u_xlatb4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec2 u_xlat15;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat33;
bool u_xlatb33;
mediump float u_xlat16_34;
mediump float u_xlat16_36;
float u_xlat37;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_22 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
    u_xlat16_1.x = u_xlat16_22 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb22 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb22) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_1.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_1.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_1.x);
    u_xlat16_2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_1.xyz = unity_SHC.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_34 = dot((-u_xlat4.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_34 = u_xlat16_34 + u_xlat16_34;
    u_xlat16_3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_34)) + (-u_xlat4.xyz);
    u_xlat22 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat22<9.99999975e-06);
#else
    u_xlatb22 = u_xlat22<9.99999975e-06;
#endif
    u_xlat22 = (u_xlatb22) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat5.z = u_xlat22 * u_xlat16_3.x;
    u_xlat6.x = u_xlat22 * u_xlat16_3.z;
    u_xlat5.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat6.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat5.xyz = u_xlat5.xyz + (-u_xlat6.xyz);
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_NormalDiff);
    u_xlat22 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat22 = sin(u_xlat22);
    u_xlat22 = u_xlat22 * _NormalRand.w;
    u_xlat22 = fract(u_xlat22);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * u_xlat5.xyz;
    u_xlat6.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat6.z<0.00499999989);
#else
    u_xlatb22 = u_xlat6.z<0.00499999989;
#endif
    u_xlat37 = u_xlat6.z * 8.29800034;
    u_xlat16_34 = (u_xlatb22) ? 0.0 : u_xlat37;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat5.xyz, u_xlat16_34);
    u_xlat16_34 = u_xlat16_2.w + -1.0;
    u_xlat16_34 = unity_SpecCube0_HDR.w * u_xlat16_34 + 1.0;
    u_xlat16_34 = u_xlat16_34 * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_34);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat37 = u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat22 = u_xlat22 + u_xlat22;
    u_xlat4.xyz = u_xlat5.xyz * (-vec3(u_xlat22)) + u_xlat4.xyz;
    u_xlat16_34 = (-u_xlat37) + 1.0;
    u_xlat16_22 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_22 = u_xlat16_34 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_34 * u_xlat16_22;
    u_xlat16_34 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_36 = (-u_xlat16_34) + _Smoothness;
    u_xlat16_36 = u_xlat16_36 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_36 = min(max(u_xlat16_36, 0.0), 1.0);
#else
    u_xlat16_36 = clamp(u_xlat16_36, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_9.xyz = u_xlat16_8.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_34) * u_xlat16_8.xyz;
    u_xlat16_9.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_9.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_10.xyz = vec3(u_xlat16_36) + (-u_xlat16_9.xyz);
    u_xlat16_10.xyz = vec3(u_xlat16_22) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_10.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat22 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat7.xyz = vec3(u_xlat22) * u_xlat7.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat7.xyz);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat6.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = texture(unity_NHxRoughness, u_xlat6.xz).x;
    u_xlat4.x = u_xlat4.x * 16.0;
    u_xlat16_3.xyz = u_xlat4.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_4.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = vec3(u_xlat22) * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_11 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_3.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat33 = max(u_xlat0.y, u_xlat0.x);
    u_xlat33 = max(u_xlat33, u_xlat0.z);
    u_xlatb4.xy = equal(vec4(u_xlat33), u_xlat0.zxzz).xy;
    u_xlat2.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat3.xz = u_xlat2.zx;
    u_xlat2.w = 2.0;
    u_xlat3.y = float(4.0);
    u_xlat3.w = float(0.0);
    u_xlat15.xy = (u_xlatb4.y) ? u_xlat2.yw : u_xlat3.xy;
    u_xlat4.xy = (u_xlatb4.x) ? u_xlat3.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat33;
    u_xlat11.x = u_xlat4.x / u_xlat0.x;
    u_xlat11.x = u_xlat11.x + u_xlat4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat11.x<0.0);
#else
    u_xlatb22 = u_xlat11.x<0.0;
#endif
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat11.x = u_xlat11.x * 0.166666672 + u_xlat22;
    u_xlat11.x = booster_Env.x * _DotStarHueSpeed + u_xlat11.x;
    u_xlat11.x = fract(u_xlat11.x);
    u_xlat22 = u_xlat11.x * 6.0;
    u_xlat22 = floor(u_xlat22);
    u_xlatb2 = lessThan(vec4(u_xlat22), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(u_xlat22<5.0);
#else
    u_xlatb4.x = u_xlat22<5.0;
#endif
    u_xlat11.x = u_xlat11.x * 6.0 + (-u_xlat22);
    u_xlat22 = max(u_xlat33, 0.00100000005);
    u_xlat3.z = u_xlat33 + u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat22;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat22 = u_xlat0.x * u_xlat11.x + (-u_xlat0.x);
    u_xlat11.x = (-u_xlat0.x) * u_xlat11.x + 1.0;
    u_xlat3.y = u_xlat11.x * u_xlat3.z;
    u_xlat11.x = u_xlat22 + 1.0;
    u_xlat3.w = u_xlat11.x * u_xlat3.z;
    u_xlat4.xz = (u_xlatb4.x) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat4.y = u_xlat3.x;
    u_xlat11.xyz = (u_xlatb2.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat11.xyz = (u_xlatb2.z) ? u_xlat3.xzw : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb2.y) ? u_xlat3.yzx : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb2.x) ? u_xlat3.zwx : u_xlat11.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat11.xyz;
    u_xlat4.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0.0>=_DotParams.w);
#else
    u_xlatb33 = 0.0>=_DotParams.w;
#endif
    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlatb2 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
vec3 u_xlat14;
mediump float u_xlat16_14;
vec2 u_xlat17;
float u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
bool u_xlatb28;
float u_xlat42;
bool u_xlatb42;
float u_xlat44;
bool u_xlatb44;
float u_xlat45;
mediump float u_xlat16_47;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_28 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_28 = (-u_xlat10_28) + 1.0;
    u_xlat16_1.x = u_xlat16_28 + (-_Cutout);
    u_xlatb28 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb28) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat28 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb28 = u_xlat28<9.99999975e-06;
    u_xlat28 = (u_xlatb28) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat28 * u_xlat16_1.x;
    u_xlat4.x = u_xlat28 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat28 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * _NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_1.xyz;
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = (-_Smoothness) + 1.0;
    u_xlatb44 = u_xlat28<0.00499999989;
    u_xlat45 = u_xlat28 * 8.29800034;
    u_xlat16_1.x = (u_xlatb44) ? 0.0 : u_xlat45;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat44 = u_xlat28 * u_xlat28;
    u_xlat16_47 = u_xlat28 * u_xlat44;
    u_xlat28 = u_xlat28 * u_xlat28 + 1.5;
    u_xlat16_47 = (-u_xlat16_47) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_47);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat45) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat45) * u_xlat3.xyz;
    u_xlat45 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat45 = max(u_xlat45, 0.00100000005);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat4.xyz = vec3(u_xlat45) * u_xlat4.xyz;
    u_xlat45 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
    u_xlat45 = max(u_xlat45, 0.319999993);
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat45 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat6.xyz = vec3(u_xlat45) * vs_TEXCOORD1.xyz;
    u_xlat45 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
    u_xlat45 = u_xlat45 * u_xlat45;
    u_xlat4.x = u_xlat44 * u_xlat44 + -1.0;
    u_xlat45 = u_xlat45 * u_xlat4.x + 1.00001001;
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat28 = u_xlat44 / u_xlat28;
    u_xlat28 = u_xlat28 + -9.99999975e-05;
    u_xlat28 = max(u_xlat28, 0.0);
    u_xlat28 = min(u_xlat28, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_47 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_47) * u_xlat16_7.xyz;
    u_xlat16_47 = (-u_xlat16_47) + _Smoothness;
    u_xlat16_47 = u_xlat16_47 + 1.0;
    u_xlat16_47 = clamp(u_xlat16_47, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_47);
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_10.xyz;
    u_xlat16_47 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_47 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_47);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_11.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_11.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_11.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_11.xyz = unity_SHC.xyz * vec3(u_xlat16_47) + u_xlat16_11.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_12.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_12.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_12.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_11.xyz = u_xlat16_11.xyz + u_xlat16_12.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_13.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = unity_Lightmap_HDR.xxx * u_xlat16_13.xyz + u_xlat16_10.xyz;
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat28 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_47 = (-u_xlat2.x) + 1.0;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_8.xyz = vec3(u_xlat16_47) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat28) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_14 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_14 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat42 = max(u_xlat0.y, u_xlat0.x);
    u_xlat42 = max(u_xlat42, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat42), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat17.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat17.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat42;
    u_xlat14.x = u_xlat3.x / u_xlat0.x;
    u_xlat14.x = u_xlat14.x + u_xlat3.y;
    u_xlatb28 = u_xlat14.x<0.0;
    u_xlat28 = u_xlatb28 ? 1.0 : float(0.0);
    u_xlat14.x = u_xlat14.x * 0.166666672 + u_xlat28;
    u_xlat14.x = booster_Env.x * _DotStarHueSpeed + u_xlat14.x;
    u_xlat14.x = fract(u_xlat14.x);
    u_xlat28 = u_xlat14.x * 6.0;
    u_xlat28 = floor(u_xlat28);
    u_xlatb1 = lessThan(vec4(u_xlat28), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb44 = u_xlat28<5.0;
    u_xlat14.x = u_xlat14.x * 6.0 + (-u_xlat28);
    u_xlat28 = max(u_xlat42, 0.00100000005);
    u_xlat3.z = u_xlat42 + u_xlat42;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat28;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat28 = u_xlat0.x * u_xlat14.x + (-u_xlat0.x);
    u_xlat14.x = (-u_xlat0.x) * u_xlat14.x + 1.0;
    u_xlat3.y = u_xlat14.x * u_xlat3.z;
    u_xlat14.x = u_xlat28 + 1.0;
    u_xlat3.w = u_xlat14.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb44)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat14.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat14.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat14.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat14.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb42 = 0.0>=_DotParams.w;
    u_xlat42 = u_xlatb42 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat42) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat42 = vs_TEXCOORD3.z;
    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat42) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlatb2 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
vec3 u_xlat14;
mediump float u_xlat16_14;
vec2 u_xlat17;
float u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
bool u_xlatb28;
float u_xlat42;
bool u_xlatb42;
float u_xlat44;
bool u_xlatb44;
float u_xlat45;
mediump float u_xlat16_47;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_28 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_28 = (-u_xlat10_28) + 1.0;
    u_xlat16_1.x = u_xlat16_28 + (-_Cutout);
    u_xlatb28 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb28) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat28 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb28 = u_xlat28<9.99999975e-06;
    u_xlat28 = (u_xlatb28) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat28 * u_xlat16_1.x;
    u_xlat4.x = u_xlat28 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat28 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * _NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_1.xyz;
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = (-_Smoothness) + 1.0;
    u_xlatb44 = u_xlat28<0.00499999989;
    u_xlat45 = u_xlat28 * 8.29800034;
    u_xlat16_1.x = (u_xlatb44) ? 0.0 : u_xlat45;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat44 = u_xlat28 * u_xlat28;
    u_xlat16_47 = u_xlat28 * u_xlat44;
    u_xlat28 = u_xlat28 * u_xlat28 + 1.5;
    u_xlat16_47 = (-u_xlat16_47) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_47);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat45) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat45) * u_xlat3.xyz;
    u_xlat45 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat45 = max(u_xlat45, 0.00100000005);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat4.xyz = vec3(u_xlat45) * u_xlat4.xyz;
    u_xlat45 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
    u_xlat45 = max(u_xlat45, 0.319999993);
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat45 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat6.xyz = vec3(u_xlat45) * vs_TEXCOORD1.xyz;
    u_xlat45 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
    u_xlat45 = u_xlat45 * u_xlat45;
    u_xlat4.x = u_xlat44 * u_xlat44 + -1.0;
    u_xlat45 = u_xlat45 * u_xlat4.x + 1.00001001;
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat28 = u_xlat44 / u_xlat28;
    u_xlat28 = u_xlat28 + -9.99999975e-05;
    u_xlat28 = max(u_xlat28, 0.0);
    u_xlat28 = min(u_xlat28, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_47 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_47) * u_xlat16_7.xyz;
    u_xlat16_47 = (-u_xlat16_47) + _Smoothness;
    u_xlat16_47 = u_xlat16_47 + 1.0;
    u_xlat16_47 = clamp(u_xlat16_47, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_47);
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_10.xyz;
    u_xlat16_47 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_47 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_47);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_11.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_11.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_11.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_11.xyz = unity_SHC.xyz * vec3(u_xlat16_47) + u_xlat16_11.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_12.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_12.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_12.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_11.xyz = u_xlat16_11.xyz + u_xlat16_12.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_13.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = unity_Lightmap_HDR.xxx * u_xlat16_13.xyz + u_xlat16_10.xyz;
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat28 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_47 = (-u_xlat2.x) + 1.0;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_8.xyz = vec3(u_xlat16_47) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat28) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_14 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_14 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat42 = max(u_xlat0.y, u_xlat0.x);
    u_xlat42 = max(u_xlat42, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat42), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat17.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat17.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat42;
    u_xlat14.x = u_xlat3.x / u_xlat0.x;
    u_xlat14.x = u_xlat14.x + u_xlat3.y;
    u_xlatb28 = u_xlat14.x<0.0;
    u_xlat28 = u_xlatb28 ? 1.0 : float(0.0);
    u_xlat14.x = u_xlat14.x * 0.166666672 + u_xlat28;
    u_xlat14.x = booster_Env.x * _DotStarHueSpeed + u_xlat14.x;
    u_xlat14.x = fract(u_xlat14.x);
    u_xlat28 = u_xlat14.x * 6.0;
    u_xlat28 = floor(u_xlat28);
    u_xlatb1 = lessThan(vec4(u_xlat28), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb44 = u_xlat28<5.0;
    u_xlat14.x = u_xlat14.x * 6.0 + (-u_xlat28);
    u_xlat28 = max(u_xlat42, 0.00100000005);
    u_xlat3.z = u_xlat42 + u_xlat42;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat28;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat28 = u_xlat0.x * u_xlat14.x + (-u_xlat0.x);
    u_xlat14.x = (-u_xlat0.x) * u_xlat14.x + 1.0;
    u_xlat3.y = u_xlat14.x * u_xlat3.z;
    u_xlat14.x = u_xlat28 + 1.0;
    u_xlat3.w = u_xlat14.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb44)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat14.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat14.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat14.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat14.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb42 = 0.0>=_DotParams.w;
    u_xlat42 = u_xlatb42 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat42) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat42 = vs_TEXCOORD3.z;
    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat42) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb2 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
vec3 u_xlat14;
mediump float u_xlat16_14;
vec2 u_xlat17;
float u_xlat28;
mediump float u_xlat16_28;
bool u_xlatb28;
float u_xlat42;
bool u_xlatb42;
float u_xlat44;
bool u_xlatb44;
float u_xlat45;
mediump float u_xlat16_47;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_28 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_28 = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_28 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb28 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb28) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat28 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat28<9.99999975e-06);
#else
    u_xlatb28 = u_xlat28<9.99999975e-06;
#endif
    u_xlat28 = (u_xlatb28) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat28 * u_xlat16_1.x;
    u_xlat4.x = u_xlat28 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat28 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * _NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_1.xyz;
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb44 = !!(u_xlat28<0.00499999989);
#else
    u_xlatb44 = u_xlat28<0.00499999989;
#endif
    u_xlat45 = u_xlat28 * 8.29800034;
    u_xlat16_1.x = (u_xlatb44) ? 0.0 : u_xlat45;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat44 = u_xlat28 * u_xlat28;
    u_xlat16_47 = u_xlat28 * u_xlat44;
    u_xlat28 = u_xlat28 * u_xlat28 + 1.5;
    u_xlat16_47 = (-u_xlat16_47) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_47);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat45) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat45) * u_xlat3.xyz;
    u_xlat45 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat45 = max(u_xlat45, 0.00100000005);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat4.xyz = vec3(u_xlat45) * u_xlat4.xyz;
    u_xlat45 = dot(u_xlat3.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat45 = max(u_xlat45, 0.319999993);
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat45 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat6.xyz = vec3(u_xlat45) * vs_TEXCOORD1.xyz;
    u_xlat45 = dot(u_xlat6.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat45 = u_xlat45 * u_xlat45;
    u_xlat4.x = u_xlat44 * u_xlat44 + -1.0;
    u_xlat45 = u_xlat45 * u_xlat4.x + 1.00001001;
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat28 = u_xlat44 / u_xlat28;
    u_xlat28 = u_xlat28 + -9.99999975e-05;
    u_xlat28 = max(u_xlat28, 0.0);
    u_xlat28 = min(u_xlat28, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_47 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_47) * u_xlat16_7.xyz;
    u_xlat16_47 = (-u_xlat16_47) + _Smoothness;
    u_xlat16_47 = u_xlat16_47 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_47 = min(max(u_xlat16_47, 0.0), 1.0);
#else
    u_xlat16_47 = clamp(u_xlat16_47, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_47);
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_10.xyz;
    u_xlat16_47 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_47 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_47);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_11.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_11.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_11.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_11.xyz = unity_SHC.xyz * vec3(u_xlat16_47) + u_xlat16_11.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_12.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_12.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_12.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_11.xyz = u_xlat16_11.xyz + u_xlat16_12.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_13.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = unity_Lightmap_HDR.xxx * u_xlat16_13.xyz + u_xlat16_10.xyz;
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat28 = dot(u_xlat6.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_47 = (-u_xlat2.x) + 1.0;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_8.xyz = vec3(u_xlat16_47) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat28) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_14 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_14 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat42 = max(u_xlat0.y, u_xlat0.x);
    u_xlat42 = max(u_xlat42, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat42), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat17.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat17.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat42;
    u_xlat14.x = u_xlat3.x / u_xlat0.x;
    u_xlat14.x = u_xlat14.x + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat14.x<0.0);
#else
    u_xlatb28 = u_xlat14.x<0.0;
#endif
    u_xlat28 = u_xlatb28 ? 1.0 : float(0.0);
    u_xlat14.x = u_xlat14.x * 0.166666672 + u_xlat28;
    u_xlat14.x = booster_Env.x * _DotStarHueSpeed + u_xlat14.x;
    u_xlat14.x = fract(u_xlat14.x);
    u_xlat28 = u_xlat14.x * 6.0;
    u_xlat28 = floor(u_xlat28);
    u_xlatb1 = lessThan(vec4(u_xlat28), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb44 = !!(u_xlat28<5.0);
#else
    u_xlatb44 = u_xlat28<5.0;
#endif
    u_xlat14.x = u_xlat14.x * 6.0 + (-u_xlat28);
    u_xlat28 = max(u_xlat42, 0.00100000005);
    u_xlat3.z = u_xlat42 + u_xlat42;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat28;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat28 = u_xlat0.x * u_xlat14.x + (-u_xlat0.x);
    u_xlat14.x = (-u_xlat0.x) * u_xlat14.x + 1.0;
    u_xlat3.y = u_xlat14.x * u_xlat3.z;
    u_xlat14.x = u_xlat28 + 1.0;
    u_xlat3.w = u_xlat14.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb44)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat4.y = u_xlat3.x;
    u_xlat14.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat14.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat14.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat14.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(0.0>=_DotParams.w);
#else
    u_xlatb42 = 0.0>=_DotParams.w;
#endif
    u_xlat42 = u_xlatb42 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat42) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat42 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat42 = min(max(u_xlat42, 0.0), 1.0);
#else
    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat42) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb2 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
vec3 u_xlat14;
mediump float u_xlat16_14;
vec2 u_xlat17;
float u_xlat28;
mediump float u_xlat16_28;
bool u_xlatb28;
float u_xlat42;
bool u_xlatb42;
float u_xlat44;
bool u_xlatb44;
float u_xlat45;
mediump float u_xlat16_47;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_28 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_28 = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_28 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb28 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb28) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat28 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat28<9.99999975e-06);
#else
    u_xlatb28 = u_xlat28<9.99999975e-06;
#endif
    u_xlat28 = (u_xlatb28) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat28 * u_xlat16_1.x;
    u_xlat4.x = u_xlat28 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat28 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * _NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_1.xyz;
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb44 = !!(u_xlat28<0.00499999989);
#else
    u_xlatb44 = u_xlat28<0.00499999989;
#endif
    u_xlat45 = u_xlat28 * 8.29800034;
    u_xlat16_1.x = (u_xlatb44) ? 0.0 : u_xlat45;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat44 = u_xlat28 * u_xlat28;
    u_xlat16_47 = u_xlat28 * u_xlat44;
    u_xlat28 = u_xlat28 * u_xlat28 + 1.5;
    u_xlat16_47 = (-u_xlat16_47) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_47);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat45) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat45) * u_xlat3.xyz;
    u_xlat45 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat45 = max(u_xlat45, 0.00100000005);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat4.xyz = vec3(u_xlat45) * u_xlat4.xyz;
    u_xlat45 = dot(u_xlat3.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat45 = max(u_xlat45, 0.319999993);
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat45 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat6.xyz = vec3(u_xlat45) * vs_TEXCOORD1.xyz;
    u_xlat45 = dot(u_xlat6.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat45 = u_xlat45 * u_xlat45;
    u_xlat4.x = u_xlat44 * u_xlat44 + -1.0;
    u_xlat45 = u_xlat45 * u_xlat4.x + 1.00001001;
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat28 = u_xlat44 / u_xlat28;
    u_xlat28 = u_xlat28 + -9.99999975e-05;
    u_xlat28 = max(u_xlat28, 0.0);
    u_xlat28 = min(u_xlat28, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_47 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_47) * u_xlat16_7.xyz;
    u_xlat16_47 = (-u_xlat16_47) + _Smoothness;
    u_xlat16_47 = u_xlat16_47 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_47 = min(max(u_xlat16_47, 0.0), 1.0);
#else
    u_xlat16_47 = clamp(u_xlat16_47, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_47);
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_10.xyz;
    u_xlat16_47 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_47 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_47);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_11.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_11.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_11.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_11.xyz = unity_SHC.xyz * vec3(u_xlat16_47) + u_xlat16_11.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_12.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_12.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_12.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_11.xyz = u_xlat16_11.xyz + u_xlat16_12.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_13.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = unity_Lightmap_HDR.xxx * u_xlat16_13.xyz + u_xlat16_10.xyz;
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat28 = dot(u_xlat6.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_47 = (-u_xlat2.x) + 1.0;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_8.xyz = vec3(u_xlat16_47) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat28) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_14 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_14 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat42 = max(u_xlat0.y, u_xlat0.x);
    u_xlat42 = max(u_xlat42, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat42), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat17.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat17.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat42;
    u_xlat14.x = u_xlat3.x / u_xlat0.x;
    u_xlat14.x = u_xlat14.x + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat14.x<0.0);
#else
    u_xlatb28 = u_xlat14.x<0.0;
#endif
    u_xlat28 = u_xlatb28 ? 1.0 : float(0.0);
    u_xlat14.x = u_xlat14.x * 0.166666672 + u_xlat28;
    u_xlat14.x = booster_Env.x * _DotStarHueSpeed + u_xlat14.x;
    u_xlat14.x = fract(u_xlat14.x);
    u_xlat28 = u_xlat14.x * 6.0;
    u_xlat28 = floor(u_xlat28);
    u_xlatb1 = lessThan(vec4(u_xlat28), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb44 = !!(u_xlat28<5.0);
#else
    u_xlatb44 = u_xlat28<5.0;
#endif
    u_xlat14.x = u_xlat14.x * 6.0 + (-u_xlat28);
    u_xlat28 = max(u_xlat42, 0.00100000005);
    u_xlat3.z = u_xlat42 + u_xlat42;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat28;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat28 = u_xlat0.x * u_xlat14.x + (-u_xlat0.x);
    u_xlat14.x = (-u_xlat0.x) * u_xlat14.x + 1.0;
    u_xlat3.y = u_xlat14.x * u_xlat3.z;
    u_xlat14.x = u_xlat28 + 1.0;
    u_xlat3.w = u_xlat14.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb44)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat4.y = u_xlat3.x;
    u_xlat14.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat14.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat14.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat14.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(0.0>=_DotParams.w);
#else
    u_xlatb42 = 0.0>=_DotParams.w;
#endif
    u_xlat42 = u_xlatb42 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat42) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat42 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat42 = min(max(u_xlat42, 0.0), 1.0);
#else
    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat42) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlatb2 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
bvec2 u_xlatb2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_10;
vec2 u_xlat12;
mediump vec3 u_xlat16_16;
float u_xlat20;
mediump float u_xlat16_20;
lowp float u_xlat10_20;
bool u_xlatb20;
float u_xlat30;
bool u_xlatb30;
float u_xlat32;
mediump float u_xlat16_35;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_20 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_20 = (-u_xlat10_20) + 1.0;
    u_xlat16_1.x = u_xlat16_20 + (-_Cutout);
    u_xlatb20 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb20) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat20 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb20 = u_xlat20<9.99999975e-06;
    u_xlat20 = (u_xlatb20) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat20 * u_xlat16_1.x;
    u_xlat4.x = u_xlat20 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat20 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat20 = sin(u_xlat20);
    u_xlat20 = u_xlat20 * _NormalRand.w;
    u_xlat20 = fract(u_xlat20);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat20) + u_xlat16_1.xyz;
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
    u_xlatb20 = u_xlat4.z<0.00499999989;
    u_xlat32 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb20) ? 0.0 : u_xlat32;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat20 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * vs_TEXCOORD1.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat32 = u_xlat20;
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
    u_xlat20 = u_xlat20 + u_xlat20;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat20)) + u_xlat2.xyz;
    u_xlat16_35 = (-u_xlat32) + 1.0;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_20;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_20;
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.x = (-u_xlat16_35) + _Smoothness;
    u_xlat16_6.x = u_xlat16_6.x + 1.0;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
    u_xlat16_7.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_16.xyz = u_xlat16_7.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_16.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_16.xyz = vec3(u_xlat16_35) * u_xlat16_16.xyz;
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = u_xlat16_6.xxx + (-u_xlat16_8.xyz);
    u_xlat16_9.xyz = vec3(u_xlat16_20) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_7.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_7.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_5.xyz = u_xlat16_9.xyz * u_xlat16_16.xyz + u_xlat16_5.xyz;
    u_xlat7.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat7.xyz = vec3(u_xlat20) * u_xlat7.xyz;
    u_xlat20 = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat7.xyz);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat4.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat2.x = u_xlat2.x * 16.0;
    u_xlat16_6.xyz = u_xlat2.xxx * u_xlat16_8.xyz + u_xlat16_16.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_35 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_2.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_2.xyz = u_xlat16_2.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat16_8.xyz = vec3(u_xlat20) * u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz + u_xlat16_5.xyz;
    u_xlat16_6.xyz = (-u_xlat16_5.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_10 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_10 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_6.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat30 = max(u_xlat0.y, u_xlat0.x);
    u_xlat30 = max(u_xlat30, u_xlat0.z);
    u_xlatb2.xy = equal(vec4(u_xlat30), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat3.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat3.y = float(4.0);
    u_xlat3.w = float(0.0);
    u_xlat12.xy = (u_xlatb2.y) ? u_xlat1.yw : u_xlat3.xy;
    u_xlat2.xy = (u_xlatb2.x) ? u_xlat3.zw : u_xlat12.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat30;
    u_xlat10.x = u_xlat2.x / u_xlat0.x;
    u_xlat10.x = u_xlat10.x + u_xlat2.y;
    u_xlatb20 = u_xlat10.x<0.0;
    u_xlat20 = u_xlatb20 ? 1.0 : float(0.0);
    u_xlat10.x = u_xlat10.x * 0.166666672 + u_xlat20;
    u_xlat10.x = booster_Env.x * _DotStarHueSpeed + u_xlat10.x;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat20 = u_xlat10.x * 6.0;
    u_xlat20 = floor(u_xlat20);
    u_xlatb1 = lessThan(vec4(u_xlat20), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb2.x = u_xlat20<5.0;
    u_xlat10.x = u_xlat10.x * 6.0 + (-u_xlat20);
    u_xlat20 = max(u_xlat30, 0.00100000005);
    u_xlat3.z = u_xlat30 + u_xlat30;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat20;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat20 = u_xlat0.x * u_xlat10.x + (-u_xlat0.x);
    u_xlat10.x = (-u_xlat0.x) * u_xlat10.x + 1.0;
    u_xlat3.y = u_xlat10.x * u_xlat3.z;
    u_xlat10.x = u_xlat20 + 1.0;
    u_xlat3.w = u_xlat10.x * u_xlat3.z;
    u_xlat2.xz = (u_xlatb2.x) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat2.y = u_xlat3.x;
    u_xlat10.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat2.xyz;
    u_xlat10.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat10.xyz;
    u_xlat10.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat10.xyz;
    u_xlat10.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat10.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat10.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_5.xyz;
    u_xlatb30 = 0.0>=_DotParams.w;
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD3.z;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb2 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
bvec2 u_xlatb2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_10;
vec2 u_xlat12;
mediump vec3 u_xlat16_16;
float u_xlat20;
mediump float u_xlat16_20;
bool u_xlatb20;
float u_xlat30;
bool u_xlatb30;
float u_xlat32;
mediump float u_xlat16_35;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_20 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat16_1.x = u_xlat16_20 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb20 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb20) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat20 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat20<9.99999975e-06);
#else
    u_xlatb20 = u_xlat20<9.99999975e-06;
#endif
    u_xlat20 = (u_xlatb20) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat20 * u_xlat16_1.x;
    u_xlat4.x = u_xlat20 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat20 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat20 = sin(u_xlat20);
    u_xlat20 = u_xlat20 * _NormalRand.w;
    u_xlat20 = fract(u_xlat20);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat20) + u_xlat16_1.xyz;
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb20 = u_xlat4.z<0.00499999989;
#endif
    u_xlat32 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb20) ? 0.0 : u_xlat32;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat20 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * vs_TEXCOORD1.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat32 = u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat20 = u_xlat20 + u_xlat20;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat20)) + u_xlat2.xyz;
    u_xlat16_35 = (-u_xlat32) + 1.0;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_20;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_20;
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.x = (-u_xlat16_35) + _Smoothness;
    u_xlat16_6.x = u_xlat16_6.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_16.xyz = u_xlat16_7.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_16.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_16.xyz = vec3(u_xlat16_35) * u_xlat16_16.xyz;
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = u_xlat16_6.xxx + (-u_xlat16_8.xyz);
    u_xlat16_9.xyz = vec3(u_xlat16_20) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_7.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_7.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_5.xyz = u_xlat16_9.xyz * u_xlat16_16.xyz + u_xlat16_5.xyz;
    u_xlat7.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat7.xyz = vec3(u_xlat20) * u_xlat7.xyz;
    u_xlat20 = dot(u_xlat3.xyz, u_xlat7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat7.xyz);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat4.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat2.x = u_xlat2.x * 16.0;
    u_xlat16_6.xyz = u_xlat2.xxx * u_xlat16_8.xyz + u_xlat16_16.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_2.xyz = u_xlat16_2.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat16_8.xyz = vec3(u_xlat20) * u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz + u_xlat16_5.xyz;
    u_xlat16_6.xyz = (-u_xlat16_5.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_10 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_10 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_6.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat30 = max(u_xlat0.y, u_xlat0.x);
    u_xlat30 = max(u_xlat30, u_xlat0.z);
    u_xlatb2.xy = equal(vec4(u_xlat30), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat3.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat3.y = float(4.0);
    u_xlat3.w = float(0.0);
    u_xlat12.xy = (u_xlatb2.y) ? u_xlat1.yw : u_xlat3.xy;
    u_xlat2.xy = (u_xlatb2.x) ? u_xlat3.zw : u_xlat12.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat30;
    u_xlat10.x = u_xlat2.x / u_xlat0.x;
    u_xlat10.x = u_xlat10.x + u_xlat2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat10.x<0.0);
#else
    u_xlatb20 = u_xlat10.x<0.0;
#endif
    u_xlat20 = u_xlatb20 ? 1.0 : float(0.0);
    u_xlat10.x = u_xlat10.x * 0.166666672 + u_xlat20;
    u_xlat10.x = booster_Env.x * _DotStarHueSpeed + u_xlat10.x;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat20 = u_xlat10.x * 6.0;
    u_xlat20 = floor(u_xlat20);
    u_xlatb1 = lessThan(vec4(u_xlat20), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(u_xlat20<5.0);
#else
    u_xlatb2.x = u_xlat20<5.0;
#endif
    u_xlat10.x = u_xlat10.x * 6.0 + (-u_xlat20);
    u_xlat20 = max(u_xlat30, 0.00100000005);
    u_xlat3.z = u_xlat30 + u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat20;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat20 = u_xlat0.x * u_xlat10.x + (-u_xlat0.x);
    u_xlat10.x = (-u_xlat0.x) * u_xlat10.x + 1.0;
    u_xlat3.y = u_xlat10.x * u_xlat3.z;
    u_xlat10.x = u_xlat20 + 1.0;
    u_xlat3.w = u_xlat10.x * u_xlat3.z;
    u_xlat2.xz = (u_xlatb2.x) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat2.y = u_xlat3.x;
    u_xlat10.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat2.xyz;
    u_xlat10.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat10.xyz;
    u_xlat10.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat10.xyz;
    u_xlat10.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat10.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat10.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.0>=_DotParams.w);
#else
    u_xlatb30 = 0.0>=_DotParams.w;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlatb2 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat15;
float u_xlat24;
mediump float u_xlat16_24;
lowp float u_xlat10_24;
bool u_xlatb24;
float u_xlat36;
bool u_xlatb36;
float u_xlat38;
bool u_xlatb38;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_24 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat10_24) + 1.0;
    u_xlat16_1.x = u_xlat16_24 + (-_Cutout);
    u_xlatb24 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb24) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat24 * u_xlat16_1.x;
    u_xlat4.x = u_xlat24 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-_Smoothness) + 1.0;
    u_xlatb38 = u_xlat24<0.00499999989;
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? 0.0 : u_xlat39;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = u_xlat24 * u_xlat38;
    u_xlat24 = u_xlat24 * u_xlat24 + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat39) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat6.xyz = vec3(u_xlat39) * vs_TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat39 = u_xlat39 * u_xlat4.x + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_41);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_41 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_11.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_11.xyz;
    u_xlat16_10.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_10.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_41 = (-u_xlat2.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_12 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat36), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
    u_xlatb24 = u_xlat12.x<0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = u_xlat12.x * 0.166666672 + u_xlat24;
    u_xlat12.x = booster_Env.x * _DotStarHueSpeed + u_xlat12.x;
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = lessThan(vec4(u_xlat24), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb38 = u_xlat24<5.0;
    u_xlat12.x = u_xlat12.x * 6.0 + (-u_xlat24);
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat24 = u_xlat0.x * u_xlat12.x + (-u_xlat0.x);
    u_xlat12.x = (-u_xlat0.x) * u_xlat12.x + 1.0;
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb36 = 0.0>=_DotParams.w;
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.z;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlatb2 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat15;
float u_xlat24;
mediump float u_xlat16_24;
lowp float u_xlat10_24;
bool u_xlatb24;
float u_xlat36;
bool u_xlatb36;
float u_xlat38;
bool u_xlatb38;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_24 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat10_24) + 1.0;
    u_xlat16_1.x = u_xlat16_24 + (-_Cutout);
    u_xlatb24 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb24) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat24 * u_xlat16_1.x;
    u_xlat4.x = u_xlat24 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-_Smoothness) + 1.0;
    u_xlatb38 = u_xlat24<0.00499999989;
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? 0.0 : u_xlat39;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = u_xlat24 * u_xlat38;
    u_xlat24 = u_xlat24 * u_xlat24 + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat39) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat6.xyz = vec3(u_xlat39) * vs_TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat39 = u_xlat39 * u_xlat4.x + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_41);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_41 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_11.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_11.xyz;
    u_xlat16_10.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_10.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_41 = (-u_xlat2.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_12 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat36), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
    u_xlatb24 = u_xlat12.x<0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = u_xlat12.x * 0.166666672 + u_xlat24;
    u_xlat12.x = booster_Env.x * _DotStarHueSpeed + u_xlat12.x;
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = lessThan(vec4(u_xlat24), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb38 = u_xlat24<5.0;
    u_xlat12.x = u_xlat12.x * 6.0 + (-u_xlat24);
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat24 = u_xlat0.x * u_xlat12.x + (-u_xlat0.x);
    u_xlat12.x = (-u_xlat0.x) * u_xlat12.x + 1.0;
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb36 = 0.0>=_DotParams.w;
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.z;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb2 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat15;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
float u_xlat36;
bool u_xlatb36;
float u_xlat38;
bool u_xlatb38;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_24 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_1.x = u_xlat16_24 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb24) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<9.99999975e-06);
#else
    u_xlatb24 = u_xlat24<9.99999975e-06;
#endif
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat24 * u_xlat16_1.x;
    u_xlat4.x = u_xlat24 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb38 = !!(u_xlat24<0.00499999989);
#else
    u_xlatb38 = u_xlat24<0.00499999989;
#endif
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? 0.0 : u_xlat39;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = u_xlat24 * u_xlat38;
    u_xlat24 = u_xlat24 * u_xlat24 + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat39) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat6.xyz = vec3(u_xlat39) * vs_TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat39 = u_xlat39 * u_xlat4.x + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_41);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_41 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_11.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_11.xyz;
    u_xlat16_10.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_10.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat2.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_12 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat36), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat12.x<0.0);
#else
    u_xlatb24 = u_xlat12.x<0.0;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = u_xlat12.x * 0.166666672 + u_xlat24;
    u_xlat12.x = booster_Env.x * _DotStarHueSpeed + u_xlat12.x;
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = lessThan(vec4(u_xlat24), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb38 = !!(u_xlat24<5.0);
#else
    u_xlatb38 = u_xlat24<5.0;
#endif
    u_xlat12.x = u_xlat12.x * 6.0 + (-u_xlat24);
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat0.x * u_xlat12.x + (-u_xlat0.x);
    u_xlat12.x = (-u_xlat0.x) * u_xlat12.x + 1.0;
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.0>=_DotParams.w);
#else
    u_xlatb36 = 0.0>=_DotParams.w;
#endif
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb2 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat15;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
float u_xlat36;
bool u_xlatb36;
float u_xlat38;
bool u_xlatb38;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_24 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_1.x = u_xlat16_24 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb24) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<9.99999975e-06);
#else
    u_xlatb24 = u_xlat24<9.99999975e-06;
#endif
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat24 * u_xlat16_1.x;
    u_xlat4.x = u_xlat24 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb38 = !!(u_xlat24<0.00499999989);
#else
    u_xlatb38 = u_xlat24<0.00499999989;
#endif
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? 0.0 : u_xlat39;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = u_xlat24 * u_xlat38;
    u_xlat24 = u_xlat24 * u_xlat24 + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat39) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat4.xyz = vec3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat6.xyz = vec3(u_xlat39) * vs_TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat39 = u_xlat39 * u_xlat4.x + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_41);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_41 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_11.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_11.xyz;
    u_xlat16_10.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_10.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat2.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_12 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat36), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat12.x<0.0);
#else
    u_xlatb24 = u_xlat12.x<0.0;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = u_xlat12.x * 0.166666672 + u_xlat24;
    u_xlat12.x = booster_Env.x * _DotStarHueSpeed + u_xlat12.x;
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = lessThan(vec4(u_xlat24), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb38 = !!(u_xlat24<5.0);
#else
    u_xlatb38 = u_xlat24<5.0;
#endif
    u_xlat12.x = u_xlat12.x * 6.0 + (-u_xlat24);
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat0.x * u_xlat12.x + (-u_xlat0.x);
    u_xlat12.x = (-u_xlat0.x) * u_xlat12.x + 1.0;
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.0>=_DotParams.w);
#else
    u_xlatb36 = 0.0>=_DotParams.w;
#endif
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlatb2 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
bvec2 u_xlatb4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec2 u_xlat15;
float u_xlat22;
mediump float u_xlat16_22;
lowp float u_xlat10_22;
bool u_xlatb22;
float u_xlat33;
bool u_xlatb33;
mediump float u_xlat16_34;
mediump float u_xlat16_36;
float u_xlat37;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_22 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_22 = (-u_xlat10_22) + 1.0;
    u_xlat16_1.x = u_xlat16_22 + (-_Cutout);
    u_xlatb22 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb22) * -1))!=0){discard;}
    u_xlat16_1.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_1.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_1.x);
    u_xlat16_2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_1.xyz = unity_SHC.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_34 = dot((-u_xlat4.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_34 = u_xlat16_34 + u_xlat16_34;
    u_xlat16_3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_34)) + (-u_xlat4.xyz);
    u_xlat22 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb22 = u_xlat22<9.99999975e-06;
    u_xlat22 = (u_xlatb22) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat5.z = u_xlat22 * u_xlat16_3.x;
    u_xlat6.x = u_xlat22 * u_xlat16_3.z;
    u_xlat5.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat6.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat5.xyz = u_xlat5.xyz + (-u_xlat6.xyz);
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_NormalDiff);
    u_xlat22 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat22 = sin(u_xlat22);
    u_xlat22 = u_xlat22 * _NormalRand.w;
    u_xlat22 = fract(u_xlat22);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * u_xlat5.xyz;
    u_xlat6.z = (-_Smoothness) + 1.0;
    u_xlatb22 = u_xlat6.z<0.00499999989;
    u_xlat37 = u_xlat6.z * 8.29800034;
    u_xlat16_34 = (u_xlatb22) ? 0.0 : u_xlat37;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat5.xyz, u_xlat16_34);
    u_xlat16_34 = u_xlat10_2.w + -1.0;
    u_xlat16_34 = unity_SpecCube0_HDR.w * u_xlat16_34 + 1.0;
    u_xlat16_34 = u_xlat16_34 * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(u_xlat16_34);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat37 = u_xlat22;
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
    u_xlat22 = u_xlat22 + u_xlat22;
    u_xlat4.xyz = u_xlat5.xyz * (-vec3(u_xlat22)) + u_xlat4.xyz;
    u_xlat16_34 = (-u_xlat37) + 1.0;
    u_xlat16_22 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_22 = u_xlat16_34 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_34 * u_xlat16_22;
    u_xlat16_34 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_36 = (-u_xlat16_34) + _Smoothness;
    u_xlat16_36 = u_xlat16_36 + 1.0;
    u_xlat16_36 = clamp(u_xlat16_36, 0.0, 1.0);
    u_xlat16_7.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_9.xyz = u_xlat16_8.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_34) * u_xlat16_8.xyz;
    u_xlat16_9.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_9.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_10.xyz = vec3(u_xlat16_36) + (-u_xlat16_9.xyz);
    u_xlat16_10.xyz = vec3(u_xlat16_22) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_10.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat22 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat7.xyz = vec3(u_xlat22) * u_xlat7.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat7.xyz);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat6.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = texture2D(unity_NHxRoughness, u_xlat6.xz).x;
    u_xlat4.x = u_xlat4.x * 16.0;
    u_xlat16_3.xyz = u_xlat4.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_34 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat16_4.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = vec3(u_xlat16_34) * u_xlat16_4.xyz;
    u_xlat16_8.xyz = vec3(u_xlat22) * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_11 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_3.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat33 = max(u_xlat0.y, u_xlat0.x);
    u_xlat33 = max(u_xlat33, u_xlat0.z);
    u_xlatb4.xy = equal(vec4(u_xlat33), u_xlat0.zxzz).xy;
    u_xlat2.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat3.xz = u_xlat2.zx;
    u_xlat2.w = 2.0;
    u_xlat3.y = float(4.0);
    u_xlat3.w = float(0.0);
    u_xlat15.xy = (u_xlatb4.y) ? u_xlat2.yw : u_xlat3.xy;
    u_xlat4.xy = (u_xlatb4.x) ? u_xlat3.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat33;
    u_xlat11.x = u_xlat4.x / u_xlat0.x;
    u_xlat11.x = u_xlat11.x + u_xlat4.y;
    u_xlatb22 = u_xlat11.x<0.0;
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat11.x = u_xlat11.x * 0.166666672 + u_xlat22;
    u_xlat11.x = booster_Env.x * _DotStarHueSpeed + u_xlat11.x;
    u_xlat11.x = fract(u_xlat11.x);
    u_xlat22 = u_xlat11.x * 6.0;
    u_xlat22 = floor(u_xlat22);
    u_xlatb2 = lessThan(vec4(u_xlat22), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb4.x = u_xlat22<5.0;
    u_xlat11.x = u_xlat11.x * 6.0 + (-u_xlat22);
    u_xlat22 = max(u_xlat33, 0.00100000005);
    u_xlat3.z = u_xlat33 + u_xlat33;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat22;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat22 = u_xlat0.x * u_xlat11.x + (-u_xlat0.x);
    u_xlat11.x = (-u_xlat0.x) * u_xlat11.x + 1.0;
    u_xlat3.y = u_xlat11.x * u_xlat3.z;
    u_xlat11.x = u_xlat22 + 1.0;
    u_xlat3.w = u_xlat11.x * u_xlat3.z;
    u_xlat4.xz = (u_xlatb4.x) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat11.xyz = (u_xlatb2.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat11.xyz = (u_xlatb2.z) ? u_xlat3.xzw : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb2.y) ? u_xlat3.yzx : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb2.x) ? u_xlat3.zwx : u_xlat11.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat11.xyz;
    u_xlat4.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlatb33 = 0.0>=_DotParams.w;
    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD3.z;
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb2 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
bvec2 u_xlatb4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec2 u_xlat15;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat33;
bool u_xlatb33;
mediump float u_xlat16_34;
mediump float u_xlat16_36;
float u_xlat37;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_22 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
    u_xlat16_1.x = u_xlat16_22 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb22 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb22) * int(0xffffffffu)))!=0){discard;}
    u_xlat16_1.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_1.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_1.x);
    u_xlat16_2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_1.xyz = unity_SHC.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_34 = dot((-u_xlat4.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_34 = u_xlat16_34 + u_xlat16_34;
    u_xlat16_3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_34)) + (-u_xlat4.xyz);
    u_xlat22 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat22<9.99999975e-06);
#else
    u_xlatb22 = u_xlat22<9.99999975e-06;
#endif
    u_xlat22 = (u_xlatb22) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat5.z = u_xlat22 * u_xlat16_3.x;
    u_xlat6.x = u_xlat22 * u_xlat16_3.z;
    u_xlat5.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat6.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat5.xyz = u_xlat5.xyz + (-u_xlat6.xyz);
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_NormalDiff);
    u_xlat22 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat22 = sin(u_xlat22);
    u_xlat22 = u_xlat22 * _NormalRand.w;
    u_xlat22 = fract(u_xlat22);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * u_xlat5.xyz;
    u_xlat6.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat6.z<0.00499999989);
#else
    u_xlatb22 = u_xlat6.z<0.00499999989;
#endif
    u_xlat37 = u_xlat6.z * 8.29800034;
    u_xlat16_34 = (u_xlatb22) ? 0.0 : u_xlat37;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat5.xyz, u_xlat16_34);
    u_xlat16_34 = u_xlat16_2.w + -1.0;
    u_xlat16_34 = unity_SpecCube0_HDR.w * u_xlat16_34 + 1.0;
    u_xlat16_34 = u_xlat16_34 * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_34);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * vs_TEXCOORD1.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat37 = u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat22 = u_xlat22 + u_xlat22;
    u_xlat4.xyz = u_xlat5.xyz * (-vec3(u_xlat22)) + u_xlat4.xyz;
    u_xlat16_34 = (-u_xlat37) + 1.0;
    u_xlat16_22 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_22 = u_xlat16_34 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_34 * u_xlat16_22;
    u_xlat16_34 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_36 = (-u_xlat16_34) + _Smoothness;
    u_xlat16_36 = u_xlat16_36 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_36 = min(max(u_xlat16_36, 0.0), 1.0);
#else
    u_xlat16_36 = clamp(u_xlat16_36, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_9.xyz = u_xlat16_8.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_34) * u_xlat16_8.xyz;
    u_xlat16_9.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_9.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_10.xyz = vec3(u_xlat16_36) + (-u_xlat16_9.xyz);
    u_xlat16_10.xyz = vec3(u_xlat16_22) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_10.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat22 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat7.xyz = vec3(u_xlat22) * u_xlat7.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat7.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat7.xyz);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat6.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = texture(unity_NHxRoughness, u_xlat6.xz).x;
    u_xlat4.x = u_xlat4.x * 16.0;
    u_xlat16_3.xyz = u_xlat4.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_34 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = vec3(u_xlat16_34) * u_xlat16_4.xyz;
    u_xlat16_8.xyz = vec3(u_xlat22) * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_11 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_3.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat33 = max(u_xlat0.y, u_xlat0.x);
    u_xlat33 = max(u_xlat33, u_xlat0.z);
    u_xlatb4.xy = equal(vec4(u_xlat33), u_xlat0.zxzz).xy;
    u_xlat2.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat3.xz = u_xlat2.zx;
    u_xlat2.w = 2.0;
    u_xlat3.y = float(4.0);
    u_xlat3.w = float(0.0);
    u_xlat15.xy = (u_xlatb4.y) ? u_xlat2.yw : u_xlat3.xy;
    u_xlat4.xy = (u_xlatb4.x) ? u_xlat3.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat33;
    u_xlat11.x = u_xlat4.x / u_xlat0.x;
    u_xlat11.x = u_xlat11.x + u_xlat4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat11.x<0.0);
#else
    u_xlatb22 = u_xlat11.x<0.0;
#endif
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat11.x = u_xlat11.x * 0.166666672 + u_xlat22;
    u_xlat11.x = booster_Env.x * _DotStarHueSpeed + u_xlat11.x;
    u_xlat11.x = fract(u_xlat11.x);
    u_xlat22 = u_xlat11.x * 6.0;
    u_xlat22 = floor(u_xlat22);
    u_xlatb2 = lessThan(vec4(u_xlat22), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(u_xlat22<5.0);
#else
    u_xlatb4.x = u_xlat22<5.0;
#endif
    u_xlat11.x = u_xlat11.x * 6.0 + (-u_xlat22);
    u_xlat22 = max(u_xlat33, 0.00100000005);
    u_xlat3.z = u_xlat33 + u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat22;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat22 = u_xlat0.x * u_xlat11.x + (-u_xlat0.x);
    u_xlat11.x = (-u_xlat0.x) * u_xlat11.x + 1.0;
    u_xlat3.y = u_xlat11.x * u_xlat3.z;
    u_xlat11.x = u_xlat22 + 1.0;
    u_xlat3.w = u_xlat11.x * u_xlat3.z;
    u_xlat4.xz = (u_xlatb4.x) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat4.y = u_xlat3.x;
    u_xlat11.xyz = (u_xlatb2.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat11.xyz = (u_xlatb2.z) ? u_xlat3.xzw : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb2.y) ? u_xlat3.yzx : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb2.x) ? u_xlat3.zwx : u_xlat11.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat11.xyz;
    u_xlat4.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0.0>=_DotParams.w);
#else
    u_xlatb33 = 0.0>=_DotParams.w;
#endif
    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlatb2 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
vec3 u_xlat14;
mediump float u_xlat16_14;
vec2 u_xlat17;
float u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
bool u_xlatb28;
float u_xlat42;
bool u_xlatb42;
float u_xlat44;
bool u_xlatb44;
float u_xlat45;
mediump float u_xlat16_47;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_28 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_28 = (-u_xlat10_28) + 1.0;
    u_xlat16_1.x = u_xlat16_28 + (-_Cutout);
    u_xlatb28 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb28) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat28 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb28 = u_xlat28<9.99999975e-06;
    u_xlat28 = (u_xlatb28) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat28 * u_xlat16_1.x;
    u_xlat4.x = u_xlat28 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat28 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * _NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_1.xyz;
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = (-_Smoothness) + 1.0;
    u_xlatb44 = u_xlat28<0.00499999989;
    u_xlat45 = u_xlat28 * 8.29800034;
    u_xlat16_1.x = (u_xlatb44) ? 0.0 : u_xlat45;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat44 = u_xlat28 * u_xlat28;
    u_xlat16_47 = u_xlat28 * u_xlat44;
    u_xlat28 = u_xlat28 * u_xlat28 + 1.5;
    u_xlat16_47 = (-u_xlat16_47) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_47);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat45) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat45) * u_xlat3.xyz;
    u_xlat45 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat45 = max(u_xlat45, 0.00100000005);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat4.xyz = vec3(u_xlat45) * u_xlat4.xyz;
    u_xlat45 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
    u_xlat45 = max(u_xlat45, 0.319999993);
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat45 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat6.xyz = vec3(u_xlat45) * vs_TEXCOORD1.xyz;
    u_xlat45 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
    u_xlat45 = u_xlat45 * u_xlat45;
    u_xlat4.x = u_xlat44 * u_xlat44 + -1.0;
    u_xlat45 = u_xlat45 * u_xlat4.x + 1.00001001;
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat28 = u_xlat44 / u_xlat28;
    u_xlat28 = u_xlat28 + -9.99999975e-05;
    u_xlat28 = max(u_xlat28, 0.0);
    u_xlat28 = min(u_xlat28, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_47 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_47) * u_xlat16_7.xyz;
    u_xlat16_47 = (-u_xlat16_47) + _Smoothness;
    u_xlat16_47 = u_xlat16_47 + 1.0;
    u_xlat16_47 = clamp(u_xlat16_47, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_47);
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_47 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_47 = clamp(u_xlat16_47, 0.0, 1.0);
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_11.xyz = vec3(u_xlat16_47) * u_xlat16_10.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_11.xyz;
    u_xlat16_47 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_47 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_47);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_11.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_11.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_11.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_11.xyz = unity_SHC.xyz * vec3(u_xlat16_47) + u_xlat16_11.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_12.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_12.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_12.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_11.xyz = u_xlat16_11.xyz + u_xlat16_12.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_13.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = unity_Lightmap_HDR.xxx * u_xlat16_13.xyz + u_xlat16_10.xyz;
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat28 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_47 = (-u_xlat2.x) + 1.0;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_8.xyz = vec3(u_xlat16_47) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat28) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_14 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_14 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat42 = max(u_xlat0.y, u_xlat0.x);
    u_xlat42 = max(u_xlat42, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat42), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat17.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat17.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat42;
    u_xlat14.x = u_xlat3.x / u_xlat0.x;
    u_xlat14.x = u_xlat14.x + u_xlat3.y;
    u_xlatb28 = u_xlat14.x<0.0;
    u_xlat28 = u_xlatb28 ? 1.0 : float(0.0);
    u_xlat14.x = u_xlat14.x * 0.166666672 + u_xlat28;
    u_xlat14.x = booster_Env.x * _DotStarHueSpeed + u_xlat14.x;
    u_xlat14.x = fract(u_xlat14.x);
    u_xlat28 = u_xlat14.x * 6.0;
    u_xlat28 = floor(u_xlat28);
    u_xlatb1 = lessThan(vec4(u_xlat28), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb44 = u_xlat28<5.0;
    u_xlat14.x = u_xlat14.x * 6.0 + (-u_xlat28);
    u_xlat28 = max(u_xlat42, 0.00100000005);
    u_xlat3.z = u_xlat42 + u_xlat42;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat28;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat28 = u_xlat0.x * u_xlat14.x + (-u_xlat0.x);
    u_xlat14.x = (-u_xlat0.x) * u_xlat14.x + 1.0;
    u_xlat3.y = u_xlat14.x * u_xlat3.z;
    u_xlat14.x = u_xlat28 + 1.0;
    u_xlat3.w = u_xlat14.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb44)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat14.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat14.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat14.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat14.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb42 = 0.0>=_DotParams.w;
    u_xlat42 = u_xlatb42 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat42) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat42 = vs_TEXCOORD3.z;
    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat42) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlatb2 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
vec3 u_xlat14;
mediump float u_xlat16_14;
vec2 u_xlat17;
float u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
bool u_xlatb28;
float u_xlat42;
bool u_xlatb42;
float u_xlat44;
bool u_xlatb44;
float u_xlat45;
mediump float u_xlat16_47;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_28 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_28 = (-u_xlat10_28) + 1.0;
    u_xlat16_1.x = u_xlat16_28 + (-_Cutout);
    u_xlatb28 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb28) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat28 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb28 = u_xlat28<9.99999975e-06;
    u_xlat28 = (u_xlatb28) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat28 * u_xlat16_1.x;
    u_xlat4.x = u_xlat28 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat28 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * _NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_1.xyz;
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = (-_Smoothness) + 1.0;
    u_xlatb44 = u_xlat28<0.00499999989;
    u_xlat45 = u_xlat28 * 8.29800034;
    u_xlat16_1.x = (u_xlatb44) ? 0.0 : u_xlat45;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat44 = u_xlat28 * u_xlat28;
    u_xlat16_47 = u_xlat28 * u_xlat44;
    u_xlat28 = u_xlat28 * u_xlat28 + 1.5;
    u_xlat16_47 = (-u_xlat16_47) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_47);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat45) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat45) * u_xlat3.xyz;
    u_xlat45 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat45 = max(u_xlat45, 0.00100000005);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat4.xyz = vec3(u_xlat45) * u_xlat4.xyz;
    u_xlat45 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
    u_xlat45 = max(u_xlat45, 0.319999993);
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat45 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat6.xyz = vec3(u_xlat45) * vs_TEXCOORD1.xyz;
    u_xlat45 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
    u_xlat45 = u_xlat45 * u_xlat45;
    u_xlat4.x = u_xlat44 * u_xlat44 + -1.0;
    u_xlat45 = u_xlat45 * u_xlat4.x + 1.00001001;
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat28 = u_xlat44 / u_xlat28;
    u_xlat28 = u_xlat28 + -9.99999975e-05;
    u_xlat28 = max(u_xlat28, 0.0);
    u_xlat28 = min(u_xlat28, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_47 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_47) * u_xlat16_7.xyz;
    u_xlat16_47 = (-u_xlat16_47) + _Smoothness;
    u_xlat16_47 = u_xlat16_47 + 1.0;
    u_xlat16_47 = clamp(u_xlat16_47, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_47);
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_47 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_47 = clamp(u_xlat16_47, 0.0, 1.0);
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_11.xyz = vec3(u_xlat16_47) * u_xlat16_10.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_11.xyz;
    u_xlat16_47 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_47 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_47);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_11.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_11.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_11.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_11.xyz = unity_SHC.xyz * vec3(u_xlat16_47) + u_xlat16_11.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_12.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_12.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_12.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_11.xyz = u_xlat16_11.xyz + u_xlat16_12.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_13.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = unity_Lightmap_HDR.xxx * u_xlat16_13.xyz + u_xlat16_10.xyz;
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat28 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_47 = (-u_xlat2.x) + 1.0;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_8.xyz = vec3(u_xlat16_47) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat28) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_14 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_14 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat42 = max(u_xlat0.y, u_xlat0.x);
    u_xlat42 = max(u_xlat42, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat42), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat17.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat17.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat42;
    u_xlat14.x = u_xlat3.x / u_xlat0.x;
    u_xlat14.x = u_xlat14.x + u_xlat3.y;
    u_xlatb28 = u_xlat14.x<0.0;
    u_xlat28 = u_xlatb28 ? 1.0 : float(0.0);
    u_xlat14.x = u_xlat14.x * 0.166666672 + u_xlat28;
    u_xlat14.x = booster_Env.x * _DotStarHueSpeed + u_xlat14.x;
    u_xlat14.x = fract(u_xlat14.x);
    u_xlat28 = u_xlat14.x * 6.0;
    u_xlat28 = floor(u_xlat28);
    u_xlatb1 = lessThan(vec4(u_xlat28), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlatb44 = u_xlat28<5.0;
    u_xlat14.x = u_xlat14.x * 6.0 + (-u_xlat28);
    u_xlat28 = max(u_xlat42, 0.00100000005);
    u_xlat3.z = u_xlat42 + u_xlat42;
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat28;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat28 = u_xlat0.x * u_xlat14.x + (-u_xlat0.x);
    u_xlat14.x = (-u_xlat0.x) * u_xlat14.x + 1.0;
    u_xlat3.y = u_xlat14.x * u_xlat3.z;
    u_xlat14.x = u_xlat28 + 1.0;
    u_xlat3.w = u_xlat14.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb44)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat14.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat14.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat14.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat14.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb42 = 0.0>=_DotParams.w;
    u_xlat42 = u_xlatb42 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat42) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat42 = vs_TEXCOORD3.z;
    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat42) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb2 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
vec3 u_xlat14;
mediump float u_xlat16_14;
vec2 u_xlat17;
float u_xlat28;
mediump float u_xlat16_28;
bool u_xlatb28;
float u_xlat42;
bool u_xlatb42;
float u_xlat44;
bool u_xlatb44;
float u_xlat45;
mediump float u_xlat16_47;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_28 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_28 = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_28 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb28 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb28) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat28 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat28<9.99999975e-06);
#else
    u_xlatb28 = u_xlat28<9.99999975e-06;
#endif
    u_xlat28 = (u_xlatb28) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat28 * u_xlat16_1.x;
    u_xlat4.x = u_xlat28 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat28 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * _NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_1.xyz;
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb44 = !!(u_xlat28<0.00499999989);
#else
    u_xlatb44 = u_xlat28<0.00499999989;
#endif
    u_xlat45 = u_xlat28 * 8.29800034;
    u_xlat16_1.x = (u_xlatb44) ? 0.0 : u_xlat45;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat44 = u_xlat28 * u_xlat28;
    u_xlat16_47 = u_xlat28 * u_xlat44;
    u_xlat28 = u_xlat28 * u_xlat28 + 1.5;
    u_xlat16_47 = (-u_xlat16_47) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_47);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat45) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat45) * u_xlat3.xyz;
    u_xlat45 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat45 = max(u_xlat45, 0.00100000005);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat4.xyz = vec3(u_xlat45) * u_xlat4.xyz;
    u_xlat45 = dot(u_xlat3.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat45 = max(u_xlat45, 0.319999993);
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat45 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat6.xyz = vec3(u_xlat45) * vs_TEXCOORD1.xyz;
    u_xlat45 = dot(u_xlat6.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat45 = u_xlat45 * u_xlat45;
    u_xlat4.x = u_xlat44 * u_xlat44 + -1.0;
    u_xlat45 = u_xlat45 * u_xlat4.x + 1.00001001;
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat28 = u_xlat44 / u_xlat28;
    u_xlat28 = u_xlat28 + -9.99999975e-05;
    u_xlat28 = max(u_xlat28, 0.0);
    u_xlat28 = min(u_xlat28, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_47 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_47) * u_xlat16_7.xyz;
    u_xlat16_47 = (-u_xlat16_47) + _Smoothness;
    u_xlat16_47 = u_xlat16_47 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_47 = min(max(u_xlat16_47, 0.0), 1.0);
#else
    u_xlat16_47 = clamp(u_xlat16_47, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_47);
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_47 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_47 = min(max(u_xlat16_47, 0.0), 1.0);
#else
    u_xlat16_47 = clamp(u_xlat16_47, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_11.xyz = vec3(u_xlat16_47) * u_xlat16_10.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_11.xyz;
    u_xlat16_47 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_47 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_47);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_11.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_11.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_11.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_11.xyz = unity_SHC.xyz * vec3(u_xlat16_47) + u_xlat16_11.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_12.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_12.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_12.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_11.xyz = u_xlat16_11.xyz + u_xlat16_12.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_13.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = unity_Lightmap_HDR.xxx * u_xlat16_13.xyz + u_xlat16_10.xyz;
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat28 = dot(u_xlat6.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_47 = (-u_xlat2.x) + 1.0;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_8.xyz = vec3(u_xlat16_47) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat28) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_14 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_14 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat42 = max(u_xlat0.y, u_xlat0.x);
    u_xlat42 = max(u_xlat42, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat42), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat17.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat17.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat42;
    u_xlat14.x = u_xlat3.x / u_xlat0.x;
    u_xlat14.x = u_xlat14.x + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat14.x<0.0);
#else
    u_xlatb28 = u_xlat14.x<0.0;
#endif
    u_xlat28 = u_xlatb28 ? 1.0 : float(0.0);
    u_xlat14.x = u_xlat14.x * 0.166666672 + u_xlat28;
    u_xlat14.x = booster_Env.x * _DotStarHueSpeed + u_xlat14.x;
    u_xlat14.x = fract(u_xlat14.x);
    u_xlat28 = u_xlat14.x * 6.0;
    u_xlat28 = floor(u_xlat28);
    u_xlatb1 = lessThan(vec4(u_xlat28), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb44 = !!(u_xlat28<5.0);
#else
    u_xlatb44 = u_xlat28<5.0;
#endif
    u_xlat14.x = u_xlat14.x * 6.0 + (-u_xlat28);
    u_xlat28 = max(u_xlat42, 0.00100000005);
    u_xlat3.z = u_xlat42 + u_xlat42;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat28;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat28 = u_xlat0.x * u_xlat14.x + (-u_xlat0.x);
    u_xlat14.x = (-u_xlat0.x) * u_xlat14.x + 1.0;
    u_xlat3.y = u_xlat14.x * u_xlat3.z;
    u_xlat14.x = u_xlat28 + 1.0;
    u_xlat3.w = u_xlat14.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb44)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat4.y = u_xlat3.x;
    u_xlat14.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat14.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat14.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat14.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(0.0>=_DotParams.w);
#else
    u_xlatb42 = 0.0>=_DotParams.w;
#endif
    u_xlat42 = u_xlatb42 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat42) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat42 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat42 = min(max(u_xlat42, 0.0), 1.0);
#else
    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat42) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb2 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
vec3 u_xlat14;
mediump float u_xlat16_14;
vec2 u_xlat17;
float u_xlat28;
mediump float u_xlat16_28;
bool u_xlatb28;
float u_xlat42;
bool u_xlatb42;
float u_xlat44;
bool u_xlatb44;
float u_xlat45;
mediump float u_xlat16_47;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_28 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_28 = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_28 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb28 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb28) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat28 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat28<9.99999975e-06);
#else
    u_xlatb28 = u_xlat28<9.99999975e-06;
#endif
    u_xlat28 = (u_xlatb28) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat28 * u_xlat16_1.x;
    u_xlat4.x = u_xlat28 * u_xlat16_1.z;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat28 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * _NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_1.xyz;
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb44 = !!(u_xlat28<0.00499999989);
#else
    u_xlatb44 = u_xlat28<0.00499999989;
#endif
    u_xlat45 = u_xlat28 * 8.29800034;
    u_xlat16_1.x = (u_xlatb44) ? 0.0 : u_xlat45;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat44 = u_xlat28 * u_xlat28;
    u_xlat16_47 = u_xlat28 * u_xlat44;
    u_xlat28 = u_xlat28 * u_xlat28 + 1.5;
    u_xlat16_47 = (-u_xlat16_47) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_47);
    u_xlat3.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat45) + u_xlat2.xyz;
    u_xlat3.xyz = vec3(u_xlat45) * u_xlat3.xyz;
    u_xlat45 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat45 = max(u_xlat45, 0.00100000005);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat4.xyz = vec3(u_xlat45) * u_xlat4.xyz;
    u_xlat45 = dot(u_xlat3.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat45 = max(u_xlat45, 0.319999993);
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat45 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat45 = inversesqrt(u_xlat45);
    u_xlat6.xyz = vec3(u_xlat45) * vs_TEXCOORD1.xyz;
    u_xlat45 = dot(u_xlat6.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat45 = u_xlat45 * u_xlat45;
    u_xlat4.x = u_xlat44 * u_xlat44 + -1.0;
    u_xlat45 = u_xlat45 * u_xlat4.x + 1.00001001;
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat28 = u_xlat44 / u_xlat28;
    u_xlat28 = u_xlat28 + -9.99999975e-05;
    u_xlat28 = max(u_xlat28, 0.0);
    u_xlat28 = min(u_xlat28, 100.0);
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_47 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_47) * u_xlat16_7.xyz;
    u_xlat16_47 = (-u_xlat16_47) + _Smoothness;
    u_xlat16_47 = u_xlat16_47 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_47 = min(max(u_xlat16_47, 0.0), 1.0);
#else
    u_xlat16_47 = clamp(u_xlat16_47, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_47);
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_47 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_47 = min(max(u_xlat16_47, 0.0), 1.0);
#else
    u_xlat16_47 = clamp(u_xlat16_47, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = min(_LightColor0.xyz, vec3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + vec3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_11.xyz = vec3(u_xlat16_47) * u_xlat16_10.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_11.xyz;
    u_xlat16_47 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_47 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_47);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_11.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_11.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_11.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_11.xyz = unity_SHC.xyz * vec3(u_xlat16_47) + u_xlat16_11.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_12.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_12.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_12.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_11.xyz = u_xlat16_11.xyz + u_xlat16_12.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_13.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = unity_Lightmap_HDR.xxx * u_xlat16_13.xyz + u_xlat16_10.xyz;
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat28 = dot(u_xlat6.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_47 = (-u_xlat2.x) + 1.0;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_8.xyz = vec3(u_xlat16_47) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat28) + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = (-u_xlat2.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_14 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_14 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat42 = max(u_xlat0.y, u_xlat0.x);
    u_xlat42 = max(u_xlat42, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat42), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat17.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat17.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat42;
    u_xlat14.x = u_xlat3.x / u_xlat0.x;
    u_xlat14.x = u_xlat14.x + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat14.x<0.0);
#else
    u_xlatb28 = u_xlat14.x<0.0;
#endif
    u_xlat28 = u_xlatb28 ? 1.0 : float(0.0);
    u_xlat14.x = u_xlat14.x * 0.166666672 + u_xlat28;
    u_xlat14.x = booster_Env.x * _DotStarHueSpeed + u_xlat14.x;
    u_xlat14.x = fract(u_xlat14.x);
    u_xlat28 = u_xlat14.x * 6.0;
    u_xlat28 = floor(u_xlat28);
    u_xlatb1 = lessThan(vec4(u_xlat28), vec4(1.0, 2.0, 3.0, 4.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb44 = !!(u_xlat28<5.0);
#else
    u_xlatb44 = u_xlat28<5.0;
#endif
    u_xlat14.x = u_xlat14.x * 6.0 + (-u_xlat28);
    u_xlat28 = max(u_xlat42, 0.00100000005);
    u_xlat3.z = u_xlat42 + u_xlat42;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.z = min(max(u_xlat3.z, 0.0), 1.0);
#else
    u_xlat3.z = clamp(u_xlat3.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat28;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat28 = u_xlat0.x * u_xlat14.x + (-u_xlat0.x);
    u_xlat14.x = (-u_xlat0.x) * u_xlat14.x + 1.0;
    u_xlat3.y = u_xlat14.x * u_xlat3.z;
    u_xlat14.x = u_xlat28 + 1.0;
    u_xlat3.w = u_xlat14.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb44)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = (-u_xlat3.z) * u_xlat0.x + u_xlat3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat4.y = u_xlat3.x;
    u_xlat14.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat14.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat14.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat14.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(0.0>=_DotParams.w);
#else
    u_xlatb42 = 0.0>=_DotParams.w;
#endif
    u_xlat42 = u_xlatb42 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat42) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat42 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat42 = min(max(u_xlat42, 0.0), 1.0);
#else
    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat42) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "DisableBatching" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "AlphaTest" "RenderType" = "DotDriver" }
  ZWrite Off
  Cull Off
  GpuProgramID 99476
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlatb2 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
bvec2 u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
vec2 u_xlat8;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_12 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_12 = (-u_xlat10_12) + 1.0;
    u_xlat16_1.x = u_xlat16_12 + (-_Cutout);
    u_xlatb12 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb12) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat12)) + u_xlat2.xyz;
    u_xlat12 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat2.x = u_xlat12 * u_xlat12;
    u_xlat2.y = (-_Smoothness) + 1.0;
    u_xlat12 = texture2D(unity_NHxRoughness, u_xlat2.xy).x;
    u_xlat12 = u_xlat12 * 16.0;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_5.xyz = vec3(u_xlat12) * u_xlat16_5.xyz;
    u_xlat16_19 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_19) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_5.xyz = (-u_xlat16_5.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_6 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_6 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat18 = max(u_xlat0.y, u_xlat0.x);
    u_xlat18 = max(u_xlat18, u_xlat0.z);
    u_xlatb2.xy = equal(vec4(u_xlat18), u_xlat0.zxzz).xy;
    u_xlat3.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat5.xz = u_xlat3.zx;
    u_xlat3.w = 2.0;
    u_xlat5.y = float(4.0);
    u_xlat5.w = float(0.0);
    u_xlat8.xy = (u_xlatb2.y) ? u_xlat3.yw : u_xlat5.xy;
    u_xlat2.xy = (u_xlatb2.x) ? u_xlat5.zw : u_xlat8.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat18;
    u_xlat6.x = u_xlat2.x / u_xlat0.x;
    u_xlat6.x = u_xlat6.x + u_xlat2.y;
    u_xlatb12 = u_xlat6.x<0.0;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat6.x = u_xlat6.x * 0.166666672 + u_xlat12;
    u_xlat6.x = booster_Env.x * _DotStarHueSpeed + u_xlat6.x;
    u_xlat6.x = fract(u_xlat6.x);
    u_xlat12 = u_xlat6.x * 6.0;
    u_xlat12 = floor(u_xlat12);
    u_xlatb2.x = u_xlat12<5.0;
    u_xlat6.x = u_xlat6.x * 6.0 + (-u_xlat12);
    u_xlatb3 = lessThan(vec4(u_xlat12), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlat12 = max(u_xlat18, 0.00100000005);
    u_xlat5.z = u_xlat18 + u_xlat18;
    u_xlat5.z = clamp(u_xlat5.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat12 = u_xlat0.x * u_xlat6.x + (-u_xlat0.x);
    u_xlat6.x = (-u_xlat0.x) * u_xlat6.x + 1.0;
    u_xlat5.y = u_xlat6.x * u_xlat5.z;
    u_xlat6.x = u_xlat12 + 1.0;
    u_xlat5.w = u_xlat6.x * u_xlat5.z;
    u_xlat2.xz = (u_xlatb2.x) ? u_xlat5.wz : u_xlat5.zy;
    u_xlat5.x = (-u_xlat5.z) * u_xlat0.x + u_xlat5.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat2.y = u_xlat5.x;
    u_xlat6.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat2.xyz;
    u_xlat6.xyz = (u_xlatb3.z) ? u_xlat5.xzw : u_xlat6.xyz;
    u_xlat6.xyz = (u_xlatb3.y) ? u_xlat5.yzx : u_xlat6.xyz;
    u_xlat6.xyz = (u_xlatb3.x) ? u_xlat5.zwx : u_xlat6.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.zzz : u_xlat6.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * u_xlat16_1.xyz + (-u_xlat0.xyz);
    u_xlatb18 = 0.0>=_DotParams.w;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat18 = vs_TEXCOORD3.z;
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb2 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
bvec2 u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
vec2 u_xlat8;
float u_xlat12;
mediump float u_xlat16_12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_12 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_12 = (-u_xlat16_12) + 1.0;
    u_xlat16_1.x = u_xlat16_12 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb12 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb12) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat12)) + u_xlat2.xyz;
    u_xlat12 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat2.x = u_xlat12 * u_xlat12;
    u_xlat2.y = (-_Smoothness) + 1.0;
    u_xlat12 = texture(unity_NHxRoughness, u_xlat2.xy).x;
    u_xlat12 = u_xlat12 * 16.0;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_5.xyz = vec3(u_xlat12) * u_xlat16_5.xyz;
    u_xlat16_19 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_19) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_5.xyz = (-u_xlat16_5.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_6 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_6 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat18 = max(u_xlat0.y, u_xlat0.x);
    u_xlat18 = max(u_xlat18, u_xlat0.z);
    u_xlatb2.xy = equal(vec4(u_xlat18), u_xlat0.zxzz).xy;
    u_xlat3.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat5.xz = u_xlat3.zx;
    u_xlat3.w = 2.0;
    u_xlat5.y = float(4.0);
    u_xlat5.w = float(0.0);
    u_xlat8.xy = (u_xlatb2.y) ? u_xlat3.yw : u_xlat5.xy;
    u_xlat2.xy = (u_xlatb2.x) ? u_xlat5.zw : u_xlat8.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat18;
    u_xlat6.x = u_xlat2.x / u_xlat0.x;
    u_xlat6.x = u_xlat6.x + u_xlat2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat6.x<0.0);
#else
    u_xlatb12 = u_xlat6.x<0.0;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat6.x = u_xlat6.x * 0.166666672 + u_xlat12;
    u_xlat6.x = booster_Env.x * _DotStarHueSpeed + u_xlat6.x;
    u_xlat6.x = fract(u_xlat6.x);
    u_xlat12 = u_xlat6.x * 6.0;
    u_xlat12 = floor(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(u_xlat12<5.0);
#else
    u_xlatb2.x = u_xlat12<5.0;
#endif
    u_xlat6.x = u_xlat6.x * 6.0 + (-u_xlat12);
    u_xlatb3 = lessThan(vec4(u_xlat12), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlat12 = max(u_xlat18, 0.00100000005);
    u_xlat5.z = u_xlat18 + u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.z = min(max(u_xlat5.z, 0.0), 1.0);
#else
    u_xlat5.z = clamp(u_xlat5.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat0.x * u_xlat6.x + (-u_xlat0.x);
    u_xlat6.x = (-u_xlat0.x) * u_xlat6.x + 1.0;
    u_xlat5.y = u_xlat6.x * u_xlat5.z;
    u_xlat6.x = u_xlat12 + 1.0;
    u_xlat5.w = u_xlat6.x * u_xlat5.z;
    u_xlat2.xz = (u_xlatb2.x) ? u_xlat5.wz : u_xlat5.zy;
    u_xlat5.x = (-u_xlat5.z) * u_xlat0.x + u_xlat5.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat2.y = u_xlat5.x;
    u_xlat6.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat2.xyz;
    u_xlat6.xyz = (u_xlatb3.z) ? u_xlat5.xzw : u_xlat6.xyz;
    u_xlat6.xyz = (u_xlatb3.y) ? u_xlat5.yzx : u_xlat6.xyz;
    u_xlat6.xyz = (u_xlatb3.x) ? u_xlat5.zwx : u_xlat6.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.zzz : u_xlat6.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * u_xlat16_1.xyz + (-u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0>=_DotParams.w);
#else
    u_xlatb18 = 0.0>=_DotParams.w;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat18 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlatb2 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
float u_xlat7;
vec2 u_xlat8;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
mediump float u_xlat16_12;
float u_xlat15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_10 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_10 = (-u_xlat10_10) + 1.0;
    u_xlat16_1.x = u_xlat16_10 + (-_Cutout);
    u_xlatb10 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb10) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat10) + _WorldSpaceLightPos0.xyz;
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = max(u_xlat10, 0.00100000005);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat10 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlat10 = max(u_xlat10, 0.319999993);
    u_xlat16_17 = (-_Smoothness) + 1.0;
    u_xlat16_3 = u_xlat16_17 * u_xlat16_17 + 1.5;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat10 = u_xlat10 * u_xlat16_3;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat7 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_12 = u_xlat16_17 * u_xlat16_17 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16_12 + 1.00001001;
    u_xlat10 = u_xlat10 * u_xlat2.x;
    u_xlat10 = u_xlat16_17 / u_xlat10;
    u_xlat10 = u_xlat10 + -9.99999975e-05;
    u_xlat10 = max(u_xlat10, 0.0);
    u_xlat10 = min(u_xlat10, 100.0);
    u_xlat16_2.xzw = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xzw * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat2.xzw = vec3(u_xlat10) * u_xlat16_4.xyz;
    u_xlat16_16 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat2.xzw = u_xlat16_1.xyz * vec3(u_xlat16_16) + u_xlat2.xzw;
    u_xlat2.xzw = u_xlat2.xzw * _LightColor0.xyz;
    u_xlat3.xyz = vec3(u_xlat7) * u_xlat2.xzw;
    u_xlat16_1.xyz = (-u_xlat3.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_5 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_5 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_1.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat15 = max(u_xlat0.y, u_xlat0.x);
    u_xlat15 = max(u_xlat15, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat15), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat8.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat8.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat15;
    u_xlat5.x = u_xlat3.x / u_xlat0.x;
    u_xlat5.x = u_xlat5.x + u_xlat3.y;
    u_xlatb10 = u_xlat5.x<0.0;
    u_xlat10 = u_xlatb10 ? 1.0 : float(0.0);
    u_xlat5.x = u_xlat5.x * 0.166666672 + u_xlat10;
    u_xlat5.x = booster_Env.x * _DotStarHueSpeed + u_xlat5.x;
    u_xlat5.x = fract(u_xlat5.x);
    u_xlat10 = u_xlat5.x * 6.0;
    u_xlat10 = floor(u_xlat10);
    u_xlatb3.x = u_xlat10<5.0;
    u_xlat5.x = u_xlat5.x * 6.0 + (-u_xlat10);
    u_xlatb1 = lessThan(vec4(u_xlat10), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlat10 = max(u_xlat15, 0.00100000005);
    u_xlat4.z = u_xlat15 + u_xlat15;
    u_xlat4.z = clamp(u_xlat4.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat10;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10 = u_xlat0.x * u_xlat5.x + (-u_xlat0.x);
    u_xlat5.x = (-u_xlat0.x) * u_xlat5.x + 1.0;
    u_xlat4.y = u_xlat5.x * u_xlat4.z;
    u_xlat5.x = u_xlat10 + 1.0;
    u_xlat4.w = u_xlat5.x * u_xlat4.z;
    u_xlat3.xz = (u_xlatb3.x) ? u_xlat4.wz : u_xlat4.zy;
    u_xlat4.x = (-u_xlat4.z) * u_xlat0.x + u_xlat4.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat3.y = u_xlat4.x;
    u_xlat5.xyz = (u_xlatb1.w) ? u_xlat4.xyz : u_xlat3.xyz;
    u_xlat5.xyz = (u_xlatb1.z) ? u_xlat4.xzw : u_xlat5.xyz;
    u_xlat5.xyz = (u_xlatb1.y) ? u_xlat4.yzx : u_xlat5.xyz;
    u_xlat5.xyz = (u_xlatb1.x) ? u_xlat4.zwx : u_xlat5.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat4.zzz : u_xlat5.xyz;
    u_xlat2.xyz = u_xlat2.xzw * vec3(u_xlat7) + (-u_xlat0.xyz);
    u_xlatb15 = 0.0>=_DotParams.w;
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat15 = vs_TEXCOORD3.z;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlatb2 = unity_FogParams.z!=0.0;
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparencyLM;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
float u_xlat7;
vec2 u_xlat8;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
mediump float u_xlat16_12;
float u_xlat15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat10_10 = texture2D(_TransparencyLM, u_xlat0.zw).x;
    u_xlat10_0.xyw = texture2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_10 = (-u_xlat10_10) + 1.0;
    u_xlat16_1.x = u_xlat16_10 + (-_Cutout);
    u_xlatb10 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb10) * -1))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat10) + _WorldSpaceLightPos0.xyz;
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = max(u_xlat10, 0.00100000005);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat10 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlat10 = max(u_xlat10, 0.319999993);
    u_xlat16_17 = (-_Smoothness) + 1.0;
    u_xlat16_3 = u_xlat16_17 * u_xlat16_17 + 1.5;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat10 = u_xlat10 * u_xlat16_3;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat7 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_12 = u_xlat16_17 * u_xlat16_17 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16_12 + 1.00001001;
    u_xlat10 = u_xlat10 * u_xlat2.x;
    u_xlat10 = u_xlat16_17 / u_xlat10;
    u_xlat10 = u_xlat10 + -9.99999975e-05;
    u_xlat10 = max(u_xlat10, 0.0);
    u_xlat10 = min(u_xlat10, 100.0);
    u_xlat16_2.xzw = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xzw * u_xlat10_0.xyw + _AddColor.xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat2.xzw = vec3(u_xlat10) * u_xlat16_4.xyz;
    u_xlat16_16 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat2.xzw = u_xlat16_1.xyz * vec3(u_xlat16_16) + u_xlat2.xzw;
    u_xlat2.xzw = u_xlat2.xzw * _LightColor0.xyz;
    u_xlat3.xyz = vec3(u_xlat7) * u_xlat2.xzw;
    u_xlat16_1.xyz = (-u_xlat3.yzx) * u_xlat10_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_5 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_5 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_1.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat15 = max(u_xlat0.y, u_xlat0.x);
    u_xlat15 = max(u_xlat15, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat15), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat8.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat8.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat15;
    u_xlat5.x = u_xlat3.x / u_xlat0.x;
    u_xlat5.x = u_xlat5.x + u_xlat3.y;
    u_xlatb10 = u_xlat5.x<0.0;
    u_xlat10 = u_xlatb10 ? 1.0 : float(0.0);
    u_xlat5.x = u_xlat5.x * 0.166666672 + u_xlat10;
    u_xlat5.x = booster_Env.x * _DotStarHueSpeed + u_xlat5.x;
    u_xlat5.x = fract(u_xlat5.x);
    u_xlat10 = u_xlat5.x * 6.0;
    u_xlat10 = floor(u_xlat10);
    u_xlatb3.x = u_xlat10<5.0;
    u_xlat5.x = u_xlat5.x * 6.0 + (-u_xlat10);
    u_xlatb1 = lessThan(vec4(u_xlat10), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlat10 = max(u_xlat15, 0.00100000005);
    u_xlat4.z = u_xlat15 + u_xlat15;
    u_xlat4.z = clamp(u_xlat4.z, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x / u_xlat10;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10 = u_xlat0.x * u_xlat5.x + (-u_xlat0.x);
    u_xlat5.x = (-u_xlat0.x) * u_xlat5.x + 1.0;
    u_xlat4.y = u_xlat5.x * u_xlat4.z;
    u_xlat5.x = u_xlat10 + 1.0;
    u_xlat4.w = u_xlat5.x * u_xlat4.z;
    u_xlat3.xz = (u_xlatb3.x) ? u_xlat4.wz : u_xlat4.zy;
    u_xlat4.x = (-u_xlat4.z) * u_xlat0.x + u_xlat4.z;
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat3.y = u_xlat4.x;
    u_xlat5.xyz = (u_xlatb1.w) ? u_xlat4.xyz : u_xlat3.xyz;
    u_xlat5.xyz = (u_xlatb1.z) ? u_xlat4.xzw : u_xlat5.xyz;
    u_xlat5.xyz = (u_xlatb1.y) ? u_xlat4.yzx : u_xlat5.xyz;
    u_xlat5.xyz = (u_xlatb1.x) ? u_xlat4.zwx : u_xlat5.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat4.zzz : u_xlat5.xyz;
    u_xlat2.xyz = u_xlat2.xzw * vec3(u_xlat7) + (-u_xlat0.xyz);
    u_xlatb15 = 0.0>=_DotParams.w;
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat15 = vs_TEXCOORD3.z;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb2 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
float u_xlat7;
vec2 u_xlat8;
float u_xlat10;
mediump float u_xlat16_10;
bool u_xlatb10;
mediump float u_xlat16_12;
float u_xlat15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_10 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_10 = (-u_xlat16_10) + 1.0;
    u_xlat16_1.x = u_xlat16_10 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb10 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb10) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat10) + _WorldSpaceLightPos0.xyz;
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = max(u_xlat10, 0.00100000005);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat10 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat10 = max(u_xlat10, 0.319999993);
    u_xlat16_17 = (-_Smoothness) + 1.0;
    u_xlat16_3 = u_xlat16_17 * u_xlat16_17 + 1.5;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat10 = u_xlat10 * u_xlat16_3;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_12 = u_xlat16_17 * u_xlat16_17 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16_12 + 1.00001001;
    u_xlat10 = u_xlat10 * u_xlat2.x;
    u_xlat10 = u_xlat16_17 / u_xlat10;
    u_xlat10 = u_xlat10 + -9.99999975e-05;
    u_xlat10 = max(u_xlat10, 0.0);
    u_xlat10 = min(u_xlat10, 100.0);
    u_xlat16_2.xzw = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xzw * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat2.xzw = vec3(u_xlat10) * u_xlat16_4.xyz;
    u_xlat16_16 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat2.xzw = u_xlat16_1.xyz * vec3(u_xlat16_16) + u_xlat2.xzw;
    u_xlat2.xzw = u_xlat2.xzw * _LightColor0.xyz;
    u_xlat3.xyz = vec3(u_xlat7) * u_xlat2.xzw;
    u_xlat16_1.xyz = (-u_xlat3.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_5 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_5 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_1.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat15 = max(u_xlat0.y, u_xlat0.x);
    u_xlat15 = max(u_xlat15, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat15), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat8.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat8.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat15;
    u_xlat5.x = u_xlat3.x / u_xlat0.x;
    u_xlat5.x = u_xlat5.x + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat5.x<0.0);
#else
    u_xlatb10 = u_xlat5.x<0.0;
#endif
    u_xlat10 = u_xlatb10 ? 1.0 : float(0.0);
    u_xlat5.x = u_xlat5.x * 0.166666672 + u_xlat10;
    u_xlat5.x = booster_Env.x * _DotStarHueSpeed + u_xlat5.x;
    u_xlat5.x = fract(u_xlat5.x);
    u_xlat10 = u_xlat5.x * 6.0;
    u_xlat10 = floor(u_xlat10);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat10<5.0);
#else
    u_xlatb3.x = u_xlat10<5.0;
#endif
    u_xlat5.x = u_xlat5.x * 6.0 + (-u_xlat10);
    u_xlatb1 = lessThan(vec4(u_xlat10), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlat10 = max(u_xlat15, 0.00100000005);
    u_xlat4.z = u_xlat15 + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.z = min(max(u_xlat4.z, 0.0), 1.0);
#else
    u_xlat4.z = clamp(u_xlat4.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat10;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat0.x * u_xlat5.x + (-u_xlat0.x);
    u_xlat5.x = (-u_xlat0.x) * u_xlat5.x + 1.0;
    u_xlat4.y = u_xlat5.x * u_xlat4.z;
    u_xlat5.x = u_xlat10 + 1.0;
    u_xlat4.w = u_xlat5.x * u_xlat4.z;
    u_xlat3.xz = (u_xlatb3.x) ? u_xlat4.wz : u_xlat4.zy;
    u_xlat4.x = (-u_xlat4.z) * u_xlat0.x + u_xlat4.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat3.y = u_xlat4.x;
    u_xlat5.xyz = (u_xlatb1.w) ? u_xlat4.xyz : u_xlat3.xyz;
    u_xlat5.xyz = (u_xlatb1.z) ? u_xlat4.xzw : u_xlat5.xyz;
    u_xlat5.xyz = (u_xlatb1.y) ? u_xlat4.yzx : u_xlat5.xyz;
    u_xlat5.xyz = (u_xlatb1.x) ? u_xlat4.zwx : u_xlat5.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat4.zzz : u_xlat5.xyz;
    u_xlat2.xyz = u_xlat2.xzw * vec3(u_xlat7) + (-u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0>=_DotParams.w);
#else
    u_xlatb15 = 0.0>=_DotParams.w;
#endif
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat15 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_FogParams.z!=0.0);
#else
    u_xlatb2 = unity_FogParams.z!=0.0;
#endif
    vs_TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD3.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Cutout;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _DotParams;
uniform 	mediump float _DotStarHueSpeed;
uniform 	mediump float _DotStarLightnessSpeed;
uniform 	mediump float _DotStarMinLightness;
uniform 	mediump float _DotStarMaxLightness;
uniform 	mediump float _DotStarAddedSaturation;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _TransparencyLM;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
float u_xlat7;
vec2 u_xlat8;
float u_xlat10;
mediump float u_xlat16_10;
bool u_xlatb10;
mediump float u_xlat16_12;
float u_xlat15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
void main()
{
    u_xlat0 = vs_TEXCOORD0 + vs_TEXCOORD3.xyxy;
    u_xlat16_10 = texture(_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_10 = (-u_xlat16_10) + 1.0;
    u_xlat16_1.x = u_xlat16_10 + (-_Cutout);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb10 = u_xlat16_1.x<0.0;
#endif
    if(((int(u_xlatb10) * int(0xffffffffu)))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat10) + _WorldSpaceLightPos0.xyz;
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = max(u_xlat10, 0.00100000005);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat10 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat10 = max(u_xlat10, 0.319999993);
    u_xlat16_17 = (-_Smoothness) + 1.0;
    u_xlat16_3 = u_xlat16_17 * u_xlat16_17 + 1.5;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat10 = u_xlat10 * u_xlat16_3;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_12 = u_xlat16_17 * u_xlat16_17 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16_12 + 1.00001001;
    u_xlat10 = u_xlat10 * u_xlat2.x;
    u_xlat10 = u_xlat16_17 / u_xlat10;
    u_xlat10 = u_xlat10 + -9.99999975e-05;
    u_xlat10 = max(u_xlat10, 0.0);
    u_xlat10 = min(u_xlat10, 100.0);
    u_xlat16_2.xzw = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xzw * u_xlat16_0.xyw + _AddColor.xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat2.xzw = vec3(u_xlat10) * u_xlat16_4.xyz;
    u_xlat16_16 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat2.xzw = u_xlat16_1.xyz * vec3(u_xlat16_16) + u_xlat2.xzw;
    u_xlat2.xzw = u_xlat2.xzw * _LightColor0.xyz;
    u_xlat3.xyz = vec3(u_xlat7) * u_xlat2.xzw;
    u_xlat16_1.xyz = (-u_xlat3.yzx) * u_xlat16_0.ywx + vec3(1.0, 1.0, 1.0);
    u_xlat0.x = booster_Env.x * _DotStarLightnessSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_5 = (-_DotStarMinLightness) + _DotStarMaxLightness;
    u_xlat0.x = u_xlat0.x * u_xlat16_5 + _DotStarMinLightness;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = (-u_xlat16_1.xyz) * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat15 = max(u_xlat0.y, u_xlat0.x);
    u_xlat15 = max(u_xlat15, u_xlat0.z);
    u_xlatb3.xy = equal(vec4(u_xlat15), u_xlat0.zxzz).xy;
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat8.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat8.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat15;
    u_xlat5.x = u_xlat3.x / u_xlat0.x;
    u_xlat5.x = u_xlat5.x + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat5.x<0.0);
#else
    u_xlatb10 = u_xlat5.x<0.0;
#endif
    u_xlat10 = u_xlatb10 ? 1.0 : float(0.0);
    u_xlat5.x = u_xlat5.x * 0.166666672 + u_xlat10;
    u_xlat5.x = booster_Env.x * _DotStarHueSpeed + u_xlat5.x;
    u_xlat5.x = fract(u_xlat5.x);
    u_xlat10 = u_xlat5.x * 6.0;
    u_xlat10 = floor(u_xlat10);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat10<5.0);
#else
    u_xlatb3.x = u_xlat10<5.0;
#endif
    u_xlat5.x = u_xlat5.x * 6.0 + (-u_xlat10);
    u_xlatb1 = lessThan(vec4(u_xlat10), vec4(1.0, 2.0, 3.0, 4.0));
    u_xlat10 = max(u_xlat15, 0.00100000005);
    u_xlat4.z = u_xlat15 + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.z = min(max(u_xlat4.z, 0.0), 1.0);
#else
    u_xlat4.z = clamp(u_xlat4.z, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / u_xlat10;
    u_xlat0.x = u_xlat0.x + _DotStarAddedSaturation;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat0.x * u_xlat5.x + (-u_xlat0.x);
    u_xlat5.x = (-u_xlat0.x) * u_xlat5.x + 1.0;
    u_xlat4.y = u_xlat5.x * u_xlat4.z;
    u_xlat5.x = u_xlat10 + 1.0;
    u_xlat4.w = u_xlat5.x * u_xlat4.z;
    u_xlat3.xz = (u_xlatb3.x) ? u_xlat4.wz : u_xlat4.zy;
    u_xlat4.x = (-u_xlat4.z) * u_xlat0.x + u_xlat4.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    u_xlat3.y = u_xlat4.x;
    u_xlat5.xyz = (u_xlatb1.w) ? u_xlat4.xyz : u_xlat3.xyz;
    u_xlat5.xyz = (u_xlatb1.z) ? u_xlat4.xzw : u_xlat5.xyz;
    u_xlat5.xyz = (u_xlatb1.y) ? u_xlat4.yzx : u_xlat5.xyz;
    u_xlat5.xyz = (u_xlatb1.x) ? u_xlat4.zwx : u_xlat5.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat4.zzz : u_xlat5.xyz;
    u_xlat2.xyz = u_xlat2.xzw * vec3(u_xlat7) + (-u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0>=_DotParams.w);
#else
    u_xlatb15 = 0.0>=_DotParams.w;
#endif
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat15 = vs_TEXCOORD3.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
}
}
 Pass {
  Tags { "DisableBatching" = "true" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "AlphaTest" "RenderType" = "DotDriver" "SHADOWSUPPORT" = "true" }
  Cull Off
  GpuProgramID 221485
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
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD1.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
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
uniform 	mediump float _Cutout;
uniform lowp sampler2D _TransparencyLM;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy + vs_TEXCOORD2.xy;
    u_xlat10_0 = texture2D(_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat16_1 = u_xlat16_0 + (-_Cutout);
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
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD1.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
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
uniform 	mediump float _Cutout;
uniform lowp sampler2D _TransparencyLM;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy + vs_TEXCOORD2.xy;
    u_xlat10_0 = texture2D(_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat16_1 = u_xlat16_0 + (-_Cutout);
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
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD1.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
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
uniform 	mediump float _Cutout;
uniform lowp sampler2D _TransparencyLM;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy + vs_TEXCOORD2.xy;
    u_xlat10_0 = texture2D(_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat16_1 = u_xlat16_0 + (-_Cutout);
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
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD1.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump float _Cutout;
uniform mediump sampler2D _TransparencyLM;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy + vs_TEXCOORD2.xy;
    u_xlat16_0 = texture(_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat16_1 = u_xlat16_0 + (-_Cutout);
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
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD1.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump float _Cutout;
uniform mediump sampler2D _TransparencyLM;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy + vs_TEXCOORD2.xy;
    u_xlat16_0 = texture(_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat16_1 = u_xlat16_0 + (-_Cutout);
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
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD1.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump float _Cutout;
uniform mediump sampler2D _TransparencyLM;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy + vs_TEXCOORD2.xy;
    u_xlat16_0 = texture(_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat16_1 = u_xlat16_0 + (-_Cutout);
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
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD1.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
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
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
uniform 	mediump float _Cutout;
uniform lowp sampler2D _TransparencyLM;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy + vs_TEXCOORD2.xy;
    u_xlat10_0 = texture2D(_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat16_1 = u_xlat16_0 + (-_Cutout);
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
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD1.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
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
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
uniform 	mediump float _Cutout;
uniform lowp sampler2D _TransparencyLM;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy + vs_TEXCOORD2.xy;
    u_xlat10_0 = texture2D(_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat16_1 = u_xlat16_0 + (-_Cutout);
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
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _TransparencyLM_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD1.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
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
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
uniform 	mediump float _Cutout;
uniform lowp sampler2D _TransparencyLM;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy + vs_TEXCOORD2.xy;
    u_xlat10_0 = texture2D(_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat16_1 = u_xlat16_0 + (-_Cutout);
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
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD1.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump float _Cutout;
uniform mediump sampler2D _TransparencyLM;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy + vs_TEXCOORD2.xy;
    u_xlat16_0 = texture(_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat16_1 = u_xlat16_0 + (-_Cutout);
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
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD1.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump float _Cutout;
uniform mediump sampler2D _TransparencyLM;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy + vs_TEXCOORD2.xy;
    u_xlat16_0 = texture(_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat16_1 = u_xlat16_0 + (-_Cutout);
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
uniform 	mediump float _DotSplitU;
uniform 	mediump float _DotSplitV;
uniform 	vec4 _DotParams;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _DotParams.x / _DotSplitU;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = _DotParams.x;
    vs_TEXCOORD1.xy = u_xlat0.xy / vec2(_DotSplitU, _DotSplitV);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump float _Cutout;
uniform mediump sampler2D _TransparencyLM;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy + vs_TEXCOORD2.xy;
    u_xlat16_0 = texture(_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat16_1 = u_xlat16_0 + (-_Cutout);
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
Fallback "Booster/Black"
}