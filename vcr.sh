#!/bin/sh

DEVICE="/dev/video0"

vlc v4l2://$DEVICE :v4l2-standard=NTSC :input-slave=alsa://hw:3,0 :v4l2-chroma= \
:v4l2-input=0 :v4l2-audio-input=-1 :v4l2-width=-1 :v4l2-height=-1 \
:v4l2-aspect-ratio=4\:3 :v4l2-fps=0 :v4l2-use-libv4l2 :v4l2-tuner=0 \
:v4l2-tuner-frequency=-1 :v4l2-tuner-audio-mode=-1 :no-v4l2-controls-reset \
:v4l2-brightness=-1 :v4l2-brightness-auto=-1 :v4l2-contrast=-1 \
:v4l2-saturation=-1 :v4l2-hue=-1 :v4l2-hue-auto=-1 :v4l2-white-balance-temperature=-1 \
:v4l2-auto-white-balance=-1 :v4l2-red-balance=-1 :v4l2-blue-balance=-1 :v4l2-gamma=-1 \
:v4l2-autogain=-1 :v4l2-gain=-1 :v4l2-sharpness=-1 :v4l2-chroma-gain=-1 \
:v4l2-chroma-gain-auto=-1 :v4l2-power-line-frequency=-1 :v4l2-backlight-compensation=-1 \
:v4l2-band-stop-filter=-1 :no-v4l2-hflip :no-v4l2-vflip :v4l2-rotate=-1 \
:v4l2-color-killer=-1 :v4l2-color-effect=-1 :v4l2-audio-volume=-1 :v4l2-audio-balance=-1 \
:no-v4l2-audio-mute :v4l2-audio-bass=-1 :v4l2-audio-treble=-1 :no-v4l2-audio-loudness \
:v4l2-set-ctrls= :live-caching=300
