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

xrdb -merge $HOME/.Xresources

# IME
#export GTK_IM_MODULE=uim
#export QT_IM_MODULE=uim
#export XMODIFIERS=@im=uim
#uim-xim & 
#uim-toolbar-gtk &
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon --xim -d &

# xmodmap
xmodmap ~/home/hiro/.Xmodmap

# Other Option File
./.mysetup.sh

# Desktop
exec awesome 
#exec gnome-session
#exec cinnamon

#exec startkde
#exec startxfce4
#...or the Window Manager of your choice
