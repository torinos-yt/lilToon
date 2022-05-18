Shader "Hidden/ltspass_tess_transparent"
{
    HLSLINCLUDE
        #include "Includes/lil_setting.hlsl"
        #pragma target 5.0
        #define LIL_RENDER 2
        #define LIL_TESSELLATION
    ENDHLSL

//----------------------------------------------------------------------------------------------------------------------
// BRP Start
//
    SubShader
    {
        // Forward Back
        Pass
        {
            Name "FORWARD_BACK"
            Tags {"LightMode" = "ForwardBase"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
            Cull Front
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            BlendOp [_BlendOp], [_BlendOpAlpha]
            Blend [_SrcBlend] [_DstBlend], [_SrcBlendAlpha] [_DstBlendAlpha]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vertTess
            #pragma fragment frag
            #pragma hull hull
            #pragma domain domain
            #pragma require tesshw tessellation
            #pragma multi_compile_fwdbase
            #pragma multi_compile_domain _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma skip_variants DIRLIGHTMAP_COMBINED
            #pragma multi_compile_domain _ VERTEXLIGHT_ON

            // Skip receiving shadow
            //#pragma skip_variants SHADOWS_SCREEN

            // Skip vertex light
            //#pragma skip_variants VERTEXLIGHT_ON

            // Skip lightmap
            #pragma skip_variants LIGHTMAP_ON DYNAMICLIGHTMAP_ON LIGHTMAP_SHADOW_MIXING SHADOWS_SHADOWMASK

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_brp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // Forward
        Pass
        {
            Name "FORWARD"
            Tags {"LightMode" = "ForwardBase"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
            Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            BlendOp [_BlendOp], [_BlendOpAlpha]
            Blend [_SrcBlend] [_DstBlend], [_SrcBlendAlpha] [_DstBlendAlpha]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vertTess
            #pragma fragment frag
            #pragma hull hull
            #pragma domain domain
            #pragma require tesshw tessellation
            #pragma multi_compile_fwdbase
            #pragma multi_compile_domain _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma skip_variants DIRLIGHTMAP_COMBINED
            #pragma multi_compile_domain _ VERTEXLIGHT_ON

            // Skip receiving shadow
            //#pragma skip_variants SHADOWS_SCREEN

            // Skip vertex light
            //#pragma skip_variants VERTEXLIGHT_ON

            // Skip lightmap
            #pragma skip_variants LIGHTMAP_ON DYNAMICLIGHTMAP_ON LIGHTMAP_SHADOW_MIXING SHADOWS_SHADOWMASK

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_brp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // Forward Outline
        Pass
        {
            Name "FORWARD_OUTLINE"
            Tags {"LightMode" = "ForwardBase"}

            Stencil
            {
                Ref [_OutlineStencilRef]
                ReadMask [_OutlineStencilReadMask]
                WriteMask [_OutlineStencilWriteMask]
                Comp [_OutlineStencilComp]
                Pass [_OutlineStencilPass]
                Fail [_OutlineStencilFail]
                ZFail [_OutlineStencilZFail]
            }
            Cull [_OutlineCull]
            ZClip [_OutlineZClip]
            ZWrite [_OutlineZWrite]
            ZTest [_OutlineZTest]
            ColorMask [_OutlineColorMask]
            Offset [_OutlineOffsetFactor], [_OutlineOffsetUnits]
            BlendOp [_OutlineBlendOp], [_OutlineBlendOpAlpha]
            Blend [_OutlineSrcBlend] [_OutlineDstBlend], [_OutlineSrcBlendAlpha] [_OutlineDstBlendAlpha]
            AlphaToMask [_OutlineAlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vertTess
            #pragma fragment frag
            #pragma hull hull
            #pragma domain domain
            #pragma require tesshw tessellation
            #pragma multi_compile_fwdbase
            #pragma multi_compile_domain _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma skip_variants SHADOWS_SCREEN DIRLIGHTMAP_COMBINED
            #pragma multi_compile_domain _ VERTEXLIGHT_ON

            // Skip vertex light
            //#pragma skip_variants VERTEXLIGHT_ON

            // Skip lightmap
            #pragma skip_variants LIGHTMAP_ON DYNAMICLIGHTMAP_ON LIGHTMAP_SHADOW_MIXING SHADOWS_SHADOWMASK

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #define LIL_OUTLINE
            #include "Includes/lil_pipeline_brp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        //----------------------------------------------------------------------------------------------------------------------
        // ForwardAdd Start
        //

        // ForwardAdd
        Pass
        {
            Name "FORWARD_ADD"
            Tags {"LightMode" = "ForwardAdd"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
		    Cull [_Cull]
            ZClip [_ZClip]
			ZWrite Off
            ZTest LEqual
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            Blend [_SrcBlendFA] [_DstBlendFA], Zero One
            BlendOp [_BlendOpFA], [_BlendOpAlphaFA]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vertTess
            #pragma fragment frag
            #pragma hull hull
            #pragma domain domain
            #pragma require tesshw tessellation
            #pragma multi_compile_fragment POINT DIRECTIONAL SPOT POINT_COOKIE DIRECTIONAL_COOKIE
            #pragma multi_compile_domain _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #pragma fragmentoption ARB_precision_hint_fastest

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #define LIL_PASS_FORWARDADD
            #include "Includes/lil_pipeline_brp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // ForwardAdd Outline
        Pass
        {
            Name "FORWARD_ADD_OUTLINE"
            Tags {"LightMode" = "ForwardAdd"}

            Stencil
            {
                Ref [_OutlineStencilRef]
                ReadMask [_OutlineStencilReadMask]
                WriteMask [_OutlineStencilWriteMask]
                Comp [_OutlineStencilComp]
                Pass [_OutlineStencilPass]
                Fail [_OutlineStencilFail]
                ZFail [_OutlineStencilZFail]
            }
            Cull [_OutlineCull]
            ZClip [_OutlineZClip]
			ZWrite Off
            ZTest LEqual
            ColorMask [_OutlineColorMask]
            Offset [_OutlineOffsetFactor], [_OutlineOffsetUnits]
            Blend [_OutlineSrcBlendFA] [_OutlineDstBlendFA], Zero One
            BlendOp [_OutlineBlendOpFA], [_OutlineBlendOpAlphaFA]
            AlphaToMask [_OutlineAlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vertTess
            #pragma fragment frag
            #pragma hull hull
            #pragma domain domain
            #pragma require tesshw tessellation
            #pragma multi_compile_fragment POINT DIRECTIONAL SPOT POINT_COOKIE DIRECTIONAL_COOKIE
            #pragma multi_compile_domain _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #pragma fragmentoption ARB_precision_hint_fastest

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #define LIL_OUTLINE
            #define LIL_PASS_FORWARDADD
            #include "Includes/lil_pipeline_brp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        //
        // ForwardAdd End

        // ShadowCaster
        Pass
        {
            Name "SHADOW_CASTER"
            Tags {"LightMode" = "ShadowCaster"}
            Offset 1, 1
		    Cull [_Cull]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_instancing

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_brp.hlsl"
            #include "Includes/lil_pass_shadowcaster.hlsl"

            ENDHLSL
        }

        // ShadowCaster Outline
        Pass
        {
            Name "SHADOW_CASTER_OUTLINE"
            Tags {"LightMode" = "ShadowCaster"}
            Offset 1, 1
		    Cull [_Cull]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_instancing

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #define LIL_OUTLINE
            #include "Includes/lil_pipeline_brp.hlsl"
            #include "Includes/lil_pass_shadowcaster.hlsl"

            ENDHLSL
        }

        // Meta
        Pass
        {
            Name "META"
            Tags {"LightMode" = "Meta"}
            Cull Off

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma shader_feature EDITOR_VISUALIZATION

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_brp.hlsl"
            #include "Includes/lil_pass_meta.hlsl"

            ENDHLSL
        }
    }
//
// BRP End

//----------------------------------------------------------------------------------------------------------------------
// LWRP Start
/*
    SubShader
    {
        // Forward
        Pass
        {
            Name "FORWARD"
            Tags {"LightMode" = "LightweightForward"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
            Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            BlendOp [_BlendOp], [_BlendOpAlpha]
            Blend [_SrcBlend] [_DstBlend], [_SrcBlendAlpha] [_DstBlendAlpha]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vertTess
            #pragma fragment frag
            #pragma hull hull
            #pragma domain domain
            #pragma require tesshw tessellation
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _MIXED_LIGHTING_SUBTRACTIVE
            #pragma multi_compile_fragment _ LIGHTMAP_ON
            #pragma multi_compile_domain _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing

            // Skip receiving shadow
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile_fragment _ _SHADOWS_SOFT

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_lwrp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // Forward Outline
        Pass
        {
            Name "FORWARD_OUTLINE"
            Tags {"LightMode" = "SRPDefaultUnlit"}

            Stencil
            {
                Ref [_OutlineStencilRef]
                ReadMask [_OutlineStencilReadMask]
                WriteMask [_OutlineStencilWriteMask]
                Comp [_OutlineStencilComp]
                Pass [_OutlineStencilPass]
                Fail [_OutlineStencilFail]
                ZFail [_OutlineStencilZFail]
            }
            Cull [_OutlineCull]
            ZClip [_OutlineZClip]
            ZWrite [_OutlineZWrite]
            ZTest [_OutlineZTest]
            ColorMask [_OutlineColorMask]
            Offset [_OutlineOffsetFactor], [_OutlineOffsetUnits]
            BlendOp [_OutlineBlendOp], [_OutlineBlendOpAlpha]
            Blend [_OutlineSrcBlend] [_OutlineDstBlend], [_OutlineSrcBlendAlpha] [_OutlineDstBlendAlpha]
            AlphaToMask [_OutlineAlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vertTess
            #pragma fragment frag
            #pragma hull hull
            #pragma domain domain
            #pragma require tesshw tessellation
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _MIXED_LIGHTING_SUBTRACTIVE
            #pragma multi_compile_fragment _ LIGHTMAP_ON
            #pragma multi_compile_domain _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #define LIL_OUTLINE
            #include "Includes/lil_pipeline_lwrp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // ShadowCaster
        Pass
        {
            Name "SHADOW_CASTER"
            Tags {"LightMode" = "ShadowCaster"}
		    Cull [_Cull]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_lwrp.hlsl"
            #include "Includes/lil_pass_shadowcaster.hlsl"

            ENDHLSL
        }

        // DepthOnly
        Pass
        {
            Name "DEPTHONLY"
            Tags {"LightMode" = "DepthOnly"}
		    Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_lwrp.hlsl"
            #include "Includes/lil_pass_depthonly.hlsl"

            ENDHLSL
        }

        // Meta
        Pass
        {
            Name "META"
            Tags {"LightMode" = "Meta"}
            Cull Off

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_lwrp.hlsl"
            #include "Includes/lil_pass_meta.hlsl"
            ENDHLSL
        }
    }
*/
// LWRP End

//----------------------------------------------------------------------------------------------------------------------
// URP Start
/*
    //----------------------------------------------------------------------------------------------------------------------
    // Universal Render Pipeline SM4.5
    SubShader
    {
        Tags{"ShaderModel" = "4.5"}
        HLSLINCLUDE
            #pragma target 4.5
            #pragma exclude_renderers gles gles3 glcore
        ENDHLSL

        // Forward
        Pass
        {
            Name "FORWARD"
            Tags {"LightMode" = "UniversalForward"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
            Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            BlendOp [_BlendOp], [_BlendOpAlpha]
            Blend [_SrcBlend] [_DstBlend], [_SrcBlendAlpha] [_DstBlendAlpha]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vertTess
            #pragma fragment frag
            #pragma hull hull
            #pragma domain domain
            #pragma require tesshw tessellation
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile _ _LIGHT_LAYERS
            #pragma multi_compile _ _CLUSTERED_RENDERING
            #pragma multi_compile_fragment _ _LIGHT_COOKIES
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
            #pragma multi_compile_fragment _ LIGHTMAP_SHADOW_MIXING
            #pragma multi_compile_fragment _ SHADOWS_SHADOWMASK
            #pragma multi_compile_fragment _ LIGHTMAP_ON
            #pragma multi_compile_fragment _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_domain _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON

            // Skip receiving shadow
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile_fragment _ _SHADOWS_SOFT

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // Forward Outline
        Pass
        {
            Name "FORWARD_OUTLINE"
            Tags {"LightMode" = "SRPDefaultUnlit"}

            Stencil
            {
                Ref [_OutlineStencilRef]
                ReadMask [_OutlineStencilReadMask]
                WriteMask [_OutlineStencilWriteMask]
                Comp [_OutlineStencilComp]
                Pass [_OutlineStencilPass]
                Fail [_OutlineStencilFail]
                ZFail [_OutlineStencilZFail]
            }
            Cull [_OutlineCull]
            ZClip [_OutlineZClip]
            ZWrite [_OutlineZWrite]
            ZTest [_OutlineZTest]
            ColorMask [_OutlineColorMask]
            Offset [_OutlineOffsetFactor], [_OutlineOffsetUnits]
            BlendOp [_OutlineBlendOp], [_OutlineBlendOpAlpha]
            Blend [_OutlineSrcBlend] [_OutlineDstBlend], [_OutlineSrcBlendAlpha] [_OutlineDstBlendAlpha]
            AlphaToMask [_OutlineAlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vertTess
            #pragma fragment frag
            #pragma hull hull
            #pragma domain domain
            #pragma require tesshw tessellation
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile _ _LIGHT_LAYERS
            #pragma multi_compile _ _CLUSTERED_RENDERING
            #pragma multi_compile_fragment _ LIGHTMAP_ON
            #pragma multi_compile_fragment _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_domain _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #define LIL_OUTLINE
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // ShadowCaster
        Pass
        {
            Name "SHADOW_CASTER"
            Tags {"LightMode" = "ShadowCaster"}
		    Cull [_Cull]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW
            #pragma multi_compile_instancing
            #pragma multi_compile _ DOTS_INSTANCING_ON

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_shadowcaster.hlsl"

            ENDHLSL
        }

        // DepthOnly
        Pass
        {
            Name "DEPTHONLY"
            Tags {"LightMode" = "DepthOnly"}
		    Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma multi_compile _ DOTS_INSTANCING_ON

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_depthonly.hlsl"

            ENDHLSL
        }

        // DepthNormals
        Pass
        {
            Name "DEPTHNORMALS"
            Tags {"LightMode" = "DepthNormals"}
		    Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma multi_compile _ DOTS_INSTANCING_ON

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_depthnormals.hlsl"

            ENDHLSL
        }

        // Universal2D
        Pass
        {
            Name "UNIVERSAL2D"
            Tags {"LightMode" = "Universal2D"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
            Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            BlendOp [_BlendOp], [_BlendOpAlpha]
            Blend [_SrcBlend] [_DstBlend], [_SrcBlendAlpha] [_DstBlendAlpha]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_universal2d.hlsl"
            ENDHLSL
        }

        // Meta
        Pass
        {
            Name "META"
            Tags {"LightMode" = "Meta"}
            Cull Off

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_meta.hlsl"
            ENDHLSL
        }
    }

    //----------------------------------------------------------------------------------------------------------------------
    // Universal Render Pipeline
    SubShader
    {
        HLSLINCLUDE
            #pragma only_renderers gles gles3 glcore d3d11
        ENDHLSL

        // Forward
        Pass
        {
            Name "FORWARD"
            Tags {"LightMode" = "UniversalForward"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
            Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            BlendOp [_BlendOp], [_BlendOpAlpha]
            Blend [_SrcBlend] [_DstBlend], [_SrcBlendAlpha] [_DstBlendAlpha]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vertTess
            #pragma fragment frag
            #pragma hull hull
            #pragma domain domain
            #pragma require tesshw tessellation
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile _ _LIGHT_LAYERS
            #pragma multi_compile _ _CLUSTERED_RENDERING
            #pragma multi_compile_fragment _ _LIGHT_COOKIES
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
            #pragma multi_compile_fragment _ LIGHTMAP_SHADOW_MIXING
            #pragma multi_compile_fragment _ SHADOWS_SHADOWMASK
            #pragma multi_compile_fragment _ LIGHTMAP_ON
            #pragma multi_compile_fragment _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_domain _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer

            // Skip receiving shadow
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile_fragment _ _SHADOWS_SOFT

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // Forward Outline
        Pass
        {
            Name "FORWARD_OUTLINE"
            Tags {"LightMode" = "SRPDefaultUnlit"}

            Stencil
            {
                Ref [_OutlineStencilRef]
                ReadMask [_OutlineStencilReadMask]
                WriteMask [_OutlineStencilWriteMask]
                Comp [_OutlineStencilComp]
                Pass [_OutlineStencilPass]
                Fail [_OutlineStencilFail]
                ZFail [_OutlineStencilZFail]
            }
            Cull [_OutlineCull]
            ZClip [_OutlineZClip]
            ZWrite [_OutlineZWrite]
            ZTest [_OutlineZTest]
            ColorMask [_OutlineColorMask]
            Offset [_OutlineOffsetFactor], [_OutlineOffsetUnits]
            BlendOp [_OutlineBlendOp], [_OutlineBlendOpAlpha]
            Blend [_OutlineSrcBlend] [_OutlineDstBlend], [_OutlineSrcBlendAlpha] [_OutlineDstBlendAlpha]
            AlphaToMask [_OutlineAlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vertTess
            #pragma fragment frag
            #pragma hull hull
            #pragma domain domain
            #pragma require tesshw tessellation
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile _ _LIGHT_LAYERS
            #pragma multi_compile _ _CLUSTERED_RENDERING
            #pragma multi_compile_fragment _ LIGHTMAP_ON
            #pragma multi_compile_fragment _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_domain _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #define LIL_OUTLINE
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // ShadowCaster
        Pass
        {
            Name "SHADOW_CASTER"
            Tags {"LightMode" = "ShadowCaster"}
		    Cull [_Cull]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW
            #pragma multi_compile_instancing

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_shadowcaster.hlsl"

            ENDHLSL
        }

        // DepthOnly
        Pass
        {
            Name "DEPTHONLY"
            Tags {"LightMode" = "DepthOnly"}
		    Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_depthonly.hlsl"

            ENDHLSL
        }

        // DepthNormals
        Pass
        {
            Name "DEPTHNORMALS"
            Tags {"LightMode" = "DepthNormals"}
		    Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_depthnormals.hlsl"

            ENDHLSL
        }

        // Universal2D
        Pass
        {
            Name "UNIVERSAL2D"
            Tags {"LightMode" = "Universal2D"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
            Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            BlendOp [_BlendOp], [_BlendOpAlpha]
            Blend [_SrcBlend] [_DstBlend], [_SrcBlendAlpha] [_DstBlendAlpha]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_universal2d.hlsl"
            ENDHLSL
        }

        // Meta
        Pass
        {
            Name "META"
            Tags {"LightMode" = "Meta"}
            Cull Off

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_meta.hlsl"
            ENDHLSL
        }
    }
*/
// URP End

//----------------------------------------------------------------------------------------------------------------------
// HDRP Start
/*
    HLSLINCLUDE
        #pragma exclude_renderers gles gles3 glcore
    ENDHLSL
    SubShader
    {
        Tags {"RenderType" = "HDLitShader"}
        // Forward
        Pass
        {
            Name "FORWARD"
            Tags {"LightMode" = "ForwardOnly"}

            Stencil
            {
                WriteMask 6
                Ref 0
                Comp Always
                Pass Replace
            }
            Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            BlendOp [_BlendOp], [_BlendOpAlpha]
            Blend [_SrcBlend] [_DstBlend], [_SrcBlendAlpha] [_DstBlendAlpha]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vertTess
            #pragma fragment frag
            #pragma hull hull
            #pragma domain domain
            #pragma require tesshw tessellation
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON
            #pragma multi_compile_fragment _ LIGHTMAP_ON
            #pragma multi_compile_fragment _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fragment _ SHADOWS_SHADOWMASK

            // Skip receiving shadow
            //#pragma multi_compile_fragment SCREEN_SPACE_SHADOWS_OFF SCREEN_SPACE_SHADOWS_ON
            //#pragma multi_compile_fragment SHADOW_LOW SHADOW_MEDIUM SHADOW_HIGH

            #define SHADERPASS SHADERPASS_FORWARD

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_hdrp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // Forward Outline
        Pass
        {
            Name "FORWARD_OUTLINE"
            Tags {"LightMode" = "SRPDefaultUnlit"}

            Stencil
            {
                WriteMask 6
                Ref 0
                Comp Always
                Pass Replace
            }
            Cull [_OutlineCull]
            ZClip [_OutlineZClip]
            ZWrite [_OutlineZWrite]
            ZTest [_OutlineZTest]
            ColorMask [_OutlineColorMask]
            Offset [_OutlineOffsetFactor], [_OutlineOffsetUnits]
            BlendOp [_OutlineBlendOp], [_OutlineBlendOpAlpha]
            Blend [_OutlineSrcBlend] [_OutlineDstBlend], [_OutlineSrcBlendAlpha] [_OutlineDstBlendAlpha]
            AlphaToMask [_OutlineAlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vertTess
            #pragma fragment frag
            #pragma hull hull
            #pragma domain domain
            #pragma require tesshw tessellation
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON
            #pragma multi_compile_fragment _ LIGHTMAP_ON
            #pragma multi_compile_fragment _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fragment _ SHADOWS_SHADOWMASK

            #define SHADERPASS SHADERPASS_FORWARD

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #define LIL_OUTLINE
            #include "Includes/lil_pipeline_hdrp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // ShadowCaster
        Pass
        {
            Name "SHADOW_CASTER"
            Tags {"LightMode" = "ShadowCaster"}

            Cull[_Cull]
            ZClip [_ZClip]
            ZWrite On
            ZTest LEqual

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON

            #define SHADERPASS SHADERPASS_SHADOWS

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_hdrp.hlsl"
            #include "Includes/lil_pass_depthonly.hlsl"

            ENDHLSL
        }

        // DepthOnly
        Pass
        {
            Name "DEPTHONLY"
            Tags {"LightMode" = "DepthForwardOnly"}

            Stencil
            {
                WriteMask 8
                Ref 0
                Comp Always
                Pass Replace
            }
            Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            Offset [_OffsetFactor], [_OffsetUnits]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vertTess
            #pragma fragment frag
            #pragma hull hull
            #pragma domain domain
            #pragma require tesshw tessellation
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON
            #pragma multi_compile _ WRITE_NORMAL_BUFFER
            #pragma multi_compile _ WRITE_MSAA_DEPTH

            #define SHADERPASS SHADERPASS_DEPTH_ONLY

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_hdrp.hlsl"
            #include "Includes/lil_pass_depthonly.hlsl"

            ENDHLSL
        }

        // DepthOnly Outline
        Pass
        {
            Name "DEPTHONLY_OUTLINE"
            Tags {"LightMode" = "DepthForwardOnly"}

            Stencil
            {
                WriteMask 8
                Ref 0
                Comp Always
                Pass Replace
            }
            Cull Back
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            Offset [_OffsetFactor], [_OffsetUnits]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vertTess
            #pragma geometry geom
            #pragma fragment frag
            #pragma hull hull
            #pragma domain domain
            #pragma require tesshw tessellation
            #pragma require geometry
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON
            #pragma multi_compile _ WRITE_NORMAL_BUFFER
            #pragma multi_compile _ WRITE_MSAA_DEPTH

            #define SHADERPASS SHADERPASS_DEPTH_ONLY

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #define LIL_ONEPASS_OUTLINE
            #include "Includes/lil_pipeline_hdrp.hlsl"
            #include "Includes/lil_pass_depthonly.hlsl"

            ENDHLSL
        }

        // MotionVectors
        Pass
        {
            Name "MOTIONVECTORS"
            Tags {"LightMode" = "MotionVectors"}

            Stencil
            {
                WriteMask 40
                Ref 32
                Comp Always
                Pass Replace
            }
            Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            Offset [_OffsetFactor], [_OffsetUnits]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vertTess
            #pragma fragment frag
            #pragma hull hull
            #pragma domain domain
            #pragma require tesshw tessellation
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON
            #pragma multi_compile _ WRITE_NORMAL_BUFFER
            #pragma multi_compile _ WRITE_MSAA_DEPTH

            #define SHADERPASS SHADERPASS_MOTION_VECTORS

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_hdrp.hlsl"
            #include "Includes/lil_pass_motionvectors.hlsl"

            ENDHLSL
        }

        // MotionVectors Outline
        Pass
        {
            Name "MOTIONVECTORS_OUTLINE"
            Tags {"LightMode" = "MotionVectors"}

            Stencil
            {
                WriteMask 40
                Ref 32
                Comp Always
                Pass Replace
            }
            Cull Back
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            Offset [_OffsetFactor], [_OffsetUnits]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vertTess
            #pragma geometry geom
            #pragma fragment frag
            #pragma hull hull
            #pragma domain domain
            #pragma require tesshw tessellation
            #pragma require geometry
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON
            #pragma multi_compile _ WRITE_NORMAL_BUFFER
            #pragma multi_compile _ WRITE_MSAA_DEPTH

            #define SHADERPASS SHADERPASS_MOTION_VECTORS

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #define LIL_ONEPASS_OUTLINE
            #include "Includes/lil_pipeline_hdrp.hlsl"
            #include "Includes/lil_pass_motionvectors.hlsl"

            ENDHLSL
        }

        // Meta
        Pass
        {
            Name "META"
            Tags {"LightMode" = "META"}
            Cull Off

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON

            #define SHADERPASS SHADERPASS_LIGHT_TRANSPORT

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_hdrp.hlsl"
            #include "Includes/lil_pass_meta.hlsl"
            ENDHLSL
        }
    }
*/
// HDRP End

}