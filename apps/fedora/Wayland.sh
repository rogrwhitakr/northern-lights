#! /bin/bash

# all environment variables dealing with session
env | grep XDG*

# session type -> x11 or wayland
echo $XDG_SESSION_TYPE

# get the gnome process
# if it displays '--wayland --display-server' it is a wayland session
ps aux | grep gnome-shell

# check for Xorg session
# if there is one -> default display server
ps aux | grep Xorg
