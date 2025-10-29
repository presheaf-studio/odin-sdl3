package sdl3

when ODIN_OS == .Windows {
    @(export)
    foreign import lib "SDL3.lib"
} else when ODIN_OS == .Darwin {
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
    foreign import lib "system:SDL3"
}
