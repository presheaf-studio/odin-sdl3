#+build darwin
package sdl3

import "core:c"

// iOS

// possibly also iphonesimulator?
when ODIN_PLATFORM_SUBTARGET == .iPhone {
    iOSAnimationCallback :: #type proc "c" (userdata: rawptr)

    @(default_calling_convention = "c", link_prefix = "SDL_")
    foreign lib {

        SetiOSAnimationCallback :: proc(window: ^Window, interval: c.int, callback: iOSAnimationCallback, callbackParam: rawptr) -> bool ---
        SetiOSEventPump :: proc(enabled: bool) ---
    }
}
