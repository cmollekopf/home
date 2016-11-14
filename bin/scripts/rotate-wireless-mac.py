#!/usr/bin/env python2.7

import re
import subprocess
import string

interface='wlan0'

output = subprocess.Popen(['/sbin/ifconfig', interface], stdout=subprocess.PIPE).communicate()[0]
macaddress = re.findall('ether (.*)  txqueuelen', output)[0]
ma = macaddress.split(':')

newlast = int(ma[-1], 16) + 1
ma[-1] = hex(newlast)[-2:]

print 'Previous MAC address:     %s' % macaddress
print 'Switching to MAC address: %s' % string.join(ma, ':')

subprocess.Popen(['/sbin/ifconfig', interface, 'down'])
subprocess.Popen(['/sbin/ifconfig', interface, 'hw', 'ether', string.join(ma, ':')])
subprocess.Popen(['/sbin/ifconfig', interface, 'up'])
