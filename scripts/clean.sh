#!/bin/bash
mkdir -p ~/Pictures/gif
mv -f ~/Downloads/*.gif ~/Pictures/gif/
mv -f ~/Desktop/*.gif ~/Pictures/gif/
mv -f ~/Downloads/*.jpg ~/Desktop/
mv -f ~/Downloads/*.JPG ~/Desktop/
mv -f ~/Downloads/*.png ~/Desktop/
mv -f ~/Downloads/*.docx ~/Desktop/
mv -f ~/Downloads/*.pptx ~/Desktop/
mv -f ~/Downloads/*.stl ~/Desktop/
today=$(date "+%Y%m%d")
mkdir -p ~/Documents/backup/desktop${today}
mv ~/Desktop/* ~/Documents/backup/desktop${today}/
mv ~/Desktop/.* ~/Documents/backup/desktop${today}/
rm ~/Downloads/*
rm ~/Downloads/.*
