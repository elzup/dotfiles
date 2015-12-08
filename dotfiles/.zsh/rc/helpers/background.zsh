case ${OSTYPE} in
    darwin*)
        background() {
            bg=$1
            if [ ${bg%%:*} = "http" ] ; then ;
                filename=${${bg:t}%\?*}
                wget $bg -O ~/Pictures/tmpbg/$filename
                bg=~/Pictures/tmpbg/$filename
                ;fi
            osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$bg\""
        }
        ;;
    *)
        alias background="display -window root -resize \`screensize\`"
        ;;
esac
