import deepl
import json
import boto3
#from credentials import deepl_key
from uuid import uuid4
deepl_key = 'a017df0b-590f-7023-9f83-e86cf0fdee34:fx'
translator = deepl.Translator(deepl_key)

def readdb(db_table='tatoeba_en_es', limit=1, key='spanish', sort='english'):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(db_table)
    result = table.scan(Limit=1, ExclusiveStartKey={key: str(uuid4()), sort:str(uuid4())}, ReturnConsumedCapacity='TOTAL')
    return result['Items'][0]['spanish'], result['Items'][0]['english']
f = readdb()
print(f)
