#!/bin/sh

# Temperature sensor DHT11 GPIO and raspberry pi.
# Export your pins:
# gpio export 17 in
# gpio edge 17 both

# Domoticz server
SERVER="localhost:8080"
# DHT  IDX
DHTIDX="32"

#DHTPIN
DHTPIN="4"
TEMP=""

until  [ -n "$TEMP" ] ; do
sleep 5
sudo nice -20 /home/pi/domoticz/scripts/AdafruitDHT.py 11 $DHTPIN > temp.txt
TEMP=$(cat temp.txt|grep Temp|cut -d"=" -f2|cut -d" " -f1)

done
TEMP=$(cat temp.txt|cut -d"=" -f2|cut -d" " -f1)
HUM=$(cat temp.txt|cut -d"=" -f3|cut -d" " -f1)
echo $TEMP
echo $HUM
# Send data
curl --connect-timeout 2 -s -i -H  "Accept: application/json"  "http://$SERVER/json.htm?type=command&param=udevice&idx=$DHTIDX&nvalue=0&svalue=$TEMP;$HUM;2"
TEMP=""
HUM=""
rm temp.txt
