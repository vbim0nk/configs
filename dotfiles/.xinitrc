#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

xrdb -merg ~/.Xresources	# update x resources db
xscreensaver -no-splash &	# starts screensaver daemon
mpd				# starts music daemon
xset +fp /usr/share/fonts/local	# sets up terminal fonts
xset fp rehash			# 

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# exec gnome-session
# exec startkde
#exec startxfce4
# ...or the Window Manager of your choice
DEFAULT_SESSION=awesome
case $1 in
	awesome|wmii|xmonad) exec $1 ;;
	*) exec $DEFAULT_SESSION ;;
esac


