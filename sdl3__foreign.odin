package sdl3

SDL3_MIXER :: #config(SDL3_MIXER, false)
when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    SYSTEM_SUPPORT :: false
    SDL3_SYSTEM :: false
    SDL3_SHARED :: false
} else {
    when ODIN_OS != .Windows {
        when ODIN_OS != .Darwin || !SDL3_MIXER {
            SYSTEM_SUPPORT :: true
        } else {
            SYSTEM_SUPPORT :: false
        }
        SDL3_SYSTEM :: #config(SDL3_SYSTEM, SYSTEM_SUPPORT)
    } else {
        SDL3_SYSTEM :: false
        SYSTEM_SUPPORT :: false
    }
    SDL3_SHARED :: #config(SDL3_SHARED, !SYSTEM_SUPPORT)

    when ODIN_OS == .Darwin && SDL3_SYSTEM && SDL3_MIXER {
        #panic("not available on brew yet, you gotta copile")
    }

    when ODIN_OS == .Windows {
        @(export)
        foreign import lib {"SDL3.lib" when SDL3_SHARED else "SDL3_static.lib"}
    } else when ODIN_OS == .Darwin {
        when !SDL3_SHARED {
            @(require) foreign import "system:System"
            @(require) foreign import "system:ObjC"
            @(require) foreign import "system:iconv"
            @(require) foreign import "system:AVFoundation.framework"
            @(require) foreign import "system:Foundation.framework"
            @(require) foreign import "system:CoreFoundation.framework"
            @(require) foreign import "system:CoreAudio.framework"
            @(require) foreign import "system:CoreMedia.framework"
            @(require) foreign import "system:UniformTypeIdentifiers.framework"
            @(require) foreign import "system:CoreGraphics.framework"
            @(require) foreign import "system:CoreVideo.framework"
            @(require) foreign import "system:CoreServices.framework"
            @(require) foreign import "system:CoreHaptics.framework"
            @(require) foreign import "system:AudioToolbox.framework"
            @(require) foreign import "system:IOKit.framework"
            @(require) foreign import "system:QuartzCore.framework"
            @(require) foreign import "system:GameController.framework"
            @(require) foreign import "system:ForceFeedback.framework"
            @(require) foreign import "system:Metal.framework"
            @(require) foreign import "system:MetalKit.framework"
            @(require) foreign import "system:Cocoa.framework"
            @(require) foreign import "system:AppKit.framework"
            @(require) foreign import "system:Carbon.framework"
            @(export)
            foreign import lib "SDL3.darwin.a"
        } else {
            @(export)
            foreign import lib {"system:SDL3" when SDL3_SYSTEM else "libSDL3.dylib"}
        }
    } else when ODIN_OS == .Linux {
        when !SDL3_SHARED {
            @(export)
            foreign import lib "SDL3.linux.a"
        } else {
            @(export)
            foreign import lib {"system:SDL3" when SDL3_SYSTEM else "libSDL3.so"}
        }
    }
}

