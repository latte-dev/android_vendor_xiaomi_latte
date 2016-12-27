# $1: wave file to read
# $2: volume(0-15)
# $3: device for output
#     0: current
#     1: speaker
#    -1: raw speaker(left)
#    -2: raw speaker(right)

# tinyplay file.wav [-D card] [-d device] [-p period_size] [-n n_periods]
# sample usage: playback_audio.sh 2000.wav 15 -1

function enable_speaker
{
	echo "enabling speaker"
	tinymix -D 0 'DAC1 MIXL DAC1 Switch' 1
	tinymix -D 0 'DAC1 MIXR DAC1 Switch' 1
	tinymix -D 0 'DAC1 Playback Volume' 150 150
	tinymix -D 0 'Headphone Switch' 0

	tinymix -D 0 'codec_out0 mix 0 pcm1_in' 1
	tinymix -D 0 'pcm1_in gain 0 volume' 0 0
	tinymix -D 0 'pcm1_in gain 0 rampduration' 5
	tinymix -D 0 'pcm1_in gain 0 mute' 0
	tinymix -D 0 'codec_out0 gain 0 volume' 0 0
	tinymix -D 0 'codec_out0 gain 0 rampduration' 5
	tinymix -D 0 'codec_out0 gain 0 mute' 0

	tinymix -D 0 'left Stop' 0
	tinymix -D 0 'right Stop' 0
}

function disable_speaker
{
	echo "disabling speaker"
	tinymix -D 0 'left Stop' 1
	tinymix -D 0 'right Stop' 1

	tinymix -D 0 'DAC1 MIXL DAC1 Switch' 0
	tinymix -D 0 'DAC1 MIXR DAC1 Switch' 0
	tinymix -D 0 'DAC1 Playback Volume' 150 150
	tinymix -D 0 'Headphone Switch' 0

	tinymix -D 0 'codec_out0 mix 0 pcm1_in' 0
	tinymix -D 0 'pcm1_in gain 0 volume' 0 0
	tinymix -D 0 'pcm1_in gain 0 rampduration' 5
	tinymix -D 0 'pcm1_in gain 0 mute' 1
	tinymix -D 0 'codec_out0 gain 0 volume' 0 0
	tinymix -D 0 'codec_out0 gain 0 rampduration' 5
	tinymix -D 0 'codec_out0 gain 0 mute' 1
}

function enable_left_speaker
{
	echo "enabling left speaker"
	tinymix -D 0 'DAC1 MIXL DAC1 Switch' 1
	tinymix -D 0 'DAC1 MIXR DAC1 Switch' 0
	tinymix -D 0 'DAC1 Playback Volume' 150 150
	tinymix -D 0 'Headphone Switch' 0

	tinymix -D 0 'codec_out0 mix 0 pcm1_in' 1
	tinymix -D 0 'pcm1_in gain 0 volume' 0 0
	tinymix -D 0 'pcm1_in gain 0 rampduration' 5
	tinymix -D 0 'pcm1_in gain 0 mute' 0
	tinymix -D 0 'codec_out0 gain 0 volume' 0 0
	tinymix -D 0 'codec_out0 gain 0 rampduration' 5
	tinymix -D 0 'codec_out0 gain 0 mute' 0

	tinymix -D 0 'left Stop' 0
	tinymix -D 0 'right Stop' 1
}

function enable_right_speaker
{
	echo "enabling right speaker"
	tinymix -D 0 'DAC1 MIXL DAC1 Switch' 0
	tinymix -D 0 'DAC1 MIXR DAC1 Switch' 1
	tinymix -D 0 'DAC1 Playback Volume' 150 150
	tinymix -D 0 'Headphone Switch' 0

	tinymix -D 0 'codec_out0 mix 0 pcm1_in' 1
	tinymix -D 0 'pcm1_in gain 0 volume' 0 0
	tinymix -D 0 'pcm1_in gain 0 rampduration' 5
	tinymix -D 0 'pcm1_in gain 0 mute' 0
	tinymix -D 0 'codec_out0 gain 0 volume' 0 0
	tinymix -D 0 'codec_out0 gain 0 rampduration' 5
	tinymix -D 0 'codec_out0 gain 0 mute' 0

	tinymix -D 0 'left Stop' 1
	tinymix -D 0 'right Stop' 0
}

echo "Volume is ignored by this script for now"

echo 0 > /sys/bus/i2c/devices/i2c-NXP9890:00/monitor
echo 0 > /sys/bus/i2c/devices/i2c-NXP9890:01/monitor

case $3 in
    1)
        enable_speaker
    ;;
    -1)
        enable_left_speaker
    ;;
    -2)
        enable_right_speaker
    ;;
esac

tinyplay $1

case $3 in
    1|-1|-2)
        disable_speaker
    ;;
esac

echo 1 > /sys/bus/i2c/devices/i2c-NXP9890:00/monitor
echo 1 > /sys/bus/i2c/devices/i2c-NXP9890:01/monitor

exit 0
