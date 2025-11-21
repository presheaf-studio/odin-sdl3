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

DateTime :: struct {
    year:        c.int, /**< Year */
    month:       c.int, /**< Month [01-12] */
    day:         c.int, /**< Day of the month [01-31] */
    hour:        c.int, /**< Hour [0-23] */
    minute:      c.int, /**< Minute [0-59] */
    second:      c.int, /**< Seconds [0-60] */
    nanosecond:  c.int, /**< Nanoseconds [0-999999999] */
    day_of_week: c.int, /**< Day of the week [0-6] (0 being Sunday) */
    utc_offset:  c.int, /**< Seconds east of UTC */
}

DateFormat :: enum c.int {
    YYYYMMDD = 0, /**< Year/Month/Day */
    DDMMYYYY = 1, /**< Day/Month/Year */
    MMDDYYYY = 2, /**< Month/Day/Year */
}

TimeFormat :: enum c.int {
    HR24 = 0, /**< 24 hour time */
    HR12 = 1, /**< 12 hour time */
}


@(default_calling_convention = "c", link_prefix = "SDL_", require_results)
foreign lib {
    GetDateTimeLocalePreferences :: proc(dateFormat: ^DateFormat, timeFormat: ^TimeFormat) -> bool ---
    GetCurrentTime :: proc(ticks: ^Time) -> bool ---
    TimeToDateTime :: proc(ticks: Time, dt: ^DateTime, localTime: bool) -> bool ---
    DateTimeToTime :: proc(#by_ptr dt: DateTime, ticks: ^Time) -> bool ---
    TimeToWindows :: proc(ticks: Time, dwLowDateTime, dwHighDateTime: ^Uint32) ---
    TimeFromWindows :: proc(dwLowDateTime, dwHighDateTime: Uint32) -> Time ---
    GetDaysInMonth :: proc(year, month: c.int) -> c.int ---
    GetDayOfYear :: proc(year, month, day: c.int) -> c.int ---
    GetDayOfWeek :: proc(year, month, day: c.int) -> c.int ---
}
