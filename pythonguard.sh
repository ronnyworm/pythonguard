#!/bin/bash
#Author: Ronny Worm
#Sollte mit Git versioniert sein!

scriptfilename=`basename "$0"`
my_directory=`dirname "$0"`

if [ $# -lt 2 ]
  then
	cat << EOF
Wenn in diesem Verzeichnis sleep_until_modified.py liegt, kann jedes Mal ein Skript ausgeführt werden, wenn sich eine angegebene Datei ändert. Dies wiederholt sich bis $scriptfilename beendet wird.
Um das Programm zu beenden, muss zwei Mal Control-C gedrückt werden, sonst wird nur Python beendet. Bei Beendigung dieses Skripts wird zwangsweise das übergebene Skript nochmal ausgeführt.
Wichtig: Immer vollständige Pfade eingeben!

Beispielaufruf: /complete_path/$scriptfilename /complete_path/skript.sh /complete_path/sich_aendernde_Datei.txt [Parameter_an_skript]
EOF
	exit
fi

script_directory=$(dirname "$1")

clear
echo "Python Guard wurde gestartet und wartet auf Änderungen an $2 ..."
cd "$script_directory"

if [ ! -f "$2" ]; then
  echo "$2 existiert nicht! Programm wird beendet"
  exit
fi

if [ ! -f "$1" ]; then
  echo "$1 existiert nicht! Programm wird beendet"
  exit
fi

count=0

while [ 1 ]
do
    # Erst ausführen
    if [ "$#" -eq 3 ]
  		then
  			"$1" "$3"
  		else
    		"$1"
  	fi

    if [ ! -f "$my_directory/sleep_until_modified.py" ]; then
      echo "Rufen Sie das Programm bitte mit vollständigen Pfad auf."
      echo "$my_directory/sleep_until_modified.py existiert nämlich nicht in"
      echo "$(pwd)"
      exit
    fi  

  	sleep 1

  	#Während Sleep kann das Programm beendet werden mit Control-C (zwei Mal!)
    if [ $count -eq 0 ]; then
      echo "sleep 1 vorbei, jetzt wieder python sleep_until_modified.py ... "
    else
      printf "sleep done; "
    fi

    # Dann warten
    python "$my_directory/sleep_until_modified.py" "$2"
    count=$((count+1))
done