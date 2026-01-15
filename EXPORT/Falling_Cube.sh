#!/bin/sh
printf '\033c\033]0;%s\a' 2DPlatformer_proto_01
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Falling_Cube.x86_64" "$@"
