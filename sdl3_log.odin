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

LogCategory :: enum c.int {
    APPLICATION,
    ERROR,
    ASSERT,
    SYSTEM,
    AUDIO,
    VIDEO,
    RENDER,
    INPUT,
    TEST,
    GPU,

    /* Reserved for future SDL library use */
    RESERVED2,
    RESERVED3,
    RESERVED4,
    RESERVED5,
    RESERVED6,
    RESERVED7,
    RESERVED8,
    RESERVED9,
    RESERVED10,

    /* Beyond this point is reserved for application use, e.g.
		enum {
			MYAPP_CATEGORY_AWESOME1 = CUSTOM,
			MYAPP_CATEGORY_AWESOME2,
			MYAPP_CATEGORY_AWESOME3,
			...
		};
	*/
    CUSTOM,
}

LogPriority :: enum c.int {
    INVALID,
    TRACE,
    VERBOSE,
    DEBUG,
    INFO,
    WARN,
    ERROR,
    CRITICAL,
}

LogOutputFunction :: #type proc "c" (userdata: rawptr, category: LogCategory, priority: LogPriority, message: cstring)

@(default_calling_convention = "c", link_prefix = "SDL_")
foreign lib {
    SetLogPriorities :: proc(priority: LogPriority) ---
    SetLogPriority :: proc(category: LogCategory, priority: LogPriority) ---
    GetLogPriority :: proc(category: LogCategory) -> LogPriority ---
    ResetLogPriorities :: proc() ---
    SetLogPriorityPrefix :: proc(priority: LogPriority, prefix: cstring) -> bool ---
    Log :: proc(fmt: cstring, #c_vararg args: ..any) ---
    LogTrace :: proc(category: c.int, fmt: cstring, #c_vararg args: ..any) ---
    LogVerbose :: proc(category: c.int, fmt: cstring, #c_vararg args: ..any) ---
    LogDebug :: proc(category: c.int, fmt: cstring, #c_vararg args: ..any) ---
    LogInfo :: proc(category: c.int, fmt: cstring, #c_vararg args: ..any) ---
    LogWarn :: proc(category: c.int, fmt: cstring, #c_vararg args: ..any) ---
    LogError :: proc(category: c.int, fmt: cstring, #c_vararg args: ..any) ---
    LogCritical :: proc(category: c.int, fmt: cstring, #c_vararg args: ..any) ---
    LogMessage :: proc(category: c.int, priority: LogPriority, fmt: cstring, #c_vararg args: ..any) ---
    LogMessageV :: proc(category: c.int, priority: LogPriority, fmt: cstring, ap: c.va_list) ---
    GetDefaultLogOutputFunction :: proc() -> LogOutputFunction ---
    GetLogOutputFunction :: proc(callback: ^LogOutputFunction, userdata: ^rawptr) ---
    SetLogOutputFunction :: proc(callback: LogOutputFunction, userdata: rawptr) ---
}
