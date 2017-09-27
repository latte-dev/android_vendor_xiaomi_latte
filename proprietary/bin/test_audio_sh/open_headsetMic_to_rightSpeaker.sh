####!bin/sh  not used

#### headset mic input

tinymix -D 1 "Stereo1 ADC1 Mux" "ADC1/2"
tinymix -D 1 "Stereo2 ADC1 Mux" "ADC1/2"
tinymix -D 1 "Sto1 ADC MIXL ADC2 Switch" 0
tinymix -D 1 "Sto1 ADC MIXR ADC2 Switch" 0
tinymix -D 1 "Sto2 ADC MIXL ADC2 Switch" 0
tinymix -D 1 "Sto2 ADC MIXR ADC2 Switch" 0
tinymix -D 1 "Sto1 ADC MIXL ADC1 Switch" 1
tinymix -D 1 "Sto1 ADC MIXR ADC1 Switch" 1
tinymix -D 1 "Sto2 ADC MIXL ADC1 Switch" 1
tinymix -D 1 "Sto2 ADC MIXR ADC1 Switch" 1
tinymix -D 1 "Stereo2 ADC LR Mux" "L"
tinymix -D 1 "IF1 ADC1 Mux" "STO1 ADC MIX"
tinymix -D 1 "IF1 ADC2 Mux" "STO2 ADC MIX"
tinymix -D 1 "Headset Mic Switch" 1

echo  cap amic slot 0 
tinymix -D 1 'pcm1_out mix 0 codec_in1' 1

tinymix -D 1 'codec_in deinterleaver codec_in0_0' 'none'
tinymix -D 1 'codec_in deinterleaver codec_in0_1' 'none'
tinymix -D 1 'codec_in deinterleaver codec_in1_0' 'slot 0'
tinymix -D 1 'codec_in deinterleaver codec_in1_1' 'slot 0'

tinymix -D 1 'codec_in1 gain 0 volume' 0 0
tinymix -D 1 'codec_in1 gain 0 rampduration' 50
tinymix -D 1 'codec_in1 gain 0 mute' 0

tinymix -D 1 'pcm1_out gain 0 volume' 0 0
tinymix -D 1 'pcm1_out gain 0 rampduration' 50
tinymix -D 1 'pcm1_out gain 0 mute' 0

tinymix -D 1 'IN1 Boost' 2
tinymix -D 1 'ADC1 Capture Volume' 63 63
tinymix -D 1 'Mono ADC Capture Volume' 60 60

tinymix -D 1 'IO Mode' 'I2C'

#### speaker play

#echo 083 0000 > /d/regmap/0-002c/registers
#echo 0c1 6000 > /d/regmap/0-002c/registers

echo "pb sp1 slot 0,1"
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
tinymix -D 1 'DAC1 Playback Volume' 155 155
tinymix -D 1 'Speaker Switch' 1
tinymix -D 1 'PDM1 R Mux' 'MONO DAC MIX'
tinymix -D 1 'PDM1 L Mux' 'MONO DAC MIX'
tinymix -D 1 'DAC1 MIXR DAC1 Switch' 1
tinymix -D 1 'DAC1 MIXL DAC1 Switch' 1
tinymix -D 1 'sprot_loop_out mix 0 media_loop1_in' 1
tinymix -D 1 'media_loop1_out mix 0 pcm2_in' 1
tinymix -D 1 'codec_out0 mix 0 sprot_loop_in' 1

echo 0080 8000 > /sys/bus/i2c/devices/0-002c/codec_reg
echo 0003 00c0 > /sys/bus/i2c/devices/0-002c/codec_reg
echo 002a aaaa > /sys/bus/i2c/devices/0-002c/codec_reg

tinymix -D 1 'Stereo DAC MIXL DAC1 L Switch' 0
tinymix -D 1 'Stereo DAC MIXR DAC1 L Switch' 1

#### lookback

tinymix -D 1 "DAC1 MIXR Stereo ADC Switch" 1
tinymix -D 1 "DAC1 MIXL Stereo ADC Switch" 1

#### exe mic

sleep 1

echo "start tinycap"

nohup tinycap /data/logs/amic.wav -D 1 -d 0 -r 48000 -c 2 -b 16 >/data/logs/nohup.out 2>&1 &

echo "loopback has open"
