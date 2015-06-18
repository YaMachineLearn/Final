import sys
import re

MAP_FILE = sys.argv[1]  #should be "../../MLDS_Final/conf/phones.60-48-39.map"
TIMIT_DICT_FILE = sys.argv[2]
OUTPUT_SIL_FILE = sys.argv[3]
OUTPUT_NONSIL_FILE = sys.argv[4]
OUTPUT_LEXICON_FILE = sys.argv[5]

SIL_PHONE = "sil"
PHONES_48 = set()
DICT_48_39 = dict()
DICT_60_48 = dict()

def main():
    readMapFile()

    outputSilNonsil()
    outputLexicon()

def readMapFile():
    with open(MAP_FILE) as mapFile:
        for line in mapFile:
            lineList = line.rstrip().split() #split with space or tab
            
            PHONES_48.add(lineList[1])
            DICT_60_48[lineList[0]] = lineList[1]
            DICT_48_39[lineList[1]] = lineList[2]

def outputSilNonsil():
    with open(OUTPUT_SIL_FILE, 'w') as silFile:
        silFile.write(SIL_PHONE + '\n')

    with open(OUTPUT_NONSIL_FILE, 'w') as nonsilFile:
        for phone in PHONES_48:
            if phone != SIL_PHONE:
                nonsilFile.write(phone + '\n')

def outputLexicon():
    timitFile = open(TIMIT_DICT_FILE)
    lexFile = open(OUTPUT_LEXICON_FILE, 'w')
    
    for line in timitFile:
        if not line.strip():
            continue
        if line[0] == ';':
            continue

        pattern = '([^ ]+) *\/(.*)\/'
        match = re.match(pattern, line)
        word = match.group(1)
        phones60 = match.group(2).split()
        phones48 = list()
        for phone in phones60:
            phoneStrip = re.match('([a-z]*)[0-9]*', phone).group(1) # remove numbers in it
            phones48.append(DICT_60_48[phoneStrip])
        
        lexFile.write(word + ' ' + ' '.join(phones48) + '\n')

    timitFile.close()
    lexFile.close()

if __name__ == '__main__':
    main()
