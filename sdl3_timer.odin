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

MS_PER_SECOND :: 1000
US_PER_SECOND :: 1000000
NS_PER_SECOND :: 1000000000
NS_PER_MS :: 1000000
NS_PER_US :: 1000

@(require_results)
SECONDS_TO_NS :: #force_inline proc "c" (S: Uint64) -> Uint64 {return S * NS_PER_SECOND}
@(require_results)
NS_TO_SECONDS :: #force_inline proc "c" (NS: Uint64) -> Uint64 {return NS / NS_PER_SECOND}
@(require_results)
MS_TO_NS :: #force_inline proc "c" (MS: Uint64) -> Uint64 {return MS * NS_PER_MS}
@(require_results)
NS_TO_MS :: #force_inline proc "c" (NS: Uint64) -> Uint64 {return NS / NS_PER_MS}
@(require_results)
US_TO_NS :: #force_inline proc "c" (US: Uint64) -> Uint64 {return US * NS_PER_US}
@(require_results)
NS_TO_US :: #force_inline proc "c" (NS: Uint64) -> Uint64 {return NS / NS_PER_US}

TimerID :: distinct Uint32

TimerCallback :: #type proc "c" (userdata: rawptr, timerID: TimerID, interval: Uint32) -> Uint32
NSTimerCallback :: #type proc "c" (userdata: rawptr, timerID: TimerID, interval: Uint64) -> Uint64

@(default_calling_convention = "c", link_prefix = "SDL_", require_results)
foreign lib {
    GetTicks :: proc() -> Uint64 ---
    GetTicksNS :: proc() -> Uint64 ---
    GetPerformanceCounter :: proc() -> Uint64 ---
    GetPerformanceFrequency :: proc() -> Uint64 ---
    Delay :: proc(ms: Uint32) ---
    DelayNS :: proc(ns: Uint64) ---
    DelayPrecise :: proc(ns: Uint64) ---
    AddTimer :: proc(interval: Uint32, callback: TimerCallback, userdata: rawptr) -> TimerID ---
    AddTimerNS :: proc(interval: Uint64, callback: NSTimerCallback, userdata: rawptr) -> TimerID ---
    RemoveTimer :: proc(id: TimerID) -> bool ---
}
