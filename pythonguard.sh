#!/bin/bash
#Author: Ronny Worm

if [ $# -lt 2 ]; then
    cat README.md
    exit
fi

my_directory=`dirname "$0"`
script_directory=$(dirname "$1")

clear
echo "PythonGuard was started and waits for changes on $2 ... each time after executing this script, it will sleep for one second and output the current time."
cd "$script_directory"

if [ ! -f "$2" ]; then
  echo "$2 does not exist! The script will exit now."
  exit
fi

if [ ! -f "$1" ]; then
  echo "$1 does not exist! The script will exit now."
  exit
fi


while [ 1 ]
do
    # Execute first
    if [ "$#" -eq 3 ]; then
  			"$1" "$3"
  	elif [ "$#" -eq 4 ]; then
        "$1" "$3" "$4"
    elif [ "$#" -eq 5 ]; then
        "$1" "$3" "$4" "$5"
    elif [ "$#" -eq 6 ]; then
        "$1" "$3" "$4" "$5" "$6"
    else
        "$1"
    fi

    if [ ! -f "$my_directory/sleep_until_modified.py" ]; then
      echo "Please execute this script will the full qualified path"
      echo "$my_directory/sleep_until_modified.py does not exist in"
      echo "$(pwd)"
      exit
    fi  

  	sleep 1
  	#During sleep the script can be stopped with Control-C (two times!)

    printf "$(date +"%H:%M:%S"); "

    # Then wait for changes
    python "$my_directory/sleep_until_modified.py" "$2"
done