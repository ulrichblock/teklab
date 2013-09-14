#!/bin/bash
: '~§03842z42=G5W88[%61&8c3443
¾:51!2b_k727KQ25{7(12Z5F8)VM¾+
;zQ£2½3G:9Oa0&21¤038[¤dLH!2[[½
-_[1{/?Rg8~0(38}9*x6BRG&y9Z541
¾/)3[q1Xwmc=[2?6N4??ei:683M105
*½{4Mx6Kse(Y5w¤$vG4:&+1f%$4p60
§£b7g)?y5x[h6_3TfGV£J£a*6T95Z6
.01v39[4-?Dnju02QxS&20&I7)WK9E
¤O%0)g?-4432J2m4?c:M([f586fv*M
%1RO439]HP£o*zec6?6uOfcD,I0_3g
e&£2cJJ62VUrs845D?2s(}0)}8EvG1
-o/&cj7o&&uT0t+m+3}R&c/Lf$nk%S
n(13?05N8:06w50*743uh-q+hMR08/
)%)f.d1V3§26ya27&£9M0§5$H&sKMH
w[2M2:6d688B4Y5m$O637*zHC443!o
}cu½1]9[O${3DMcl9y6(aIT$7:$kX£
F+I9HK-2n0709(GltP4d99jg2V£R45
?20e£21fE5lI2)K,&!N;19Zi!§O]I0
O£?v+3¾&1HLKZ2G{¤/q?[3?3=(NUPm
$-933c.8{7+N=99+,daf_{FPcpov3R
X?77kS%7+2SQ056xz77l½=0k(6q3£h
£r3:-£8z1(S%7W0*v¾Q14)29½Q¤+Yq
7!_£)4621U;?V..A:oA30HU0W03&02
FuwqNo:D?(~4X1e9{/eX-%36§70t-¤
69½}dqd+¤7¾0pfGz1m2L66JDcRal7)
-g0u-C0C%257p2¾87¾{2O0)Sq2n5Y5
524?2x£0]2*{[]5b?)A=!W}2O]6CS(
7G*b&322Y49L6*j7&59*Eim6z%14£0
4J2c$9WjE!&m0(xU=¤BSn1%ly*1H61
&8D_e{208?N/+-4M¤B7795W09;0)31
3Bm2}2)1!2!P55{-JZ739W(525P*}*
4t7)![1]70)0s8x1V£;NfuP,z(570U
278!KN&Y_§50¾(?)zp6½0{y}920q4}
V92?y+7?0gz23?R§i+]0N205{k58Fz
{+K:24}p578d12(H6+1y}zo8£o{v)k
VQ£7WE8£o8F?Bu+01nlt§Y¤6{32u2r
~£43w&A?1%01MY8XS(gr7D¤zM$P{K2
bqd1U7wh3V3)D+21177bZ6]!14[354
.{YX)1r9{?5000h_4ijM£IY½31h0H5
9t[2PH4F¤)8=c80¾/03X3f2*4(O196
{j68R$[1B63g2N06-6&0s74{n5)+n¤
                              '
function red_msg() {
	echo -e "\\033[31;1m${@}\033[0m"
}

function green_msg() {
	echo -e "\\033[32;1m${@}\033[0m"
}

function yellow_msg() {
	echo -e "\\033[33;1m${@}\033[0m"
}

function blue_msg() {
	echo -e "\\033[34;1m${@}\033[0m"
}

function magenta_msg() {
	echo -e "\\033[35;1m${@}\033[0m"
}

function cyan_msg() {
	echo -e "\\033[36;1m${@}\033[0m"
}

IMVERSION="1.9.2"
LICENCE=`wget -q -O - http://programme.ulrich-block.de/licence.php?p=i`
if [ "$LICENCE" != "Ich habe bezahlt" ]; then
	red_msg "Invalid licence for this server. Please contact the author."
	exit 0
fi
#IMBINPATH=`readlink -f $0`
#HOME=`dirname $IMBINPATH`
HOME=$PWD
if [ -f $HOME/im_config/image_manager.config ]; then
	source $HOME/im_config/image_manager.config
fi
SERVERNAME="$2"
KUERZEL="$3"
FORCE="$4"
INPUTARRAY=($*)
CONFIGDIR="$HOME/im_config"
MAPFOLDER="$HOME/im_maps"
ADDONFOLDER="$HOME/im_addons"
SERVERDIR="$HOME/im_server"
TEMPDIR="$HOME/im_temp"
LOGDIR="$HOME/im_logs"
IMLOG="$HOME/im_logs/image_manager.log"

if [[ -d $MAPFOLDER && -d $ADDONFOLDER && -d $HOME/im_config ]]; then
 FAIL2=0
 if [ ! -f "$CONFIGDIR/games_installed.list" ]; then red_msg "The file $CONFIGDIR/games_installed.list does not exist"; FAIL2=1; fi
 if [ ! -f "$CONFIGDIR/maps_installed.list" ]; then red_msg "The file $CONFIGDIR/maps_installed.list does not exist"; FAIL2=1; fi
 if [ ! -f "$CONFIGDIR/addons_installed.list" ]; then red_msg "The file $CONFIGDIR/addons_installed.list does not exist"; FAIL2=1; fi
 if [ ! -f "$CONFIGDIR/games_available.list" ]; then red_msg "The file $CONFIGDIR/games_available.list does not exist"; FAIL2=1; fi
 if [ "$FAIL2" -gt "0" ]; then red_msg "Please fix the the error(s) first."; red_msg "shutting down"; sleep 1; exit 0; fi
 INSTALLED=`cat $CONFIGDIR/games_installed.list | awk -F: '{print $2}' | sort -r`
 INSTALLEDMAPS=`cat $CONFIGDIR/maps_installed.list | awk -F: '{print $1":"$2}'`
 INSTALLEDADDONS=`cat $CONFIGDIR/addons_installed.list | awk -F: '{print $1":"$2}'`
 AVAILABLE1=`cat $CONFIGDIR/games_available.list | grep $SERVERNAME: | awk -F: '{print $1}'`
 AVAILABLE2=`cat $CONFIGDIR/games_available.list | grep $SERVERNAME: | awk -F: '{print $2}'`
 AVAILABLE3=`cat $CONFIGDIR/games_installed.list | grep $SERVERNAME: | awk -F: '{print $1}'`
fi
KUERZELS=($(echo $KUERZEL | sed 's/-/ /g'))
KUERZELCOUNT=${#KUERZELS[@]}
if [ "$KUERZELCOUNT" -le "2" ]; then
	PROTECTED=`echo "$KUERZEL" | awk -F- '{print $2}'`
	PROTECTED2=`echo "$KUERZEL" | awk -F- '{print $1}'`
else
	PROTECTED=`echo "$KUERZEL" | awk -F- '{print $'$KUERZELCOUNT'}'`
	CORCOUNT=$[KUERZELCOUNT-2]
	i=0
	while [ $i -le $CORCOUNT ]; do 
		if [ -z $PROTECTED2 ]; then
			PROTECTED2=`echo "$KUERZEL" | awk -F- '{print $1}'`
		else
			PROTECTED2=$PROTECTED2-${KUERZELS[$i]}
		fi
		i=$[i+1]
	done
fi
TEKLABGROUP="users"

function initeins {
if [ "`id -u`" != "0" ]; then
 red_msg "You need to be root, to to use this function"
 exit 0
fi
}

function initzwei {
if [ "`id -u`" == "0" ]; then
 red_msg "You can not run the image_manager as root"
 exit 0
fi
}

function initdrei {
FAIL=0
if [ -z "$SERVERNAME" ]; then red_msg "You forgot to use a steamshorten that is used for the steam update tool like cstrike, or dods. 
Note: instead of \"Counter-strike Source\" you have to use css"; FAIL=1; fi
if [ -z "$KUERZEL" ]; then red_msg "You forgot to use a Teklab shorten like cs, css, or dods"; FAIL=1; fi
if [ -n "$SERVERNAME" ]; then
if [ "$SERVERNAME" == "$AVAILABLE1" ] || [ "$SERVERNAME" == "$AVAILABLE3" ]; then 
	sleep 1
	yellow_msg "Starting..."
else
	red_msg "The game $SERVERNAME you choose does not exits! Please use one of these or install a nonsteam game:
"; cat $CONFIGDIR/games_available.list | awk -F: '{print $1}'; FAIL=1; fi
fi
if [ "$FAIL" -gt "0" ]; then red_msg "Please fix the the error(s) first."; red_msg "shutting down"; sleep 1; exit 0; fi
}

function check_folders {
FAIL=0
if [ ! -d "$HOME/im_logs" ]; then mkdir -p $HOME/im_logs; yellow_msg "The folder $HOME/im_logs does not exist. I will try to create one for you."; FAIL=1; fi
if [ ! -d "$HOME/im_maps" ]; then mkdir -p $HOME/im_maps; yellow_msg "The folder $HOME/im_maps does not exist. I will try to create one for you."; FAIL=1; fi
if [ ! -d "$HOME/im_addons" ]; then mkdir -p $HOME/im_addons ; yellow_msg "The folder $HOME/im_addons does not exist. I will try to create one for you."; FAIL=1; fi
if [ ! -d "$HOME/im_config" ]; then mkdir -p $HOME/im_config ; yellow_msg "The folder $HOME/im_config does not exist. I will try to create one for you."; FAIL=1; fi
if [ ! -d "$HOME/im_server" ]; then mkdir -p $HOME/im_server ; yellow_msg "The folder $HOME/im_server does not exist. I will try to create one for you."; FAIL=1; fi
if [ ! -d $HOME/im_images/addons ]; then mkdir -p $HOME/im_images/addons ; yellow_msg "The folder $HOME/im_images/addons does not exist. I will try to create one for you."; FAIL=1; fi
if [ ! -d $HOME/im_images_files/addons ]; then mkdir -p $HOME/im_images_files/addons ; yellow_msg "The folder $HOME/im_images_files/addons does not exist. I will try to create one for you."; FAIL=1; fi
if [ "$FAIL" -gt "0" ]; then yellow_msg "Please check if the error(s) have been fixed and rerun the image manager."; red_msg "shutting down"; sleep 1; exit 0; fi
}

function check_config {
check_folders
FAIL=0
if [ ! -f "$CONFIGDIR/games_installed.list" ]; then red_msg "The file $CONFIGDIR/games_installed.list does not exist"; FAIL=1; fi
if [ ! -f "$CONFIGDIR/maps_installed.list" ]; then red_msg "The file $CONFIGDIR/maps_installed.list does not exist"; FAIL=1; fi
if [ ! -f "$CONFIGDIR/addons_installed.list" ]; then red_msg "The file $CONFIGDIR/addons_installed.list does not exist"; FAIL=1; fi
if [ ! -f "$CONFIGDIR/games_available.list" ]; then red_msg "The file $CONFIGDIR/games_available.list does not exist"; FAIL=1; fi
if [ -z "$HOME" ]; then red_msg "The command \"pwd\" can not be used"; FAIL=1; fi
if [ -z "$MASTERUSER" ]; then
	FAIL=1
	yellow_msg "The CVAR MASTERUSER does not exist. I will try to fix that for you."
	echo "MASTERUSER=\"`id -un`\"" >> $HOME/im_config/image_manager.config
fi
if [ -z "$CONFIGDIR" ]; then
	FAIL=1
	yellow_msg "The CVAR CONFIGDIR does not exist. I will try to fix that for you."
	echo "CONFIGDIR=\"$HOME/im_config\"" >> $HOME/im_config/image_manager.config
fi
if [ -z "$IMAGEDIR" ]; then
	FAIL=1
	yellow_msg "The CVAR IMAGEDIR does not exist. I will try to fix that for you."
	echo "IMAGEDIR=\"$HOME/im_images\"" >> $HOME/im_config/image_manager.config
fi
if [ -z "$FILEIMAGEDIR" ]; then
	FAIL=1
	yellow_msg "The CVAR FILEIMAGEDIR does not exist. I will try to fix that for you."
	echo "FILEIMAGEDIR=\"$HOME/im_images_files\"" >> $HOME/im_config/image_manager.config
fi
if [ -z "$AUTOUPDATE" ]; then
	FAIL=1
	yellow_msg "The CVAR AUTOUPDATE does not exist. I will try to fix that for you."
	echo "AUTOUPDATE=\"0\"" >> $HOME/im_config/image_manager.config
fi
if [ "$FAIL" -gt "0" ]; then yellow_msg "Please check if the error(s) have been fixed and rerun the image manager."; red_msg "shutting down"; sleep 1; exit 0; fi
}

function updateim {
	if [ "$AUTOUPDATE" == "0" ]; then
		if [ "$RUNUPDATE" == "1" ]; then
			AUTOUPDATE=1
		fi
	fi
	if [ "$AUTOUPDATE" == "1" ]; then
		yellow_msg "Checking for updates"
		CURRENTFDLVERSION=`wget -q -O - http://programme.ulrich-block.de/im_version.php?f=current`
		if [ -z $CURRENTFDLVERSION ]; then
			red_msg "The licenceserver did not reply the current Image Manager version. Please contact the author"
			echo "`date`: The licenceserver did not reply the current Image Manager version. Please contact the author" >> $IMLOG
		elif [ "$IMVERSION" != "$CURRENTFDLVERSION" ]; then
			cd $HOME
			if [ -f $HOME/image_manager.tar ]; then
				rm $HOME/image_manager.tar
			fi
			yellow_msg "Downloading new version"
			wget -q http://programme.ulrich-block.de/download/`uname -m`/image_manager.tar
			if [ -f image_manager.tar ]; then
				if [ -f $HOME/$0.old ]; then
					mv $HOME/$0.old $HOME/$0.old.2
				fi
				if [ -f $HOME/$0.old2 ]; then
					rm $HOME/$0.old.2
				fi
				mv $HOME/$0 $HOME/$0.old
				tar xf image_manager.tar
				rm image_manager.tar
				chmod +x image_manager
				echo "`date`: Updated the Image Manager" >> $IMLOG
				green_msg "Updated the Image Manager. Please rerun the Image Manager"
				exit 0
			else
				red_msg "Could not download the new version"
			fi
		else
			green_msg "Image Manager is up to date"
		fi
	fi
}

function install_im {
cyan_msg "Please enter the name of the master and imageuser"
read INSTALLMASTER
if [ "`grep \"$INSTALLMASTER:\" /etc/passwd | awk -F ":" '{print $1}'`" != "$INSTALLMASTER" ]; then
	if [ -d /home/$INSTALLMASTER ]; then
		useradd -g $TEKLABGROUP -d /home/$INSTALLMASTER -s /bin/bash $INSTALLMASTER
	else
		useradd -g $TEKLABGROUP -b /home -s /bin/bash $INSTALLMASTER
	fi
	passwd $INSTALLMASTER
else
	yellow_msg "User found setting group \"users\" as mastegroup"
	usermod -g $TEKLABGROUP $INSTALLMASTER
fi
sleep 1
yellow_msg "Creating folders and files"
mkdir -p /home/$INSTALLMASTER/im_addons
mkdir -p /home/$INSTALLMASTER/im_config
mkdir -p /home/$INSTALLMASTER/im_images/addons
mkdir -p /home/$INSTALLMASTER/im_images_files/addons
mkdir -p /home/$INSTALLMASTER/im_maps
mkdir -p /home/$INSTALLMASTER/im_server
mkdir -p /home/$INSTALLMASTER/im_temp
mkdir -p /home/$INSTALLMASTER/im_logs
touch /home/$INSTALLMASTER/im_config/addons_installed.list
echo 'css:"Counter-Strike Source":
ageofchivalry:"Age of Chivalry":
diprip:"Dip Rip":
dods:"Day of Defeat Source":
dystopia:"Dystopia":
esmod:"Eternal Silence":
garrysmod:"Garrys Mod":
hl2mp:"HL2 Multiplayer":
insurgency:"Insurgency":
left4dead:"Left 4 Dead":
left4dead2:"Left 4 Dead 2":
pvkii:"Pirates, Vikings and Knights II":
smashball:"Smashball":
synergy:"Synergy":
tf:"Team Fortress 2":
zps:"Zombie Panic: Source":
cstrike:"Counter-Strike":
cstrike_beta:"Counter-Strike Beta":
czero:"Counter-Strike Condition Zero":
dmc:"Death Match Classic":
dod:"Day of Defeat":
ricochet:"Ricochet"
tfc:"team Fortess Classic":
aliensvspredator:"Alien versus Predator":
darkesthour:"Darkest Hour: Europe 44-45":
darkmessiah:"Dark Messiah":
defencealliance2:"Defence Alliance 2":
killingfloor:"Killingfloor":
marenostrum:"Mare Nostrum":
redorchestra:"Red Orchestra":
serioussamhdse:"Serious Sam the Second Encounter HD":
ship:"The Ship":
sin:"SiN Episodes: Emergence":
tshb:"ThreadSpace: Hyperbole":
' > /home/$INSTALLMASTER/im_config/games_available.list
touch /home/$INSTALLMASTER/im_config/games_installed.list
touch /home/$INSTALLMASTER/im_config/maps_installed.list

cat > /home/$INSTALLMASTER/im_config/image_manager.config <<EOF
MASTERUSER="$INSTALLMASTER"
AUTOUPDATE="0"
EOF

cyan_msg "Please enter the absolute path where the images will be stored. If you leave this filed blank following folders will be used:
/home/$INSTALLMASTER/im_images
/home/$INSTALLMASTER/im_images_files
"
read INSTALLIMAGEFOLDER
if [ "$INSTALLIMAGEFOLDER" != "" ]; then
cat >> /home/$INSTALLMASTER/im_config/image_manager.config <<EOF
IMAGEDIR="$INSTALLIMAGEFOLDER"
FILEIMAGEDIR="$INSTALLIMAGEFOLDER"
EOF
else
cat >> /home/$INSTALLMASTER/im_config/image_manager.config <<EOF
IMAGEDIR="/home/$INSTALLMASTER/im_images"
FILEIMAGEDIR="/home/$INSTALLMASTER/im_images_files"
EOF
fi


cyan_msg "If this server is only used for gameservers do you want to syncronise via ftp or rsync?
The ftp data will be stored as plain text. For Rsync keys in .ssh will used.
You can enter \"no\" \"rsync\" \"ftp\":"
read SLAVEINSTALL
if [ "$SLAVEINSTALL" == "ftp" ]; then
	cyan_msg "Please enter the IP of the server you create the images with"
	read MASTERIP
	cyan_msg "Please enter the password to the masteruser you create your images with"
	read FTPPASSWORD
	mkdir -p /home/$INSTALLMASTER/im_config/.ftp
	echo "$MASTERIP:$FTPPASSWORD" > /home/$INSTALLMASTER/im_config/.ftp/userdata
	echo "SYNC=ftp" >> /home/$INSTALLMASTER/im_config/image_manager.config
elif [ "$SLAVEINSTALL" == "rsync" ]; then
	cyan_msg "Please enter the IP of the server you create the images with"
	read MASTERIP
	cyan_msg "Please enter the SSHPORT of the server you create the images with"
	read MASTERPORT
	mkdir -p /home/$INSTALLMASTER/im_config/.ftp
	echo "$MASTERIP:$MASTERPORT" > /home/$INSTALLMASTER/im_config/.ftp/userdata
	echo "SYNC=rsync" >> /home/$INSTALLMASTER/im_config/image_manager.config
else
	echo "SYNC=none" >> /home/$INSTALLMASTER/im_config/image_manager.config
fi
mv `pwd`/image_manager /home/$INSTALLMASTER/image_manager
cd /home/$INSTALLMASTER/im_server
yellow_msg "Downloading steamupdater"
sleep 1 
wget http://storefront.steampowered.com/download/hldsupdatetool.bin > /dev/null 2>&1
chmod +x hldsupdatetool.bin
./hldsupdatetool.bin
sleep 1
yellow_msg "Downloading latest srcupdatecheck written by Nephyrin"
wget http://nephyrin.net/tools/nemrun/latest/srcupdatecheck > /dev/null 2>&1
wget http://nephyrin.net/tools/nemrun/latest/Readme.txt > /dev/null 2>&1
chmod +x srcupdatecheck
sleep 1 
chown -R $INSTALLMASTER:$TEKLABGROUP /home/$INSTALLMASTER
yellow_msg "Updating the hldsupdatetool with the User $INSTALLMASTER in the screen \"hldsupdate\""
su -c "screen -dmS hldsupdate ./steam -command update" $INSTALLMASTER
}

function replacement {
	yellow_msg "removing gamefiles from old installation: $SERVERDIRS"
	cd $SERVERDIR/$SHORTEN2-master
	if [ ! -f $HOME/im_temp/$SHORTEN2-file.lst ]; then
		find -type f | grep -v "valve\|overviews/\|scripts/\|media/\|particles/\|/sound/\|/hl2/\|/overviews/\|/resource/\|/sprites/\|steam_appid.txt\|gameinfo.txt\|steam.inf\|.vdf\|.cfg\|.gam\|.txt\|.db\|.log" > $HOME/im_temp/$SHORTEN2-file.lst
	fi
	if [ -f $HOME/im_temp/$SHORTEN2-remove.lst ]; then 
		rm $HOME/im_temp/$SHORTEN2-remove.lst
	fi
	cat $HOME/im_temp/$SHORTEN2-file.lst | while read LINE; do
		echo "$SERVERDIRS/$LINE" >> $HOME/im_temp/$SHORTEN2-remove.lst
	done
	cat $HOME/im_temp/$SHORTEN2-remove.lst | while read RMDATEI; do
		rm -rf $RMDATEI
	done
	find $SERVERDIRS -type f -name "steam" -exec rm -r {} \;
	find $SERVERDIRS -type f -name "test1.so" -exec rm -r {} \;
	find $SERVERDIRS -type f -name "test2.so" -exec rm -r {} \;
	find $SERVERDIRS -type f -name "test3.so" -exec rm -r {} \;
	yellow_msg "creating symlinks for the installation: $SERVERDIRS"
	cp -sR $SERVERDIR/$SHORTEN2-master/* $SERVERDIRS/ > /dev/null 2>&1
	echo "`date`: Changed $SERVERDIRS to symlinksystem" >> $IMLOG
	yellow_msg "Setting up chmods"
	find $SERVERDIRS -type d  | while read SERVERDIRS2; do
		chmod 770 "$SERVERDIRS2"
	done
	chown -R $USERNAME:$TEKLABGROUP $SERVERDIRS
	green_msg "The files in $SERVERDIRS have been replaced with symlinks"
}

function replacement2 {
	USERNAME=$(echo $SERVERDIRS | awk -F/ '{print $3}')
	find $SERVERDIRS -type f -name gameinfo.txt | while read GAMEINFO; do
		GAMEINSTALLED=`cat $GAMEINFO | grep -v // | grep -v "|" | grep "game" | awk -F'"' '{ print $2 }'`
		if [ -n "$GAMEINSTALLED" ]; then
				SHORTEN=`cat $CONFIGDIR/games_available.list | grep "$GAMEINSTALLED\":" | awk -F: '{ print $1 }'`
				SHORTEN2=`cat $CONFIGDIR/games_installed.list | grep "$SHORTEN" | awk -F: '{ print $2 }'`
		fi
		if [ -n "$SHORTEN2" ]; then
			replacement
		fi
	done
	find $SERVERDIRS -type f -name liblist.gam | while read GAMEINFO; do
		GAMEINSTALLED=`head -n 1 $GAMEINFO | awk -F'"' '{ print $2 }'`
		if [-n "$GAMEINSTALLED" ]; then
			SHORTEN=`cat $CONFIGDIR/games_available.list | grep "$GAMEINSTALLED\":" | awk -F: '{ print $1 }'`
			SHORTEN2=`cat $CONFIGDIR/games_installed.list | grep "$SHORTEN" | awk -F: '{ print $2 }'`
		fi
		if [ -n "$SHORTEN2" ]; then
			replacement
		fi
	done
}

function install_im_replace {
if [ "$SERVERNAME" != "" ]; then
	if [ ! -d /home/$SERVERNAME/server ]; then
		red_msg "You need to enter a existing User"
		exit 0
	fi
	COUNTDIRS=${#INPUTARRAY[@]}
	if [ "$COUNTDIRS" == "2" ]; then
		find /home/$SERVERNAME/server -mindepth 1 -maxdepth 1 -type d -group $TEKLABGROUP | while read SERVERDIRS; do
			yellow_msg "Found the server $SERVERDIRS"
			cyan_msg "Enter \"yes\" to change them into symlinks:"
			read ANSWER < /dev/tty
			if [ "$ANSWER" == "yes" ]; then
				replacement2
			else
				red_msg "Folder $SERVERDIRS skipped by the user"
				echo ""
			fi
		done
	else
		CORCOUNT=$[COUNTDIRS-1]
		DISALLOWEDOVERRIDE=1
		i=2
		while [ $i -le $CORCOUNT ]; do
			SERVERDIRS=/home/$SERVERNAME/server/${INPUTARRAY[$i]}
			if [ -d $SERVERDIRS ]; then
				cyan_msg "Enter \"yes\" to change $SERVERDIRS into symlinks:"
				read ANSWER
				if [ "$ANSWER" == "yes" ]; then
					replacement2
				else
					red_msg "Folder $SERVERDIRS skipped by the user"
					echo ""
				fi
			else
				echo ""
				red_msg "Error:"
				red_msg "Could not find the folder $SERVERDIRS"
			fi
			i=$[i+1]
		done	
	fi
else
	cyan_msg "Do you really want to change all installations to symlinks? Enter \"yes\" if you are sure:"
	read ANSWER
	if [ "$ANSWER" != "yes" ]; then
		red_msg "Aborted by the user"
		sleep 1
		exit 0
	fi
	find /home/*/server -mindepth 1 -maxdepth 1 -type d -group $TEKLABGROUP | while read SERVERDIRS; do
		yellow_msg "Found the server $SERVERDIRS"
		cyan_msg "Enter \"yes\" to change them into symlinks:"
		read ANSWER < /dev/tty
		if [ "$ANSWER" == "yes" ]; then
			replacement2
		else
			red_msg "Folder $SERVERDIRS skipped by the user"
			echo ""
		fi
	done
fi
}

function installed_list {
if [ -f $TEMPDIR/games_installed.tmp ]; then
	 rm $TEMPDIR/games_installed.tmp
fi
cat $CONFIGDIR/games_installed.list > $TEMPDIR/games_installed.tmp
echo "$SERVERNAME:$KUERZEL:$AVAILABLE2:$STEAM" >> $TEMPDIR/games_installed.tmp
sort $TEMPDIR/games_installed.tmp > $CONFIGDIR/games_installed.list
rm $TEMPDIR/games_installed.tmp
echo "`date`: Installed $SERVERNAME:$KUERZEL" >> $IMLOG
}

function no_steam_add {
cd $SERVERDIR
SERVERAVAILABLE=$(ls | grep master)
yellow_msg "Following non steam servers are available but not installed:"
for NEW in $SERVERAVAILABLE; do
	KUERZELS=($(echo $NEW | sed 's/-/ /g'))
	KUERZELCOUNT=${#KUERZELS[@]}
	if [ "$KUERZELCOUNT" -le "2" ]; then
		SHORTEN=$(echo $NEW | awk -F- '{print $1}')
		if [[ ! `cat $CONFIGDIR/games_installed.list | grep $SHORTEN:` ]]; then
			green_msg "$SHORTEN"
		fi
	else
		CORCOUNT=$[KUERZELCOUNT-2]
		i=1
		while [ $i -le $CORCOUNT ]; do 
			if [ -z $SHORTEN ]; then
				SHORTEN=$(echo "$NEW" | awk -F- '{print $1}')
			else
				SHORTEN=$SHORTEN-${KUERZELS[$i]}
			fi
			i=$[i+1]
		done
		if [[ ! `cat $CONFIGDIR/games_installed.list | grep $SHORTEN:` ]]; then
			green_msg "$SHORTEN"
		fi
	fi
done
cyan_msg "Please enter the name of the server you want to install:"
read SERVERINSTALL
if [ -z $SERVERINSTALL ]; then
	red_msg "You need to enter a servername"
	exit 0
elif [ -d $SERVERDIR/$SERVERINSTALL-image ]; then
	red_msg "The server already exist"
	exit 0
elif [ ! -d $SERVERDIR/$SERVERINSTALL-master ]; then
	red_msg "Please enter a valid servername"
	exit 0
fi
mkdir -p $SERVERDIR/$SERVERINSTALL-image
find $SERVERDIR/$SERVERINSTALL-image -type d -print0 | xargs -0 chmod 770
mkdir -p $MAPFOLDER/$SERVERINSTALL-master
mkdir -p $MAPFOLDER/$SERVERINSTALL-image
mkdir -p $ADDONFOLDER/$SERVERINSTALL-master
mkdir -p $ADDONFOLDER/$SERVERINSTALL-image
touch $SERVERDIR/$SERVERINSTALL-master/InstallRecord.blob
STEAM="nosteam"
KUERZEL="$SERVERINSTALL"
SERVERNAME="$SERVERINSTALL"
AVAILABLE2="$SERVERINSTALL"
FORCE="f"
installed_list
imagesymlinks
image_update
hash_update
}


function no_steam_add_p {
cd $SERVERDIR
SERVERAVAILABLE=`ls | grep master | awk -F- '{ print $1 }'`
yellow_msg "Following non steam servers are available and no protected server is installed:"
cat $CONFIGDIR/games_installed.list | grep :nosteam | while read LINE; do
	P1=`echo $LINE | awk -F: '{print $2}'`
	KUERZELS=($(echo $P1 | sed 's/-/ /g'))
	KUERZELCOUNT=${#KUERZELS[@]}
	P2=`echo $P1 | awk -F- '{print $'$KUERZELCOUNT'}'`
	if [[ "$P2" != "p" && ! `cat $CONFIGDIR/games_installed.list | grep $P1-p:` ]]; then
		green_msg "$P1"
	fi
done
cyan_msg "Please enter the name of the server you want to install:"
read SERVERINSTALL
if [ -z $SERVERINSTALL ]; then
	red_msg "You need to enter a servername"
	exit 0
elif [ ! -d $SERVERDIR/$SERVERINSTALL-master ]; then
	red_msg "Please enter a valid servername"
	exit 0
fi
mkdir -p $MAPFOLDER/$SERVERINSTALL-p-master
mkdir -p $ADDONFOLDER/$SERVERINSTALL-p-master
mkdir -p $MAPFOLDER/$SERVERINSTALL-p-image
mkdir -p $ADDONFOLDER/$SERVERINSTALL-p-image
if [ -f $SERVERDIR/$SERVERINSTALL-master/InstallRecord.blob ]; then
	touch $SERVERDIR/$SERVERINSTALL-master/InstallRecord.blob
fi
SERVERNAME=$SERVERINSTALL
KUERZEL=$SERVERINSTALL-p
AVAILABLE2=$SERVERINSTALL
PROTECTED="p"
PROTECTED2=$SERVERINSTALL
STEAM="nosteam"
FORCE="f"
installed_list
imagesymlinks
image_update
hash_update
}

function no_steam_update {
FORCE="f"
cat $CONFIGDIR/games_installed.list | grep :nosteam | while read LINE; do
	KUERZEL=`echo $LINE | awk -F: '{print $2}'`
	PROTECTED=`echo $P1 | awk -F- '{print $2}'`
	PROTECTED2=`echo $P1 | awk -F- '{print $1}'`
	imagesymlinks
	image_update
	hash_update
done
}

function no_steam_delete {
cd $SERVERDIR
SERVERAVAILABLE=`ls | grep master | awk -F- '{ print $1 }'`
yellow_msg "Following servers are installed:"
cat $CONFIGDIR/games_installed.list | grep :nosteam | while read LINE; do
	green_msg $LINE | awk -F: '{print $2}'
done
cyan_msg "Please enter the servername you want to remove"
read AUSWAHL
if [ -z $AUSWAHL ]; then
	red_msg "You need to enter a servername"
	exit 0
elif [[ ! -d $SERVERDIR/$AUSWAHL-master && ! -d $SERVERDIR/$AUSWAHL-image ]]; then
	red_msg "Please enter a valid servername"
	exit 0
fi
rm -rf $SERVERDIR/$AUSWAHL-image $IMAGEDIR/$AUSWAHL.* $IMAGEDIR/addons/$AUSWAHL.*
grep -v $AUSWAHL: $CONFIGDIR/games_installed.list > $TEMPDIR/games_installed.tmp
sort $TEMPDIR/games_installed.tmp > $CONFIGDIR/games_installed.list
rm $TEMPDIR/games_installed.tmp
}


function no_steam {
cyan_msg "Please enter your action (add, protected, update, delete):"
read CASE
if [ "$CASE" = "add" ]; then
	no_steam_add
elif [ "$CASE" = "protected" ]; then
	no_steam_add_p
elif [ "$CASE" = "update" ]; then
	no_steam_update
elif [ "$CASE" = "delete" ]; then
	no_steam_delete
else
	red_msg "Please enter a valid action"
fi
}


function no_steam_add_game {
cd $SERVERDIR
SERVERAVAILABLE=`ls | grep master | awk -F- '{ print $1 }'`
yellow_msg "Following non steam servers are available but not installed:"
for NEW in $SERVERAVAILABLE; do
	if [[ ! `cat $CONFIGDIR/games_installed.list | grep $NEW:` ]]; then
		green_msg "$NEW"
	fi
done
cyan_msg "Please enter the name of the server you want to install:"
read SERVERINSTALL
if [ -z $SERVERINSTALL ]; then
	red_msg "You need to enter a servername"
	exit 0
elif [ ! -d $SERVERDIR/$SERVERINSTALL-master ]; then
	red_msg "Please enter a valid servername"
	exit 0
fi
mkdir -p $MAPFOLDER/$SERVERINSTALL-master
mkdir -p $ADDONFOLDER/$SERVERINSTALL-master
mkdir -p $MAPFOLDER/$SERVERINSTALL-image
mkdir -p $ADDONFOLDER/$SERVERINSTALL-image
touch $SERVERDIR/$SERVERINSTALL-master/InstallRecord.blob
SERVERNAME=$SERVERINSTALL
KUERZEL=$SERVERINSTALL
AVAILABLE2=$SERVERINSTALL
STEAM="nosteam"
installed_list
}


function no_steam_delete_game {
cd $SERVERDIR
SERVERAVAILABLE=`ls | grep master | awk -F- '{ print $1 }'`
yellow_msg "Following non steam servers are installed:"
for NEW in $SERVERAVAILABLE; do
	if [[ `cat $CONFIGDIR/games_installed.list | grep $NEW:` ]]; then
		INSTALLED1=`cat $CONFIGDIR/games_installed.list | grep $NEW: | awk -F: '{print $1}'`
		INSTALLED3=`cat $CONFIGDIR/games_installed.list | grep $NEW: | awk -F: '{print $3}'`
		if [[ "$INSTALLED1" = "$INSTALLED3" && "$NEW" = "$INSTALLED3" ]]; then
			green_msg "$NEW"
		fi
	fi
done
cyan_msg "Please enter the servername you want to remove"
read AUSWAHL
if [ -z $AUSWAHL ]; then
	red_msg "You need to enter a servername"
	exit 0
elif [ ! -d $SERVERDIR/$AUSWAHL-master ]; then
	red_msg "Please enter a valid servername"
	exit 0
fi
rm -rf $MAPFOLDER/$AUSWAHL-master
rm -rf $ADDONFOLDER/$AUSWAHL-master
grep -v $AUSWAHL: $CONFIGDIR/games_installed.list > $TEMPDIR/games_installed.tmp
sort $TEMPDIR/games_installed.tmp > $CONFIGDIR/games_installed.list
rm $TEMPDIR/games_installed.tmp
}


function no_steam_game {
cyan_msg "Please enter the action you want to do (add, delete):"
read CASE
if [ "$CASE" = "add" ]; then
	no_steam_add_game
elif [ "$CASE" = "delete" ]; then
	no_steam_delete_game
else
	red_msg "Please enter a vaild action"
fi
}


function masterserver_update {
cd $SERVERDIR
if [ ! -d $SERVERDIR/$KUERZEL-master ]; then
	if ([ "$(echo $PROTECTED | grep 'p\|tv')" != "" ] && [ -d $SERVERDIR/$PROTECTED2-master ] && [ ! -d $SERVERDIR/$KUERZEL-image ]); then
		mkdir -p $SERVERDIR/$KUERZEL-image
		STEAM="nosteam"
		installed_list
		if [ ! -d $MAPFOLDER/$KUERZEL-master ]; then mkdir -p $MAPFOLDER/$KUERZEL-master; fi
		if [ ! -d $MAPFOLDER/$KUERZEL-image ]; then mkdir -p $MAPFOLDER/$KUERZEL-image; fi
		if [ ! -d $ADDONFOLDER/$KUERZEL-master ]; then mkdir -p $ADDONFOLDER/$KUERZEL-master; fi
		if [ ! -d $ADDONFOLDER/$KUERZEL-image ]; then mkdir -p $ADDONFOLDER/$KUERZEL-image; fi
	elif ([ "$(echo $PROTECTED | grep 'p\|tv')" != "" ] && [ ! -d $SERVERDIR/$PROTECTED2-master ]); then
		echo "$SERVERDIR/$PROTECTED2-master"
		echo "You are trying to create a protected server without having a non protected. Please install the normal server for the game first"
		exit 0
	elif [ "$PROTECTED" != "p" ]; then
		mkdir -p $SERVERDIR/$KUERZEL-master
		mkdir -p $SERVERDIR/$KUERZEL-image
		mkdir -p $MAPFOLDER/$KUERZEL-master
		mkdir -p $MAPFOLDER/$KUERZEL-image
		mkdir -p $ADDONFOLDER/$KUERZEL-master
		mkdir -p $ADDONFOLDER/$KUERZEL-image
		STEAM="steam"
		installed_list
	fi
fi 
if [ "$(echo $PROTECTED | grep 'p\|tv')" != "" ]; then
	FORCE="f"
	imagesymlinks
	image_update
	hash_update
elif [ "$SERVERNAME" = "css" ]; then
	if [ "$(screen -ls | grep \"$KUERZEL.update\" | awk '{print $1}' | awk -F "." '{print $2}')" == "$KUERZEL.update" ]; then
		red_msg "An update with the screen name \"$KUERZEL.update\" is already in progress"
	else
		echo "#!/bin/bash


./steam -command update -retry
./steam -command update -game \"Counter-Strike Source\" -dir $SERVERDIR/$KUERZEL-master -verify_all -retry > $LOGDIR/$KUERZEL-update.log
cd $HOME
./image_manager update_image $SERVERNAME $KUERZEL" > $HOME/im_temp/$KUERZEL.update.sh
		if [[ `cat $CONFIGDIR/games_installed.list | grep "$KUERZEL-p:"` ]]; then
			echo "./image_manager update_image $SERVERNAME $KUERZEL-p" >> $HOME/im_temp/$KUERZEL.update.sh
		fi
		if [[ `cat $CONFIGDIR/games_installed.list | grep "$KUERZEL-tv:"` ]]; then
			echo "./image_manager update_image $SERVERNAME $KUERZEL-tv" >> $HOME/im_temp/$KUERZEL.update.sh
		fi
		chmod +x $HOME/im_temp/$KUERZEL.update.sh
		screen -dmS $KUERZEL.update $HOME/im_temp/$KUERZEL.update.sh
		green_msg "Updating/Installing the server in the screen $KUERZEL.update. Depending on your an Valve´s connection this can take a while. If you want to see the progress open the $KUERZEL-update.log in the im_logs directory"
	fi
else
	if [ "$(screen -ls | grep \"$KUERZEL.update\" | awk '{print $1}' | awk -F "." '{print $2}')" == "$KUERZEL.update" ]; then
		red_msg "An update with the screen name \"$KUERZEL.update\" is already in progress"
	else
		echo "#!/bin/bash


./steam -command update -retry
./steam -command update -game $SERVERNAME -dir $SERVERDIR/$KUERZEL-master -verify_all -retry > $LOGDIR/$KUERZEL-update.log
cd $HOME
./image_manager update_image $SERVERNAME $KUERZEL" > $HOME/im_temp/$KUERZEL.update.sh
		if [[ `cat $CONFIGDIR/games_installed.list | grep $KUERZEL-p:` ]]; then
			echo "./image_manager update_image $SERVERNAME $KUERZEL-p" >> $HOME/im_temp/$KUERZEL.update.sh
		fi
		chmod +x $HOME/im_temp/$KUERZEL.update.sh
		screen -dmS $KUERZEL.update $HOME/im_temp/$KUERZEL.update.sh
		green_msg "Updating/Installing the server in the screen $KUERZEL.update. Depending on your an Valve´s connection this can take a while. If you want to see the progress open the $KUERZEL-update.log in the im_logs directory"
	fi
 fi
}

function imagesymlinks2 {
if [ "`echo $PROTECTED | grep 'p\|tv'`" != "" ]; then
	cd $SERVERDIR/$PROTECTED2-master
else
	cd $SERVERDIR/$KUERZEL-master
fi
if [ -f $HOME/im_temp/$KUERZEL-userfilesmove.lst ]; then 
	rm $HOME/im_temp/$KUERZEL-userfilesmove.lst
fi
find -type f -name "*.vdf" -o -name "*.cfg" -o -name "*.gam" -o -name "*.txt" -o -name "*.log" -o -name "*.smx" -o -name "*.sp" -o -name "*.db" | sed -e 's/\.\///g' > $HOME/im_temp/$KUERZEL-userfiles.lst
cat $HOME/im_temp/$KUERZEL-userfiles.lst | grep -v "valve\|overviews/\|scripts/\|media/\|particles/\|gameinfo.txt\|steam.inf\|/sound/\|steam_appid.txt\|/hl2/\|/overviews/\|/resource/\|/sprites/" > $HOME/im_temp/$KUERZEL-userfiles2.lst
cd ..
cat $HOME/im_temp/$KUERZEL-userfiles2.lst | while read LINE; do
	dirname "$LINE" | while read FOLDER; do
		if [[ ! -d "$SERVERDIR/$KUERZEL-image/$FOLDER" ]]; then
			mkdir -p "$SERVERDIR/$KUERZEL-image/$FOLDER"
		fi
	done
	find "/home/$VARIABLE2/server/$VARIABLE4/$VARIABLE3/$LINE" -type l -delete > /dev/null 2>&1
	if [ ! -f "$SERVERDIR/$KUERZEL-image/$LINE" ]; then	
		if [ "`echo $PROTECTED | grep 'p\|tv'`" != "" ]; then
			cp "$SERVERDIR/$PROTECTED2-master/$LINE" "$SERVERDIR/$KUERZEL-image/$LINE" > /dev/null 2>&1
		else
			cp "$SERVERDIR/$KUERZEL-master/$LINE" "$SERVERDIR/$KUERZEL-image/$LINE" > /dev/null 2>&1
		fi
	fi
done
}
 
function imagesymlinks {
if [ ! -d $SERVERDIR/$KUERZEL-image ]; then
	mkdir $SERVERDIR/$KUERZEL-image
fi
screen -dmS $KUERZEL.delete.badsymlinks find -L $SERVERDIR/$KUERZEL-image/ -type l -exec rm -r {} \;
if [ "$(echo $PROTECTED | grep 'p\|tv')" != "" ]; then
	imagesymlinks2
	cp -sR $SERVERDIR/$PROTECTED2-master/* $SERVERDIR/$KUERZEL-image/ > /dev/null 2>&1
else
	imagesymlinks2
	cp -sR $SERVERDIR/$KUERZEL-master/* $SERVERDIR/$KUERZEL-image/ > /dev/null 2>&1
fi
}

function map_install {
yellow_msg "Following games are installed:"
green_msg "$INSTALLED"
cyan_msg "To which games shall I add a mappackage?:"
read MAPTYPE
if [ -z $MAPTYPE ]; then
	red_msg "Please enter a gamename"
	exit 0
elif [[ ! `echo $INSTALLED | grep $MAPTYPE` ]]; then
	red_msg "Please enter a valid/installed game"
	exit 0
fi
MAPMASTER=`ls $MAPFOLDER/$MAPTYPE-master`
yellow_msg "Following mappages are new but not installed:"
ls $MAPFOLDER/$MAPTYPE-master | while read FOLDER; do
	if [[ ! `cat $CONFIGDIR/maps_installed.list | grep $MAPTYPE:$FOLDER:` ]]; then
		green_msg "$FOLDER"
	fi
done
cyan_msg "Please enter the name of the mappage you want to create a new image:"
read IMAGEFILE
if [ -z $IMAGEFILE ]; then
	red_msg "You need to enter a mappagename"
	exit 0
elif [ "`cat $CONFIGDIR/maps_installed.list | grep $MAPTYPE:$FOLDER:`" != "" ]; then
	red_msg "The image already exist"
	exit 0
elif [ ! -d $MAPFOLDER/$MAPTYPE-master/$IMAGEFILE ]; then
	red_msg "Please enter a valid mappackage name"
	exit 0
fi
touch $MAPFOLDER/$MAPTYPE-master/$IMAGEFILE/map-$IMAGEFILE.blib
mkdir -p $MAPFOLDER/$MAPTYPE-image/$IMAGEFILE
updatemaplist
mapimage_update
} 

function updatemaplist {
if [ -f $CONFIGDIR/maps_installed.list ]; then
	cat $CONFIGDIR/maps_installed.list > $TEMPDIR/maps_installed.temp
	echo "$MAPTYPE:$IMAGEFILE:" >> $TEMPDIR/maps_installed.temp
	sort $TEMPDIR/maps_installed.temp > $CONFIGDIR/maps_installed.list
	echo "`date`: Installed the $IMAGEFILE mappacke for $MAPTPE" >> $IMLOG
else
	red_msg "Please make sure the file $CONFIGDIR/maps_installed.list exists"
	exit 0
fi
}

function mapsymlinks {
if [ ! -d $MAPFOLDER/$MAPTYPE-image/ ]; then
	mkdir -p $MAPFOLDER/$MAPTYPE-image/
fi
if [ -z $IMAGEFILE ]; then
	find -L $MAPFOLDER/$MAPTYPE-image/$IMAGEFILE -type l -exec rm -r {} \;
else
	find -L $MAPFOLDER/$MAPTYPE-image/ -type l -exec rm -r {} \;
fi	
if [ -f $TEMPDIR/$MAPTYPE-$IMAGEFILE-filelist.temp ]; then
	rm $TEMPDIR/$MAPTYPE-$IMAGEFILE-filelist.temp
fi
if [ -f $MAPFOLDER/$MAPTYPE-image/$IMAGEFILE/$IMAGEFILE-maplist.txt ]; then
	rm $MAPFOLDER/$MAPTYPE-image/$IMAGEFILE/$IMAGEFILE-maplist.txt
fi
cp -sR $MAPFOLDER/$MAPTYPE-master/$IMAGEFILE/* $MAPFOLDER/$MAPTYPE-image/$IMAGEFILE/ > /dev/null 2>&1
}
 
function mapimage_update {
if [ -d $MAPFOLDER/$MAPTYPE-image/ ]; then
	if [ -z $REAL ]; then
		yellow_msg "Creating symlinks if necessary"
		mapsymlinks
	fi
	find $MAPFOLDER/$MAPTYPE-master/$IMAGEFILE/ -type f -name *.bsp | while read MAPS; do
		FILE2="${MAPS##*/}"
		echo "$FILE2" | cut -d. -f1 >>  $TEMPDIR/$MAPTYPE-$IMAGEFILE-filelist.temp
	done
	yellow_msg "Creating maplist"
	if [ -z $REAL ]; then
		sort $TEMPDIR/$MAPTYPE-$IMAGEFILE-filelist.temp > $MAPFOLDER/$MAPTYPE-image/$IMAGEFILE/$IMAGEFILE-maplist.txt
	else
		sort $TEMPDIR/$MAPTYPE-$IMAGEFILE-filelist.temp > $MAPFOLDER/$MAPTYPE-master/$IMAGEFILE/$IMAGEFILE-maplist.txt
	fi
	if [ ! -d $IMAGEDIR/addons ]; then
		mkdir -p $IMAGEDIR/addons
	fi
	yellow_msg "Removing old image"
	if [ -z $REAL ]; then
		if [ -f $IMAGEDIR/addons/$MAPTYPE-m-$IMAGEFILE.tar ]; then
			rm $IMAGEDIR/addons/$MAPTYPE-m-$IMAGEFILE.tar
		fi
	else
		if [ -f $FILEIMAGEDIR/addons/$MAPTYPE-m-$IMAGEFILE.tar ]; then
			rm $FILEIMAGEDIR/addons/$MAPTYPE-m-$IMAGEFILE.tar
		fi
	fi
	if [ -z $REAL ]; then
		cd $MAPFOLDER/$MAPTYPE-image/$IMAGEFILE/
	else
		cd $MAPFOLDER/$MAPTYPE-master/$IMAGEFILE/
	fi
	yellow_msg "Creating new image"
	if [ -z $REAL ]; then
		find ./ -type d -print0 | xargs -0 chmod 770
		tar czf $IMAGEDIR/addons/$MAPTYPE-m-$IMAGEFILE.tar .
		find . -type l > $IMAGEDIR/addons/$MAPTYPE-m-$IMAGEFILE.lst
	else
		tar czf $FILEIMAGEDIR/addons/$MAPTYPE-m-$IMAGEFILE.tar .
		find . -type l > $FILEIMAGEDIR/addons/$MAPTYPE-m-$IMAGEFILE.lst
	fi
	green_msg "Image Update for $MAPTYPE-m-$IMAGEFILE successfull!"
	echo "`date`: Updated the $MAPTYPE-m-$IMAGEFILE Image" >> $IMLOG
else
	red_msg "Image Update for $MAPTYPE-a-$IMAGEFILE failed. The folder does not exist!"
	echo "`date`: Could not update the $MAPTYPE-a-$IMAGEFILE Image because the folder does not exist" >> $IMLOG
fi
}

function map_update {
for MAPS in $INSTALLEDMAPS; do
	IMAGEFILE=`echo $MAPS | awk -F ':' '{print $2}'`
	MAPTYPE=`echo $MAPS | awk -F ':' '{print $1}'`
	mapimage_update
done
}

function map_update_file {
yellow_msg "Following games are installed:"
green_msg "$INSTALLED"
cyan_msg "For which games shall I update the mappackage?:"
read MAPTYPE
if [ -z $MAPTYPE ]; then
	red_msg "Please enter a gamename"
	exit 0
elif [[ ! `echo $INSTALLED | grep $MAPTYPE` ]]; then
	red_msg "Please enter a valid/installed game"
	exit 0
fi
yellow_msg "Following mappacks are installed:"
cat $CONFIGDIR/maps_installed.list | grep $MAPTYPE: | while read INSTALLEDMAPS; do
	green_msg "$INSTALLEDMAPS" | awk -F: '{print $2}'
done
cyan_msg "Please enter the name of the package you want to update:"
read IMAGEFILE
if [ -z $IMAGEFILE ]; then
	red_msg "You need to enter a packagename"
	exit 0
elif [ "$IMAGEFILE" = "$MAPTYPE" ]; then
	red_msg "Please enter only the package name"
	exit 0
elif [ ! -d $MAPFOLDER/$MAPTYPE-master/$IMAGEFILE ]; then
	red_msg "Please enter a valid mappackage name"
	exit 0
fi
mapimage_update
}

function removemaplist {
cat $CONFIGDIR/maps_installed.list | grep -v $REMOVEMAP: > $TEMPDIR/maps_installed.temp
sort $TEMPDIR/maps_installed.temp > $CONFIGDIR/maps_installed.list
}

function map_remove {
yellow_msg "Following games are installed:"
green_msg "$INSTALLED"
cyan_msg "For which games shall I remove a mappackage?:"
read MAPTYPE
if [ -z $MAPTYPE ]; then
	red_msg "Please enter a gamename"
	exit 0
elif [[ ! `echo $INSTALLED | grep $MAPTYPE` ]]; then
	red_msg "Please enter a valid/installed game"
	exit 0
fi
yellow_msg "Following mappacks are installed:"
cat $CONFIGDIR/maps_installed.list | grep $MAPTYPE: | while read INSTALLEDMAPS; do
	green_msg "$INSTALLEDMAPS" | awk -F: '{print $2}'
done
cyan_msg "Please enter the name of the package you want to remove:"
read REMOVEMAP
if [ -z $REMOVEMAP ]; then
	red_msg "You need to enter a packagename"
	exit 0
elif [ "$REMOVEMAP" = "$MAPTYPE" ]; then
	red_msg "Please enter only the package name"
	exit 0
elif [ ! -d $MAPFOLDER/$MAPTYPE-image/$IMAGEFILE ]; then
	red_msg "Please enter a valid mappackage name"
	exit 0
fi
rm -rf $MAPFOLDER/$MAPTYPE-image/$REMOVEMAP $IMAGEDIR/addons/$MAPTYPE-m-$REMOVEMAP.tar $IMAGEDIR/addons/$MAPTYPE-m-$REMOVEMAP.lst
removemaplist
echo "`date`: Removed the $REMOVEMAP mappackage" >> $IMLOG
}

function addon_install {
yellow_msg "Following games are installed:"
green_msg "$INSTALLED"
cyan_msg "To which games shall I add a addons?:"
read ADDONTYPE
ADDONTYPE=`echo $ADDONTYPE | tr -d "\r\n" | tr -d '\+\0\b\r' | sed 's/ //g'`
if [ -z $ADDONTYPE ]; then
	red_msg "Please enter a gamename"
	exit 0
elif [[ ! `echo $INSTALLED | grep $ADDONTYPE` ]]; then
	red_msg "Please enter a valid/installed game"
	exit 0
fi
yellow_msg "Following addons are new but not installed:"
ls $ADDONFOLDER/$ADDONTYPE-master | while read FOLDER; do
	if [[ ! `cat $CONFIGDIR/addons_installed.list | grep $ADDONTYPE:$FOLDER:` ]]; then
		green_msg "$FOLDER"
	fi
done
cyan_msg "Please enter the name of the addon you want to create a new image:"
read IMAGEFILE
IMAGEFILE=`echo $IMAGEFILE | tr -d "\r\n" | tr -d '\+\0\b\r' | sed 's/ //g'`
if [ -z $IMAGEFILE ]; then
	red_msg "You need to enter a addonname"
	exit 0
elif [ "`cat $CONFIGDIR/addons_installed.list | grep $ADDONTYPE:$IMAGEFILE:`" != "" ]; then
	red_msg "The image already exist"
	exit 0
elif [ ! -d $ADDONFOLDER/$ADDONTYPE-master/$IMAGEFILE ]; then
	red_msg "Please enter a valid addon name"
	exit 0
fi
MASTERADDA=""
yellow_msg "If this addon is standalone you probably want to remove the folders too if you remove it."
yellow_msg "If you do so please enter the name of the folder(s) that shall be removed with its subfolders. Seperate folders with space"
yellow_msg "Leave this blank if the folder(s) are still needed after remove"
yellow_msg "Example input: metamod sourcemod"
read ADDONREMOVEFOLDERS
ADDONREMOVEFOLDERS=`echo $ADDONREMOVEFOLDERS | tr -d "\r\n" | tr -d '\+\0\b\r' | sed 's/ //g'`
REMOVEFOLDERS=`echo $ADDONREMOVEFOLDERS | tr -d ',' | tr -d ';'`
touch $ADDONFOLDER/$ADDONTYPE-master/$IMAGEFILE/addon-$IMAGEFILE.blib
mkdir -p $ADDONFOLDER/$ADDONTYPE-image/$IMAGEFILE
updateaddonlist
addonimage_update
} 

function updateaddonlist {
cat $CONFIGDIR/addons_installed.list > $TEMPDIR/addons_installed.temp
echo "$ADDONTYPE:$IMAGEFILE:$REMOVEFOLDERS:$MASTERADDA:" >> $TEMPDIR/addons_installed.temp
sort $TEMPDIR/addons_installed.temp > $CONFIGDIR/addons_installed.list
echo "`date`: Installed the $IMAGEFILE addon for $ADDONTYPE" >> $IMLOG
}

function addonsymlinks {	
if [ ! -d $ADDONFOLDER/$ADDONTYPE-image/$IMAGEFILE/ ]; then
	mkdir -p $ADDONFOLDER/$ADDONTYPE-image/$IMAGEFILE/
fi
screen -dmS badl.$IMAGEFILE find -L $ADDONFOLDER/$ADDONTYPE-image/$IMAGEFILE -type l -exec rm -r {} \;
MASTERFOLDERS=($(grep "$ADDONTYPE:$IMAGEFILE:" $CONFIGDIR/addons_installed.list | awk -F: '{print $4}' | sed 's/,/ /g' | sed 's/  / /g'))
COUNTFOLDERS=${#MASTERFOLDERS[@]}
if [ -f $HOME/im_temp/$ADDONTYPE-userfiles.lst ]; then
	rm $HOME/im_temp/$ADDONTYPE-userfiles.lst
fi
i=1
cd $ADDONFOLDER/$ADDONTYPE-master/$IMAGEFILE
find -type f -name "*.cfg" -o -name "*.gam" -o -name "*.txt" -o -name "*.log" -o -name "*.smx" -o -name "*.sp" -o -name "*.sma" -o -name "*.amxx" > $HOME/im_temp/$ADDONTYPE-userfiles.lst
cd ..
cat $HOME/im_temp/$ADDONTYPE-userfiles.lst | while read LINE; do
	dirname $LINE | while read FOLDER; do
		if [ ! -d $ADDONFOLDER/$ADDONTYPE-image/$IMAGEFILE/$FOLDER ]; then
			mkdir -p $ADDONFOLDER/$ADDONTYPE-image/$IMAGEFILE/$FOLDER
		fi
	done
	find $ADDONFOLDER/$ADDONTYPE-image/$IMAGEFILE/$LINE -type l -delete > /dev/null 2>&1
	if [ ! -f $ADDONFOLDER/$ADDONTYPE-image/$IMAGEFILE/$LINE ]; then
		cp $ADDONFOLDER/$ADDONTYPE-master/$IMAGEFILE/$LINE $ADDONFOLDER/$ADDONTYPE-image/$IMAGEFILE/$LINE > /dev/null 2>&1
	fi
done
cp -sR $ADDONFOLDER/$ADDONTYPE-master/$IMAGEFILE/* $ADDONFOLDER/$ADDONTYPE-image/$IMAGEFILE/ > /dev/null 2>&1
} 

function addonimage_update {
if [ -d $ADDONFOLDER/$ADDONTYPE-master/$IMAGEFILE/ ]; then
	if [ -z $REAL ]; then
		addonsymlinks	
	fi
	if [ -f $IMAGEDIR/addons/$ADDONTYPE-a-$IMAGEFILE.tar ]; then
		yellow_msg "Removing old image"
		rm $IMAGEDIR/addons/$ADDONTYPE-a-$IMAGEFILE.tar > /dev/null 2>&1
	fi
	if [ -z $REAL ]; then	
		cd $ADDONFOLDER/$ADDONTYPE-image/$IMAGEFILE/
	else
		cd $ADDONFOLDER/$ADDONTYPE-master/$IMAGEFILE/
	fi
	if [ -f $TEMPDIR/$ADDONTYPE-a-$IMAGEFILE.tmp ]; then
		rm $TEMPDIR/$ADDONTYPE-a-$IMAGEFILE.tmp
		touch $TEMPDIR/$ADDONTYPE-a-$IMAGEFILE.tmp
	fi
	ADDONF=($(grep "$ADDONTYPE:$IMAGEFILE:" $CONFIGDIR/addons_installed.list | awk -F: '{print $3}' | sed 's/,/ /g' | sed 's/  / /g'))
	COUNTDIRS=${#ADDONF[@]}
	i=0
	if [ -f $TEMPDIR/$ADDONTYPE-a-$IMAGEFILE.tmp ]; then
		rm $TEMPDIR/$ADDONTYPE-a-$IMAGEFILE.tmp
	fi
	touch $TEMPDIR/$ADDONTYPE-a-$IMAGEFILE.tmp
	while [ $i -le $COUNTDIRS ]; do
		if [ "${ADDONF[$i]}" != "" ]; then
			find . -mindepth 1 -type d -name "${ADDONF[$i]}" >> $TEMPDIR/$ADDONTYPE-a-$IMAGEFILE.tmp
		fi
		i=$[i+1]
	done
	find . -type l >> $TEMPDIR/$ADDONTYPE-a-$IMAGEFILE.tmp
	find . -type f >> $TEMPDIR/$ADDONTYPE-a-$IMAGEFILE.tmp
	if [ -z $REAL ]; then
		find ./ -type d -print0 | xargs -0 chmod 770
		yellow_msg "Creating new Image"
		screen -dmS $IMAGEFILE.tar tar czf $IMAGEDIR/addons/$ADDONTYPE-a-$IMAGEFILE.tar .
		sort $TEMPDIR/$ADDONTYPE-a-$IMAGEFILE.tmp > $IMAGEDIR/addons/$ADDONTYPE-a-$IMAGEFILE.lst
	else
		yellow_msg "Creating new Image"
		screen -dmS $IMAGEFILE.tar tar czf $FILEIMAGEDIR/addons/$ADDONTYPE-a-$IMAGEFILE.tar .
		sort $TEMPDIR/$ADDONTYPE-a-$IMAGEFILE.tmp > $FILEIMAGEDIR/addons/$ADDONTYPE-a-$IMAGEFILE.lst
	fi
	green_msg "Image Update for $ADDONTYPE-a-$IMAGEFILE successfull!"
	echo "`date`: Updated the $ADDONTYPE-a-$IMAGEFILE Image" >> $IMLOG
else
	red_msg "Image Update for $ADDONTYPE-a-$IMAGEFILE failed. The folder does not exist!"
	echo "`date`: Could not update the $ADDONTYPE-a-$IMAGEFILE Image because the folder does not exist" >> $IMLOG
fi
}

function addon_update {
for ADDONS in $INSTALLEDADDONS; do
 IMAGEFILE=`echo $ADDONS | awk -F ':' '{print $2}'`
 ADDONTYPE=`echo $ADDONS | awk -F ':' '{print $1}'`
 addonimage_update
done
}

function addon_update_file {
yellow_msg "Following games are installed:"
green_msg "$INSTALLED"
cyan_msg "For which games shall I update an addonpackage?:"
read ADDONTYPE
if [ -z $ADDONTYPE ]; then
	red_msg "Please enter a gamename"
	exit 0
elif [[ ! `echo $INSTALLED | grep $ADDONTYPE` ]]; then
	red_msg "Please enter a valid/installed game"
	exit 0
fi
yellow_msg "Following addons are installed:"
cat $CONFIGDIR/addons_installed.list | grep $ADDONTYPE: | while read INSTALLEDADDONS; do
	green_msg "$(echo $INSTALLEDADDONS | awk -F: '{print $2}')"
done
cyan_msg "Please enter the name of the package you want to update:"
read IMAGEFILE
if [ -z $IMAGEFILE ]; then
	red_msg "You need to enter a packagename"
	exit 0
elif [ "$IMAGEFILE" = "$ADDONTYPE" ]; then
	red_msg "Please enter only the package name"
	exit 0
elif [ ! -d $ADDONFOLDER/$ADDONTYPE-master/$IMAGEFILE ]; then
	red_msg "Please enter a valid mappackage name"
	exit 0
fi
addonimage_update
}

function removeaddonlist {
cat $CONFIGDIR/addons_installed.list | grep -v $REMOVEADDON: > $TEMPDIR/addons_installed.temp
sort $TEMPDIR/addons_installed.temp > $CONFIGDIR/addons_installed.list
}

function addon_remove {
yellow_msg "Following games are installed:"
green_msg "$INSTALLED"
cyan_msg "For which games shall I remove a mappackage?:"
read ADDONTYPE
if [ -z $ADDONTYPE ]; then
	red_msg "Please enter a gamename"
	exit 0
elif [[ ! `echo $INSTALLED | grep $ADDONTYPE` ]]; then
	red_msg "Please enter a valid/installed game"
	exit 0
fi
yellow_msg "Following addons are installed:"
cat $CONFIGDIR/addons_installed.list | grep $ADDONTYPE: | while read INSTALLEDADDONS; do
	green_msg "$INSTALLEDADDONS" | awk -F: '{print $2}'
done
cyan_msg "Please enter the name of the addon you want to remove:"
read REMOVEADDON
if [ -z $REMOVEADDON ]; then
	red_msg "You need to enter a packagename"
	exit 0
elif [ "$REMOVEADDON" == "$ADDONTYPE" ]; then
	red_msg "Please enter only the package name"
	exit 0
elif [ ! -d $ADDONFOLDER/$ADDONTYPE-image/$REMOVEADDON ]; then
	red_msg "Please enter a valid mappackage name"
	exit 0
fi
rm -rf $ADDONFOLDER/$ADDONTYPE-image/$REMOVEADDON $IMAGEDIR/addons/$ADDONTYPE-a-$REMOVEADDON.tar $IMAGEDIR/addons/$ADDONTYPE-a-$REMOVEADDON.lst
removeaddonlist
echo "`date`: Removed the addon $REMOVEADDON" >> $IMLOG
green_msg "Removed the $ADDONTYPE addon $REMOVEADDON"
}

function pbupdate {
if [[ `find $SERVERDIR/$KUERZEL-master -type f -name pbsetup.run` ]]; then
	if [ "$(screen -ls | grep \"$KUERZEL.update\" | awk '{print $1}' | awk -F "." '{print $2}')" == "$KUERZEL.update" ]; then
		red_msg "An update with the screen name \"$KUERZEL.update\" is already in progress"
	else
		PBUSTER=`find $SERVERDIR/$KUERZEL-master -maxdepth 1 -type f -name pbsetup.run`
		PBUSTERPATH=`dirname $PBUSTER`
		echo "#!/bin/bash

cd $PBUSTERPATH
./pbsetup.run -u --i-accept-the-pb-eula > $LOGDIR/$KUERZEL-update.log
./image_manager update_image $SERVERNAME $KUERZEL" > $HOME/im_temp/$KUERZEL.update.sh
		if [[ `cat $HOME/im_config/games_installed.list | grep $KUERZEL-p:` ]]; then
			echo "./image_manager update_image $SERVERNAME $KUERZEL-p" >> $HOME/im_temp/$KUERZEL.update.sh
		fi
		chmod +x $HOME/im_temp/$KUERZEL.update.sh
		screen -dmS $KUERZEL.update $HOME/im_temp/$KUERZEL.update.sh
		green_msg "Updating Punkbuster for the game $KUERZEL in the screen $KUERZEL.update. If you want to see the progress open the $KUERZEL-update.log in the im_logs directory"
	fi
else
	red_msg "No Punkbuster found. If you want to update the $KUERZEL image try $0 update_image $KUERZEL $KUERZEL f"
fi
}

function image_update2 {
	yellow_msg "removing the old $KUERZEL image"
	if [ "$REAL" == "master" ]; then
		if [ ! -d $FILEIMAGEDIR/addons ]; then
			mkdir -p $FILEIMAGEDIR/addons
		fi
		if [ -f $FILEIMAGEDIR/$KUERZEL.tar ]; then
			rm $FILEIMAGEDIR/$KUERZEL.tar > /dev/null 2>&1
		fi
		cd $SERVERDIR/$KUERZEL-master
	else
		if [ -f $IMAGEDIR/$KUERZEL.tar ]; then
			rm $IMAGEDIR/$KUERZEL.tar > /dev/null 2>&1
		fi
		cd $SERVERDIR/$KUERZEL-image
		find ./ -type d -print0 | xargs -0 chmod 770
	fi
	yellow_msg "creating the new $KUERZEL image. This can take a while"
	if [ "$REAL" == "master" ]; then
		echo "#!/bin/bash
tar czf $FILEIMAGEDIR/$KUERZEL.tar .
rm $TEMPDIR/$KUERZEL.update.tmp
if [ -f $FILEIMAGEDIR/$KUERZEL.tar.md5 ]; then
	rm $FILEIMAGEDIR/$KUERZEL.tar.md5
fi
md5sum $FILEIMAGEDIR/$KUERZEL.tar | awk '{print $1}' > $FILEIMAGEDIR/$KUERZEL.tar.md5
rm $TEMPDIR/$KUERZEL-tar.sh" > $TEMPDIR/$KUERZEL-tar.sh
		chmod +x $TEMPDIR/$KUERZEL-tar.sh
		screen -dmS $KUERZEL.tar $TEMPDIR/$KUERZEL-tar.sh
	else
		tar czf $IMAGEDIR/$KUERZEL.tar .
	fi
	echo "update" > $TEMPDIR/$KUERZEL.update.tmp
	green_msg "$KUERZEL image update successfull"
	echo "`date`: Updated the $KUERZEL image" >> $IMLOG
}
 
function image_update {
STEXT="downloading"
PBTEXT="needs to be updated."
if [ "$(echo $PROTECTED | grep 'p\|tv')" != "" ]; then
	ULOG="$LOGDIR/$PROTECTED2-update.log"
else
	ULOG="$LOGDIR/$KUERZEL-update.log"
fi
if [ -f $ULOG ]; then 
	if [[ `cat $ULOG | grep "$STEXT" ` ]] || [[ `cat $ULOG | grep "$PBTEXT" ` ]]; then
		image_update2
	else
		if [ "$FORCE" == "f" ]; then
			image_update2
		else
			yellow_msg "Image is already up to date"
		fi		
	fi
else
	if [ "$FORCE" == "f" ]; then
		image_update2
	else
		red_msg "No update.log has been found. If you want to update the $KUERZEL image try $0 update_image $KUERZEL $KUERZEL f"
	fi
fi
}


function pbrootupdate {
if [ -f $HOME/im_temp/$KUERZEL.update.sh ]; then
	rm $HOME/im_temp/$KUERZEL.update.sh
fi
find $SERVERDIR/$KUERZEL-master -type f -name pbsetup.run | while read PBUSTER; do
	if [ "$(screen -ls | grep \"$KUERZEL.update\" | awk '{print $1}' | awk -F "." '{print $2}')" == "$KUERZEL.update" ]; then
		red_msg "An update with the screen name \"$KUERZEL.update\" is already in progress"
	else
		PATH=`dirname $PBUSTER`
		if [ ! -f $HOME/im_temp/$KUERZEL.update.sh ]; then
			echo "#!/bin/bash" > $HOME/im_temp/$KUERZEL.update.sh
		fi
		echo "  
cd $PATH
./pbsetup.run -u --i-accept-the-pb-eula > $LOGDIR/$KUERZEL-update.log
rm $HOME/im_temp/$KUERZEL.update.sh
" >> $HOME/im_temp/$KUERZEL.update.sh
		if [ "$REAL" == "master" ]; then
			echo "cd $HOME
./image_manager update_image_file" >> $HOME/im_temp/$KUERZEL.update.sh
		fi
		chmod +x $HOME/im_temp/$KUERZEL.update.sh
		screen -dmS $KUERZEL.update $HOME/im_temp/$KUERZEL.update.sh
		green_msg "Updating Punkbuster for the game $KUERZEL in the screen $KUERZEL.update. If you want to see the progress open the $KUERZEL-update.log in the im_server directory"
	fi
done
}

function hash_update {
if [ "$REAL" == "master" ]; then
	cd $FILEIMAGEDIR
else
	cd $IMAGEDIR
fi
if [ -f $TEMPDIR/$KUERZEL.update.tmp ]; then 
	rm $TEMPDIR/$KUERZEL.update.tmp
	if [ -f $KUERZEL.tar.md5 ]; then
		yellow_msg "Removing the old md5sum file"
		rm $KUERZEL.tar.md5
	fi
	yellow_msg "Creating new md5sum file"
	md5sum $KUERZEL.tar | awk '{print $1}' > $KUERZEL.tar.md5
	yellow_msg "MD5 sum created"
elif [ "$(echo $PROTECTED | grep 'p\|tv')" != "" ]; then
	if [ -f $KUERZEL.tar.md5 ]; then
		yellow_msg "Removing the old md5sum file"
		rm $KUERZEL.tar.md5
	fi
	yellow_msg "Creating new md5sum file"
	md5sum $KUERZEL.tar | awk '{print $1}' > $KUERZEL.tar.md5
	green_msg "md5sum file successfully created"
fi
}

function update_all {
echo "`date`: Running the updater tools for all installed games" >> $IMLOG

cat $CONFIGDIR/games_installed.list | awk -F ":" '{print $2}' | sort -r | while read KUERZEL; do
	if [ -n $KUERZEL ]; then
		KUERZELS=($(echo $KUERZEL | sed 's/-/ /g'))
		KUERZELCOUNT=${#KUERZELS[@]}
		PROTEC=`echo "$KUERZEL" | awk -F- '{print $'$KUERZELCOUNT'}'`
		if [ "$(echo $PROTEC | grep 'p\|tv')" != "" ]; then
			SERVERNAME=`cat $CONFIGDIR/games_installed.list | grep :$KUERZEL: | grep -v $KUERZEL-tv | grep -v $KUERZEL-p | awk -F ":" '{print $1}'`
			STEAM=`cat $CONFIGDIR/games_installed.list | grep :$KUERZEL: | grep -v $KUERZEL-tv | grep -v $KUERZEL-p | awk -F ":" '{print $4}'`
		else
			SERVERNAME=`cat $CONFIGDIR/games_installed.list | grep :$KUERZEL: | awk -F ":" '{print $1}'`
			STEAM=`cat $CONFIGDIR/games_installed.list | grep :$KUERZEL: | awk -F ":" '{print $4}'`
		fi
		if ([ -n "$SERVERNAME" ] && [ "$STEAM" != "nosteam" ]); then
			masterserver_update
		elif ([ -n "$SERVERNAME" ] && [ "$STEAM" == "nosteam" ] && [ "$(echo $PROTEC | grep 'p\|tv')" == "" ]); then
			PSERVER=`cat $CONFIGDIR/games_installed.list | grep $KUERZEL: | awk -F ":" '{print $2}' | awk -F- '{print $'$KUERZELCOUNT'}'`
			if [ "$PSERVER" != "p" ]; then
				pbupdate
			fi
		fi
	fi
done
}


function rootupdate {
cd $SERVERDIR
if [ ! -d $SERVERDIR/$KUERZEL-master ]; then
	if [[  "$(echo $PROTECTED | grep 'p\|tv')" != "" && -d $SERVERDIR/$PROTECTED2-master ]]; then
		yellow_msg "Starting to copy data from non protected server to protected"
		cp -r $SERVERDIR/$PROTECTED2-master $SERVERDIR/$KUERZEL-master
		find $SERVERDIR/$KUERZEL-master -maxdepth 2 -type f -name "srcds_run" -o -name "hlds_run" -delete
		green_msg "Copy finished"
	else
		mkdir -p $SERVERDIR/$KUERZEL-master
	fi
	if [ ! -d $MAPFOLDER/$KUERZEL-master ]; then mkdir -p $MAPFOLDER/$KUERZEL-master; fi
	if [ ! -d $MAPFOLDER/$KUERZEL-image ]; then mkdir -p $MAPFOLDER/$KUERZEL-image; fi
	if [ ! -d $ADDONFOLDER/$KUERZEL-master ]; then mkdir -p $ADDONFOLDER/$KUERZEL-master; fi
	if [ ! -d $ADDONFOLDER/$KUERZEL-image ]; then mkdir -p $ADDONFOLDER/$KUERZEL-image; fi
	STEAM="steam"
	installed_list
fi
if [ "$SERVERNAME" = "css" ]; then
	if [ "$(screen -ls | grep \"$KUERZEL.update\" | awk '{print $1}' | awk -F "." '{print $2}')" == "$KUERZEL.update" ]; then
		red_msg "An update with the screen name \"$KUERZEL.update\" is already in progress"
	else
		echo "#!/bin/bash
  
./steam -command update -retry
./steam -command update -game \"Counter-Strike Source\" -dir $SERVERDIR/$KUERZEL-master -verify_all -retry > $LOGDIR/$KUERZEL-update.log
rm $HOME/im_temp/$KUERZEL.update.sh
" > $HOME/im_temp/$KUERZEL.update.sh
		if [ "$REAL" == "master" ]; then
			echo "cd $HOME
./image_manager update_image_file css css" >> $HOME/im_temp/$KUERZEL.update.sh
		fi
		chmod +x $HOME/im_temp/$KUERZEL.update.sh
		screen -dmS $KUERZEL.update $HOME/im_temp/$KUERZEL.update.sh
		green_msg "Updating/Installing the server in the screen $KUERZEL.update. Depending on your an Valve´s connection this can take a while. 
If you want to see the progress open the $KUERZEL-update.log in the im_logs directory"
		echo "`date`: Updater for $KUERZEL started" >> $IMLOG
	fi
else
	if [ "$(screen -ls | grep \"$KUERZEL.update\" | awk '{print $1}' | awk -F "." '{print $2}')" == "$KUERZEL.update" ]; then
		red_msg "An update with the screen name \"$KUERZEL.update\" is already in progress"
	else
		echo "#!/bin/bash
  
./steam -command update -retry
./steam -command update -game $SERVERNAME -dir $SERVERDIR/$KUERZEL-master -verify_all -retry > $LOGDIR/$KUERZEL-update.log
rm $HOME/im_temp/$KUERZEL.update.sh
" > $HOME/im_temp/$KUERZEL.update.sh
		if [ "$REAL" == "master" ]; then
			echo "cd $HOME
./image_manager update_image_file $SERVERNAME $KUERZEL" >> $HOME/im_temp/$KUERZEL.update.sh
		fi
		chmod +x $HOME/im_temp/$KUERZEL.update.sh
		screen -dmS $KUERZEL.update $HOME/im_temp/$KUERZEL.update.sh
		green_msg "Updating/Installing the server in the screen $KUERZEL.update . Depending on your an Valve´s connection this can take a while. 
If you want to see the progress open the $KUERZEL-update.log in the im_logs directory"
		echo "`date`: Updater for $KUERZEL started" >> $IMLOG
	fi
fi
}

function update_all_install {
echo "`date`: Updatetools for for all installed servers started" >> $IMLOG
for u in $INSTALLED; do
	KUERZEL="$u"
	SERVERNAME=`cat $CONFIGDIR/games_installed.list | grep $KUERZEL: | awk -F: '{print $1}'`
	STEAM=`cat $CONFIGDIR/games_installed.list | grep $KUERZEL: | awk -F: '{print $4}'`
	if ([ -n "$SERVERNAME" ] && [ "$STEAM" != "nosteam" ]); then
		rootupdate
	elif ([ -n "$SERVERNAME" ] && [ "$STEAM" == "nosteam" ]); then
		pbrootupdate
	fi
done
}


function updatecustomers {
find /home/$SERVERNAME/server -mindepth 1 -maxdepth 1 -type d -group $TEKLABGROUP | while read CUSTOMERSERVER; do
	find $CUSTOMERSERVER -name "InstallRecord.blob" -maxdepth 1 -type l | while read MASTERBLOB; do
		SERVERDIR=`dirname $MASTERBLOB`
		MASTERFILE=$(find $MASTERBLOB -maxdepth 1 -type l -ls | awk '{print $13}')
		MASTERDIR=$(dirname $MASTERFILE)
		if [ -d $MASTERDIR ]; then
			screen -dmS checksymlinks cp -sR $MASTERDIR/* $SERVERDIR/ > /dev/null 2>&1
		fi
	done
	screen -dmS delete_bad_symlinks find -L $SERVERFOLDERS -type l -exec rm -r {} \;
done
echo "`date`: Updating Gameserversymlinks for customers if necessary" >> $IMLOG
}

function mapupdatecustomers {
find /home/$SERVERNAME/server -mindepth 1 -maxdepth 1 -type d -group $TEKLABGROUP | while read MAPDIRECTORY; do
	find $MAPDIRECTORY -name "map-*.blib" -maxdepth 1 -type l | while read MASTERBLIB; do  
		MAPDIR=`dirname $MASTERBLIB`
		MASTERFILE=$(find $MASTERBLIB -maxdepth 1 -type l -ls | awk '{print $13}')
		MASTERDIR=$(dirname $MASTERFILE)
		if [ -d $MASTERDIR ]; then
			screen -dmS checksymlinks cp -sR $MASTERDIR/* $MAPDIR/ > /dev/null 2>&1
		fi
	done
	screen -d -m -S delete_bad_symlinks find -L $SERVERFOLDERS -type l -exec rm -r {} \;
done
echo "`date`: Updating Mapsymlinks for customers if necessary" >> $IMLOG
}


function addonupdatecustomers {
find /home/$SERVERNAME/server -mindepth 1 -maxdepth 1 -type d -group $TEKLABGROUP | while read ADDONDIRECTORY; do
	find $ADDONDIRECTORY -maxdepth 1 -name "addon-*.blib" -type l | while read MASTERBLIB; do
		ADDONDIR=`dirname $MASTERBLIB`
		MASTERFILE=$(find $MASTERBLIB -maxdepth 1 -type l -ls | awk '{print $13}')
		MASTERDIR=$(dirname $MASTERFILE)
		if [ -d $MASTERDIR ]; then
			screen -dmS checksymlinks cp -sR $MASTERDIR/* $ADDONDIR/ > /dev/null 2>&1
		fi
	done
	screen -dmS delete_bad_symlinks find -L $SERVERFOLDERS -type l -exec rm -r {} \;
done
echo "`date`: Updating Addonsymlinks for customers if necessary" >> $IMLOG
}

function badftpdata {
	if [ ! -f $HOME/im_config/.ftp/userdata ]; then
		red_msg "The File $HOME/im_config/.ftp/userdata does not exist "
		exit 0
	fi
	FTPIP=`grep : $HOME/im_config/.ftp/userdata | awk -F: '{ print $1}'`
	FTPPASSWORD=`grep : $HOME/im_config/.ftp/userdata | awk -F: '{ print $2}'`
	if [ -z $FTPIP ]; then
		red_msg "No valid FTP Data found in $HOME/im_config/.ftp/userdata"
		exit 0
	elif [ -z $FTPPASSWORD ]; then
		red_msg "No valid FTP Data found in $HOME/im_config/.ftp/userdata"
		exit 0
	fi
}

function badsyncdata {
	SSHPORT=$(head -n 1 $CONFIGDIR/.ftp/userdata | awk -F ":" '{print $2}')
	SSHIP=$(head -n 1 $CONFIGDIR/.ftp/userdata | awk -F ":" '{print $1}')
	if [ "$SSHPORT" == "" ]; then
		red_msg "No valid SSH PORT found in $HOME/im_config/.ftp/userdata"
		exit 0
	elif [ "$SSHIP" == "" ]; then
		red_msg "No valid SSH IP found in $HOME/im_config/.ftp/userdata"
		exit 0
	fi
}

function syncmaps {
	for U in $INSTALLED; do
		if [ "$(screen -ls | grep $U.syncmaps)" != "" ]; then
			red_msg "An update with the screen name \"syncmaps.$U\" is already in progress"
		else
			if [ "$SYNC" == "ftp" ]; then
				badftpdata
				FTPIP=`grep : $HOME/im_config/.ftp/userdata | awk -F: '{ print $1}'`
				FTPPASSWORD=`grep : $HOME/im_config/.ftp/userdata | awk -F: '{ print $2}'`
				green_msg "Syncronising maps for $U"
				echo "#!/bin/bash
lftp <<EOFTP
open ftp://`whoami`:$FTPPASSWORD@$FTPIP
mirror -n im_maps/$U-master $MAPFOLDER/$U-master
exit
EOFTP
rm $TEMPDIR/syncmap$U.sh" > $TEMPDIR/syncmap$U.sh
				chmod +x $TEMPDIR/syncmap$U.sh
				screen -dmS $U.syncmaps $TEMPDIR/syncmap$U.sh
			elif [ "$SYNC" == "rsync" ]; then
				badsyncdata
				screen -d -m -S $U.syncmaps rsync -av --delete -e "ssh -p $SSHPORT -l `whoami`" $SSHIP:/home/`whoami`/im_maps/$U-master $MAPFOLDER/
			else
				red_msg "No syncing method is setup"
				exit 0
			fi
			green_msg "Syncronysing $U maps with the masterserver in the screen \"$U.syncaddons\""
		fi
	done
	echo "`date`: Syncronysing maps with the masterserver" >> $IMLOG
}

function syncaddons {
	for U in $INSTALLED; do
		if [ "$(screen -ls | grep $U.syncaddons)" != "" ]; then
			red_msg "An update with the screen name \"syncaddons.$U\" is already in progress"
		else
			if [ "$SYNC" == "ftp" ]; then
				badftpdata
				FTPIP=`grep : $HOME/im_config/.ftp/userdata | awk -F: '{ print $1}'`
				FTPPASSWORD=`grep : $HOME/im_config/.ftp/userdata | awk -F: '{ print $2}'`
				green_msg "Syncronising addons for $U"
				echo "#!/bin/bash
lftp <<EOFTP
open ftp://`whoami`:$FTPPASSWORD@$FTPIP
mirror -n im_addons/$U-master $ADDONFOLDER/$U-master
exit
EOFTP" > $TEMPDIR/syncaddon$U.sh
				chmod +x $TEMPDIR/syncaddon$U.sh
				screen -dmS $U.syncaddons $TEMPDIR/syncaddon$U.sh
			elif [ "$SYNC" == "rsync" ]; then
				badsyncdata
				screen -d -m -S $U.syncaddons rsync -av --delete -e "ssh -p $SSHPORT -l `whoami`" $SSHIP:/home/`whoami`/im_addons/$U-master $ADDONFOLDER/
			else
				red_msg "No syncing method is setup"
				exit 0
			fi
			green_msg "Syncronysing $U addons with the masterserver in the screen \"$U.syncaddons\""
		fi
	done
	echo "`date`: Syncronysing addons with the masterserver" >> $IMLOG
}

function startsyncserver {
if [ "$SYNC" == "ftp" ]; then
	echo "#!/bin/bash
lftp <<EOFTP
open ftp://`whoami`:$FTPPASSWORD@$FTPIP
mirror -n im_server/$KUERZEL-master $SERVERDIR/$KUERZEL-master
exit
EOFTP" > $TEMPDIR/$KUERZEL-syncs.sh
	chmod +x $TEMPDIR/$KUERZEL-syncs.sh
	screen -dmS $KUERZEL-syncs $TEMPDIR/$KUERZEL-syncs.sh
elif [ "$SYNC" == "rsync" ]; then
	echo "#!/bin/bash
rsync -av --delete -e \"ssh -p $SSHPORT -l `whoami`\" $SSHIP:/home/`whoami`/im_server/$KUERZEL-master $SERVERDIR/ >> $LOGDIR/$KUERZEL-sync.log " > $TEMPDIR/$KUERZEL-syncs.sh
	chmod +x $TEMPDIR/$KUERZEL-syncs.sh
	screen -d -m -S $KUERZEL-syncs $TEMPDIR/$KUERZEL-syncs.sh
fi
}

function syncservers {
	if [ "$SYNC" == "ftp" ]; then
		badftpdata
	elif [ "$SYNC" == "rsync" ]; then
		badsyncdata
	else
		red_msg "No syncing method is setup"
		exit 0
	fi
	COUNTDIRS=${#INPUTARRAY[@]}
	if [ "$COUNTDIRS" == "1" ]; then
		red_msg "You need to enter teklab shorten too like css cs csz dod"
		exit 0
	fi
	cd $TEMPDIR
	if [ "$SYNC" == "ftp" ]; then
		wget --quiet ftp://$(id -un):$FTPPASSWORD@$FTPIP/im_config/games_installed.list
	elif [ "$SYNC" == "rsync" ]; then
		rsync -av --delete -e "ssh -p $SSHPORT -l `whoami`" $SSHIP:/home/`whoami`/im_config/games_installed.list $TEMPDIR/
	fi
	cd $HOME
	if [ ! -f $TEMPDIR/games_installed.list ]; then
		red_msg "The gamelist download failed"
		exit 0
	fi
	CORCOUNT=$[COUNTDIRS-1]
	i=1
	while [ $i -le $CORCOUNT ]; do
		KUERZEL=$(echo ${INPUTARRAY[$i]} | tr -d ',' | tr -d ';')
		if [[ `screen -ls | grep $KUERZEL-syncs` ]]; then
			red_msg "An update with the screen name \"$KUERZEL-syncs\" is already in progress"
		else			
			if [ "$(grep :$KUERZEL: $CONFIGDIR/games_installed.list | grep -v :$KUERZEL-p:$KUERZEL: | grep -v :$KUERZEL-tv:$KUERZEL:)" != "" ]; then
				green_msg "Syncronising: $KUERZEL"
				if [ ! -d $SERVERDIR/$KUERZEL-master ]; then
					mkdir -p $SERVERDIR/$KUERZEL-master
				fi
				startsyncserver
			else
				green_msg "Creating folders for: $KUERZEL"
				mkdir -p $SERVERDIR/$KUERZEL-master
				mkdir -p $MAPFOLDER/$KUERZEL-master
				mkdir -p $ADDONFOLDER/$KUERZEL-master
				SERVERNAME=$(grep ":$KUERZEL:" $TEMPDIR/games_installed.list | grep -v ":$KUERZEL-p:$KUERZEL:" | grep -v ":$KUERZEL-tv:$KUERZEL:" | awk -F ":" '{print $1}')
				AVAILABLE2=$(grep ":$KUERZEL:" $TEMPDIR/games_installed.list | grep -v ":$KUERZEL-p:$KUERZEL:" | grep -v ":$KUERZEL-tv:$KUERZEL:" | awk -F ":" '{print $3}')
				STEAM=$(grep ":$KUERZEL:" $TEMPDIR/games_installed.list | grep -v ":$KUERZEL-p:$KUERZEL:" | grep -v ":$KUERZEL-tv:$KUERZEL:" | awk -F ":" '{print $4}')
				if [ "$SERVERNAME" != "" ]; then
					if [ "$(grep :$KUERZEL: $CONFIGDIR/games_installed.list | grep -v :$KUERZEL-p:$KUERZEL: | grep -v :$KUERZEL-tv:$KUERZEL:)" == "" ]; then
						installed_list
					fi
				fi
				green_msg "Syncronising: $KUERZEL"
				startsyncserver
			fi
		fi
		i=$[i+1]		
	done
	echo "`date`: Syncronysing $KUERZEL with the masterserver" >> $IMLOG
	if [ -f $TEMPDIR/games_installed.list ]; then
		rm $TEMPDIR/games_installed.list
	fi
}

function server_delete {
yellow_msg "Following Servers are installed:"
for S in $INSTALLED; do
	green_msg "$S"
done
echo ""
cyan_msg "Which server and image shall be removed?"
read AUSWAHL
if [ -z $AUSWAHL ]; then
	red_msg "You need to enter a shorten"
	exit 0
elif [[ ! -d $SERVERDIR/$AUSWAHL-master && ! -d $SERVERDIR/$AUSWAHL-image ]]; then
	red_msg "Please enter a valid shorten"
	exit 0
fi 
yellow_msg "Removing the Image(s)"
rm -rf $IMAGEDIR/$AUSWAHL.*
rm -rf $FILEIMAGEDIR/$AUSWAHL.*
yellow_msg "Removing the serverinstalls"
rm -rf $SERVERDIR/$AUSWAHL-master $SERVERDIR/$AUSWAHL-image $SERVERDIR/$AUSWAHL-p-image
rm $LOGDIR/$AUSWAHL-update.log
yellow_msg "removing the mappackages"
rm -rf $ADDONFOLDER/$AUSWAHL-*
yellow_msg "removing the addons"
rm -rf $MAPFOLDER/$AUSWAHL-*
grep -v $AUSWAHL: $CONFIGDIR/games_installed.list > $TEMPDIR/games_installed.tmp
sort $TEMPDIR/games_installed.tmp > $CONFIGDIR/games_installed.list
rm $TEMPDIR/games_installed.tmp
echo "`date`: Deleted $AUSWAHL" >> $IMLOG
green_msg "Succesfully removed $AUSWAHL"
}

function nemruncheck_image {
for U in $INSTALLED; do
	KUERZEL="$U"
	SERVERNAME=`cat $CONFIGDIR/games_installed.list | grep $U: | awk -F: '{print $1}'`
	if [ "$(screen -ls | grep \"$KUERZEL.update\" | awk '{print $1}' | awk -F "." '{print $2}')" != "$KUERZEL.update" ]; then
		find $SERVERDIR/$KUERZEL-master -type f -name "steam.inf" | while read STEAMINF; do
			if [[ `$SERVERDIR/srcupdatecheck $STEAMINF | grep "OUT OF DATE!"` ]]; then
				masterserver_update
			fi
		done
	fi  
done
}

function nemruncheck_game {
for U in $INSTALLED; do
	KUERZEL="$U"
	SERVERNAME=`cat $CONFIGDIR/games_installed.list | grep $U: | awk -F: '{print $1}'`
	if [ "$(screen -ls | grep \"$KUERZEL.update\" | awk '{print $1}' | awk -F "." '{print $2}')" != "$KUERZEL.update" ]; then
		find $SERVERDIR/$KUERZEL-master -type f -name "steam.inf" | while read STEAMINF; do
			if [[ `$SERVERDIR/srcupdatecheck $STEAMINF | grep "OUT OF DATE!"` ]]; then
				rootupdate
			fi
		done
	fi  
done
}

function backup {
if [ ! -d $HOME/im_backup ]; then
	mkdir $HOME/im_backup
fi 
find /home/ -name server -type d -group $TEKLABGROUP | while read CUSTOMERS; do
	find $CUSTOMERS -maxdepth 1 -type d | grep "$CUSTOMERS/" | while read SERVERDIRS; do
		USERNAME=`echo "$SERVERDIRS" | awk -F/ '{print $3}'`
		FOLDERNAME=`echo "$SERVERDIRS" | awk -F/ '{print $5}'`
		find $SERVERDIRS -type f > $HOME/im_temp/$FOLDERNAME.backup.list
		cat $HOME/im_temp/$FOLDERNAME.backup.list | while read LINES; do
			screen -dmS $USERNAME.$FOLDERNAME.backup tar cfj $HOME/im_backup/$USERNAME-$FOLDERNAME.tar.gz $LINES
		done
	done
done
}


function info {

echo "
Image Manger for Tekbaseimages
Version $IMVERSION
Copyright (c)2010-2011
Ulrich Block
ulblock@gmx.de 
www.ulrich-block.de

Note: for Counter-Strike Source you need to replace the steam shorten with css

Usage (general):              $0 {install|delete_source|update_im}
Usage (imageserver & games):  $0 {nosteam|update_source steamshorten teklabshorten|update_image steamshorten teklabshorten|update_all_sources|nemrun_check_image}
Usage (imageserver & maps):   $0 {mapinstall|mapupdate|mapremove}
Usage (imageserver & addons): $0 {addoninstall|addonupdate|addonremove}
Usage (standalone images):    $0 {update_file|update_image_file|update_all_files|map_file_update|addon_file_update}
Usage (gameserver & games):   $0 {update_old_installs|nosteam_gameroot|update_gamefiles steamshorten teklabshorten|update_customers|update_all_gamefiles|nemrun_check_game|sync_server}
Usage (gameserver & addons):  $0 {sync_addons|sync_maps|update_addons_customers|update_maps_customers}"

}

case "$1" in
	update_file)
		REAL="master"
		check_config
		rootupdate		
	;;
	update_all_files)
		REAL="master"
		update_all_install
	;;
	update_im)
		RUNUPDATE=1
		updateim
	;;
	update_image_file)
		REAL="master"
		initzwei
		check_config
		initdrei
		image_update
		hash_update
	;;
	map_file_update)
		REAL="master"
		initzwei
		check_config
		map_update_file
	;;
	addon_file_update)
		REAL="master"
		initzwei
		check_config
		addon_update_file
	;;
	install)
		initeins
		install_im
	;;	
	delete_source)
		initzwei
		check_config
		server_delete
	;;
	update_old_installs)
		initeins
		check_config
		install_im_replace
	;;
	nosteam)
		initzwei
		check_config
		no_steam
	;;
	nosteam_gameroot)
		initzwei
		check_config
		no_steam_game
	;;
	update_source)
		initzwei
		check_config
		initdrei
		masterserver_update
	;;
	update_image)
		initzwei
		check_config
		initdrei
		imagesymlinks
		image_update
		hash_update
	;;
	update_all_sources)
		initzwei
		check_config
		update_all
	;;
	update_gamefiles)
		check_config
		rootupdate
	;;
	mapinstall)
		initzwei
		check_config
		map_install
	;;
	mapupdate)
		initzwei
		check_config
		map_update
	;;
	mapremove)
		initzwei
		check_config
		map_remove
	;;
	addoninstall)
		initzwei
		check_config
		addon_install
	;;
	addonupdate)
		initzwei
		check_config
		addon_update
	;;
	addonremove)
		initzwei
		check_config
		addon_remove
	;;
	update_customers)
		check_config
		updatecustomers
	;;
	sync_addons)
		initzwei
		check_config
		syncaddons
	;;
	sync_maps)
		initzwei
		check_config
		syncmaps
	;;
	sync_server)
		initzwei
		check_config
		syncservers
	;;
	update_all_gamefiles)
		check_config
		update_all_install
	;;
	update_addons_customers)
		check_config
		addonupdatecustomers
	;;
	update_maps_customers)
		check_config
		mapupdatecustomers
	;;
	nemrun_check_image)
		check_config
		nemruncheck_image
	;;
	nemrun_check_game)
		check_config
		nemruncheck_game
	;;
	*)
		info
	;;
esac
exit 0