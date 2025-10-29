package sdl3_ttf

import "core:c"

import sdl "../"

DrawCommand :: enum c.int {
    NOOP,
    FILL,
    COPY,
}

FillOperation :: struct {
    cmd:  DrawCommand,
    rect: sdl.Rect,
}

CopyOperation :: struct {
    cmd:         DrawCommand,
    text_offset: c.int,
    glyph_font:  ^Font,
    glyph_index: u32,
    src:         sdl.Rect,
    dst:         sdl.Rect,
    reserved:    rawptr,
}

DrawOperation :: struct #raw_union {
    cmd:  DrawCommand,
    fill: FillOperation,
    copy: CopyOperation,
}

TextLayout :: struct {}

TextData :: struct {
    font:                ^Font,
    color:               sdl.FColor,
    needs_layout_update: bool,
    layout:              ^TextLayout,
    x, y:                c.int,
    w, h:                c.int,
    num_ops:             c.int,
    ops:                 [^]DrawOperation `fmt:"v,num_ops"`,
    num_clusters:        c.int,
    clusters:            [^]SubString `fmt:"v,num_clusters"`,
    props:               sdl.PropertiesID,
    needs_engine_update: bool,
    engine:              ^TextEngine,
    engine_text:         rawptr,
}

TextEngine :: struct {
    version:     u32,
    userdata:    rawptr,
    CreateText:  proc "c" (userdata: rawptr, text: ^Text) -> bool,
    DestroyText: proc "c" (userdata: rawptr, Textext: ^Text),
}

#assert((size_of(TextEngine) == 16 && size_of(rawptr) == 4) || (size_of(TextEngine) == 32 && size_of(rawptr) == 8))
