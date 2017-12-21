#!/bin/bash

APP_NAME=$1
X=$2
Y=$3
WIDTH=$4
HEIGHT=$5

osascript \
-e "tell application \"$APP_NAME\"" \
-e "set bounds of front window to {$X, $Y, $WIDTH, $HEIGHT}" \
-e "end tell"
