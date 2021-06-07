#ifndef LIL_INPUT_INCLUDED
#define LIL_INPUT_INCLUDED

//------------------------------------------------------------------------------------------------------------------------------
// Variables from Unity
#if !defined(SPOT) && !defined(POINT_COOKIE) && LIL_VERTEXLIGHT_MODE == 4
    TEXTURE2D(_LightTextureB0);
    SAMPLER(sampler_LightTextureB0);
#endif

TEXTURE3D(_DitherMaskLOD);
TEXTURE2D(_BackgroundTexture);
TEXTURE2D(_GrabTexture);
TEXTURE2D(_CameraDepthTexture);
SAMPLER(sampler_linear_repeat);
SAMPLER(sampler_DitherMaskLOD);
SAMPLER(sampler_BackgroundTexture);
SAMPLER(sampler_GrabTexture);
SAMPLER(sampler_CameraDepthTexture);
float4 _GrabTexture_TexelSize;

//------------------------------------------------------------------------------------------------------------------------------
// Texture Exists
#if defined(LIL_FEATURE_TEX_LAYER_MASK)
    #define Exists_Main2ndBlendMask     true
    #define Exists_Main3rdBlendMask     true
#else
    #define Exists_Main2ndBlendMask     false
    #define Exists_Main3rdBlendMask     false
#endif

#if defined(LIL_FEATURE_TEX_NORMAL_MASK)
    #define Exists_Bump2ndScaleMask     true
#else
    #define Exists_Bump2ndScaleMask     false
#endif

#if defined(LIL_FEATURE_TEX_SHADOW_BORDER)
    #define Exists_ShadowBorderMask     true
#else
    #define Exists_ShadowBorderMask     false
#endif

#if defined(LIL_FEATURE_TEX_SHADOW_BLUR)
    #define Exists_ShadowBlurMask       true
#else
    #define Exists_ShadowBlurMask       false
#endif

#if defined(LIL_FEATURE_TEX_SHADOW_STRENGTH)
    #define Exists_ShadowStrengthMask   true
#else
    #define Exists_ShadowStrengthMask   false
#endif

#if defined(LIL_FEATURE_TEX_SHADOW_1ST)
    #define Exists_ShadowColorTex       true
#else
    #define Exists_ShadowColorTex       false
#endif

#if defined(LIL_FEATURE_TEX_SHADOW_2ND)
    #define Exists_Shadow2ndColorTex    true
#else
    #define Exists_Shadow2ndColorTex    false
#endif

#if defined(LIL_FEATURE_TEX_REFLECTION_SMOOTHNESS)
    #define Exists_SmoothnessTex        true
#else
    #define Exists_SmoothnessTex        true
#endif

#if defined(LIL_FEATURE_TEX_REFLECTION_METALLIC)
    #define Exists_MetallicGlossMap     true
#else
    #define Exists_MetallicGlossMap     false
#endif

#if defined(LIL_FEATURE_TEX_REFLECTION_COLOR)
    #define Exists_ReflectionColorTex   true
#else
    #define Exists_ReflectionColorTex   false
#endif

#if defined(LIL_FEATURE_TEX_MATCAP_MASK)
    #define Exists_MatCapBlendMask      true
#else
    #define Exists_MatCapBlendMask      false
#endif

#if defined(LIL_FEATURE_TEX_RIMLIGHT_COLOR)
    #define Exists_RimColorTex          true
#else
    #define Exists_RimColorTex          false
#endif

#if defined(LIL_FEATURE_TEX_EMISSION_MASK)
    #define Exists_EmissionBlendMask    true
    #define Exists_Emission2ndBlendMask true
#else
    #define Exists_EmissionBlendMask    false
    #define Exists_Emission2ndBlendMask false
#endif

#if defined(LIL_FEATURE_TEX_AUDIOLINK_MASK)
    #define Exists_AudioLinkMask    true
#else
    #define Exists_AudioLinkMask    false
#endif

#if defined(LIL_FEATURE_TEX_OUTLINE_COLOR)
    #define Exists_OutlineTex           true
#else
    #define Exists_OutlineTex           false
#endif

#if defined(LIL_FEATURE_TEX_OUTLINE_WIDTH)
    #define Exists_OutlineWidthMask     true
#else
    #define Exists_OutlineWidthMask     false
#endif

#if defined(LIL_FEATURE_TEX_FUR_MASK)
    #define Exists_FurMask              true
#else
    #define Exists_FurMask              false
#endif

#if defined(LIL_FEATURE_TEX_FUR_NORMAL)
    #define Exists_FurVectorTex         true
#else
    #define Exists_FurVectorTex         false
#endif

