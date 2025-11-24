package sdl3

when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {

    // odinfmt: disable
    @(default_calling_convention = "c", link_prefix = "SDL_", require_results)
    foreign {

        GetPlatform :: proc() -> cstring ---
    }
    // odinfmt: enable
} else {
    @(default_calling_convention = "c", link_prefix = "SDL_", require_results)
    foreign lib {

        GetPlatform :: proc() -> cstring ---
    }
}
