#!/usr/bin/env bash

set -e

cp libs/SDL/libSDL3.a ../SDL3.a
cp libs/SDL_image/libSDL3_image.a ../image/SDL3_image.a
cp libs/SDL_ttf/libSDL3_ttf.a ../ttf/SDL3_ttf.a
cp libs/SDL_mixer/libSDL3_mixer.a ../mixer/SDL3_mixer.a

cp -r SDL/include/SDL3/* ../include
cp -r SDL_image/include/SDL3_image/* ../image/include
cp -r SDL_ttf/include/SDL3_ttf/* ../ttf/include
cp -r SDL_mixer/include/SDL3_mixer/* ../mixer/include