#define Exists_MainTex              true
#define Exists_Main2ndTex           true
#define Exists_Main3rdTex           true
#define Exists_BumpMap              true
#define Exists_Bump2ndMap           true
#define Exists_MatCapTex            true
#define Exists_EmissionMap          true
#define Exists_EmissionGradTex      true
#define Exists_Emission2ndMap       true
#define Exists_Emission2ndGradTex   true
#define Exists_ParallaxMap          true
#define Exists_FurNoiseMask         true
#define Exists_TriMask              true

//------------------------------------------------------------------------------------------------------------------------------
// Input

// ST               x:scale y:scale z:offset w:offset
// ScrollRotate     x:scroll y:scroll z:angle w:rotation
// Blink            x:strength y:type z:speed w:offset
// HSVG             x:hue y:saturation z:value w:gamma
// BlendMode        0:normal 1:add 2:screen 3:multiply

// bool does not work in cbuffer
//#define lilBool bool
#define lilBool uint

#if defined(LIL_LITE)
CBUFFER_START(UnityPerMaterial)
float4  _Color;
float4  _MainTex_ST;
float4  _MainTex_ScrollRotate;
float4  _RimColor;
float4  _EmissionColor;
float4  _EmissionBlink;
float4  _EmissionMap_ST;
float4  _EmissionMap_ScrollRotate;
float4  _OutlineColor;
float4  _OutlineTex_ST;
float4  _OutlineTex_ScrollRotate;
float   _Cutoff;
float   _FlipNormal;
float   _BackfaceForceShadow;
float   _ShadowBorder;
float   _ShadowBlur;
float   _ShadowEnvStrength;
float   _RimBorder;
float   _RimBlur;
float   _RimFresnelPower;
float   _OutlineWidth;
lilBool _Invisible;
lilBool _AsUnlit;
lilBool _UseShadow;
lilBool _UseMatCap;
lilBool _MatCapMul;
lilBool _UseRim;
lilBool _RimShadowMask;
lilBool _UseEmission;
lilBool _OutlineFixWidth;
lilBool _OutlineVertexR2Width;
lilBool _OutlineEnableLighting;
CBUFFER_END
#elif defined(LIL_BAKER)
CBUFFER_START(UnityPerMaterial)
float4  _Color;
float4  _MainTex_ST;
float4  _MainTexHSVG;
float4  _Color2nd;
float4  _Main2ndTex_ST;
float4  _Color3rd;
float4  _Main3rdTex_ST;
float   _Main2ndTexAngle;
float   _Main3rdTexAngle;
uint    _Main2ndTexBlendMode;
uint    _Main3rdTexBlendMode;
lilBool _UseMain2ndTex;
lilBool _Main2ndTexIsDecal;
lilBool _Main2ndTexIsLeftOnly;
lilBool _Main2ndTexIsRightOnly;
lilBool _Main2ndTexShouldCopy;
lilBool _Main2ndTexShouldFlipMirror;
lilBool _Main2ndTexShouldFlipCopy;
lilBool _Main2ndTexIsMSDF;
lilBool _UseMain3rdTex;
lilBool _Main3rdTexIsDecal;
lilBool _Main3rdTexIsLeftOnly;
lilBool _Main3rdTexIsRightOnly;
lilBool _Main3rdTexShouldCopy;
lilBool _Main3rdTexShouldFlipMirror;
lilBool _Main3rdTexShouldFlipCopy;
lilBool _Main3rdTexIsMSDF;
CBUFFER_END
#else
CBUFFER_START(UnityPerMaterial)
//------------------------------------------------------------------------------------------------------------------------------
// Vector
// Main
float4  _Color;
float4  _MainTex_ST;
#if defined(LIL_FEATURE_ANIMATE_MAIN_UV)
    float4  _MainTex_ScrollRotate;
#endif
#if defined(LIL_FEATURE_MAIN_TONE_CORRECTION)
    float4  _MainTexHSVG;
#endif

// Main2nd
#if defined(LIL_FEATURE_MAIN2ND)
    float4  _Color2nd;
    float4  _Main2ndTex_ST;
    #if defined(LIL_FEATURE_DECAL) && defined(LIL_FEATURE_ANIMATE_DECAL)
        float4  _Main2ndTexDecalAnimation;
        float4  _Main2ndTexDecalSubParam;
    #endif
#endif

// Main3rd
#if defined(LIL_FEATURE_MAIN3RD)
    float4  _Color3rd;
    float4  _Main3rdTex_ST;
    #if defined(LIL_FEATURE_DECAL) && defined(LIL_FEATURE_ANIMATE_DECAL)
        float4  _Main3rdTexDecalAnimation;
        float4  _Main3rdTexDecalSubParam;
    #endif
