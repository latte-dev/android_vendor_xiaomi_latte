
gain=$1
echo "the input is $gain !"

gain=$((gain*14))
echo "the gain is $gain !"

#### the volume from 0~~127
tinymix -D 1 'ADC1 Capture Volume' $gain $gain

echo "change gain over!"
