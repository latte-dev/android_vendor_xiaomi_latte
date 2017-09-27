
gain=$1
echo "the input is $gain !"

gain=$((gain*1000))
echo "the gain is $gain !"

#### the max time is 10s.
echo $gain > /sys/class/timed_output/vibrator_1/enable
