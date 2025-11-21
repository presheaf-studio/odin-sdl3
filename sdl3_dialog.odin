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

DialogFileFilter :: struct {
    name:    cstring,
    pattern: cstring,
}

FileDialogType :: enum c.int {
    OPENFILE,
    SAVEFILE,
    OPENFOLDER,
}

DialogFileCallback :: #type proc "c" (userdata: rawptr, filelist: [^]cstring, filter: c.int)

@(default_calling_convention = "c", link_prefix = "SDL_")
foreign lib {
    ShowOpenFileDialog :: proc(callback: DialogFileCallback, userdata: rawptr, window: ^Window, filters: [^]DialogFileFilter, nfilters: c.int, default_location: cstring, allow_many: bool) ---
    ShowSaveFileDialog :: proc(callback: DialogFileCallback, userdata: rawptr, window: ^Window, filters: [^]DialogFileFilter, nfilters: c.int, default_location: cstring) ---
    ShowOpenFolderDialog :: proc(callback: DialogFileCallback, userdata: rawptr, window: ^Window, default_location: cstring, allow_many: bool) ---
    ShowFileDialogWithProperties :: proc(type: FileDialogType, callback: DialogFileCallback, userdata: rawptr, props: PropertiesID) ---
}

PROP_FILE_DIALOG_FILTERS_POINTER :: "SDL.filedialog.filters"
PROP_FILE_DIALOG_NFILTERS_NUMBER :: "SDL.filedialog.nfilters"
PROP_FILE_DIALOG_WINDOW_POINTER :: "SDL.filedialog.window"
PROP_FILE_DIALOG_LOCATION_STRING :: "SDL.filedialog.location"
PROP_FILE_DIALOG_MANY_BOOLEAN :: "SDL.filedialog.many"
PROP_FILE_DIALOG_TITLE_STRING :: "SDL.filedialog.title"
PROP_FILE_DIALOG_ACCEPT_STRING :: "SDL.filedialog.accept"
PROP_FILE_DIALOG_CANCEL_STRING :: "SDL.filedialog.cancel"
