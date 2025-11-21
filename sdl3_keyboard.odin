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

KeyboardID :: distinct Uint32

TextInputType :: enum c.int {
    TEXT, /**< The input is text */
    TEXT_NAME, /**< The input is a person's name */
    TEXT_EMAIL, /**< The input is an e-mail address */
    TEXT_USERNAME, /**< The input is a username */
    TEXT_PASSWORD_HIDDEN, /**< The input is a secure password that is hidden */
    TEXT_PASSWORD_VISIBLE, /**< The input is a secure password that is visible */
    NUMBER, /**< The input is a number */
    NUMBER_PASSWORD_HIDDEN, /**< The input is a secure PIN that is hidden */
    NUMBER_PASSWORD_VISIBLE, /**< The input is a secure PIN that is visible */
}

Capitalization :: enum c.int {
    NONE, /**< No auto-capitalization will be done */
    SENTENCES, /**< The first letter of sentences will be capitalized */
    WORDS, /**< The first letter of words will be capitalized */
    LETTERS, /**< All letters will be capitalized */
}

PROP_TEXTINPUT_TYPE_NUMBER :: "SDL.textinput.type"
PROP_TEXTINPUT_CAPITALIZATION_NUMBER :: "SDL.textinput.capitalization"
PROP_TEXTINPUT_AUTOCORRECT_BOOLEAN :: "SDL.textinput.autocorrect"
PROP_TEXTINPUT_MULTILINE_BOOLEAN :: "SDL.textinput.multiline"
PROP_TEXTINPUT_ANDROID_INPUTTYPE_NUMBER :: "SDL.textinput.android.inputtype"


@(default_calling_convention = "c", link_prefix = "SDL_", require_results)
foreign lib {
    HasKeyboard :: proc() -> bool ---
    GetKeyboards :: proc(count: ^c.int) -> [^]KeyboardID ---
    GetKeyboardNameForID :: proc(instance_id: KeyboardID) -> cstring ---
    GetKeyboardFocus :: proc() -> ^Window ---
    GetKeyboardState :: proc(numkeys: ^c.int) -> [^]bool ---
    ResetKeyboard :: proc() ---
    GetModState :: proc() -> Keymod ---
    SetModState :: proc(modstate: Keymod) ---
    GetKeyFromScancode :: proc(scancode: Scancode, modstate: Keymod, key_event: bool) -> Keycode ---
    GetScancodeFromKey :: proc(key: Keycode, modstate: ^Keymod) -> Scancode ---
    SetScancodeName :: proc(scancode: Scancode, name: cstring) -> bool ---
    GetScancodeName :: proc(scancode: Scancode) -> cstring ---
    GetScancodeFromName :: proc(name: cstring) -> Scancode ---
    GetKeyName :: proc(key: Keycode) -> cstring ---
    GetKeyFromName :: proc(name: cstring) -> Keycode ---
    StartTextInput :: proc(window: ^Window) -> bool ---
    StartTextInputWithProperties :: proc(window: ^Window, props: PropertiesID) -> bool ---
    TextInputActive :: proc(window: ^Window) -> bool ---
    StopTextInput :: proc(window: ^Window) -> bool ---
    ClearComposition :: proc(window: ^Window) -> bool ---
    SetTextInputArea :: proc(window: ^Window, rect: Maybe(^Rect), cursor: c.int) -> bool ---
    GetTextInputArea :: proc(window: ^Window, rect: ^Rect, cursor: ^c.int) -> bool ---
    HasScreenKeyboardSupport :: proc() -> bool ---
    ScreenKeyboardShown :: proc(window: ^Window) -> bool ---
}
