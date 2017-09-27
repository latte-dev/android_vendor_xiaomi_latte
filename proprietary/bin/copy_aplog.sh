#!/system/bin/sh

APLOG_DIR=/sdcard/logs
PANICLOG_DIR=/data/dontpanic
INTEL_LOGS_DIR=/data/logs
ANR_DIR=/data/anr
RECOVERY_DIR=/cache/recovery

#cd $APLOG_DIR && rm -fr gps hcidump anr recovery
mkdir -p $APLOG_DIR

#dumpsys alarm > $INTEL_LOGS_DIR/alarm.txt

getprop > $APLOG_DIR/prop.txt
[ -e /system/build.prop ] && cp /system/build.prop $APLOG_DIR/
[ -e /system/etc/version.conf ] && cp /system/etc/version.conf $APLOG_DIR/
[ -d $INTEL_LOGS_DIR ] && cp -a $INTEL_LOGS_DIR $APLOG_DIR
[ -d $PANICLOG_DIR ] && cp -a $PANICLOG_DIR $APLOG_DIR/panic
[ -d $ANR_DIR ] &&  cp -a $ANR_DIR $APLOG_DIR/anr
[ -d $RECOVERY_DIR ] && cp -a $RECOVERY_DIR/ $APLOG_DIR


FILENAME=$(date +%Y_%m_%d_%H_%M_%S)

mkdir -p /sdcard/aplog
tar zcf /sdcard/aplog/${FILENAME}_ap_log.tgz $APLOG_DIR

rm -rf $APLOG_DIR
rm -f $INTEL_LOGS_DIR/tcp*
