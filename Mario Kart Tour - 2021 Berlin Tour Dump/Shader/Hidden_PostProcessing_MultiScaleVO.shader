//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/MultiScaleVO" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 38580
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 92442
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 147485
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 200548
}
}
}