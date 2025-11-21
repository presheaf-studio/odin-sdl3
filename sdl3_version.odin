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

MAJOR_VERSION :: 3
MINOR_VERSION :: 2
MICRO_VERSION :: 16

@(require_results)
VERSIONNUM :: #force_inline proc "c" (major, minor, patch: c.int) -> c.int {return(
        (major * 1000000) +
        (minor * 1000) +
        patch \
    )}
@(require_results)
VERSIONNUM_MAJOR :: #force_inline proc "c" (version: c.int) -> c.int {return version / 1000000}
@(require_results)
VERSIONNUM_MINOR :: #force_inline proc "c" (version: c.int) -> c.int {return (version / 1000) % 1000}
@(require_results)
VERSIONNUM_MICRO :: #force_inline proc "c" (version: c.int) -> c.int {return version % 1000}

VERSION :: MAJOR_VERSION * 1000000 + MINOR_VERSION * 1000 + MICRO_VERSION

@(require_results)
VERSION_ATLEAST :: proc "c" (X, Y, Z: c.int) -> bool {return VERSION >= VERSIONNUM(X, Y, Z)}


@(default_calling_convention = "c", link_prefix = "SDL_", require_results)
foreign lib {
    GetVersion :: proc() -> c.int ---
    GetRevision :: proc() -> cstring ---
}
