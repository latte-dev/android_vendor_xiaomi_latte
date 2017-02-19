climax_hostSW  -d  /dev/i2c-1 --slave=0x34 --xmem=0x1027f -w0x400001 2>&1 >> /data/cit.audio.cal.txt
climax_hostSW  -d  /dev/i2c-1 --slave=0x37 --xmem=0x1027f -w0x400001 2>&1 >> /data/cit.audio.cal.txt
sleep 2
climax_hostSW  -d  /dev/i2c-1 --slave=0x34 --xmem=0x1027f -w0x66666 2>&1 >> /data/cit.audio.cal.txt
climax_hostSW  -d  /dev/i2c-1 --slave=0x37 --xmem=0x1027f -w0x66666 2>&1 >> /data/cit.audio.cal.txt
sleep 2
climax_hostSW -d /dev/i2c-1 -l /etc/firmware/tfa98xx.cnt --dumpmodel=z --cit 2>&1 >> /data/audio.cit.cal.txt
