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

// UNIX

X11EventHook :: #type proc "c" (
    userdata: rawptr,
    xevent: rawptr,
    /* ^xlib.XEvent */
) -> bool

@(default_calling_convention = "c", link_prefix = "SDL_")
foreign lib {
    SetX11EventHook :: proc(callback: X11EventHook, userdata: rawptr) ---
}

// Linux

@(default_calling_convention = "c", link_prefix = "SDL_")
foreign lib {
    SetLinuxThreadPriority :: proc(threadID: Sint64, priority: c.int) -> bool ---
    SetLinuxThreadPriorityAndPolicy :: proc(threadID: Sint64, sdlPriority: c.int, schedPolicy: c.int) -> bool ---
}

// iOS

iOSAnimationCallback :: #type proc "c" (userdata: rawptr)

@(default_calling_convention = "c", link_prefix = "SDL_")
foreign lib {
    SetiOSAnimationCallback :: proc(window: ^Window, interval: c.int, callback: iOSAnimationCallback, callbackParam: rawptr) -> bool ---
    SetiOSEventPump :: proc(enabled: bool) ---
}

// Android

RequestAndroidPermissionCallback :: #type proc "c" (userdata: rawptr, permission: cstring, granted: bool)


@(default_calling_convention = "c", link_prefix = "SDL_", require_results)
foreign lib {
    GetAndroidJNIEnv :: proc() -> rawptr ---
    GetAndroidActivity :: proc() -> rawptr ---
    GetAndroidSDKVersion :: proc() -> c.int ---
    IsChromebook :: proc() -> bool ---
    IsDeXMode :: proc() -> bool ---
    SendAndroidBackButton :: proc() ---
    GetAndroidInternalStoragePath :: proc() -> cstring ---
    GetAndroidExternalStorageState :: proc() -> Uint32 ---
    GetAndroidExternalStoragePath :: proc() -> cstring ---
    GetAndroidCachePath :: proc() -> cstring ---
    RequestAndroidPermission :: proc(permission: cstring, cb: RequestAndroidPermissionCallback, userdata: rawptr) -> bool ---
    ShowAndroidToast :: proc(message: cstring, duration: c.int, gravity: c.int, xoffset, yoffset: c.int) -> bool ---
    SendAndroidMessage :: proc(command: Uint32, param: c.int) -> bool ---
}

// General

Sandbox :: enum c.int {
    NONE = 0,
    UNKNOWN_CONTAINER,
    FLATPAK,
    SNAP,
    MACOS,
}

@(default_calling_convention = "c", link_prefix = "SDL_", require_results)
foreign lib {
    IsTablet :: proc() -> bool ---
    IsTV :: proc() -> bool ---
    GetSandbox :: proc() -> Sandbox ---
    OnApplicationWillTerminate :: proc() ---
    OnApplicationDidReceiveMemoryWarning :: proc() ---
    OnApplicationWillEnterBackground :: proc() ---
    OnApplicationDidEnterBackground :: proc() ---
    OnApplicationWillEnterForeground :: proc() ---
    OnApplicationDidEnterForeground :: proc() ---
    OnApplicationDidChangeStatusBarOrientation :: proc() ---
}


// GDK

XTaskQueueHandle :: distinct rawptr
XUserHandle :: distinct rawptr

@(default_calling_convention = "c", link_prefix = "SDL_", require_results)
foreign lib {
    GetGDKTaskQueue :: proc(outTaskQueue: ^XTaskQueueHandle) -> bool ---
    GetGDKDefaultUser :: proc(outUserHandle: ^XUserHandle) -> bool ---
}
