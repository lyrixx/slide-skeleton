#!/bin/bash

# apt-get install inotify-tools

BASE_PATH=`dirname $0`

if [[ `which inotifywait` ]]; then
    while true; do
        inotifywait -e modify $BASE_PATH/slides.md | while read line; do
            $BASE_PATH/build.sh
        done
    done
elif [[ `which fswatch` ]]; then
    fswatch $BASE_PATH/slides.md "$BASE_PATH/build.sh"
else
    NOCOLOR='\e[0m'
    REDCOLOR='\e[37;41m'

    echo -e "$REDCOLOR You must install one of 'inotifywait' or 'fswatch'.$NOCOLOR"
    echo ""
    echo ' # apt-get install inotify-tools'
    echo ' # brew install fswatch'

    exit 1
fi
