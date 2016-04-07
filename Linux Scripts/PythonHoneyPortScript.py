
#!/usr/bin/python
import socket
import select
import os
ports = [Unused Port #1, Unused Port #2, Unused Port #3] #Change to port numbers
def make_socket(number):
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	s.bind(("0.0.0.0", port))
	s.listen(5)
	return s
print "Started on ports ", ports

read_list = []
for port in ports:
	read_list.append(make_socket(port))

while True:
	readable, writable, errorer = select.select(read_list, [], [])
	for s in readable:
		c, addr = s.accept()
		print addr, ":", c.getsockname()
       client = str(addr[0])
       if client in ("scoring engine", "127.0.0.1"):  #change to scoring engine ip
             c.shutdown(socket.SHUT_RDWR)
             c.close()      
	os.system(“ufw insert 1 deny incoming from ‘client’”) 
     	c.shutdown(socket.SHUT_RDWR)
      	c.close()
