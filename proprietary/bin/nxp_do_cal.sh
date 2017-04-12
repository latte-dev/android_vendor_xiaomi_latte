climax_hostSW -d /dev/i2c-1  -l /etc/firmware/tfa98xx.cnt  --resetMtpEx 2>&1 >> /data/cit.audio.cal.txt
sleep 0.5
climax_hostSW -d /dev/i2c-1 --calibrate=once -l /etc/firmware/tfa98xx.cnt 2>&1 >> /data/cit.audio.cal.txt
climax_hostSW -d /dev/i2c-1 -l /etc/firmware/tfa98xx.cnt --calshow --cit 2>&1 >> /data/cit.audio.cal.txt
