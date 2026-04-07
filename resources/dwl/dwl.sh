#!/bin/sh

export XDG_RUNTIME_DIR=/tmp/xdg-runtime-$(id -u)
mkdir -p $XDG_RUNTIME_DIR
dwl -s "/usr/local/bin/autostart.sh"