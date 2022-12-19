CHECK_DOUBLE_PROCESS=$(ps -ax | grep backup_auto.sh | awk '{print $1}' |wc -l | cut -c8-)
CHECK_NEW_PROCESS=$(jobs | grep backup_auto.sh | awk '{print $1}' | cut -c2-2)
NUMBER_PROCESS=$(jobs | grep backup_auto.sh | wc -l | cut -c8-)
var=2
var3=3
DATE="$(echo $(date) | cut -c5-10 | tr " " "_")"
PRIVATE_GIT="https://github.com/vakandi/backup-session-1337.git"

if [ $CHECK_NEW_PROCESS -ge "1" ]; then
	kill "%$(jobs | grep backup_auto.sh | awk '{print $1}' | cut -c2-2)"
	exit
fi
while true
do
		cd ~/ && cd goinfre && mkdir backup && git clone $PRIVATE_GIT gcl$DATE
		cd ~/ && cp -r Library/Application\ Support/Firefox/Profiles goinfre/Firefox_Profiles_Backup_tmp
		cp -r Library/Mozilla/Firefox/Profiles goinfre/Firefox_Profiles_Backup_tmp2
		tar --exclude='./.brew' --exclude='./Library' --exclude='./Desktop' --exclude='./.tmp' --exclude='./code/1337RANK.io' --exclude='./Applications' --exclude='./backup-session-1337' -cf goinfre/backup/backup_session_1337_$DATE.tar * .*
		cd ~/ && cd goinfre && cd backup && cd gcl$DATE
		mv ../backup_session_1337_$DATE.tar .
		echo "\033[43;mCompression the backup using xz..\033[0m"
		xz -9 backup_session_1337_$DATE.tar
		echo "\033[42;m  Compression is done  \033[0m"
		echo "\033[44;mUse xz --decompress to unzip it)\033[0m"
		git add backup_session_1337_$DATE.tar.xz && git commit -m "backup $DATE" && git push
		cd ~/ && cd goinfre && rm -rf backup Firefox_Profiles_Backup_tmp
		#If you prefer using a dmg image to backup, just uncomment the line below
		#hdiutil create -fs HFS+ -srcfolder ~/.tmp/$BACKUPNAME -volname Backup_1337_$DATE backup_session_1337_$DATE.dmg
		sleep 1800s
done


