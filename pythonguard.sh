#!/bin/bash
#Author: Ronny Worm
#Sollte mit Git versioniert sein!

scriptfilename=`basename "$0"`

if [ $# -lt 2 ]
  then
	cat << EOF
Wenn in diesem Verzeichnis sleep_until_modified.py liegt, kann jedes Mal ein Skript ausgeführt werden, wenn sich eine angegebene Datei ändert. Dies wiederholt sich bis $scriptfilename beendet wird.
Um das Programm zu beenden, muss zwei Mal Control-C gedrückt werden, sonst wird nur Python beendet.

Beispielaufruf: ./$scriptfilename /skript.sh /sich_aendernde_Datei.txt [Parameter_an_skript]
EOF
	exit
fi

while [ 1 ]
do
    python sleep_until_modified.py "$2"
    if [ "$#" -eq 3 ]
  		then
  			./"$1" "$3"
  		else
    		./"$1"
  	fi
  	sleep 1
  	#Während Sleep kann das Programm beendet werden mit Control-C
  	echo "sleep 1 vorbei, jetzt wieder python sleep_until_modified.py ..."
done