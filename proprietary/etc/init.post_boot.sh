#!/system/bin/busybox sh

# set sno
setprop ro.sys.oem.sno `/system/bin/acd-utils r 7 | tail -n 1`
setprop permanent.hw.custom.serialno `/system/bin/acd-utils r 17 | tail -n 1`
echo > /sys/devices/system/cpu/cpu1/online
echo > /sys/devices/system/cpu/cpu2/online
echo > /sys/devices/system/cpu/cpu3/online 
sleep 25
mount -o rw,remount /system
echo -n 1840000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo -n 1840000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
echo -n 1840000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
echo -n 1840000 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
echo "1840000" > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
echo "90" > /sys/devices/system/cpu/cpufreq/interactive/target_loads
echo "1680000" > /sys/devices/system/cpu/cpufreq/interactive/touchboost_freq
echo "40000" > /sys/devices/system/cpu/cpufreq/interactive/touchboostpulse_duration
echo "99" > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
echo 200 >/sys/class/drm/card0/gt_min_freq_mhz
mount -o ro,remount /system
