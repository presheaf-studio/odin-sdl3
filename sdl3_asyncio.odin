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

AsyncIO :: struct {}

AsyncIOTaskType :: enum c.int {
    READ, /**< A read operation. */
    WRITE, /**< A write operation. */
    CLOSE, /**< A close operation. */
}

AsyncIOResult :: enum c.int {
    COMPLETE, /**< request was completed without error */
    FAILURE, /**< request failed for some reason; check SDL_GetError()! */
    CANCELED, /**< request was canceled before completing. */
}

AsyncIOOutcome :: struct {
    asyncio:           ^AsyncIO, /**< what generated this task. This pointer will be invalid if it was closed! */
    type:              AsyncIOTaskType, /**< What sort of task was this? Read, write, etc? */
    result:            AsyncIOResult, /**< the result of the work (success, failure, cancellation). */
    buffer:            rawptr, /**< buffer where data was read/written. */
    offset:            Uint64, /**< offset in the SDL_AsyncIO where data was read/written. */
    bytes_requested:   Uint64, /**< number of bytes the task was to read/write. */
    bytes_transferred: Uint64, /**< actual number of bytes that were read/written. */
    userdata:          rawptr, /**< pointer provided by the app when starting the task */
}

AsyncIOQueue :: struct {}

@(default_calling_convention = "c", link_prefix = "SDL_", require_results)
foreign lib {
    AsyncIOFromFile :: proc(file: cstring, mode: cstring) -> ^AsyncIO ---
    GetAsyncIOSize :: proc(asyncio: ^AsyncIO) -> Sint64 ---
    ReadAsyncIO :: proc(asyncio: ^AsyncIO, ptr: rawptr, offset, size: Uint64, queue: ^AsyncIOQueue, userdata: rawptr) -> bool ---
    WriteAsyncIO :: proc(asyncio: ^AsyncIO, ptr: rawptr, offset, size: Uint64, queue: ^AsyncIOQueue, userdata: rawptr) -> bool ---
    CloseAsyncIO :: proc(asyncio: ^AsyncIO, flush: bool, queue: ^AsyncIOQueue, userdata: rawptr) -> bool ---
    CreateAsyncIOQueue :: proc() -> ^AsyncIOQueue ---
    DestroyAsyncIOQueue :: proc(queue: ^AsyncIOQueue) ---
    GetAsyncIOResult :: proc(queue: ^AsyncIOQueue, outcome: ^AsyncIOOutcome) -> bool ---
    WaitAsyncIOResult :: proc(queue: ^AsyncIOQueue, outcome: ^AsyncIOOutcome, timeoutMS: Sint32) -> bool ---
    SignalAsyncIOQueue :: proc(queue: ^AsyncIOQueue) ---
    LoadFileAsync :: proc(file: cstring, queue: ^AsyncIOQueue, userdata: rawptr) -> bool ---
}
