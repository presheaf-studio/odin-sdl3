#!/bin/bash

# List of files to update
files=(
"sdl3_assert.odin"
"sdl3_asyncio.odin"
"sdl3_atomic.odin"
"sdl3_audio.odin"
"sdl3_bits.odin"
"sdl3_blendmode.odin"
"sdl3_camera.odin"
"sdl3_clipboard.odin"
"sdl3_cpuinfo.odin"
"sdl3_dialog.odin"
"sdl3_error.odin"
"sdl3_events.odin"
"sdl3_filesystem.odin"
"sdl3_gamepad.odin"
"sdl3_gpu.odin"
"sdl3_guid.odin"
"sdl3_haptic.odin"
"sdl3_hidapi.odin"
"sdl3_hints.odin"
"sdl3_init.odin"
"sdl3_iostream.odin"
"sdl3_joystick.odin"
"sdl3_keyboard.odin"
"sdl3_keycode.odin"
"sdl3_loadso.odin"
"sdl3_locale.odin"
"sdl3_log.odin"
"sdl3_main.odin"
"sdl3_messagebox.odin"
"sdl3_metal.odin"
"sdl3_misc.odin"
"sdl3_mouse.odin"
"sdl3_mutex.odin"
"sdl3_pixels.odin"
"sdl3_platform.odin"
"sdl3_power.odin"
"sdl3_process.odin"
"sdl3_properties.odin"
"sdl3_rect.odin"
"sdl3_render.odin"
"sdl3_scancode.odin"
"sdl3_sensor.odin"
"sdl3_stdinc.odin"
"sdl3_storage.odin"
"sdl3_surface.odin"
"sdl3_system.odin"
"sdl3_system_windows.odin"
"sdl3_thread.odin"
"sdl3_time.odin"
"sdl3_timer.odin"
"sdl3_touch.odin"
"sdl3_tray.odin"
"sdl3_version.odin"
"sdl3_video.odin"
"sdl3_vulkan.odin"
)

wasm_block='when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    foreign import lib "SDL3_wasm.a"
}

'

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        # Insert after "package sdl3" line
        sed -i '' "2a\\
$wasm_block" "$file"
        echo "Updated $file"
    fi
done
