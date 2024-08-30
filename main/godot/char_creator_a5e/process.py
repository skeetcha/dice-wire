import csv
import json
import os

files = [i for i in os.listdir() if '.json' in i]

cult_key_to_str = {'deepdwarf': 'CULTURE_DEDW', 'dragonbound': 'CULTURE_DRBN', 'dragoncult': 'CULTURE_DRCT'}

key_to_str = {'culture_features.json': cult_key_to_str, 'heritage_gifts.json': {}, 'heritage_features.json': {}}
string_from_file = {'culture_features.json': 'CULTURE_', 'heritage_gifts.json': 'HERITAGE_', 'heritage_features.json': 'HGIFT_'}

csvfile = open('newstrings.csv', 'w', newline='')
csvwriter = csv.writer(csvfile, delimiter=',', quotechar='"')
csvwriter.writerow(['key', 'en_US', 'es'])

def parseObj(obj, string):
    for key in obj.keys():
        if isinstance(obj[key], str):
            parseStr(obj[key], string + '_' + key.upper())
        elif isinstance(obj[key], list):
            parseArr(obj[key], string + '_' + key.upper())
        elif isinstance(obj[key], str):
            parseStr(obj[key], string + '_' + key.upper())

def parseArr(arr, string):
    for i in range(len(arr)):
        parseObj(arr[i], string + str(i + 1))

def parseStr(val, string):
    csvwriter.writerow([string, val, ''])

for file in files:
    f = open(file, 'r')
    data = json.load(f)
    f.close()

    for key in data.keys():
        string = string_from_file[file] + key[:4].upper()

        if key in key_to_str[file].keys():
            string = key_to_str[file][key]
        
        parseArr(data[key], string)
        
        '''for vkey in data[key].keys():
            if vkey == 'features':
                for i in range(len(data[key][vkey])):
                    for vvkey in data[key][vkey].keys():
                        csvwriter.writerow([string + '_' + vkey.upper() + str(i + 1) + '_' + vvkey.upper(), data[key][vkey][i][vvkey], ''])
            else:
                csvwriter.writerow([string + '_' + vkey.upper(), data[key][vkey], ''])'''

csvfile.close()