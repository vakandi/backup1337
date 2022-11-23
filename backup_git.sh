#!/bin/sh
#This script will backup everything using the goinfre (local disk of your machine)" so that you can avoid low memory problem, the backup is removed after the push on git
DATE="$(echo $(date) | cut -c5-10 | tr " " "_")"
PRIVATE_GIT="https://github.com/vakandi/backup-session-1337.git"

#
cd ~/ && cp -r Library/Mozilla/Firefox/Profiles goinfre/Firefox_Profiles_Backup_tmp2 && cp -r Library/Application\ Support/Firefox/Profiles goinfre/Firefox_Profiles_Backup_tmp
cd goinfre
echo "\033[44;mCreating the backup folder..  \033[0m"
mkdir backup
cd ~/
echo "\033[44;mCloning the git repo into 'gcl$DATE'\033[0m"
git clone $PRIVATE_GIT goinfre/backup/gcl$DATE
echo "\033[44;mCreation of the archive .tar...  \033[0m"
echo "\033[44;mIt may take some time....  \033[0m"
tar --exclude='./.TemporaryItems' --exclude='.CFUserTextEncoding' --exclude='.DocumentRevisions-V100' --exclude='.TemporaryItems' --exclude='.fseventsd'  --exclude='./.brew' --exclude='./Library' --exclude='./Desktop' --exclude='./.tmp' --exclude='./code/1337RANK.io' --exclude='./Applications' --exclude='./backup-session-1337' -cf goinfre/backup/gcl$DATE/backup_session_1337_$DATE.tar * .*

echo "\033[45;m    ⬆⬆⬆⬆  IF YOU SEE ERROR HERE ⬆⬆⬆⬆  \033[0m"
echo "\033[45;m   It's normal, the backup has been made \033[0m"
echo "\033[44;mThe tar archive is now created inside goinfre/backup/gcl$DATE  \033[0m"
ls goinfre/backup/gcl$DATE/backup_session_1337*
sleep 3s
cd goinfre
cd backup
cd gcl$DATE
echo "\033[44;mCompression the backup using xz..\033[0m"
#BACKUP_PATH=/goinfre/backup/gcl$DATE/backup_session_1337_$DATE.tar
#if [ -f "$BACKUP_PATH" ]; then
#    echo "\033[42;m$BACKUP_PATH exists,\n BACKUP SUCCEED\033]0m"
#	xz -9 backup_session_1337_$DATE.tar
#else
#    echo "\033[41;m$BACKUP_PATH does not exist. BACKUP FAILED\033]0m"
#	exit
#fi

xz -9 backup_session_1337_$DATE.tar
echo "\033[42;m  Compression is done  \033[0m"
echo "\033[42;m  Splitting Backup into 95MO FILE (github limits 100MO file) \033[0m"
split --verbose -b 95000k backup_session_1337_$DATE.tar backup_segment
echo "\033[44;mUse xz --decompress to unzip it)\033[0m"
git add backup_segment* && git commit -m "backup $DATE" && git push && git pull && git push
echo "\033[42;mGit Push DONE \033[0m"

echo "\033[42;m To redo the backup from the split files, just do:  \033[0m"
echo "\033[42;m cat backup_segment?? > backup_session_1337.tar.xz \033[0m"
echo "\033[42;m and then \033[0m"
echo "\033[42;m xz -d backup_session_1337.tar.xz \033[0m"
echo "\033[42;m Now if you want to open it :  tar xf backup_session_1337.tar \033[0m"
echo "\033[42;m _____  \033[0m"
#cd ~/ && cd goinfre && rm -rf backup Firefox_Profiles_Backup_tmp
echo "\033[35;m script made by wbousfir \033[0m"
