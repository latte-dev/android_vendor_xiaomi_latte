#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/by-name/android_recovery:13423882:c51edb8d73c6a590bbf41a1479a795749e4a5a60; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/by-name/android_boot:10892550:7f91497314986137cdf53b36c84e4a58e6bfb616 EMMC:/dev/block/by-name/android_recovery c51edb8d73c6a590bbf41a1479a795749e4a5a60 13423882 7f91497314986137cdf53b36c84e4a58e6bfb616:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
