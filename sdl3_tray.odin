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

Tray :: struct {}
TrayMenu :: struct {}
TrayEntry :: struct {}

TrayEntryFlags :: distinct bit_set[TrayEntryFlag;Uint32]
TrayEntryFlag :: enum Uint32 {
    BUTTON   = 0, /**< Make the entry a simple button. Required. */
    CHECKBOX = 1, /**< Make the entry a checkbox. Required. */
    SUBMENU  = 2, /**< Prepare the entry to have a submenu. Required */
    DISABLED = 31, /**< Make the entry disabled. Optional. */
    CHECKED  = 30, /**< Make the entry checked. This is valid only for checkboxes. Optional. */
}

TRAYENTRY_BUTTON :: TrayEntryFlags{.BUTTON} /**< Make the entry a simple button. Required. */
TRAYENTRY_CHECKBOX :: TrayEntryFlags{.CHECKBOX} /**< Make the entry a checkbox. Required. */
TRAYENTRY_SUBMENU :: TrayEntryFlags{.SUBMENU} /**< Prepare the entry to have a submenu. Required */
TRAYENTRY_DISABLED :: TrayEntryFlags{.DISABLED} /**< Make the entry disabled. Optional. */
TRAYENTRY_CHECKED :: TrayEntryFlags {
    .CHECKED,
} /**< Make the entry checked. This is valid only for checkboxes. Optional. */

TrayCallback :: #type proc "c" (userdata: rawptr, entry: ^TrayEntry)


@(default_calling_convention = "c", link_prefix = "SDL_", require_results)
foreign lib {
    CreateTray :: proc(icon: ^Surface, tooltip: cstring) -> ^Tray ---
    SetTrayIcon :: proc(tray: ^Tray, icon: ^Surface) ---
    SetTrayTooltip :: proc(tray: ^Tray, tooltip: cstring) ---
    CreateTrayMenu :: proc(tray: ^Tray) -> ^TrayMenu ---
    CreateTraySubmenu :: proc(entry: ^TrayEntry) -> ^TrayMenu ---
    GetTrayMenu :: proc(tray: ^Tray) -> TrayMenu ---
    GetTraySubmenu :: proc(entry: ^TrayEntry) -> ^TrayMenu ---
    GetTrayEntries :: proc(menu: ^TrayMenu, size: ^c.int) -> [^]^TrayEntry ---
    RemoveTrayEntry :: proc(entry: ^TrayEntry) ---
    InsertTrayEntryAt :: proc(menu: ^TrayMenu, pos: c.int, label: cstring, flags: TrayEntryFlags) -> ^TrayEntry ---
    SetTrayEntryLabel :: proc(entry: ^TrayEntry, label: cstring) ---
    GetTrayEntryLabel :: proc(entry: ^TrayEntry) -> cstring ---
    SetTrayEntryChecked :: proc(entry: ^TrayEntry, checked: bool) ---
    GetTrayEntryChecked :: proc(entry: ^TrayEntry) -> bool ---
    SetTrayEntryEnabled :: proc(entry: ^TrayEntry, enabled: bool) ---
    GetTrayEntryEnabled :: proc(entry: ^TrayEntry) -> bool ---
    SetTrayEntryCallback :: proc(entry: ^TrayEntry, callback: TrayCallback, userdata: rawptr) ---
    ClickTrayEntry :: proc(entry: ^TrayEntry) ---
    DestroyTray :: proc(tray: ^Tray) ---
    GetTrayEntryParent :: proc(entry: ^TrayEntry) -> ^TrayMenu ---
    GetTrayMenuParentEntry :: proc(menu: ^TrayMenu) -> ^TrayEntry ---
    GetTrayMenuParentTray :: proc(menu: ^TrayMenu) -> ^Tray ---
    UpdateTrays :: proc() ---
}
