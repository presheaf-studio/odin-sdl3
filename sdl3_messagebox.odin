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

MessageBoxFlags :: distinct bit_set[MessageBoxFlag;Uint32]
MessageBoxFlag :: enum Uint32 {
    ERROR                 = 4, /**< error dialog */
    WARNING               = 5, /**< warning dialog */
    INFORMATION           = 6, /**< informational dialog */
    BUTTONS_LEFT_TO_RIGHT = 7, /**< buttons placed left to right */
    BUTTONS_RIGHT_TO_LEFT = 8, /**< buttons placed right to left */
}

MessageBoxButtonFlags :: distinct bit_set[MessageBoxButtonFlag;Uint32]
MessageBoxButtonFlag :: enum Uint32 {
    RETURNKEY_DEFAULT = 0, /**< Marks the default button when return is hit */
    ESCAPEKEY_DEFAULT = 1, /**< Marks the default button when return is hit */
}

MessageBoxButtonData :: struct {
    flags:    MessageBoxButtonFlags,
    buttonID: c.int, /**< User defined button id (value returned via SDL_ShowMessageBox) */
    text:     cstring, /**< The UTF-8 button text */
}


MessageBoxColor :: distinct [3]Uint8

MessageBoxColorType :: enum c.int {
    BACKGROUND,
    TEXT,
    BUTTON_BORDER,
    BUTTON_BACKGROUND,
    BUTTON_SELECTED,
}


MessageBoxColorScheme :: struct {
    colors: [MessageBoxColorType]MessageBoxColor,
}


MessageBoxData :: struct {
    flags:       MessageBoxFlags,
    window:      ^Window, /**< Parent window, can be NULL */
    title:       cstring, /**< UTF-8 title */
    message:     cstring, /**< UTF-8 message text */
    numbuttons:  c.int,
    buttons:     [^]MessageBoxButtonData `fmt:"v,numbuttons"`,
    colorScheme: ^MessageBoxColorScheme, /**< MessageBoxColorScheme, can be NULL to use system settings */
}


@(default_calling_convention = "c", link_prefix = "SDL_")
foreign lib {
    ShowMessageBox :: proc(#by_ptr messageboxdata: MessageBoxData, buttonid: ^c.int) -> bool ---
    ShowSimpleMessageBox :: proc(flags: MessageBoxFlags, title, message: cstring, window: ^Window) -> bool ---
}
