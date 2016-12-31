#!/system/bin/sh

# This script is started from init.rc on early-boot

# Load atomisp driver and dependencies in the proper order.  Note that
# we cannot do this from init.rc directly because atomisp wants to
# make a request_firmware call from its module init function, which
# init won't service until the module load completes!
insmod /system/lib/modules/videobuf-core.ko
insmod /system/lib/modules/videobuf-vmalloc.ko
insmod /system/lib/modules/s5k4h8drv.ko
insmod /system/lib/modules/t4ka3drv.ko
insmod /system/lib/modules/ov5693.ko up_delay=3
insmod /system/lib/modules/atomisp-css2401a0_v21.ko dypool_enable=y repool_pgnr=32768
