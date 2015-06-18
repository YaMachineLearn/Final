TRAIN_EXTRACT_FILE_PATH=$DATA_ROOT_PATH/sentence/train.set
WAV_SCP_PATH=$OUTPUT_PATH/train
TRAIN_WAV_FILE_PATH=data/train/wav

if [ ! -f "$TRAIN_EXTRACT_FILE_PATH" ]; then
    echo "Error: no $TRAIN_EXTRACT_FILE_PATH file!"
    exit 1
fi

echo "Creating wav.scp to $WAV_SCP_PATH..."
if [ ! -d "$WAV_SCP_PATH" ]; then
    echo "  Making directory $WAV_SCP_PATH..."
    mkdir -pv $WAV_SCP_PATH
fi

TRAIN_FILES=`sed -e "s/\([^,]*\),\(.*\)/\1/g" $TRAIN_EXTRACT_FILE_PATH`
> $WAV_SCP_PATH/wav.scp
for file in $TRAIN_FILES; do
    echo "$file $TRAIN_WAV_FILE_PATH/$file.wav" >> $WAV_SCP_PATH/wav.scp
done
