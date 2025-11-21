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

Point :: distinct [2]c.int
FPoint :: distinct [2]f32

Rect :: struct {
    x, y: c.int,
    w, h: c.int,
}

FRect :: struct {
    x, y: f32,
    w, h: f32,
}

RectToFRect :: #force_inline proc "c" (rect: Rect, frect: ^FRect) {
    frect.x = f32(rect.x)
    frect.y = f32(rect.y)
    frect.w = f32(rect.w)
    frect.h = f32(rect.h)
}


@(require_results)
PointInRect :: proc "c" (p: Point, r: Rect) -> bool {
    return (p.x >= r.x) && (p.x < (r.x + r.w)) && (p.y >= r.y) && (p.y < (r.y + r.h))
}

@(require_results)
RectEmpty :: proc "c" (r: Rect) -> bool {
    return r.w <= 0 || r.h <= 0
}


@(require_results)
RectEqual :: proc "c" (a, b: Rect) -> bool {
    return a == b
}

@(default_calling_convention = "c", link_prefix = "SDL_", require_results)
foreign lib {
    HasRectIntersection :: proc(#by_ptr A, B: Rect) -> bool ---
    GetRectIntersection :: proc(#by_ptr A, B: Rect, result: ^Rect) -> bool ---
    GetRectUnion :: proc(#by_ptr A, B: Rect, result: ^Rect) -> bool ---
    GetRectEnclosingPoints :: proc(points: [^]Point, count: c.int, #by_ptr clip: Rect, result: ^Rect) -> bool ---
    GetRectAndLineIntersection :: proc(#by_ptr rect: Rect, X1, Y1, X2, Y2: ^c.int) -> bool ---
    HasRectIntersectionFloat :: proc(#by_ptr A, B: FRect) -> bool ---
    GetRectIntersectionFloat :: proc(#by_ptr A, B: FRect, result: ^FRect) -> bool ---
    GetRectUnionFloat :: proc(#by_ptr A, B: FRect, result: ^FRect) -> bool ---
    GetRectEnclosingPointsFloat :: proc(points: [^]FPoint, count: c.int, #by_ptr clip: FRect, result: ^FRect) -> bool ---
    GetRectAndLineIntersectionFloat :: proc(#by_ptr rect: FRect, X1, Y1, X2, Y2: ^f32) -> bool ---
}
