"""
Program: Pico Web Server

Device: Raspberry Pi Pico
Description: Raspberry Pi Pico Web Server

BlueDot Docs (getting started): https://bluedot.readthedocs.io/en/latest/gettingstarted.html

Packages to Install:
    sudo pip3 install bluedot

# Important snippets
#  https://datasheets.raspberrypi.com/picow/connecting-to-the-internet-with-pico-w.pdf

"""

import network
import socket
import time
from machine import Pin

led = Pin(15, Pin.OUT)
ssid = '<SSID>'
password = '<PASS>'
wlan = network.WLAN(network.STA_IF)
wlan.active(True)
wlan.connect(ssid, password)

html = """<!DOCTYPE html>
<html>
<head> <title>Pico W</title> </head>
<body> <h1>Pico W</h1>
<p>Hello World</p>
</body>
</html>
"""
# Wait for connect or fail
max_wait = 10

while max_wait > 0:

    if wlan.status() < 0 or wlan.status() >= 3:
        break

    max_wait -= 1
    print('waiting for connection...')
    time.sleep(1)

# Handle connection error
if wlan.status() != 3:

    raise RuntimeError('network connection failed')

else:

    print('connected')

    status = wlan.ifconfig()
    print( 'ip = ' + status[0] )

# Open socket
addr = socket.getaddrinfo('0.0.0.0', 80)[0][-1]

s = socket.socket()
s.bind(addr)
s.listen(1)

print('listening on', addr)

# Listen for incoming connections
while True:
    
    try:
        # cl = client connection, addr = client address
        cl, addr = s.accept()

        print('client connected from', addr)
        
        # Save client request info into a temp file for reading (rwb = read/write binary)
        cl_file = cl.makefile('rwb', 0)

        # Read request
        while True:
            line = cl_file.readline()

            if not line or line == b'\r\n':
                break

        # Build resoibse
        response = html
        cl.send('HTTP/1.0 200 OK\r\nContent-type: text/html\r\n\r\n')
        cl.send(response)
        cl.close()
    
    # If we have trouble parsing client request - hit the exception block
    except OSError as e:
        cl.close()
        print('connection closed')
