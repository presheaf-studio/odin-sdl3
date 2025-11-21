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


TouchID :: distinct Uint64
FingerID :: distinct Uint64

TouchDeviceType :: enum c.int {
    INVALID = -1,
    DIRECT, /**< touch screen with window-relative coordinates */
    INDIRECT_ABSOLUTE, /**< trackpad with absolute device coordinates */
    INDIRECT_RELATIVE, /**< trackpad with screen cursor-relative coordinates */
}

Finger :: struct {
    id:       FingerID, /**< the finger ID */
    x:        f32, /**< the x-axis location of the touch event, normalized (0...1) */
    y:        f32, /**< the y-axis location of the touch event, normalized (0...1) */
    pressure: f32, /**< the quantity of pressure applied, normalized (0...1) */
}

TOUCH_MOUSEID :: MouseID(1 << 32 - 1)
MOUSE_TOUCHID :: TouchID(1 << 64 - 1)

@(default_calling_convention = "c", link_prefix = "SDL_", require_results)
foreign lib {
    GetTouchDevices :: proc(count: ^c.int) -> [^]TouchID ---
    GetTouchDeviceName :: proc(touchID: TouchID) -> cstring ---
    GetTouchDeviceType :: proc(touchID: TouchID) -> TouchDeviceType ---
    GetTouchFingers :: proc(touchID: TouchID, count: ^c.int) -> [^]^Finger ---
}
