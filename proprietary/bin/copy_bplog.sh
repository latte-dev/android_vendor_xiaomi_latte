#!/system/bin/sh

BPLOG_DIR=/sdcard/bplogs/
INTEL_LOGS_DIR=/data/logs/

#cd $APLOG_DIR && rm -fr gps hcidump anr recovery
mkdir -p $BPLOG_DIR
#tcplog=$(getprop persist.service.tcplog.enable)

cp -a ${INTEL_LOGS_DIR}* $BPLOG_DIR

FILENAME=$(date +%Y_%m_%d_%H_%M_%S)
#setprop persist.service.tcplog.enable 0

mkdir -p /sdcard/bplog
tar zcf /sdcard/bplog/${FILENAME}_bplog.tgz $BPLOG_DIR

rm -rf $BPLOG_DIR
