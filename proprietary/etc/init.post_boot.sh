#!/system/bin/busybox sh

# set sno
setprop ro.sys.oem.sno `/system/bin/acd-utils r 7 | tail -n 1`
setprop permanent.hw.custom.serialno `/system/bin/acd-utils r 17 | tail -n 1`
