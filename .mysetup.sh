
# {{{ settings 
# keyRepeat speed
xset r rate 150 80
# xset r rate 255 25 # default

# }}}

# {{{ touchpad
synclient TapButton1=1
synclient TapButton2=2
synclient TapButton3=3
synclient VertEdgeScroll=1
synclient HorizEdgeScroll=1
# }}}

# {{{ my startup application
# Dropbox sync start
dropbox start
klipper
sudo nohup php /home/hiro/work/php/eject/stream.php &
# php ./work/php/eject/eject.php &
# autokey-gtk
# wine /opt/clibor/Clibor.exe
# }}}

