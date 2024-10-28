#!/bin/env nu
#initial check for occupied workspaces
let occupied = hyprctl workspaces 
              | rg ID 
              | sd '\(\)' '\(1\)' 
              | awk 'NR>1{print $1}' RS='(' FS=')' 
              | split row "\n";

let focused = hyprctl workspaces 
              | rg active
              | sd '\(\)' '\(1\)' 
              | awk 'NR>1{print $1}' RS='(' FS=')' 
              | split row "\n";

def workspaces[$event] {
  if [[ ${1:0:4} == "workspace" ]]
}

socat -u UNIX-CONNECT:/tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock - | while read -r event; do 
workspaces "$event"
done
