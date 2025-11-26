#+build windows
package sdl3

when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    foreign import lib "SDL3.wasm.a"
}

// Windows

import win32 "core:sys/windows"

WindowsMessageHook :: #type proc(userdata: rawptr, msg: ^win32.MSG) -> bool

when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    @(default_calling_convention = "c", link_prefix = "SDL_")
    foreign {

    SetWindowsMessageHook :: proc(callback: WindowsMessageHook, userdata: rawptr) ---
    GetDirect3D9AdapterIndex :: proc(displayID: DisplayID) -> c.int ---
    GetDXGIOutputInfo :: proc(displayID: DisplayID, adapterIndex: ^c.int, outputIndex: ^c.int) -> bool ---
    }
} else {
    @(default_calling_convention = "c", link_prefix = "SDL_")
    foreign lib {

    SetWindowsMessageHook :: proc(callback: WindowsMessageHook, userdata: rawptr) ---
    GetDirect3D9AdapterIndex :: proc(displayID: DisplayID) -> c.int ---
    GetDXGIOutputInfo :: proc(displayID: DisplayID, adapterIndex: ^c.int, outputIndex: ^c.int) -> bool ---
    }
}
