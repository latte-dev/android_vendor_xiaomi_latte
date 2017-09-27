
gain=$1
echo "the input is $gain !"

gain=$((gain*20))
echo "the gain is $gain !"

#### the volume from 0~~255
tinymix -D 1 'DAC1 Playback Volume' $gain $gain

echo "change gain over!"
