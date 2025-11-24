package sdl3

when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    foreign import lib "SDL3.wasm.a"
}

import "core:c"

PowerState :: enum c.int {
    ERROR = -1, /**< error determining power status */
    UNKNOWN, /**< cannot determine power status */
    ON_BATTERY, /**< Not plugged in, running on the battery */
    NO_BATTERY, /**< Plugged in, no battery available */
    CHARGING, /**< Plugged in, charging battery */
    CHARGED, /**< Plugged in, battery charged */
}

@(default_calling_convention = "c", link_prefix = "SDL_")
foreign lib {
    GetPowerInfo :: proc(seconds: ^c.int, percent: ^c.int) -> PowerState ---
}
