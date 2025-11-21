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

PropertiesID :: distinct Uint32

PropertyType :: enum c.int {
    INVALID,
    POINTER,
    STRING,
    NUMBER,
    FLOAT,
    BOOLEAN,
}

CleanupPropertyCallback :: #type proc "c" (userdata: rawptr, value: rawptr)
EnumeratePropertiesCallback :: #type proc "c" (userdata: rawptr, props: PropertiesID, name: cstring)


@(default_calling_convention = "c", link_prefix = "SDL_")
foreign lib {
    @(require_results)
    GetGlobalProperties :: proc() -> PropertiesID ---
    @(require_results)
    CreateProperties :: proc() -> PropertiesID ---
    @(require_results)
    HasProperty :: proc(props: PropertiesID, name: cstring) -> bool ---
    @(require_results)
    GetPropertyType :: proc(props: PropertiesID, name: cstring) -> PropertyType ---
    @(require_results)
    GetPointerProperty :: proc(props: PropertiesID, name: cstring, default_value: rawptr) -> rawptr ---
    @(require_results)
    GetStringProperty :: proc(props: PropertiesID, name: cstring, default_value: cstring) -> cstring ---
    @(require_results)
    GetNumberProperty :: proc(props: PropertiesID, name: cstring, default_value: Sint64) -> Sint64 ---
    @(require_results)
    GetFloatProperty :: proc(props: PropertiesID, name: cstring, default_value: f32) -> f32 ---
    @(require_results)
    GetBooleanProperty :: proc(props: PropertiesID, name: cstring, default_value: bool) -> bool ---

    CopyProperties :: proc(src, dst: PropertiesID) -> bool ---
    LockProperties :: proc(props: PropertiesID) -> bool ---
    UnlockProperties :: proc(props: PropertiesID) ---
    SetPointerPropertyWithCleanup :: proc(props: PropertiesID, name: cstring, value: rawptr, cleanup: CleanupPropertyCallback, userdata: rawptr) -> bool ---
    SetPointerProperty :: proc(props: PropertiesID, name: cstring, value: rawptr) -> bool ---
    SetStringProperty :: proc(props: PropertiesID, name: cstring, value: cstring) -> bool ---
    SetNumberProperty :: proc(props: PropertiesID, name: cstring, value: Sint64) -> bool ---
    SetFloatProperty :: proc(props: PropertiesID, name: cstring, value: f32) -> bool ---
    SetBooleanProperty :: proc(props: PropertiesID, name: cstring, value: bool) -> bool ---
    ClearProperty :: proc(props: PropertiesID, name: cstring) -> bool ---
    EnumerateProperties :: proc(props: PropertiesID, callback: EnumeratePropertiesCallback, userdata: rawptr) -> bool ---
    DestroyProperties :: proc(props: PropertiesID) ---
}
