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

Thread :: struct {}
ThreadID :: distinct Uint64

TLSID :: AtomicInt

ThreadPriority :: enum c.int {
    LOW,
    NORMAL,
    HIGH,
    TIME_CRITICAL,
}

ThreadState :: enum c.int {
    UNKNOWN, /**< The thread is not valid */
    ALIVE, /**< The thread is currently running */
    DETACHED, /**< The thread is detached and can't be waited on */
    COMPLETE, /**< The thread has finished and should be cleaned up with SDL_WaitThread() */
}

ThreadFunction :: #type proc "c" (data: rawptr) -> c.int

TLSDestructorCallback :: #type proc "c" (value: rawptr)

@(default_calling_convention = "c", link_prefix = "SDL_")
foreign lib {
    CreateThreadRuntime :: proc(fn: ThreadFunction, name: cstring, data: rawptr, pfnBeginThread: FunctionPointer, pfnEndThread: FunctionPointer) -> ^Thread ---
    CreateThreadWithPropertiesRuntime :: proc(props: PropertiesID, pfnBeginThread: FunctionPointer, pfnEndThread: FunctionPointer) -> ^Thread ---
}

@(require_results)
CreateThread :: proc "c" (fn: ThreadFunction, name: cstring, data: rawptr) -> ^Thread {
    return CreateThreadRuntime(fn, name, data, BeginThreadFunction(), EndThreadFunction())
}
@(require_results)
CreateThreadWithProperties :: proc "c" (props: PropertiesID) -> ^Thread {
    return CreateThreadWithPropertiesRuntime(props, BeginThreadFunction(), EndThreadFunction())
}

PROP_THREAD_CREATE_ENTRY_FUNCTION_POINTER :: "SDL.thread.create.entry_function"
PROP_THREAD_CREATE_NAME_STRING :: "SDL.thread.create.name"
PROP_THREAD_CREATE_USERDATA_POINTER :: "SDL.thread.create.userdata"
PROP_THREAD_CREATE_STACKSIZE_NUMBER :: "SDL.thread.create.stacksize"


BeginThreadFunction :: proc "c" () -> FunctionPointer {
    when ODIN_OS == .Windows {
        foreign _ {
            _beginthreadex :: proc "c" (security: rawptr, stack_size: c.uint, start_address: proc "c" (_: rawptr), arglist: rawptr, initflag: c.uint, thraddr: ^c.uint) -> uintptr ---
        }
        return FunctionPointer(_beginthreadex)
    } else {
        return nil
    }
}

EndThreadFunction :: proc "c" () -> FunctionPointer {
    when ODIN_OS == .Windows {
        foreign _ {
            _endthreadex :: proc "c" (retval: c.uint) ---
        }
        return FunctionPointer(_endthreadex)
    } else {
        return nil
    }
}

@(default_calling_convention = "c", link_prefix = "SDL_", require_results)
foreign lib {
    GetThreadName :: proc(thread: ^Thread) -> cstring ---
    GetCurrentThreadID :: proc() -> ThreadID ---
    GetThreadID :: proc(thread: ^Thread) -> ThreadID ---
    GetThreadState :: proc(thread: ^Thread) -> ThreadState ---
    GetTLS :: proc(id: ^TLSID) -> rawptr ---
    SetTLS :: proc(id: ^TLSID, value: rawptr, destructor: TLSDestructorCallback) -> bool ---
}

@(default_calling_convention = "c", link_prefix = "SDL_")
foreign lib {
    SetCurrentThreadPriority :: proc(priority: ThreadPriority) -> bool ---
    WaitThread :: proc(thread: ^Thread, status: ^c.int) ---
    DetachThread :: proc(thread: ^Thread) ---
    CleanupTLS :: proc() ---
}
