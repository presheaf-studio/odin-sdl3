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

Process :: struct {}

ProcessIO :: enum c.int {
    STDIO_INHERITED, /**< The I/O stream is inherited from the application. */
    STDIO_NULL, /**< The I/O stream is ignored. */
    STDIO_APP, /**< The I/O stream is connected to a new SDL_IOStream that the application can read or write */
    STDIO_REDIRECT, /**< The I/O stream is redirected to an existing SDL_IOStream. */
}

PROP_PROCESS_CREATE_ARGS_POINTER :: "SDL.process.create.args"
PROP_PROCESS_CREATE_ENVIRONMENT_POINTER :: "SDL.process.create.environment"
PROP_PROCESS_CREATE_STDIN_NUMBER :: "SDL.process.create.stdin_option"
PROP_PROCESS_CREATE_STDIN_POINTER :: "SDL.process.create.stdin_source"
PROP_PROCESS_CREATE_STDOUT_NUMBER :: "SDL.process.create.stdout_option"
PROP_PROCESS_CREATE_STDOUT_POINTER :: "SDL.process.create.stdout_source"
PROP_PROCESS_CREATE_STDERR_NUMBER :: "SDL.process.create.stderr_option"
PROP_PROCESS_CREATE_STDERR_POINTER :: "SDL.process.create.stderr_source"
PROP_PROCESS_CREATE_STDERR_TO_STDOUT_BOOLEAN :: "SDL.process.create.stderr_to_stdout"
PROP_PROCESS_CREATE_BACKGROUND_BOOLEAN :: "SDL.process.create.background"

PROP_PROCESS_PID_NUMBER :: "SDL.process.pid"
PROP_PROCESS_STDIN_POINTER :: "SDL.process.stdin"
PROP_PROCESS_STDOUT_POINTER :: "SDL.process.stdout"
PROP_PROCESS_STDERR_POINTER :: "SDL.process.stderr"
PROP_PROCESS_BACKGROUND_BOOLEAN :: "SDL.process.background"

@(default_calling_convention = "c", link_prefix = "SDL_", require_results)
foreign lib {
    CreateProcess :: proc(args: [^]cstring, pipe_stdio: bool) -> ^Process ---
    CreateProcessWithProperties :: proc(props: PropertiesID) -> ^Process ---
    GetProcessProperties :: proc(process: ^Process) -> PropertiesID ---
    ReadProcess :: proc(process: ^Process, datasize: ^uint, exitcode: ^c.int) -> rawptr ---
    GetProcessInput :: proc(process: ^Process) -> ^IOStream ---
    GetProcessOutput :: proc(process: ^Process) -> ^IOStream ---
    KillProcess :: proc(process: ^Process, force: bool) -> bool ---
    WaitProcess :: proc(process: ^Process, block: bool, exitcode: ^c.int) -> bool ---
    DestroyProcess :: proc(process: ^Process) ---
}
