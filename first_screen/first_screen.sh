#!/bin/bash

help() {
cat <<EOF
    first_screen.sh <m3u8-url>
EOF
    exit 0
}

if [ $# != 1 ]; then
    help
fi

url=$1
echo "get m3u8"
m3u8=` curl  "$url"`
index=0
echo
echo "$m3u8" | while read line
do
    echo "$line" | grep "#EXTINF:"
    if [ $? == 0 ]; then
        read line
        host=`echo "$url" | awk -F/ '{print $3}'`
        curl  "http://$host$line" -o /dev/null
        if [ $index == 2 ];then
            exit 0
        else
            index=$((index+1))
        fi
        echo
    fi
done