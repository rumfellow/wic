import openai
import requests
import boto3
from sqlite3 import connect
from uuid import uuid4
from urllib.parse import quote,unquote


##Converting local ANKI db to python dictionary

def get_word(db):
    con = connect(db)
    cur = con.cursor()
    all_words = cur.execute('SELECT n.flds FROM notes n, cards c WHERE n.id = c.id;')
    return all_words

def get_random_word(path_to_db):
    con = connect(path_to_db)
    cur = con.cursor()
    random_word = cur.execute('SELECT n.sfld FROM notes n, cards c WHERE n.id = c.id ORDER BY RANDOM() LIMIT 1;')
    return random_word


##DynamoDB write and random read functions
##Schema (Item={'value': 'eng_value', 'key': 'esp_value'})
def upload(dictionary, db_table='anki_esp_main', value='english', key='spanish'):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(db_table)
    for pair in dictionary.items():
        print('Uploading: ', pair)
        table.put_item(Item={value:pair[1],key:pair[0]})

def batch_upload(dictionary, db_table='anki_esp_main', value='english', key='spanish'):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(db_table)
    writer = table.batch_writer()
    for pair in dictionary.items():
        print('Uploading: ', pair)
        writer.put_item(Item={value:pair[1],key:pair[0]})

def readdb(db_table='anki_esp_main', limit=1, key='spanish'):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(db_table)
    result = table.scan(Limit=1, ExclusiveStartKey={key: str(uuid4())}, ReturnConsumedCapacity='TOTAL')
    return result['Items'][0]['spanish']


##Submitting to GPT-3

def espprompt(word):
    esprompt = "genera una frasa con \'" + word + "\'"
    response = openai.Completion.create(
    model="text-davinci-002",
    prompt=esprompt,
    temperature=0.9,
    max_tokens=50,
    top_p=1,
    frequency_penalty=0,
    presence_penalty=0
    )
    #print(esprompt)
    return response['choices'][0]['text']

##Obtaining the translation from google translate service
def googletranslate(phrase,key):
    url='https://translation.googleapis.com/language'
    endpoint='/translate/v2?key='
    query='&q='
    source='&source='+'es'
    target='&target='+'en'
    phrase=quote(phrase)
    model='&model=nmt'
    f = requests.get(url+endpoint+key+model+query+quote(phrase)+source+target+'&format=text')
    result = unquote(f.json()['data']['translations'][0]['translatedText'])
    return result

##Obtaining the translation from DeepL translate service, by far the best option
def deepltrans(text, translator, target_lang="EN"):
    result = translator.translate_text(text, target_lang="EN-GB")
    translated_text = result.text
    return(translated_text)



