#! /bin/sh

gnome-control-center
#->	open settings

xrandr
#->	screen resolution display
#->	change management

# cvt X Y
# Calculates VESA CVT (Coordinated Video Timing) modelines for use with X. 
cvt --verbose 1920 1200

# gtf X Y frequency
# gets also some info not sure which
gtf 1920 1080 60 --verbose


# create the Modeline (all data created by cvt)
xrandr --newmode "1920x1200_60.00"  193.25  1920 2056 2256 2592  1200 1203 1209 1245 -hsync +vsync

# add the modeline to output
# i had prblems finding the right out
# this gave me the default that worked
xrandr --listactivemonitors

xrandr --addmode VGA1 "1920x1200_60.00" 
xrandr --addmode default 1920x1200_33.00