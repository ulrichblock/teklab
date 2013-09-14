#!/bin/bash

############################################################################
#                                                                          #
#  Gameserver image_manager.sh for teklab and hldsupdatetool games         #
#                                                                          #
#  Copyright (c)2010-2010                                                  #
#  Ulrich Block                                                            #
#                                                                          #
#  Contact:                                                                #
#  ulblock at gmx.de                                                       #
#  www.ulrich-block.de                                                     #
#                                                                          #
#  Singe server updating and installing:                                   #
#  Usage: ./image_creator.sh update steamshorten teklabshorten             #
#                                                                          #
#  Update all installed server at once:                                    #
#  Usage: ./image_creator.sh updateall                                     #
#                                                                          #
#  Delete a server, image, amd md5sum                                      #
#  Usage: ./image_creator.sh delete                                        #
#                                                                          #
#  Repack and rehash the image                                             #
#  Usage: ./image_creator.sh image steamshorten teklabshorten              #
#                                                                          #
#  Note: for Counter-Strike Source you need to replace the steam shorten   #
#  with css                                                                #
#                                                                          #
#  Possible folder strukture (not required):                               #
#   script: /home/user/image_manager                                       #
#   images: /home/user/image_manager/images                                #
#   server: /home/user/image_manager/server                                #
#                                                                          #
#  It is required to place the steam updatetool in the server folder       #
#  Update it to the latest version before running this script              #
#                                                                          #
############################################################################

IMAGEDIR=/home/user/images
SCRIPTDIR=/home/user
SERVERDIR=/home/user/server
SERVERNAME="$2"
KUERZEL="$3"
INSTALLED=`cat $SCRIPTDIR/games_installed.list | awk -F: '{print $2}'`
AVAILABLE1=`cat $SCRIPTDIR/games_available.list | grep $SERVERNAME: | awk -F: '{print $1}'`
AVAILABLE2=`cat $SCRIPTDIR/games_available.list | grep $SERVERNAME: | awk -F: '{print $2}'`
PROTECTED=`echo "$KUERZEL" | awk -F- '{print $2}'`
PROTECTED2=`echo "$KUERZEL" | awk -F- '{print $1}'`
 
function init {
if [ -z "$SERVERDIR" ]; then 
 echo "The var SERVERDIR wasn't set in the imageupdater"
 exit 0
elif [ -z "$IMAGEDIR" ]; then 
 echo "The var IMAGEDIR wasn't set in imageupdater"
 exit 0
fi
}
function init_zwei {
if [ -z "$SERVERNAME" ]; then 
 echo "You forgot to use a SERVERNAME that is used for the steam update tool like cstrike, or dods"
 exit 0
elif [ -z "$KUERZEL" ]; then 
 echo "You forgot to use a Teklab KUERZEL like cs, css, or dods"
 exit 0
elif [ ! "$SERVERNAME" = "$AVAILABLE1" ]; then
 echo "The SERVERNAME you chose does not exits! Please use one of these:
 SERVERNAME"
 cat games_available.list | awk -F: '{print $1}'
 exit 0
fi
}

function steam_update {
./steam -command update -retry > /dev/null 2>&1
}

function installed_list {
cat $SCRIPTDIR/games_installed.list > $SCRIPTDIR/games_installed.tmp
echo "
$SERVERNAME:$KUERZEL:$AVAILABLE2" >> $SCRIPTDIR/games_installed.tmp
sort $SCRIPTDIR/games_installed.tmp > $SCRIPTDIR/games_installed.list
rm $SCRIPTDIR/games_installed.tmp
}

function server_update {
 cd $SERVERDIR
 if [ ! -d $SERVERDIR/$KUERZEL ]; then
  if [[ "$PROTECTED" = "p" && -d $SERVERDIR/$PROTECTED2 ]]; then
   cp -r $SERVERDIR/$PROTECTED2 $SERVERDIR/$KUERZEL
   cd $SERVERDIR/$KUERZEL
   steam_update
   installed_list
   image_update
  else
   steam_update
   mkdir -p $SERVERDIR/$KUERZEL
   cp steam test1.so test2.so test3.so $SERVERDIR/$KUERZEL/
   installed_list
  fi
 fi
 cd $SERVERDIR/$KUERZEL
 if [ "$SERVERNAME" = css ]; then
  steam_update
  ./steam -command update -game "Counter-Strike Source" -dir $SERVERDIR/$KUERZEL -verify_all -retry > update.log
  if [[ `cat update.log | grep downloading ` ]]; then
   rm update.log
   image_update
  else
   echo "Kein Image Update noetig"
  fi
 else
  steam_update
  ./steam -command update -game $SERVERNAME -dir $SERVERDIR/$KUERZEL -verify_all -retry > update.log
  if [[ `cat update.log | grep downloading ` ]]; then
   rm update.log
   image_update
  else
   echo "Kein Image Update noetig"
  fi
 fi
}

function image_update {
rm $IMAGEDIR/$KUERZEL.tar > /dev/null 2>&1
cd $SERVERDIR/$KUERZEL
tar czf $IMAGEDIR/$KUERZEL.tar .
echo "update" > $SERVERDIR/update.$KUERZEL.tmp
echo "Image Update erfolgt"
}

function hash_update {
cd $IMAGEDIR
if [ -f $SERVERDIR/update.$KUERZEL.tmp ]; then 
 rm $SERVERDIR/update.$KUERZEL.tmp
 rm $KUERZEL.tar.md5
 md5sum $KUERZEL.tar | awk '{print $1}' > $KUERZEL.tar.md5
fi
}

function update_all {
for u in $INSTALLED; do
 KUERZEL="$u"
 SERVERNAME=`cat $SCRIPTDIR/games_installed.list | grep $KUERZEL: | awk -F: '{print $1}'`
 server_update
 hash_update
done
}

function server_delete {
 for S in $INSTALLED; do
  echo "Kuerzel: $S"
 done
 echo "Welcher Server und das zugehörige Image soll geloescht werden? 
Gib bitte das Kuerzel ein:"
 read AUSWAHL
 rm -rf $SERVERDIR/$AUSWAHL $IMAGEDIR/$AUSWAHL.*
 grep -v $AUSWAHL: $SCRIPTDIR/games_installed.list > $SCRIPTDIR/games_installed.tmp
 sort $SCRIPTDIR/games_installed.tmp > $SCRIPTDIR/games_installed.list
 rm $SCRIPTDIR/games_installed.tmp
}

init

case "$1" in
 image)
  init_zwei
  image_update
  hash_update
 ;;
 
  delete)
   server_delete
 ;;
 
 update)
  init_zwei
  steam_update
  server_update
  hash_update
 ;;

 updateall)
  update_all
 ;;
 
 *)
  echo "Usage: updateall | delete | update steamshorten teklabshorten | image steamshorten teklabshorten"
 ;;
 
esac
exit 0
