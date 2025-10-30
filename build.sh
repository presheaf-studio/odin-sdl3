#!/usr/bin/env bash

set -e

[ -d SDL ] || git clone https://github.com/libsdl-org/SDL --revision 0f061ff154dafb2f65fd882aa69beb119f99318d --depth=1 --recurse-submodules -j 4 &
[ -d SDL_image ] || git clone https://github.com/libsdl-org/SDL_image --revision 925c19db4d0bc9809fd3ac25c7e0ef771b668390 --depth=1 --recurse-submodules -j 10 &
[ -d SDL_mixer ] || git clone https://github.com/libsdl-org/SDL_mixer --revision 9cc531686cb3e3ed394790ff075c9760359c0756 --depth=1 --recurse-submodules -j 4 &
[ -d SDL_ttf ] || git clone https://github.com/libsdl-org/SDL_ttf --revision 6b1114c526ed98d5d03bf504ef06f04c669e2be2 --depth=1 --recurse-submodules -j 10 &

wait

cmake -S . -B libs -DSDL_SHARED=ON -DSDL_STATIC=OFF -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release
if [ $(uname -s) = 'Darwin' ]; then
    cmake --build libs -j$(sysctl -n hw.ncpu) --config Release
    # LIB_EXT=darwin
    cp libs/SDL/*.dylib .
    cp libs/SDL_image/*.dylib image/
    cp libs/SDL_ttf/*.dylib ttf/
    cp libs/SDL_mixer/*.dylib mixer/
else
    cmake --build libs -j$(nproc) --config Release
    # LIB_EXT=linux
    cp libs/SDL/*.so .
    cp libs/SDL_image/*.so image/
    cp libs/SDL_ttf/*.so ttf/
    cp libs/SDL_mixer/*.so mixer/
fi

# cp libs/SDL/libSDL3.a SDL3.$LIB_EXT.a
# cp libs/SDL_image/libSDL3_image.a image/SDL3_image.$LIB_EXT.a
# cp libs/SDL_ttf/libSDL3_ttf.a ttf/SDL3_ttf.$LIB_EXT.a
# cp libs/SDL_mixer/libSDL3_mixer.a mixer/SDL3_mixer.$LIB_EXT.a

cp -r SDL/include/SDL3/* include
cp -r SDL_image/include/SDL3_image/* image/include
cp -r SDL_ttf/include/SDL3_ttf/* ttf/include
cp -r SDL_mixer/include/SDL3_mixer/* mixer/include
