ALL_WAV_FILES_PATH=$DATA_ROOT_PATH/wav
TRAIN_WAV_FILES_PATH=$OUTPUT_PATH/train
TEST_WAV_FILES_PATH=$OUTPUT_PATH/test
TRAIN_EXTRACT_FILE_PATH=$DATA_ROOT_PATH/sentence/train.set
TEST_EXTRACT_FILE_PATH=$DATA_ROOT_PATH/mfcc/test.ark

if [ ! -d "$ALL_WAV_FILES_PATH" ]; then
    echo "Error: no $ALL_WAV_FILES_PATH directory!"
    exit 1
fi
if [ ! -f "$TRAIN_EXTRACT_FILE_PATH" ]; then
    echo "Error: no $TRAIN_EXTRACT_FILE_PATH file!"
    exit 1
fi
if [ ! -f "$TEST_EXTRACT_FILE_PATH" ]; then
    echo "Error: no $TEST_EXTRACT_FILE_PATH file!"
    exit 1
fi
echo "Spliting wav files to $TRAIN_WAV_FILES_PATH and $TEST_WAV_FILES_PATH..."
## Preparing train and test directories ##
if [ ! -d "$TRAIN_WAV_FILES_PATH" ]; then
    echo "  Making directory $TRAIN_WAV_FILES_PATH..."
    mkdir -pv $TRAIN_WAV_FILES_PATH
fi
if [ ! -d "$TEST_WAV_FILES_PATH" ]; then
    echo "  Making directory $TEST_WAV_FILES_PATH..."
    mkdir -pv $TEST_WAV_FILES_PATH
fi

## Getting all train wav files
echo "  Getting train wav file names..."
TRAIN_FILES=`sed -e "s/\([^,]*\),\(.*\)/\1\.wav/g" $TRAIN_EXTRACT_FILE_PATH`

## Getting all test wav files
echo "  Getting test wav file names..."
TEST_FILES=`sed -e "s/\(.*\)_\(.* \)\(.*\)/\1\.wav/g" $TEST_EXTRACT_FILE_PATH | uniq`

echo "  Linking train wav files to $TRAIN_WAV_FILES_PATH..."
for file in $TRAIN_FILES; do
    if [ ! -h $TRAIN_WAV_FILES_PATH/$file ]; then
        ln -s $ALL_WAV_FILES_PATH/$file $TRAIN_WAV_FILES_PATH/$file
    fi
done

echo "  Linking test wav files to $TEST_WAV_FILES_PATH..."
for file in $TEST_FILES; do
    if [ ! -h $TEST_WAV_FILES_PATH/$file ]; then
        ln -s $ALL_WAV_FILES_PATH/$file $TEST_WAV_FILES_PATH/$file
    fi
done

