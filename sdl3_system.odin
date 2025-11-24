package sdl3

import "core:c"

// General

Sandbox :: enum c.int {
    NONE = 0,
    UNKNOWN_CONTAINER,
    FLATPAK,
    SNAP,
    MACOS,
}

when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {

    // odinfmt: disable
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
    // odinfmt: enable
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

    // odinfmt: disable
    @(default_calling_convention = "c", link_prefix = "SDL_", require_results)
    foreign {

        GetGDKTaskQueue :: proc(outTaskQueue: ^XTaskQueueHandle) -> bool ---
        GetGDKDefaultUser :: proc(outUserHandle: ^XUserHandle) -> bool ---
    }
    // odinfmt: enable
} else {
    @(default_calling_convention = "c", link_prefix = "SDL_", require_results)
    foreign lib {

        GetGDKTaskQueue :: proc(outTaskQueue: ^XTaskQueueHandle) -> bool ---
        GetGDKDefaultUser :: proc(outUserHandle: ^XUserHandle) -> bool ---
    }
}
