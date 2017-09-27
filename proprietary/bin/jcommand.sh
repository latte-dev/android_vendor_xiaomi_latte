#!/system/bin/sh

PARA_ALL=`getprop sys.jcommand_para`
#PARA_ALL=$1

if [ "$PARA_ALL" == "" ]; then
    echo "PARA_ALL is null" >>/data/jcommand_log.txt
else
    setprop sys.jcommand_para ""
fi

#PARA_M=MODE
#PARA_1=PA1
#PARA_2=PA2
#echo "all is :$PARA_ALL" >>/data/jcommand_log.txt

PARA_TEMP=${PARA_ALL%%\]*}
#echo "temp is :${PARA_TEMP}"
PARA_M=${PARA_TEMP#*\[}
#echo $PARA_M

PARA_TEMP=${PARA_ALL%%\]*}
#echo "temp is :$PARA_TEMP"
PARA_M=${PARA_TEMP#\[*}
#echo "mode : $PARA_M"

PARA_TEMP=${PARA_ALL#*\]}
PARA_TEMP_1=${PARA_TEMP%%\]*}
#echo "temp is :$PARA_TEMP"
PARA_1=${PARA_TEMP_1#\[*}
#echo "para 1 is :$PARA_1"

PARA_TEMP=${PARA_ALL##*\[}
#echo "temp is : $PARA_TEMP"
PARA_2=${PARA_TEMP%*\]}
#echo "para 2 : $PARA_2"


##  excute the writesys from intel platform
##  para_1 : value ; para_2: sys_filename ; 
##  para_1 and para_2 shouldnt be null
function SetPMSys() {
    echo " we would excute: write $PARA_1 into $PARA_2"
    echo $PARA_1 >  $PARA_2
}

##  excute the setmtu from QC platform
##  para_1 :ifname ; para_2: MTU ; 
##  para_1 and para_2 shouldnt be null
function SetMtu() {
    echo " we would excute: ip link set dev $PARA_1 mtu $PARA_2"
    ip link set dev $PARA_1 mtu $PARA_2
}

##  excute the Wifi-Wapi-Cert from QC platform
##  para_1: NULL ; para_2 : NULL
##  para_1/ para_2 is not null, but we can  ignore it
function CopyCertfilefromSD() {
    echo " we would excute: CopyCertfilefromSD"
    DEFAULT_CERT_FILE_PATH=/data/wapi_certificate
    DEFAULT_SD_PATH=/sdcard
    mkdir ${DEFAULT_CERT_FILE_PATH}
    chmod 777 ${DEFAULT_CERT_FILE_PATH}
    cp ${DEFAULT_SD_PATH}/*.cer  ${DEFAULT_CERT_FILE_PATH}
    chmod 777  ${DEFAULT_CERT_FILE_PATH}/*.cer
}

##  delete file
##  para_1: path to delete
##  para_2: 0 - remove path
##          1 - clear files in path but do not remove path
##          2 - remove oldest file in path
function DeleteFile() {
    echo " we would excute: DeleteFile $PARA_1 $PARA_2"
    if [ -f "$PARA_1" ]; then
        rm "$PARA_1"
    elif [ -d "$PARA_1" ]; then
        if [ "$PARA_2" == "1" ]; then
            cd "$PARA_1"
            ls | xargs rm -r
        elif [ "$PARA_2" == "2" ]; then
            cd "$PARA_1"
            OLDEST=$(busybox ls -rt | head -1)
            rm -r $OLDEST
        else
            rm -r "$PARA_1"
        fi
    else
        echo "DeleteFile while PARA_1 is not a valid file path" >>/data/jcommand_log.txt
    fi
}

# add by liuxu7@lenovo.com, begin

##  set default install location
##  para_1 : location code, should not be null
##  location code:
##  0 [auto]: Let system decide the best location
##  1 [internal]: Install on internal device storage
##  2 [external]: Install on external media
function SetDefaultInstallLocation() {
    echo " we would excute: pm set-install-location $PARA_1"
    pm set-install-location $PARA_1
}

# add by liuxu7@lenovo.com, end

#====================================
#main

if [ "$PARA_M" == "PMSYS" ]; then
    SetPMSys
elif [ "$PARA_M" == "SETMTU" ]; then
    SetMtu
elif [ "$PARA_M" == "CPCER" ]; then
    CopyCertfilefromSD
elif [ "$PARA_M" == "DELFILE" ]; then
    DeleteFile
# add by liuxu7@lenovo.com, begin
elif [ "$PARA_M" == "SETPMLOCATION" ]; then
    SetDefaultInstallLocation
# add by liuxu7@lenovo.com, end
fi
