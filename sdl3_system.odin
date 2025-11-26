package sdl3

when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    foreign import lib "SDL3.wasm.a"
}

import "core:c"

// UNIX

X11EventHook :: #type proc "c" (
    userdata: rawptr,
    xevent: rawptr,
    /* ^xlib.XEvent */
) -> bool

when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    @(default_calling_convention = "c", link_prefix = "SDL_")
    foreign {

    SetX11EventHook :: proc(callback: X11EventHook, userdata: rawptr) ---
    }
} else {
    @(default_calling_convention = "c", link_prefix = "SDL_")
    foreign lib {

    SetX11EventHook :: proc(callback: X11EventHook, userdata: rawptr) ---
    }
}

// Linux

when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    @(default_calling_convention = "c", link_prefix = "SDL_")
    foreign {

    SetLinuxThreadPriority :: proc(threadID: Sint64, priority: c.int) -> bool ---
    SetLinuxThreadPriorityAndPolicy :: proc(threadID: Sint64, sdlPriority: c.int, schedPolicy: c.int) -> bool ---
    }
} else {
    @(default_calling_convention = "c", link_prefix = "SDL_")
    foreign lib {

    SetLinuxThreadPriority :: proc(threadID: Sint64, priority: c.int) -> bool ---
    SetLinuxThreadPriorityAndPolicy :: proc(threadID: Sint64, sdlPriority: c.int, schedPolicy: c.int) -> bool ---
    }
}

// iOS

iOSAnimationCallback :: #type proc "c" (userdata: rawptr)

when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    @(default_calling_convention = "c", link_prefix = "SDL_")
    foreign {

    SetiOSAnimationCallback :: proc(window: ^Window, interval: c.int, callback: iOSAnimationCallback, callbackParam: rawptr) -> bool ---
    SetiOSEventPump :: proc(enabled: bool) ---
    }
} else {
    @(default_calling_convention = "c", link_prefix = "SDL_")
    foreign lib {

    SetiOSAnimationCallback :: proc(window: ^Window, interval: c.int, callback: iOSAnimationCallback, callbackParam: rawptr) -> bool ---
    SetiOSEventPump :: proc(enabled: bool) ---
    }
}

// Android

RequestAndroidPermissionCallback :: #type proc "c" (userdata: rawptr, permission: cstring, granted: bool)


when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    @(default_calling_convention = "c", link_prefix = "SDL_", require_results)
    foreign {

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
} else {
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
}

// General

Sandbox :: enum c.int {
    NONE = 0,
    UNKNOWN_CONTAINER,
    FLATPAK,
    SNAP,
    MACOS,
}

when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    @(default_calling_convention = "c", link_prefix = "SDL_", require_results)
    foreign {

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
} else {
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
}


// GDK

XTaskQueueHandle :: distinct rawptr
XUserHandle :: distinct rawptr

when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    @(default_calling_convention = "c", link_prefix = "SDL_", require_results)
    foreign {

    GetGDKTaskQueue :: proc(outTaskQueue: ^XTaskQueueHandle) -> bool ---
    GetGDKDefaultUser :: proc(outUserHandle: ^XUserHandle) -> bool ---
    }
} else {
    @(default_calling_convention = "c", link_prefix = "SDL_", require_results)
    foreign lib {

    GetGDKTaskQueue :: proc(outTaskQueue: ^XTaskQueueHandle) -> bool ---
    GetGDKDefaultUser :: proc(outUserHandle: ^XUserHandle) -> bool ---
    }
}
