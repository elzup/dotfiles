#!/bin/sh
#
# ~/.xinitrc
#
userresources=$HOME/.Xdefaults
usermodmap=$HOME/.Xmodmap

# merge in defaults and keymaps

if [ -f $userresources ]; then
    xrdb -merge $userresources
fi

if [ -f $usermodmap ]; then
    xmodmap $usermodmap
fi

# Executed by startx (run your window manager from here)
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# IME
#export GTK_IM_MODULE=uim
#export QT_IM_MODULE=uim
#export XMODIFIERS=@im=uim
#uim-xim & 
#uim-toolbar-gtk &

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
export DefaultIMModule=fcitx
fcitx

#export GTK_IM_MODULE=xim
#export QT_IM_MODULE=xim

# ibus-daemon --xim -d &

# clipit

# Other Option File
./.mysetup.sh

# xset +fp /usr/share/fonts/local
# xset fp reflash

# Desktop
exec awesome 
#exec gnome-session
#exec cinnamon

#exec startkde
#exec startxfce4
#...or the Window Manager of your choice
