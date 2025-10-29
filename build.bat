@echo off

setlocal EnableDelayedExpansion

if not exist SDL\NUL (
   git clone https://github.com/libsdl-org/SDL --revision 0f061ff154dafb2f65fd882aa69beb119f99318d --depth=1 --recurse-submodules -j 4
)
if not exist SDL_image\NUL (
   git clone https://github.com/libsdl-org/SDL_image --revision 925c19db4d0bc9809fd3ac25c7e0ef771b668390 --depth=1 --recurse-submodules -j 10
)
if not exist SDL_mixer\NUL (
   git clone https://github.com/libsdl-org/SDL_mixer --revision 9cc531686cb3e3ed394790ff075c9760359c0756 --depth=1 --recurse-submodules -j 4
)
if not exist SDL_ttf\NUL (
   git clone https://github.com/libsdl-org/SDL_ttf --revision 6b1114c526ed98d5d03bf504ef06f04c669e2be2 --depth=1 --recurse-submodules -j 10
)

cmake -S . -B libs -DSDL_SHARED=OFF -DSDL_STATIC=ON -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=Release
cmake --build libs -j%NUMBER_OF_PROCESSORS% --config Release

copy /y libs\SDL\Release\SDL3-static.lib             SDL3.lib
copy /y libs\SDL_image\Release\SDL3_image-static.lib image\SDL3_image.lib
copy /y libs\SDL_mixer\Release\SDL3_mixer-static.lib mixer\SDL3_mixer.lib
copy /y libs\SDL_ttf\Release\SDL3_ttf-static.lib     ttf\SDL3_ttf.lib

if not exist include\NUL (
   mkdir include
)

copy /y "SDL\include\SDL3\*" include
xcopy /s /y SDL_image\include\SDL3_image image\include
xcopy /s /y SDL_mixer\include\SDL3_mixer mixer\include
xcopy /s /y SDL_ttf\include\SDL3_ttf     ttf\include
