#!/usr/bin/env bash

set -e

cmake -S . -B libs -DSDL_SHARED=OFF -DSDL_STATIC=ON -DBUILD_SHARED_LIBS=OFF
cmake --build libs -j16
