package sdl3

when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    foreign import lib "SDL3.wasm.a"
}

@(default_calling_convention = "c", link_prefix = "SDL_", require_results)
foreign lib {
    GetPlatform :: proc() -> cstring ---
}
