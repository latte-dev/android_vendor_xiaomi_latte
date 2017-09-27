
echo "kill tinycap"

killall tinycap

killall tinyplay

echo "break loopbank"

tinymix -D 1 "DAC1 MIXR Stereo ADC Switch" 0
tinymix -D 1 "DAC1 MIXL Stereo ADC Switch" 0
tinymix -D 1 'Stereo DAC MIXL DAC1 L Switch' 0
tinymix -D 1 'Stereo DAC MIXR DAC1 R Switch' 0
tinymix -D 1 'Stereo DAC MIXL DAC2 L Switch' 0
tinymix -D 1 'Stereo DAC MIXR DAC2 R Switch' 0
tinymix -D 1 'Stereo DAC MIXR DAC1 L Switch' 0
tinymix -D 1 'Stereo DAC MIXL DAC1 R Switch' 0
tinymix -D 1 "Sto1 ADC MIXL ADC1 Switch" 0
tinymix -D 1 "Sto1 ADC MIXR ADC1 Switch" 0
tinymix -D 1 "Sto2 ADC MIXL ADC1 Switch" 0
tinymix -D 1 "Sto2 ADC MIXR ADC1 Switch" 0
tinymix -D 1 "Headset Mic Switch" 0
tinymix -D 1 'pcm1_out mix 0 codec_in1' 0

tinymix -D 1 'codec_out0 mix 0 sprot_loop_in' 0
tinymix -D 1 'sprot_loop_out mix 0 media_loop1_in' 0
tinymix -D 1 'media_loop1_out mix 0 pcm1_in' 0

tinymix -D 1 'OUT1 Playback Switch' 0
tinymix -D 1 'OUT2 Playback Switch' 0
tinymix -D 1 'OUT3 Playback Switch' 0
tinymix -D 1 'Speaker Switch' 0
tinymix -D 1 'DAC1 MIXR DAC1 Switch' 0
tinymix -D 1 'DAC1 MIXL DAC1 Switch' 0
tinymix -D 1 'sprot_loop_out mix 0 media_loop1_in' 0
tinymix -D 1 'media_loop1_out mix 0 pcm2_in' 0
tinymix -D 1 'codec_out0 mix 0 sprot_loop_in' 0
tinymix -D 1 'codec_in1 gain 0 mute' 1
tinymix -D 1 'pcm1_out gain 0 mute' 1
tinymix -D 1 'pcm1_in gain 0 mute' 1
tinymix -D 1 'media_loop1_out gain 0 mute' 1
tinymix -D 1 'sprot_loop_out gain 0 mute' 1
tinymix -D 1 'codec_out0 gain 0 mute' 1
tinymix -D 1 'pcm2_in gain 0 mute' 1
tinymix -D 1 'codec_out0 gain 0 mute' 1

tinymix -D 1 'codec_out1 mix 0 pcm1_in' 0
tinymix -D 1 'pcm1_in gain 0 mute' 1
tinymix -D 1 'codec_out1 gain 0 mute' 1
tinymix -D 1 'OUT1 Playback Switch' 0
tinymix -D 1 'OUT2 Playback Switch' 0
tinymix -D 1 "Headphone Switch" 0
tinymix -D 1 "Speaker Switch" 0
tinymix -D 1 'Sto1 ADC MIXL ADC2 Switch' 0
tinymix -D 1 'Sto1 ADC MIXL ADC1 Switch' 0
tinymix -D 1 'Sto1 ADC MIXR ADC2 Switch' 0
tinymix -D 1 'Sto1 ADC MIXR ADC1 Switch' 0
tinymix -D 1 'Int Mic Switch' 0
tinymix -D 1 'Headset Mic Switch'  0
tinymix -D 1 'pcm1_out mix 0 codec_in0' 0
tinymix -D 1 'pcm1_out gain 0 mute' 1
tinymix -D 1 'codec_in0 gain 0 mute' 1
tinymix -D 1 'codec_in1 gain 0 mute' 1

echo 0080 4000 > /sys/bus/i2c/devices/0-002c/codec_reg
