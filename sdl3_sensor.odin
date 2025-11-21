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

Sensor :: struct {}

SensorID :: distinct Uint32

STANDARD_GRAVITY :: 9.80665

SensorType :: enum c.int {
    INVALID = -1, /**< Returned for an invalid sensor */
    UNKNOWN, /**< Unknown sensor type */
    ACCEL, /**< Accelerometer */
    GYRO, /**< Gyroscope */
    ACCEL_L, /**< Accelerometer for left Joy-Con controller and Wii nunchuk */
    GYRO_L, /**< Gyroscope for left Joy-Con controller */
    ACCEL_R, /**< Accelerometer for right Joy-Con controller */
    GYRO_R, /**< Gyroscope for right Joy-Con controller */
}

@(default_calling_convention = "c", link_prefix = "SDL_", require_results)
foreign lib {
    GetSensors :: proc(count: ^c.int) -> [^]SensorID ---
    GetSensorNameForID :: proc(instance_id: SensorID) -> cstring ---
    GetSensorTypeForID :: proc(instance_id: SensorID) -> SensorType ---
    GetSensorNonPortableTypeForID :: proc(instance_id: SensorID) -> c.int ---
    OpenSensor :: proc(instance_id: SensorID) -> ^Sensor ---
    GetSensorFromID :: proc(instance_id: SensorID) -> ^Sensor ---
    GetSensorProperties :: proc(sensor: ^Sensor) -> PropertiesID ---
    GetSensorName :: proc(sensor: ^Sensor) -> cstring ---
    GetSensorType :: proc(sensor: ^Sensor) -> SensorType ---
    GetSensorNonPortableType :: proc(sensor: ^Sensor) -> c.int ---
    GetSensorID :: proc(sensor: ^Sensor) -> SensorID ---
    GetSensorData :: proc(sensor: ^Sensor, data: [^]f32, num_values: c.int) -> bool ---
    CloseSensor :: proc(sensor: ^Sensor) ---
    UpdateSensors :: proc() ---
}