#endif

// Shadow
#if defined(LIL_FEATURE_SHADOW)
    float4  _ShadowColor;
    float4  _Shadow2ndColor;
    float4  _ShadowBorderColor;
#endif

// Emission
#if defined(LIL_FEATURE_EMISSION_1ST)
    float4  _EmissionColor;
    float4  _EmissionBlink;
    #if defined(LIL_FEATURE_EMISSION_UV)
        float4  _EmissionMap_ST;
        #if defined(LIL_FEATURE_ANIMATE_EMISSION_UV)
            float4  _EmissionMap_ScrollRotate;
        #endif
    #endif
    #if defined(LIL_FEATURE_EMISSION_MASK_UV)
        float4  _EmissionBlendMask_ST;
        #if defined(LIL_FEATURE_ANIMATE_EMISSION_MASK_UV)
            float4  _EmissionBlendMask_ScrollRotate;
        #endif
    #endif
#endif

// Emission 2nd
#if defined(LIL_FEATURE_EMISSION_2ND)
    float4  _Emission2ndColor;
    float4  _Emission2ndBlink;
    #if defined(LIL_FEATURE_EMISSION_UV)
        float4  _Emission2ndMap_ST;
        #if defined(LIL_FEATURE_ANIMATE_EMISSION_UV)
            float4  _Emission2ndMap_ScrollRotate;
        #endif
    #endif
    #if defined(LIL_FEATURE_EMISSION_MASK_UV)
        float4  _Emission2ndBlendMask_ST;
        #if defined(LIL_FEATURE_ANIMATE_EMISSION_MASK_UV)
            float4  _Emission2ndBlendMask_ScrollRotate;
        #endif
    #endif
#endif

// Normal Map
#if defined(LIL_FEATURE_NORMAL_1ST)
    float4  _BumpMap_ST;
#endif

// Normal Map 2nd
#if defined(LIL_FEATURE_NORMAL_2ND)
    float4  _Bump2ndMap_ST;
#endif

// Reflection
#if defined(LIL_FEATURE_REFLECTION)
    float4  _ReflectionColor;
#endif

// MatCap
#if defined(LIL_FEATURE_MATCAP)
    float4  _MatCapColor;
#endif

// Rim Light
#if defined(LIL_FEATURE_RIMLIGHT)
    float4  _RimColor;
#endif

// Distance Fade
#if defined(LIL_FEATURE_DISTANCE_FADE)
    float4 _DistanceFade;
    float4 _DistanceFadeColor;
#endif

// AudioLink
#if defined(LIL_FEATURE_AUDIOLINK)
    float4  _AudioLinkUVParams;
    #if defined(LIL_FEATURE_AUDIOLINK_VERTEX)
        float4  _AudioLinkVertexUVParams;
        float4  _AudioLinkVertexStart;
        float4  _AudioLinkVertexStrength;
    #endif
    #if defined(LIL_FEATURE_AUDIOLINK_LOCAL)
        float4  _AudioLinkLocalMapParams;
    #endif
#endif

// Outline
float4  _OutlineColor;
float4  _OutlineTex_ST;
#if defined(LIL_FEATURE_ANIMATE_OUTLINE_UV)
    float4  _OutlineTex_ScrollRotate;
#endif
#if defined(LIL_FEATURE_TEX_OUTLINE_COLOR)
    #if defined(LIL_FEATURE_OUTLINE_TONE_CORRECTION)
        float4  _OutlineTexHSVG;
    #endif
#endif

// Fur
#if defined(LIL_FUR)
    float4  _FurNoiseMask_ST;
    float4  _FurVector;
#endif

// Refraction
#if defined(LIL_REFRACTION)
    float4  _RefractionColor;
#endif

//------------------------------------------------------------------------------------------------------------------------------
// Float
#if LIL_RENDER != 0
    float   _Cutoff;
#endif
float   _FlipNormal;
#if defined(LIL_FEATURE_MAIN2ND)
    float   _Main2ndTexAngle;
#endif
#if defined(LIL_FEATURE_MAIN3RD)
    float   _Main3rdTexAngle;
#endif
#if defined(LIL_FEATURE_SHADOW)
    float   _BackfaceForceShadow;
    float   _ShadowStrength;
    float   _ShadowBorder;
    float   _ShadowBlur;
    float   _Shadow2ndBorder;
    float   _Shadow2ndBlur;
    float   _ShadowMainStrength;
    float   _ShadowEnvStrength;
    float   _ShadowBorderRange;
#endif
#if defined(LIL_FEATURE_NORMAL_1ST)
    float   _BumpScale;
