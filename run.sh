#!/bin/sh

xhost +local:root

# Create a directory for recordings saved from the Bluecherry client
mkdir $HOME/bluecherry-recordings

docker run -it \
   --net=host \
   --device=/dev/dri/card0:/dev/dri/card0 \
   --device=/dev/dri/renderD128:/dev/dri/renderD128 \
   --device=/dev/snd/timer:/dev/snd/timer \
   --device=/dev/snd/pcmC0D0p:/dev/snd/pcmC0D0p \
   --device=/dev/snd/controlC0:/dev/snd/controlC0 \
   --device=/dev/snd/seq:/dev/snd/seq \
   --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --env="QT_GRAPHICSSYSTEM='native'" \
   --ipc host \
   --user "$(id -u):$(id -g)" \
   --volume="$HOME/bluecherry-recordings:/recordings" \
   --volume="$HOME/.Xauthority:/root/.Xauthority:rw" bluecherrydvr/bluecherry-client
