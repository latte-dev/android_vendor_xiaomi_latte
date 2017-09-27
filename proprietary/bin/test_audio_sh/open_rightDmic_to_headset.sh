
echo 'pb hs slot 2,3'

tinymix -D 1 'codec_out1 mix 0 pcm1_in' 1
tinymix -D 1 'pcm1_in gain 0 mute' 0
tinymix -D 1 'pcm1_in gain 0 volume' 0 0
tinymix -D 1 'pcm1_in gain 0 rampduration' 40
tinymix -D 1 'codec_out1 gain 0 mute' 0
tinymix -D 1 'codec_out1 gain 0 volume' 0 0
tinymix -D 1 'codec_out1 gain 0 rampduration' 40
tinymix -D 1 'OUT1 Playback Switch' 1
tinymix -D 1 'OUT2 Playback Switch' 1
tinymix -D 1 'DAC2 Playback Volume' 160 160
tinymix -D 1 "Headphone Switch" 1
tinymix -D 1 "Speaker Switch" 0
tinymix -D 1 "DAC1 MIXR Stereo ADC Switch" 1
tinymix -D 1 "DAC1 MIXL Stereo ADC Switch" 1
tinymix -D 1 'Stereo1 DMIC Mux' 'DMIC1'
tinymix -D 1 'Stereo1 ADC L2 Mux' 'DMIC'
tinymix -D 1 'Stereo1 ADC R2 Mux' 'DMIC'
tinymix -D 1 'Sto1 ADC MIXL ADC2 Switch' 1
tinymix -D 1 'Sto1 ADC MIXL ADC1 Switch' 0
tinymix -D 1 'Sto1 ADC MIXR ADC2 Switch' 1
tinymix -D 1 'Sto1 ADC MIXR ADC1 Switch' 0
tinymix -D 1 'IF1 ADC1 IN1 Mux' 'IF_ADC1'
tinymix -D 1 'IF1 ADC1 IN2 Mux' 'IF1_ADC1_IN1'
tinymix -D 1 'Int Mic Switch' 1
tinymix -D 1 'Headset Mic Switch'  0
tinymix -D 1 'pcm1_out mix 0 codec_in0' 1
tinymix -D 1 'pcm1_out gain 0 volume' 80%,80%
tinymix -D 1 'pcm1_out gain 0 rampduration' 50
tinymix -D 1 'pcm1_out gain 0 mute' 0
tinymix -D 1 'codec_in deinterleaver codec_in0_0' 'slot 0'
tinymix -D 1 'codec_in deinterleaver codec_in0_1' 'slot 1'
tinymix -D 1 'codec_in0 gain 0 volume' 80%,80%
tinymix -D 1 'codec_in0 gain 0 rampduration' 50
tinymix -D 1 'codec_in0 gain 0 mute' 0
tinymix -D 1 'codec_in1 gain 0 volume' 80%,80%
tinymix -D 1 'codec_in1 gain 0 rampduration' 50
tinymix -D 1 'codec_in1 gain 0 mute' 0

echo 002a ffff > /sys/bus/i2c/devices/0-002c/codec_reg

tinymix -D 1 'Stereo DAC MIXL DAC1 L Switch' 0
tinymix -D 1 'Stereo DAC MIXL DAC2 L Switch' 0
tinymix -D 1 'Stereo DAC MIXL DAC1 R Switch' 1
tinymix -D 1 'Stereo DAC MIXR DAC1 R Switch' 1
tinymix -D 1 'Stereo DAC MIXR DAC2 R Switch' 0
tinymix -D 1 'Stereo DAC MIXR DAC1 L Switch' 0

echo 0080 8000 > /sys/bus/i2c/devices/0-002c/codec_reg
echo 0050 a565 > /sys/bus/i2c/devices/0-002c/codec_reg

echo "loopback has open"
