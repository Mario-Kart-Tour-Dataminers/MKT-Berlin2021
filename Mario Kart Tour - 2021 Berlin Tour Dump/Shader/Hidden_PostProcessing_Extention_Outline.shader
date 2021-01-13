//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Extention/Outline" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 60621
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
uniform 	vec4 _CameraDepthNormalsTexture_TexelSize;
uniform 	int _UseBaseColor;
uniform 	vec4 _BaseColor;
uniform 	vec4 _OutlineColor;
uniform 	float _NormalIntensityFactor;
uniform 	float _NormalAttenuationBias;
uniform 	float _DepthIntensityFactor;
uniform 	float _DepthAttenuationBias;
uniform lowp sampler2D _CameraDepthNormalsTexture;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_TARGET0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_19;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
void main()
{
    u_xlat0 = _CameraDepthNormalsTexture_TexelSize.xyxy * vec4(1.0, 0.0, -1.0, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture2D(_CameraDepthNormalsTexture, u_xlat0.xy);
    u_xlat10_0 = texture2D(_CameraDepthNormalsTexture, u_xlat0.zw);
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_1 = dot(u_xlat10_1.zw, vec2(1.0, 0.00392156886));
    u_xlat16_7.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_7.x = 2.0 / u_xlat16_7.x;
    u_xlat2.xy = u_xlat16_2.xy * u_xlat16_7.xx;
    u_xlat2.z = u_xlat16_7.x + -1.0;
    u_xlat10_3 = texture2D(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy);
    u_xlat16_7.xyz = u_xlat10_3.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_20 = dot(u_xlat10_3.zw, vec2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat3.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat3.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat0.x = dot(u_xlat10_0.zw, vec2(1.0, 0.00392156886));
    u_xlat16_6 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_6 = 2.0 / u_xlat16_6;
    u_xlat2.xy = u_xlat16_2.xy * vec2(u_xlat16_6);
    u_xlat2.z = u_xlat16_6 + -1.0;
    u_xlat6.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat6.x = u_xlat6.y + u_xlat6.x;
    u_xlat6.x = u_xlat6.z + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat4 = _CameraDepthNormalsTexture_TexelSize.xyxy * vec4(0.0, 1.0, 0.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_5 = texture2D(_CameraDepthNormalsTexture, u_xlat4.xy);
    u_xlat10_4 = texture2D(_CameraDepthNormalsTexture, u_xlat4.zw);
    u_xlat16_7.xyz = u_xlat10_5.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat0.z = dot(u_xlat10_5.zw, vec2(1.0, 0.00392156886));
    u_xlat16_18 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_18 = 2.0 / u_xlat16_18;
    u_xlat2.xy = u_xlat16_7.xy * vec2(u_xlat16_18);
    u_xlat2.z = u_xlat16_18 + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat18 = u_xlat7.y + u_xlat7.x;
    u_xlat18 = u_xlat7.z + u_xlat18;
    u_xlat6.x = u_xlat18 + u_xlat6.x;
    u_xlat16_7.xyz = u_xlat10_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat0.w = dot(u_xlat10_4.zw, vec2(1.0, 0.00392156886));
    u_xlat0.xzw = (-u_xlat0.xzw) + vec3(u_xlat16_20);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat2.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat2.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD0.xy + _CameraDepthNormalsTexture_TexelSize.xy;
    u_xlat10_4 = texture2D(_CameraDepthNormalsTexture, u_xlat7.xy);
    u_xlat16_7.xyz = u_xlat10_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat2.x = dot(u_xlat10_4.zw, vec2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat4.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat4.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat4 = _CameraDepthNormalsTexture_TexelSize.xyxy * vec4(1.0, -1.0, -1.0, 1.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_5 = texture2D(_CameraDepthNormalsTexture, u_xlat4.xy);
    u_xlat10_4 = texture2D(_CameraDepthNormalsTexture, u_xlat4.zw);
    u_xlat16_7.xyz = u_xlat10_5.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat2.y = dot(u_xlat10_5.zw, vec2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat5.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat5.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat5.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat16_7.xyz = u_xlat10_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat2.z = dot(u_xlat10_4.zw, vec2(1.0, 0.00392156886));
    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(u_xlat16_20);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat4.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat4.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD0.xy + (-_CameraDepthNormalsTexture_TexelSize.xy);
    u_xlat10_4 = texture2D(_CameraDepthNormalsTexture, u_xlat7.xy);
    u_xlat16_7.xyz = u_xlat10_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_21 = dot(u_xlat10_4.zw, vec2(1.0, 0.00392156886));
    u_xlat16_21 = u_xlat16_20 + (-u_xlat16_21);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat4.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat4.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat6.x = u_xlat6.x * _NormalIntensityFactor;
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _NormalAttenuationBias;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat16_1 = (-u_xlat16_1) + u_xlat16_20;
    u_xlat16_7.x = (-u_xlat16_20) + 0.600000024;
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x + u_xlat16_1;
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat2.x + u_xlat0.x;
    u_xlat0.x = u_xlat2.y + u_xlat0.x;
    u_xlat0.x = u_xlat2.z + u_xlat0.x;
    u_xlat0.x = u_xlat16_21 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _DepthIntensityFactor;
    u_xlat0.x = u_xlat0.x * 1000.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _DepthAttenuationBias;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat6.x * u_xlat6.x + u_xlat0.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_7.x;
    u_xlat6.x = float(_UseBaseColor);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = (-u_xlat10_1) + _BaseColor;
    u_xlat1 = u_xlat6.xxxx * u_xlat2 + u_xlat10_1;
    u_xlat2 = (-u_xlat1) + _OutlineColor;
    SV_TARGET0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
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
uniform 	vec4 _CameraDepthNormalsTexture_TexelSize;
uniform 	int _UseBaseColor;
uniform 	vec4 _BaseColor;
uniform 	vec4 _OutlineColor;
uniform 	float _NormalIntensityFactor;
uniform 	float _NormalAttenuationBias;
uniform 	float _DepthIntensityFactor;
uniform 	float _DepthAttenuationBias;
uniform lowp sampler2D _CameraDepthNormalsTexture;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_TARGET0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_19;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
void main()
{
    u_xlat0 = _CameraDepthNormalsTexture_TexelSize.xyxy * vec4(1.0, 0.0, -1.0, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture2D(_CameraDepthNormalsTexture, u_xlat0.xy);
    u_xlat10_0 = texture2D(_CameraDepthNormalsTexture, u_xlat0.zw);
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_1 = dot(u_xlat10_1.zw, vec2(1.0, 0.00392156886));
    u_xlat16_7.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_7.x = 2.0 / u_xlat16_7.x;
    u_xlat2.xy = u_xlat16_2.xy * u_xlat16_7.xx;
    u_xlat2.z = u_xlat16_7.x + -1.0;
    u_xlat10_3 = texture2D(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy);
    u_xlat16_7.xyz = u_xlat10_3.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_20 = dot(u_xlat10_3.zw, vec2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat3.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat3.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat0.x = dot(u_xlat10_0.zw, vec2(1.0, 0.00392156886));
    u_xlat16_6 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_6 = 2.0 / u_xlat16_6;
    u_xlat2.xy = u_xlat16_2.xy * vec2(u_xlat16_6);
    u_xlat2.z = u_xlat16_6 + -1.0;
    u_xlat6.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat6.x = u_xlat6.y + u_xlat6.x;
    u_xlat6.x = u_xlat6.z + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat4 = _CameraDepthNormalsTexture_TexelSize.xyxy * vec4(0.0, 1.0, 0.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_5 = texture2D(_CameraDepthNormalsTexture, u_xlat4.xy);
    u_xlat10_4 = texture2D(_CameraDepthNormalsTexture, u_xlat4.zw);
    u_xlat16_7.xyz = u_xlat10_5.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat0.z = dot(u_xlat10_5.zw, vec2(1.0, 0.00392156886));
    u_xlat16_18 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_18 = 2.0 / u_xlat16_18;
    u_xlat2.xy = u_xlat16_7.xy * vec2(u_xlat16_18);
    u_xlat2.z = u_xlat16_18 + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat18 = u_xlat7.y + u_xlat7.x;
    u_xlat18 = u_xlat7.z + u_xlat18;
    u_xlat6.x = u_xlat18 + u_xlat6.x;
    u_xlat16_7.xyz = u_xlat10_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat0.w = dot(u_xlat10_4.zw, vec2(1.0, 0.00392156886));
    u_xlat0.xzw = (-u_xlat0.xzw) + vec3(u_xlat16_20);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat2.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat2.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD0.xy + _CameraDepthNormalsTexture_TexelSize.xy;
    u_xlat10_4 = texture2D(_CameraDepthNormalsTexture, u_xlat7.xy);
    u_xlat16_7.xyz = u_xlat10_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat2.x = dot(u_xlat10_4.zw, vec2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat4.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat4.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat4 = _CameraDepthNormalsTexture_TexelSize.xyxy * vec4(1.0, -1.0, -1.0, 1.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_5 = texture2D(_CameraDepthNormalsTexture, u_xlat4.xy);
    u_xlat10_4 = texture2D(_CameraDepthNormalsTexture, u_xlat4.zw);
    u_xlat16_7.xyz = u_xlat10_5.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat2.y = dot(u_xlat10_5.zw, vec2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat5.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat5.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat5.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat16_7.xyz = u_xlat10_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat2.z = dot(u_xlat10_4.zw, vec2(1.0, 0.00392156886));
    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(u_xlat16_20);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat4.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat4.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD0.xy + (-_CameraDepthNormalsTexture_TexelSize.xy);
    u_xlat10_4 = texture2D(_CameraDepthNormalsTexture, u_xlat7.xy);
    u_xlat16_7.xyz = u_xlat10_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_21 = dot(u_xlat10_4.zw, vec2(1.0, 0.00392156886));
    u_xlat16_21 = u_xlat16_20 + (-u_xlat16_21);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat4.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat4.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat6.x = u_xlat6.x * _NormalIntensityFactor;
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _NormalAttenuationBias;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat16_1 = (-u_xlat16_1) + u_xlat16_20;
    u_xlat16_7.x = (-u_xlat16_20) + 0.600000024;
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x + u_xlat16_1;
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat2.x + u_xlat0.x;
    u_xlat0.x = u_xlat2.y + u_xlat0.x;
    u_xlat0.x = u_xlat2.z + u_xlat0.x;
    u_xlat0.x = u_xlat16_21 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _DepthIntensityFactor;
    u_xlat0.x = u_xlat0.x * 1000.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _DepthAttenuationBias;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat6.x * u_xlat6.x + u_xlat0.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_7.x;
    u_xlat6.x = float(_UseBaseColor);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = (-u_xlat10_1) + _BaseColor;
    u_xlat1 = u_xlat6.xxxx * u_xlat2 + u_xlat10_1;
    u_xlat2 = (-u_xlat1) + _OutlineColor;
    SV_TARGET0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
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
uniform 	vec4 _CameraDepthNormalsTexture_TexelSize;
uniform 	int _UseBaseColor;
uniform 	vec4 _BaseColor;
uniform 	vec4 _OutlineColor;
uniform 	float _NormalIntensityFactor;
uniform 	float _NormalAttenuationBias;
uniform 	float _DepthIntensityFactor;
uniform 	float _DepthAttenuationBias;
uniform lowp sampler2D _CameraDepthNormalsTexture;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_TARGET0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_19;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
void main()
{
    u_xlat0 = _CameraDepthNormalsTexture_TexelSize.xyxy * vec4(1.0, 0.0, -1.0, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture2D(_CameraDepthNormalsTexture, u_xlat0.xy);
    u_xlat10_0 = texture2D(_CameraDepthNormalsTexture, u_xlat0.zw);
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_1 = dot(u_xlat10_1.zw, vec2(1.0, 0.00392156886));
    u_xlat16_7.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_7.x = 2.0 / u_xlat16_7.x;
    u_xlat2.xy = u_xlat16_2.xy * u_xlat16_7.xx;
    u_xlat2.z = u_xlat16_7.x + -1.0;
    u_xlat10_3 = texture2D(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy);
    u_xlat16_7.xyz = u_xlat10_3.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_20 = dot(u_xlat10_3.zw, vec2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat3.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat3.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat0.x = dot(u_xlat10_0.zw, vec2(1.0, 0.00392156886));
    u_xlat16_6 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_6 = 2.0 / u_xlat16_6;
    u_xlat2.xy = u_xlat16_2.xy * vec2(u_xlat16_6);
    u_xlat2.z = u_xlat16_6 + -1.0;
    u_xlat6.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat6.x = u_xlat6.y + u_xlat6.x;
    u_xlat6.x = u_xlat6.z + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat4 = _CameraDepthNormalsTexture_TexelSize.xyxy * vec4(0.0, 1.0, 0.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_5 = texture2D(_CameraDepthNormalsTexture, u_xlat4.xy);
    u_xlat10_4 = texture2D(_CameraDepthNormalsTexture, u_xlat4.zw);
    u_xlat16_7.xyz = u_xlat10_5.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat0.z = dot(u_xlat10_5.zw, vec2(1.0, 0.00392156886));
    u_xlat16_18 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_18 = 2.0 / u_xlat16_18;
    u_xlat2.xy = u_xlat16_7.xy * vec2(u_xlat16_18);
    u_xlat2.z = u_xlat16_18 + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat18 = u_xlat7.y + u_xlat7.x;
    u_xlat18 = u_xlat7.z + u_xlat18;
    u_xlat6.x = u_xlat18 + u_xlat6.x;
    u_xlat16_7.xyz = u_xlat10_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat0.w = dot(u_xlat10_4.zw, vec2(1.0, 0.00392156886));
    u_xlat0.xzw = (-u_xlat0.xzw) + vec3(u_xlat16_20);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat2.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat2.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD0.xy + _CameraDepthNormalsTexture_TexelSize.xy;
    u_xlat10_4 = texture2D(_CameraDepthNormalsTexture, u_xlat7.xy);
    u_xlat16_7.xyz = u_xlat10_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat2.x = dot(u_xlat10_4.zw, vec2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat4.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat4.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat4 = _CameraDepthNormalsTexture_TexelSize.xyxy * vec4(1.0, -1.0, -1.0, 1.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_5 = texture2D(_CameraDepthNormalsTexture, u_xlat4.xy);
    u_xlat10_4 = texture2D(_CameraDepthNormalsTexture, u_xlat4.zw);
    u_xlat16_7.xyz = u_xlat10_5.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat2.y = dot(u_xlat10_5.zw, vec2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat5.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat5.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat5.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat16_7.xyz = u_xlat10_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat2.z = dot(u_xlat10_4.zw, vec2(1.0, 0.00392156886));
    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(u_xlat16_20);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat4.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat4.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD0.xy + (-_CameraDepthNormalsTexture_TexelSize.xy);
    u_xlat10_4 = texture2D(_CameraDepthNormalsTexture, u_xlat7.xy);
    u_xlat16_7.xyz = u_xlat10_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_21 = dot(u_xlat10_4.zw, vec2(1.0, 0.00392156886));
    u_xlat16_21 = u_xlat16_20 + (-u_xlat16_21);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat4.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat4.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat6.x = u_xlat6.x * _NormalIntensityFactor;
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _NormalAttenuationBias;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat16_1 = (-u_xlat16_1) + u_xlat16_20;
    u_xlat16_7.x = (-u_xlat16_20) + 0.600000024;
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x + u_xlat16_1;
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat2.x + u_xlat0.x;
    u_xlat0.x = u_xlat2.y + u_xlat0.x;
    u_xlat0.x = u_xlat2.z + u_xlat0.x;
    u_xlat0.x = u_xlat16_21 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _DepthIntensityFactor;
    u_xlat0.x = u_xlat0.x * 1000.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _DepthAttenuationBias;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat6.x * u_xlat6.x + u_xlat0.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_7.x;
    u_xlat6.x = float(_UseBaseColor);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = (-u_xlat10_1) + _BaseColor;
    u_xlat1 = u_xlat6.xxxx * u_xlat2 + u_xlat10_1;
    u_xlat2 = (-u_xlat1) + _OutlineColor;
    SV_TARGET0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
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
uniform 	vec4 _CameraDepthNormalsTexture_TexelSize;
uniform 	int _UseBaseColor;
uniform 	vec4 _BaseColor;
uniform 	vec4 _OutlineColor;
uniform 	float _NormalIntensityFactor;
uniform 	float _NormalAttenuationBias;
uniform 	float _DepthIntensityFactor;
uniform 	float _DepthAttenuationBias;
uniform mediump sampler2D _CameraDepthNormalsTexture;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_19;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
void main()
{
    u_xlat0 = _CameraDepthNormalsTexture_TexelSize.xyxy * vec4(1.0, 0.0, -1.0, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_1 = texture(_CameraDepthNormalsTexture, u_xlat0.xy);
    u_xlat16_0 = texture(_CameraDepthNormalsTexture, u_xlat0.zw);
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_1.x = dot(u_xlat16_1.zw, vec2(1.0, 0.00392156886));
    u_xlat16_7.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_7.x = 2.0 / u_xlat16_7.x;
    u_xlat2.xy = u_xlat16_2.xy * u_xlat16_7.xx;
    u_xlat2.z = u_xlat16_7.x + -1.0;
    u_xlat16_3 = texture(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy);
    u_xlat16_7.xyz = u_xlat16_3.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_20 = dot(u_xlat16_3.zw, vec2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat3.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat3.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat0.x = dot(u_xlat16_0.zw, vec2(1.0, 0.00392156886));
    u_xlat16_6 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_6 = 2.0 / u_xlat16_6;
    u_xlat2.xy = u_xlat16_2.xy * vec2(u_xlat16_6);
    u_xlat2.z = u_xlat16_6 + -1.0;
    u_xlat6.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat6.x = u_xlat6.y + u_xlat6.x;
    u_xlat6.x = u_xlat6.z + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat4 = _CameraDepthNormalsTexture_TexelSize.xyxy * vec4(0.0, 1.0, 0.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_5 = texture(_CameraDepthNormalsTexture, u_xlat4.xy);
    u_xlat16_4 = texture(_CameraDepthNormalsTexture, u_xlat4.zw);
    u_xlat16_7.xyz = u_xlat16_5.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat0.z = dot(u_xlat16_5.zw, vec2(1.0, 0.00392156886));
    u_xlat16_18 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_18 = 2.0 / u_xlat16_18;
    u_xlat2.xy = u_xlat16_7.xy * vec2(u_xlat16_18);
    u_xlat2.z = u_xlat16_18 + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat18 = u_xlat7.y + u_xlat7.x;
    u_xlat18 = u_xlat7.z + u_xlat18;
    u_xlat6.x = u_xlat18 + u_xlat6.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat0.w = dot(u_xlat16_4.zw, vec2(1.0, 0.00392156886));
    u_xlat0.xzw = (-u_xlat0.xzw) + vec3(u_xlat16_20);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat2.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat2.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD0.xy + _CameraDepthNormalsTexture_TexelSize.xy;
    u_xlat16_4 = texture(_CameraDepthNormalsTexture, u_xlat7.xy);
    u_xlat16_7.xyz = u_xlat16_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat2.x = dot(u_xlat16_4.zw, vec2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat4.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat4.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat4 = _CameraDepthNormalsTexture_TexelSize.xyxy * vec4(1.0, -1.0, -1.0, 1.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_5 = texture(_CameraDepthNormalsTexture, u_xlat4.xy);
    u_xlat16_4 = texture(_CameraDepthNormalsTexture, u_xlat4.zw);
    u_xlat16_7.xyz = u_xlat16_5.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat2.y = dot(u_xlat16_5.zw, vec2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat5.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat5.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat5.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat2.z = dot(u_xlat16_4.zw, vec2(1.0, 0.00392156886));
    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(u_xlat16_20);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat4.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat4.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD0.xy + (-_CameraDepthNormalsTexture_TexelSize.xy);
    u_xlat16_4 = texture(_CameraDepthNormalsTexture, u_xlat7.xy);
    u_xlat16_7.xyz = u_xlat16_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_21 = dot(u_xlat16_4.zw, vec2(1.0, 0.00392156886));
    u_xlat16_21 = u_xlat16_20 + (-u_xlat16_21);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat4.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat4.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat6.x = u_xlat6.x * _NormalIntensityFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _NormalAttenuationBias;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_20;
    u_xlat16_7.x = (-u_xlat16_20) + 0.600000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat2.x + u_xlat0.x;
    u_xlat0.x = u_xlat2.y + u_xlat0.x;
    u_xlat0.x = u_xlat2.z + u_xlat0.x;
    u_xlat0.x = u_xlat16_21 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _DepthIntensityFactor;
    u_xlat0.x = u_xlat0.x * 1000.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _DepthAttenuationBias;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat6.x * u_xlat6.x + u_xlat0.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_7.x;
    u_xlat6.x = float(_UseBaseColor);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = (-u_xlat16_1) + _BaseColor;
    u_xlat1 = u_xlat6.xxxx * u_xlat2 + u_xlat16_1;
    u_xlat2 = (-u_xlat1) + _OutlineColor;
    SV_TARGET0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
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
uniform 	vec4 _CameraDepthNormalsTexture_TexelSize;
uniform 	int _UseBaseColor;
uniform 	vec4 _BaseColor;
uniform 	vec4 _OutlineColor;
uniform 	float _NormalIntensityFactor;
uniform 	float _NormalAttenuationBias;
uniform 	float _DepthIntensityFactor;
uniform 	float _DepthAttenuationBias;
uniform mediump sampler2D _CameraDepthNormalsTexture;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_19;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
void main()
{
    u_xlat0 = _CameraDepthNormalsTexture_TexelSize.xyxy * vec4(1.0, 0.0, -1.0, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_1 = texture(_CameraDepthNormalsTexture, u_xlat0.xy);
    u_xlat16_0 = texture(_CameraDepthNormalsTexture, u_xlat0.zw);
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_1.x = dot(u_xlat16_1.zw, vec2(1.0, 0.00392156886));
    u_xlat16_7.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_7.x = 2.0 / u_xlat16_7.x;
    u_xlat2.xy = u_xlat16_2.xy * u_xlat16_7.xx;
    u_xlat2.z = u_xlat16_7.x + -1.0;
    u_xlat16_3 = texture(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy);
    u_xlat16_7.xyz = u_xlat16_3.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_20 = dot(u_xlat16_3.zw, vec2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat3.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat3.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat0.x = dot(u_xlat16_0.zw, vec2(1.0, 0.00392156886));
    u_xlat16_6 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_6 = 2.0 / u_xlat16_6;
    u_xlat2.xy = u_xlat16_2.xy * vec2(u_xlat16_6);
    u_xlat2.z = u_xlat16_6 + -1.0;
    u_xlat6.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat6.x = u_xlat6.y + u_xlat6.x;
    u_xlat6.x = u_xlat6.z + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat4 = _CameraDepthNormalsTexture_TexelSize.xyxy * vec4(0.0, 1.0, 0.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_5 = texture(_CameraDepthNormalsTexture, u_xlat4.xy);
    u_xlat16_4 = texture(_CameraDepthNormalsTexture, u_xlat4.zw);
    u_xlat16_7.xyz = u_xlat16_5.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat0.z = dot(u_xlat16_5.zw, vec2(1.0, 0.00392156886));
    u_xlat16_18 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_18 = 2.0 / u_xlat16_18;
    u_xlat2.xy = u_xlat16_7.xy * vec2(u_xlat16_18);
    u_xlat2.z = u_xlat16_18 + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat18 = u_xlat7.y + u_xlat7.x;
    u_xlat18 = u_xlat7.z + u_xlat18;
    u_xlat6.x = u_xlat18 + u_xlat6.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat0.w = dot(u_xlat16_4.zw, vec2(1.0, 0.00392156886));
    u_xlat0.xzw = (-u_xlat0.xzw) + vec3(u_xlat16_20);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat2.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat2.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD0.xy + _CameraDepthNormalsTexture_TexelSize.xy;
    u_xlat16_4 = texture(_CameraDepthNormalsTexture, u_xlat7.xy);
    u_xlat16_7.xyz = u_xlat16_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat2.x = dot(u_xlat16_4.zw, vec2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat4.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat4.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat4 = _CameraDepthNormalsTexture_TexelSize.xyxy * vec4(1.0, -1.0, -1.0, 1.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_5 = texture(_CameraDepthNormalsTexture, u_xlat4.xy);
    u_xlat16_4 = texture(_CameraDepthNormalsTexture, u_xlat4.zw);
    u_xlat16_7.xyz = u_xlat16_5.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat2.y = dot(u_xlat16_5.zw, vec2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat5.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat5.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat5.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat2.z = dot(u_xlat16_4.zw, vec2(1.0, 0.00392156886));
    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(u_xlat16_20);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat4.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat4.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD0.xy + (-_CameraDepthNormalsTexture_TexelSize.xy);
    u_xlat16_4 = texture(_CameraDepthNormalsTexture, u_xlat7.xy);
    u_xlat16_7.xyz = u_xlat16_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_21 = dot(u_xlat16_4.zw, vec2(1.0, 0.00392156886));
    u_xlat16_21 = u_xlat16_20 + (-u_xlat16_21);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat4.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat4.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat6.x = u_xlat6.x * _NormalIntensityFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _NormalAttenuationBias;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_20;
    u_xlat16_7.x = (-u_xlat16_20) + 0.600000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat2.x + u_xlat0.x;
    u_xlat0.x = u_xlat2.y + u_xlat0.x;
    u_xlat0.x = u_xlat2.z + u_xlat0.x;
    u_xlat0.x = u_xlat16_21 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _DepthIntensityFactor;
    u_xlat0.x = u_xlat0.x * 1000.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _DepthAttenuationBias;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat6.x * u_xlat6.x + u_xlat0.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_7.x;
    u_xlat6.x = float(_UseBaseColor);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = (-u_xlat16_1) + _BaseColor;
    u_xlat1 = u_xlat6.xxxx * u_xlat2 + u_xlat16_1;
    u_xlat2 = (-u_xlat1) + _OutlineColor;
    SV_TARGET0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
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
uniform 	vec4 _CameraDepthNormalsTexture_TexelSize;
uniform 	int _UseBaseColor;
uniform 	vec4 _BaseColor;
uniform 	vec4 _OutlineColor;
uniform 	float _NormalIntensityFactor;
uniform 	float _NormalAttenuationBias;
uniform 	float _DepthIntensityFactor;
uniform 	float _DepthAttenuationBias;
uniform mediump sampler2D _CameraDepthNormalsTexture;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_TARGET0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_19;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
void main()
{
    u_xlat0 = _CameraDepthNormalsTexture_TexelSize.xyxy * vec4(1.0, 0.0, -1.0, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_1 = texture(_CameraDepthNormalsTexture, u_xlat0.xy);
    u_xlat16_0 = texture(_CameraDepthNormalsTexture, u_xlat0.zw);
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_1.x = dot(u_xlat16_1.zw, vec2(1.0, 0.00392156886));
    u_xlat16_7.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_7.x = 2.0 / u_xlat16_7.x;
    u_xlat2.xy = u_xlat16_2.xy * u_xlat16_7.xx;
    u_xlat2.z = u_xlat16_7.x + -1.0;
    u_xlat16_3 = texture(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy);
    u_xlat16_7.xyz = u_xlat16_3.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_20 = dot(u_xlat16_3.zw, vec2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat3.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat3.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat0.x = dot(u_xlat16_0.zw, vec2(1.0, 0.00392156886));
    u_xlat16_6 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_6 = 2.0 / u_xlat16_6;
    u_xlat2.xy = u_xlat16_2.xy * vec2(u_xlat16_6);
    u_xlat2.z = u_xlat16_6 + -1.0;
    u_xlat6.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat6.x = u_xlat6.y + u_xlat6.x;
    u_xlat6.x = u_xlat6.z + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat4 = _CameraDepthNormalsTexture_TexelSize.xyxy * vec4(0.0, 1.0, 0.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_5 = texture(_CameraDepthNormalsTexture, u_xlat4.xy);
    u_xlat16_4 = texture(_CameraDepthNormalsTexture, u_xlat4.zw);
    u_xlat16_7.xyz = u_xlat16_5.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat0.z = dot(u_xlat16_5.zw, vec2(1.0, 0.00392156886));
    u_xlat16_18 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_18 = 2.0 / u_xlat16_18;
    u_xlat2.xy = u_xlat16_7.xy * vec2(u_xlat16_18);
    u_xlat2.z = u_xlat16_18 + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat18 = u_xlat7.y + u_xlat7.x;
    u_xlat18 = u_xlat7.z + u_xlat18;
    u_xlat6.x = u_xlat18 + u_xlat6.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat0.w = dot(u_xlat16_4.zw, vec2(1.0, 0.00392156886));
    u_xlat0.xzw = (-u_xlat0.xzw) + vec3(u_xlat16_20);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat2.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat2.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD0.xy + _CameraDepthNormalsTexture_TexelSize.xy;
    u_xlat16_4 = texture(_CameraDepthNormalsTexture, u_xlat7.xy);
    u_xlat16_7.xyz = u_xlat16_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat2.x = dot(u_xlat16_4.zw, vec2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat4.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat4.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat4 = _CameraDepthNormalsTexture_TexelSize.xyxy * vec4(1.0, -1.0, -1.0, 1.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_5 = texture(_CameraDepthNormalsTexture, u_xlat4.xy);
    u_xlat16_4 = texture(_CameraDepthNormalsTexture, u_xlat4.zw);
    u_xlat16_7.xyz = u_xlat16_5.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat2.y = dot(u_xlat16_5.zw, vec2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat5.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat5.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat5.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat2.z = dot(u_xlat16_4.zw, vec2(1.0, 0.00392156886));
    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(u_xlat16_20);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat4.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat4.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD0.xy + (-_CameraDepthNormalsTexture_TexelSize.xy);
    u_xlat16_4 = texture(_CameraDepthNormalsTexture, u_xlat7.xy);
    u_xlat16_7.xyz = u_xlat16_4.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_21 = dot(u_xlat16_4.zw, vec2(1.0, 0.00392156886));
    u_xlat16_21 = u_xlat16_20 + (-u_xlat16_21);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = 2.0 / u_xlat16_19;
    u_xlat4.xy = u_xlat16_7.xy * vec2(u_xlat16_19);
    u_xlat4.z = u_xlat16_19 + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat6.x = u_xlat6.x * _NormalIntensityFactor;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _NormalAttenuationBias;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_20;
    u_xlat16_7.x = (-u_xlat16_20) + 0.600000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat2.x + u_xlat0.x;
    u_xlat0.x = u_xlat2.y + u_xlat0.x;
    u_xlat0.x = u_xlat2.z + u_xlat0.x;
    u_xlat0.x = u_xlat16_21 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _DepthIntensityFactor;
    u_xlat0.x = u_xlat0.x * 1000.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _DepthAttenuationBias;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat6.x * u_xlat6.x + u_xlat0.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_7.x;
    u_xlat6.x = float(_UseBaseColor);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = (-u_xlat16_1) + _BaseColor;
    u_xlat1 = u_xlat6.xxxx * u_xlat2 + u_xlat16_1;
    u_xlat2 = (-u_xlat1) + _OutlineColor;
    SV_TARGET0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
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