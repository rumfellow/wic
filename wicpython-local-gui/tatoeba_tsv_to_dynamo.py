#!/bin/python3
import json
import csv

f = []
data = open('testfile.tsv', 'r')
#data = open('/home/alex/projects/anki-tatoeba/tatoeba_es_en.tsv','r')
reader = csv.reader(data, delimiter='\t')
try:
    for row in reader:
#       print(row)
       f.append({"PutRequest": {"Item":{"spanish":{"S":row[1]},"english":{"S":row[3]}}}},)
#    print(row)
except IndexError:
    pass
    
with open('/tmp/data.json', 'w') as k:
    json.dump(f, k,ensure_ascii=False, indent=0)

#print(json.dumps(f,ensure_ascii=False))
#{"Item":{"spanish":{"S":"Esto es lo que quiero."},"english":{"S":"This is what I want."}}}

