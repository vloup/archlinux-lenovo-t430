#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# set vanilla cursor style
export XCURSOR_PATH=""

# exec gnome-session
# exec startkde
#exec startxfce4
#exec openbox-session
exec i3
# ...or the Window Manager of your choice
