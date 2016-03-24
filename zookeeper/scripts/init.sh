#!/bin/bash

# CONFIGURE ZOOKEEPER NODE IP's

ZOOKEEPERCONFIG=/etc/zookeeper/conf/zoo.cfg

if [[ -f "$ZOOKEEPERCONFIG" ]] ; then  sed -i".bak" '/^server\./d' $ZOOKEEPERCONFIG; fi

if [[ "$#" -ne 0 ]]
then
    strips="$@"
elif [[ -n "$ZOOKIPS" ]]
then
    strips="$ZOOKIPS"
else
    exit 1
fi

ips=$(echo "$strips" | tr ",", "\n")

let j=1
for ip in $ips
do
    echo "server.${j}=${ip}:2888:3888" >> $ZOOKEEPERCONFIG
    ((j=j+1))
done

echo "CONFIG ZOOKEEPER NODES IP'S, DONE!"

# Start Supervisor

/usr/bin/supervisord