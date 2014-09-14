#!/usr/bin/python
import socket
import time
import urllib2
import re

# For use with LightwaveRF wifi link and energy monitor

# Create a virtual electric utility device in Domoticz note the IDX val
# Change the idx= value in the URL string below on line 26 and the server IP/port

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.SOL_UDP)
sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
sock.sendto("100,@?W", 0, ('255.255.255.255' , 9760))


sock2 = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock2.bind(('0.0.0.0', 9761))
sock2.settimeout(5)

while True:
	data, addr = sock2.recvfrom(1024) # buffer size is 1024 bytes
	print "received message:", data
	if re.search("100\\,\\?W=.*",data):
		m = re.search(r"(\d+)\,(\d+)\,(\d+),(\d+)",data)
		urllib2.urlopen("http://192.168.0.101:8080/json.htm?type=command&param=udevice&idx=46&nvalue=0&svalue="+m.group(1)+";"+m.group(3))
		sock2.close()
		sock.close()
	sock2.close()
	sock.close()
	break