#endif
#if defined(LIL_FEATURE_NORMAL_2ND)
    float   _Bump2ndScale;
#endif
#if defined(LIL_FEATURE_REFLECTION)
    float   _Smoothness;
    float   _Metallic;
#endif
#if defined(LIL_FEATURE_MATCAP)
    float   _MatCapBlend;
#endif
#if defined(LIL_FEATURE_RIMLIGHT)
    float   _RimBorder;
    float   _RimBlur;
    float   _RimFresnelPower;
#endif
#if defined(LIL_FEATURE_EMISSION_1ST)
    float   _EmissionBlend;
    float   _EmissionParallaxDepth;
    float   _EmissionFluorescence;
    #if defined(LIL_FEATURE_EMISSION_GRADATION)
        float   _EmissionGradSpeed;
    #endif
#endif
#if defined(LIL_FEATURE_EMISSION_2ND)
    float   _Emission2ndBlend;
    float   _Emission2ndParallaxDepth;
    float   _Emission2ndFluorescence;
    #if defined(LIL_FEATURE_EMISSION_GRADATION)
        float   _Emission2ndGradSpeed;
    #endif
#endif
#if defined(LIL_FEATURE_PARALLAX)
    float   _Parallax;
    float   _ParallaxOffset;
#endif

float   _OutlineWidth;

#if defined(LIL_FUR)
    float   _FurVectorScale;
    float   _FurGravity;
    float   _FurAO;
#endif
#if defined(LIL_REFRACTION)
    float   _RefractionStrength;
    float   _RefractionFresnelPower;
#endif
#if defined(LIL_TESSELLATION)
    float   _TessEdge;
    float   _TessStrength;
    float   _TessShrink;
    float   _TessFactorMax;
#endif

//------------------------------------------------------------------------------------------------------------------------------
// Int
#if defined(LIL_FEATURE_MAIN2ND)
    uint    _Main2ndTexBlendMode;
#endif
#if defined(LIL_FEATURE_MAIN3RD)
    uint    _Main3rdTexBlendMode;
#endif
#if defined(LIL_FEATURE_MATCAP)
    uint    _MatCapBlendMode;
#endif
#if defined(LIL_FEATURE_AUDIOLINK)
    uint    _AudioLinkUVMode;
    #if defined(LIL_FEATURE_AUDIOLINK_VERTEX)
        uint    _AudioLinkVertexUVMode;
    #endif
#endif
#if defined(LIL_FUR)
    uint    _FurLayerNum;
#endif

//------------------------------------------------------------------------------------------------------------------------------
// Bool
lilBool _Invisible;
lilBool _AsUnlit;
#if defined(LIL_FEATURE_MAIN2ND)
    lilBool _UseMain2ndTex;
    lilBool _Main2ndEnableLighting;
    lilBool _Main2ndTexIsMSDF;
    #if defined(LIL_FEATURE_DECAL)
        lilBool _Main2ndTexIsDecal;
        lilBool _Main2ndTexIsLeftOnly;
        lilBool _Main2ndTexIsRightOnly;
        lilBool _Main2ndTexShouldCopy;
        lilBool _Main2ndTexShouldFlipMirror;
        lilBool _Main2ndTexShouldFlipCopy;
    #endif
#endif
#if defined(LIL_FEATURE_MAIN3RD)
    lilBool _UseMain3rdTex;
    lilBool _Main3rdEnableLighting;
    lilBool _Main3rdTexIsMSDF;
    #if defined(LIL_FEATURE_DECAL)
        lilBool _Main3rdTexIsDecal;
        lilBool _Main3rdTexIsLeftOnly;
        lilBool _Main3rdTexIsRightOnly;
        lilBool _Main3rdTexShouldCopy;
        lilBool _Main3rdTexShouldFlipMirror;
        lilBool _Main3rdTexShouldFlipCopy;
    #endif
#endif
#if defined(LIL_FEATURE_SHADOW)
    lilBool _UseShadow;
    #if defined(LIL_FEATURE_RECEIVE_SHADOW)
        lilBool _ShadowReceive;
    #endif
#endif
#if defined(LIL_FEATURE_NORMAL_1ST)
    lilBool _UseBumpMap;
#endif
#if defined(LIL_FEATURE_NORMAL_2ND)
    lilBool _UseBump2ndMap;
#endif
#if defined(LIL_FEATURE_REFLECTION)
    lilBool _UseReflection;
    lilBool _ApplySpecular;
    lilBool _ApplyReflection;
    lilBool _SpecularToon;
    lilBool _ReflectionApplyTransparency;
