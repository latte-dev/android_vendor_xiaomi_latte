#!/system/bin/sh

# This script is started from init.rc on early-boot

# Load atomisp driver and dependencies in the proper order.  Note that
# we cannot do this from init.rc directly because atomisp wants to
# make a request_firmware call from its module init function, which
# init won't service until the module load completes!
modules=`getprop ro.modules.location`
insmod $modules/heci.ko
insmod $modules/heci-ish.ko
insmod $modules/hid-heci-ish.ko
insmod $modules/sens-col-core.ko
insmod $modules/hid-sensor-hub.ko
insmod $modules/hid-sensor-accel-3d.ko
insmod $modules/hid-sensor-als.ko
insmod $modules/hid-sensor-gyro-3d.ko
insmod $modules/hid-sensor-iio-common.ko
insmod $modules/hid-sensor-incl-3d.ko
insmod $modules/hid-sensor-magn-3d.ko
insmod $modules/hid-sensor-trigger.ko
insmod $modules/videobuf-core.ko
insmod $modules/videobuf-vmalloc.ko
insmod $modules/s5k4h8drv.ko
insmod $modules/t4ka3drv.ko
insmod $modules/ov5693.ko up_delay=3
insmod $modules/atomisp-css2401a0_v21.ko dypool_enable=y repool_pgnr=32768
