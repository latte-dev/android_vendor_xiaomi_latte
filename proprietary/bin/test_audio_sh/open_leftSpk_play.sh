
tinymix -D 1 'codec_out0 mix 0 sprot_loop_in' 1
tinymix -D 1 'sprot_loop_out mix 0 media_loop1_in' 1
tinymix -D 1 'media_loop1_out mix 0 pcm1_in' 1

tinymix -D 1 'pcm1_in gain 0 volume' 0 0
tinymix -D 1 'pcm1_in gain 0 rampduration' 40
tinymix -D 1 'pcm1_in gain 0 mute' 0

tinymix -D 1 'media_loop1_out gain 0 volume' 0 0
tinymix -D 1 'media_loop1_out gain 0 rampduration' 40
tinymix -D 1 'media_loop1_out gain 0 mute' 0

tinymix -D 1 'sprot_loop_out gain 0 volume' 0 0
tinymix -D 1 'sprot_loop_out gain 0 rampduration' 40
tinymix -D 1 'sprot_loop_out gain 0 mute' 0

tinymix -D 1 'codec_out0 gain 0 volume' 0 0
tinymix -D 1 'codec_out0 gain 0 rampduration' 40
tinymix -D 1 'codec_out0 gain 0 mute' 0

tinymix -D 1 'pcm2_in gain 0 mute' 0
tinymix -D 1 'codec_out0 gain 0 mute' 0
tinymix -D 1 'OUT1 Playback Switch' 1
tinymix -D 1 'OUT2 Playback Switch' 1
tinymix -D 1 'OUT3 Playback Switch' 1
tinymix -D 1 'Speaker Switch' 1
tinymix -D 1 'PDM1 R Mux' 'MONO DAC MIX'
tinymix -D 1 'PDM1 L Mux' 'MONO DAC MIX'
tinymix -D 1 'DAC1 MIXR DAC1 Switch' 1
tinymix -D 1 'DAC1 MIXL DAC1 Switch' 1
tinymix -D 1 'sprot_loop_out mix 0 media_loop1_in' 1
tinymix -D 1 'media_loop1_out mix 0 pcm2_in' 1
tinymix -D 1 'codec_out0 mix 0 sprot_loop_in' 1

tinymix -D 1 'Stereo DAC MIXL DAC1 L Switch' 1
tinymix -D 1 'Stereo DAC MIXR DAC1 L Switch' 0

tinymix -D 1 'DAC1 Playback Volume' 80 80

#echo 083 0000 > /d/regmap/0-002c/registers
#echo 0c1 6000 > /d/regmap/0-002c/registers

echo 0080 4000 > /sys/bus/i2c/devices/0-002c/codec_reg

echo "pb sp1 slot 0,1"

nohup tinyplay /system/bin/test_audio_sh/spk.wav -D 1 >/data/logs/nohup.out 2>&1 &

echo "have play the music"