#endif
#if defined(LIL_FEATURE_MATCAP)
    lilBool _UseMatCap;
    lilBool _MatCapEnableLighting;
    lilBool _MatCapApplyTransparency;
#endif
#if defined(LIL_FEATURE_RIMLIGHT)
    lilBool _UseRim;
    lilBool _RimEnableLighting;
    lilBool _RimShadowMask;
    lilBool _RimApplyTransparency;
#endif
#if defined(LIL_FEATURE_EMISSION_1ST)
    lilBool _UseEmission;
    #if defined(LIL_FEATURE_EMISSION_GRADATION)
        lilBool _EmissionUseGrad;
    #endif
#endif
#if defined(LIL_FEATURE_EMISSION_2ND)
    lilBool _UseEmission2nd;
    #if defined(LIL_FEATURE_EMISSION_GRADATION)
        lilBool _Emission2ndUseGrad;
    #endif
#endif
#if defined(LIL_FEATURE_PARALLAX)
    lilBool _UseParallax;
#endif
#if defined(LIL_FEATURE_AUDIOLINK)
    lilBool _UseAudioLink;
    #if defined(LIL_FEATURE_MAIN2ND)
        lilBool _AudioLink2Main2nd;
    #endif
    #if defined(LIL_FEATURE_MAIN3RD)
        lilBool _AudioLink2Main3rd;
    #endif
    #if defined(LIL_FEATURE_EMISSION_1ST)
        lilBool _AudioLink2Emission;
    #endif
    #if defined(LIL_FEATURE_EMISSION_2ND)
        lilBool _AudioLink2Emission2nd;
    #endif
    #if defined(LIL_FEATURE_AUDIOLINK_VERTEX)
        lilBool _AudioLink2Vertex;
    #endif
    #if defined(LIL_FEATURE_AUDIOLINK_LOCAL)
        lilBool _AudioLinkAsLocal;
    #endif
#endif

lilBool _OutlineFixWidth;
lilBool _OutlineVertexR2Width;
lilBool _OutlineEnableLighting;

#if defined(LIL_FUR)
    lilBool _VertexColor2FurVector;
#endif
#if defined(LIL_REFRACTION)
    lilBool _RefractionColorFromMain;
#endif
CBUFFER_END
#endif

//------------------------------------------------------------------------------------------------------------------------------
// Texture
TEXTURE2D(_MainTex);
TEXTURE2D(_Main2ndTex);
TEXTURE2D(_Main2ndBlendMask);
TEXTURE2D(_Main3rdTex);
TEXTURE2D(_Main3rdBlendMask);
TEXTURE2D(_BumpMap);
TEXTURE2D(_Bump2ndMap);
TEXTURE2D(_Bump2ndScaleMask);
TEXTURE2D(_ShadowBorderMask);
TEXTURE2D(_ShadowBlurMask);
TEXTURE2D(_ShadowStrengthMask);
TEXTURE2D(_ShadowColorTex);
TEXTURE2D(_Shadow2ndColorTex);
TEXTURE2D(_SmoothnessTex);
TEXTURE2D(_MetallicGlossMap);
TEXTURE2D(_ReflectionColorTex);
TEXTURE2D(_MatCapTex);
TEXTURE2D(_MatCapBlendMask);
TEXTURE2D(_RimColorTex);
TEXTURE2D(_EmissionMap);
TEXTURE2D(_EmissionBlendMask);
TEXTURE2D(_EmissionGradTex);
TEXTURE2D(_Emission2ndMap);
TEXTURE2D(_Emission2ndBlendMask);
TEXTURE2D(_Emission2ndGradTex);
TEXTURE2D(_ParallaxMap);
TEXTURE2D(_AudioLinkMask);
TEXTURE2D(_AudioLinkLocalMap);
TEXTURE2D(_OutlineTex);
TEXTURE2D(_OutlineWidthMask);
TEXTURE2D(_FurNoiseMask);
TEXTURE2D(_FurMask);
TEXTURE2D(_FurVectorTex);
TEXTURE2D(_TriMask);
SAMPLER(sampler_MainTex);
SAMPLER(sampler_Main2ndTex);
SAMPLER(sampler_Main3rdTex);
SAMPLER(sampler_EmissionMap);
SAMPLER(sampler_Emission2ndMap);
SAMPLER(sampler_OutlineTex);

// AudioLink
#if defined(LIL_FEATURE_AUDIOLINK)
SAMPLER(sampler_linear_clamp);
Texture2D<float4> _AudioTexture;
float4 _AudioTexture_TexelSize;
#endif

#if Exists_MainTex == false
#define sampler_MainTex sampler_linear_repeat
#endif

#endif