ALL_WAV_FILES_PATH=$DATA_ROOT_PATH/wav
TRAIN_WAV_FILES_PATH=$DATA_ROOT_PATH/train
TEST_WAV_FILES_PATH=$DATA_ROOT_PATH/test
TRAIN_LABEL_FILE_PATH=$DATA_ROOT_PATH/label/train.lab


if [ -z "$1" ]; then
    if [ ! -d "$ALL_WAV_FILES_PATH" ]; then
        echo "Error: no $ALL_WAV_FILES_PATH directory!"
        exit 1
    fi
    if [ ! -f "$TRAIN_LABEL_FILE_PATH" ]; then
        echo "Error: no $TRAIN_LABEL_FILE_PATH file!"
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
    TRAIN_FILES=`sed -e "s/\(.*\)_\(.*\),\(.*\)/\1/g" $TRAIN_LABEL_FILE_PATH | uniq`

    echo "  Moving train wav files to $TRAIN_WAV_FILES_PATH..."
    for file in $TRAIN_FILES; do
        mv $ALL_WAV_FILES_PATH/"$file.wav" $TRAIN_WAV_FILES_PATH
    done

    echo "  Moving test wav files to $TEST_WAV_FILES_PATH..."
    for file in `ls $ALL_WAV_FILES_PATH`; do
        mv $ALL_WAV_FILES_PATH/$file $TEST_WAV_FILES_PATH
    done

    ## Removing wav directory
    echo "  Removing $ALL_WAV_FILES_PATH directory..."
    rm -rf $ALL_WAV_FILES_PATH
elif [ $1 = "-r" ]; then
    if [ ! -d "$TRAIN_WAV_FILES_PATH" ]; then
        echo "Error: no $TRAIN_WAV_FILES_PATH directory!"
        exit 1
    fi
    if [ ! -d "$TEST_WAV_FILES_PATH" ]; then
        echo "Error: no $TEST_WAV_FILES_PATH directory!"
        exit 1
    fi
    echo "Merging wav files to $ALL_WAV_FILES_PATH..."
    ## Preparing train and test directories ##
    if [ ! -d "$ALL_WAV_FILES_PATH" ]; then
        echo "  Making directory $ALL_WAV_FILES_PATH..."
        mkdir -pv $ALL_WAV_FILES_PATH
    fi

    ## Moving all wav files
    echo "  Moving train wav files to $ALL_WAV_FILES_PATH..."
    for file in `ls $TRAIN_WAV_FILES_PATH`; do
        mv $TRAIN_WAV_FILES_PATH/$file $ALL_WAV_FILES_PATH
    done

    echo "  Moving test wav files to $ALL_WAV_FILES_PATH..."
    for file in `ls $TEST_WAV_FILES_PATH`; do
        mv $TEST_WAV_FILES_PATH/$file $ALL_WAV_FILES_PATH
    done

    ## Removing train and test wav directory
    echo "  Removing $TRAIN_WAV_FILES_PATH directory..."
    rm -rf $TRAIN_WAV_FILES_PATH
    echo "  Removing $TEST_WAV_FILES_PATH directory..."
    rm -rf $TEST_WAV_FILES_PATH
fi
