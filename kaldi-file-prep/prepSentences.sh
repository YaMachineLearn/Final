#[^a-zA-Z0-9,'\-_ \.\?:"!;\n]

cat $DATA_ROOT_PATH/sentence/train.set \
| sed "s/, / /g" \
| sed "s/,/ /g" \
| sed "s/[\.\?\":!;]//g" \
| sed "s/./\L&/g" \
> $OUTPUT_PATH/train/text

cat $DATA_ROOT_PATH/sentence/train.set \
| sed "s/\([^_]*\)_\([^,]*\).*/\1_\2 \1/g" \
> $OUTPUT_PATH/train/utt2spk

cat $DATA_ROOT_PATH/sentence/train.set \
| sed "s/\(.\)\([^_]*\).*/\1\2 \1/g" \
| uniq \
> $OUTPUT_PATH/train/spk2gender

# sed "s/^M//g" \
# | tr '\n' ' ' \
# | sed "s/[Mm]r\./mr/g" \
# | sed "s/[Mm]rs\./mrs/g" \
# | sed "s/[Jj]r\./jr/g" \
# | sed "s/\([a-zA-Z]*\)n't/\1 not/g" \
# | sed "s/\([a-zA-Z]*\)'m/\1 am/g" \
# | sed "s/\([a-zA-Z]*\)'re/\1 are/g" \
# | sed "s/\([a-zA-Z]*\)'ll/\1 will/g" \
# | sed "s/\([a-zA-Z]*\)'ve/\1 have/g" \
# | sed "s/\t/ /g" \
# | sed "s/(\([^()]*\))/\n\1\n/g" \
# | sed "s/\"\([^\"]*\)\"/\n\1\n/g" \
# | sed "s/\'\([^\']*\)\'/\n\1\n/g" \
# | sed "s/\[[^][]*\]//g" \
# | sed "s/[,:\/\` ]/ /g" \
# | sed "s/[\?\!\.;]/\n/g" \
# | sed "s/[^a-zA-Z0-9 ]/ /g" \
# | sed "s/./\L&/g" \
# | sed "s/ [ ]*/ /g" \
# | sed "s/^[ \t]*//g" \
# | sed "s/[\t ]*$//g" \
# | sed "/^$/d" \
# | sed "/^[^ ]*$/d" \
# | sed "s/[^[:print:]]//g" \
# | sed "s/^/<s> /" \
# | sed "s/$/ <\/s>/" \