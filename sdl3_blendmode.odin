package sdl3

when ODIN_OS == .Windows {
    // @(export)
    foreign import lib "SDL3.lib"
} else when ODIN_OS == .Darwin {
    // @(require) foreign import "system:System"
    // @(require) foreign import "system:ObjC"
    // @(require) foreign import "system:iconv"
    // @(require) foreign import "system:AVFoundation.framework"
    // @(require) foreign import "system:Foundation.framework"
    // @(require) foreign import "system:CoreFoundation.framework"
    // @(require) foreign import "system:CoreAudio.framework"
    // @(require) foreign import "system:CoreMedia.framework"
    // @(require) foreign import "system:UniformTypeIdentifiers.framework"
    // @(require) foreign import "system:CoreGraphics.framework"
    // @(require) foreign import "system:CoreVideo.framework"
    // @(require) foreign import "system:CoreServices.framework"
    // @(require) foreign import "system:CoreHaptics.framework"
    // @(require) foreign import "system:AudioToolbox.framework"
    // @(require) foreign import "system:IOKit.framework"
    // @(require) foreign import "system:QuartzCore.framework"
    // @(require) foreign import "system:GameController.framework"
    // @(require) foreign import "system:ForceFeedback.framework"
    // @(require) foreign import "system:Metal.framework"
    // @(require) foreign import "system:MetalKit.framework"
    // @(require) foreign import "system:Cocoa.framework"
    // @(require) foreign import "system:AppKit.framework"
    // @(require) foreign import "system:Carbon.framework"
    // @(export)
    // foreign import lib "SDL3.darwin.a"
    // foreign import lib "libSDL3.dylib"
    // @(export)
    foreign import lib "system:SDL3"
} else when ODIN_OS == .Linux {
    // @(export)
    foreign import lib "system:SDL3"
} else when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    // @(export)
    foreign import lib "SDL3_wasm.a"
}

import "core:c"

BlendMode :: distinct bit_set[BlendModeFlag;Uint32]

BlendModeFlag :: enum Uint32 {
    BLEND               = 0, // log2(0x00000001)
    BLEND_PREMULTIPLIED = 4, // log2(0x00000010)
    ADD                 = 1, // log2(0x00000002)
    ADD_PREMULTIPLIED   = 5, // log2(0x00000020)
    MOD                 = 2, // log2(0x00000004)
    MUL                 = 3, // log2(0x00000008)
}

BLENDMODE_NONE :: BlendMode{} /**< no blending: dstRGBA = srcRGBA */
BLENDMODE_BLEND :: BlendMode {
    .BLEND,
} /**< alpha blending: dstRGB = (srcRGB * srcA) + (dstRGB * (1-srcA)), dstA = srcA + (dstA * (1-srcA)) */
BLENDMODE_BLEND_PREMULTIPLIED :: BlendMode {
    .BLEND_PREMULTIPLIED,
} /**< pre-multiplied alpha blending: dstRGBA = srcRGBA + (dstRGBA * (1-srcA)) */
BLENDMODE_ADD :: BlendMode{.ADD} /**< additive blending: dstRGB = (srcRGB * srcA) + dstRGB, dstA = dstA */
BLENDMODE_ADD_PREMULTIPLIED :: BlendMode {
    .ADD_PREMULTIPLIED,
} /**< pre-multiplied additive blending: dstRGB = srcRGB + dstRGB, dstA = dstA */
BLENDMODE_MOD :: BlendMode{.MOD} /**< color modulate: dstRGB = srcRGB * dstRGB, dstA = dstA */
BLENDMODE_MUL :: BlendMode{.MUL} /**< color multiply: dstRGB = (srcRGB * dstRGB) + (dstRGB * (1-srcA)), dstA = dstA */
BLENDMODE_INVALID :: transmute(BlendMode)Uint32(0x7FFFFFFF)


BlendOperation :: enum c.int {
    ADD          = 0x1, /**< dst + src: supported by all renderers */
    SUBTRACT     = 0x2, /**< src - dst : supported by D3D, OpenGL, OpenGLES, and Vulkan */
    REV_SUBTRACT = 0x3, /**< dst - src : supported by D3D, OpenGL, OpenGLES, and Vulkan */
    MINIMUM      = 0x4, /**< min(dst, src) : supported by D3D, OpenGL, OpenGLES, and Vulkan */
    MAXIMUM      = 0x5, /**< max(dst, src) : supported by D3D, OpenGL, OpenGLES, and Vulkan */
}

BlendFactor :: enum c.int {
    ZERO                = 0x1, /**< 0, 0, 0, 0 */
    ONE                 = 0x2, /**< 1, 1, 1, 1 */
    SRC_COLOR           = 0x3, /**< srcR, srcG, srcB, srcA */
    ONE_MINUS_SRC_COLOR = 0x4, /**< 1-srcR, 1-srcG, 1-srcB, 1-srcA */
    SRC_ALPHA           = 0x5, /**< srcA, srcA, srcA, srcA */
    ONE_MINUS_SRC_ALPHA = 0x6, /**< 1-srcA, 1-srcA, 1-srcA, 1-srcA */
    DST_COLOR           = 0x7, /**< dstR, dstG, dstB, dstA */
    ONE_MINUS_DST_COLOR = 0x8, /**< 1-dstR, 1-dstG, 1-dstB, 1-dstA */
    DST_ALPHA           = 0x9, /**< dstA, dstA, dstA, dstA */
    ONE_MINUS_DST_ALPHA = 0xA, /**< 1-dstA, 1-dstA, 1-dstA, 1-dstA */
}

@(default_calling_convention = "c", link_prefix = "SDL_", require_results)
foreign lib {
    ComposeCustomBlendMode :: proc(srcColorFactor: BlendFactor, dstColorFactor: BlendFactor, colorOperation: BlendOperation, srcAlphaFactor: BlendFactor, dstAlphaFactor: BlendFactor, alphaOperation: BlendOperation) -> BlendMode ---
}
