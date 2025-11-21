#+build !js
#+build !wasi
#+build !orca
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

import vk "vendor:vulkan"

@(default_calling_convention = "c", link_prefix = "SDL_")
foreign lib {
    Vulkan_LoadLibrary :: proc(path: cstring) -> bool ---
    Vulkan_GetVkGetInstanceProcAddr :: proc() -> FunctionPointer ---
    Vulkan_UnloadLibrary :: proc() ---
    Vulkan_GetInstanceExtensions :: proc(count: ^Uint32) -> [^]cstring ---
    Vulkan_CreateSurface :: proc(window: ^Window, instance: vk.Instance, allocator: Maybe(^vk.AllocationCallbacks), surface: ^vk.SurfaceKHR) -> bool ---
    Vulkan_DestroySurface :: proc(instance: vk.Instance, surface: vk.SurfaceKHR, allocator: Maybe(^vk.AllocationCallbacks)) ---
    Vulkan_GetPresentationSupport :: proc(instance: vk.Instance, physicalDevice: vk.PhysicalDevice, queueFamilyIndex: Uint32) -> bool ---

}
