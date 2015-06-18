import sys

MAP_FILE = sys.argv[1]  #should be "../../MLDS_Final/conf/phones.60-48-39.map"
TIMIT_DICT_FILE = sys.argv[2]
OUTPUT_SIL_FILE = sys.argv[3]
OUTPUT_NONSIL_FILE = sys.argv[4]
OUTPUT_LEXICON_FILE = sys.argv[5]

print MAP_FILE
print OUTPUT_LEXICON_FILE

SIL_PHONE = "sil"
PHONES_48 = set()
DICT_48_39 = dict()

def main():
    readMapFile()

    outputSilNonsil()
    #outputLexicon()

def readMapFile():
    with open(MAP_FILE) as mapFile:
        for line in mapFile:
            lineList = line.rstrip().split() #split with space or tab
            
            print lineList[1]
            PHONES_48.add(lineList[1])
            DICT_48_39[lineList[1]] = lineList[2]

def outputSilNonsil():
    with open(OUTPUT_SIL_FILE, 'w') as silFile:
        silFile.write(SIL_PHONE + '\n')

    with open(OUTPUT_NONSIL_FILE, 'w') as nonsilFile:
        for phone in PHONES_48:
            if phone != SIL_PHONE:
                nonsilFile.write(phone + '\n')

def outputLexicon():
    with open(OUTPUT_LEXICON_FILE, 'w') as lexFile:
        pass

if __name__ == '__main__':
    main()
