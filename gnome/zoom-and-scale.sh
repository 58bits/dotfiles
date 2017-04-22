# https://bbs.archlinux.org/viewtopic.php?id=215389
# First scale Gnome up to the minimum size which is too big.
# Usually "2" is already too big, but if "2" is still small for you, try "3", etc.
gsettings set org.gnome.desktop.interface scaling-factor 2
# Now start scaling down by setting zoom-out factor with xrandr.
# First get the output name:
xrandr | grep -v disconnected | grep connected | cut -d' ' -f1
# eDP1
#
# Use this value to specify --output further on.
# If you have two or more screens you can set their scale independently.
# Now, to zoom-out 1.2 times, run the following:
xrandr --output eDP1 --scale 1.2x1.2
# If the UI is still too big, increase the scale:
xrandr --output eDP1 --scale 1.25x1.25
# If UI becomes too small, decrease the scale factor a bit.
# Repeat until you find a value which works best for your screen and your eyes.
# Finally, you need to allow the mouse to navigate the whole screen.
# To do this you need to get the current scaled resolution:
xrandr | grep eDP1
# eDP1 connected primary 2304x1296+0+0 (normal left inverted right x axis y axis) 239mm x 134mm
#
# Now use the acquired resolution value to set correct panning:
xrandr --output eDP1 --panning 2304x1296

# Set on desktop with HDMI port
gsettings set org.gnome.desktop.interface scaling-factor 2
xrandr | grep -v disconnected | grep connected | cut -d' ' -f1
xrandr --output HDMI-2 --scale 1.25x1.25
xrandr | grep HDMI-2
xrandr --output HDMI-2 --panning 4800x2700
