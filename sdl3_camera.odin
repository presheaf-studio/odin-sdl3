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

CameraID :: distinct Uint32

Camera :: struct {}

CameraSpec :: struct {
    format:                PixelFormat, /**< Frame format */
    colorspace:            Colorspace, /**< Frame colorspace */
    width:                 c.int, /**< Frame width */
    height:                c.int, /**< Frame height */
    framerate_numerator:   c.int, /**< Frame rate numerator ((num / denom) == FPS, (denom / num) == duration in seconds) */
    framerate_denominator: c.int, /**< Frame rate demoninator ((num / denom) == FPS, (denom / num) == duration in seconds) */
}

CameraPosition :: enum c.int {
    UNKNOWN,
    FRONT_FACING,
    BACK_FACING,
}

@(default_calling_convention = "c", link_prefix = "SDL_")
foreign lib {
    GetNumCameraDrivers :: proc() -> c.int ---
    GetCameraDriver :: proc(index: c.int) -> cstring ---
    GetCurrentCameraDriver :: proc() -> cstring ---
    GetCameras :: proc(count: ^c.int) -> [^]CameraID ---
    GetCameraSupportedFormats :: proc(instance_id: CameraID, count: ^c.int) -> [^]^CameraSpec ---
    GetCameraName :: proc(instance_id: CameraID) -> cstring ---
    GetCameraPosition :: proc(instance_id: CameraID) -> CameraPosition ---
    OpenCamera :: proc(instance_id: CameraID, spec: ^CameraSpec) -> ^Camera ---
    GetCameraPermissionState :: proc(camera: ^Camera) -> c.int ---
    GetCameraID :: proc(camera: ^Camera) -> CameraID ---
    GetCameraProperties :: proc(camera: ^Camera) -> PropertiesID ---
    GetCameraFormat :: proc(camera: ^Camera, spec: ^CameraSpec) -> bool ---
    AcquireCameraFrame :: proc(camera: ^Camera, timestampNS: ^Uint64) -> ^Surface ---
    ReleaseCameraFrame :: proc(camera: ^Camera, frame: ^Surface) ---
    CloseCamera :: proc(camera: ^Camera) ---
}
