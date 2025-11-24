package sdl3

when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    foreign import lib "SDL3.wasm.a"
}

import "core:c"

Locale :: struct {
    language: cstring, /**< A language name, like "en" for English. */
    country:  cstring, /**< A country, like "US" for America. Can be NULL. */
}

@(default_calling_convention = "c", link_prefix = "SDL_", require_results)
foreign lib {
    GetPreferredLocales :: proc(count: ^c.int) -> [^]^Locale ---
}
