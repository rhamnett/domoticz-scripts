#!/usr/bin/python
import socket
import time
import urllib2
import re


sock2 = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock2.bind(('0.0.0.0', 9761))
sock2.settimeout(20)

while True:
	data, addr = sock2.recvfrom(1024) # buffer size is 1024 bytes
#	print "received message:", data
	if re.search("\*\!",data):
		m = re.search(r'cUse":(\d+),"maxUse":(\d+),"todUse":(\d+),"yesUse":(\d+)',data)
		urllib2.urlopen("http://192.168.0.101:8080/json.htm?type=command&param=udevice&idx=46&nvalue=0&svalue="+m.group(1)+";"+m.group(3))
#		print "http://192.168.0.101:8080/json.htm?type=command&param=udevice&idx=46&nvalue=0&svalue="+m.group(1)+";"+m.group(3)
		sock2.close()
	sock2.close()
	break
