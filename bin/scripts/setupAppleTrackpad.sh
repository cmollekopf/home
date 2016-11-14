#!/bin/bash
echo -e 'power on\nconnect 88:63:DF:F1:D9:92\nquit' | bluetoothctl
sleep 5
synclient TapButton1=1
synclient MinSpeed=1.5
synclient MaxSpeed=3
