#!/bin/bash

set -e

# check systemd dir
if [ ! -d "./systemd" ]; then
  echo "Directory './systemd' not found." >&2
  exit 1
fi

# link systemd service or path file to ~/.config/systemd/user
function link () {
  name=$1
  dest=$HOME/.config/systemd/user/$1
  if [ -L $dest ]; then
    rm $dest
  fi
  ln -s $(pwd)/systemd/$1 $dest
  echo Linked to "'$dest'".
}

if [ "$1" = "watch" ]; then
  # link service files
  cd ./systemd
  services=($(ls *.service))
  cd ..
  for (( i=0; i<${#services[@]}; i++ ))
  do
    link ${services[$i]}
  done

  # link path files
  cd ./systemd
  paths=($(ls *.path))
  cd ..
  for (( i=0; i<${#paths[@]}; i++ ))
  do
    link ${paths[$i]}
  done

  # reload systemd
  systemctl --user daemon-reload

  # enable paths
  for (( i=0; i<${#paths[@]}; i++ ))
  do
    systemctl --user enable --now ${paths[$i]}
  done
elif [ "$1" = "unwatch" ]; then
  # disable paths
  cd ./systemd
  paths=($(ls *.path))
  cd ..
  for (( i=0; i<${#paths[@]}; i++ ))
  do
    systemctl --user disable --now ${paths[$i]}
  done

  # disable services
  cd ./systemd
  services=($(ls *.service))
  cd ..
  for (( i=0; i<${#services[@]}; i++ ))
  do
    systemctl --user disable ${services[$i]}
  done
else
  # print usage
  echo "Usage: $0 {watch|unwatch}"
fi
