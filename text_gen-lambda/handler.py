import boto3
import json
import deepl
from credentials import deepl_key
import openai
from uuid import uuid4


translator = deepl.Translator(deepl_key)
dynamodb = boto3.resource('dynamodb') 
table = dynamodb.Table('userdata')


class userdata:
    def __init__(self,trans,token,dictionary, native, gptkey, style='normal'):
        langs = {
            'Español':'ES',
            'Française':'FR',
            'Italiana':'IT',
            'English':'EN-US',
            'Русский':'RU',
            'Deutsch':'DE'
            }
        levels = {
            'A1 beginner': 'a1',
            'A2 beginner':'a2',
            'B1 intermediate':'b1',
            'B2 advanced':'b2',
            'C1 proficiency':'c1',
            'Train phrases':'tatoeba'
            }
        prompts = {
            'ES':'generar una historia en español usando algunas de las siguientes palabras: ',
            'FR':'générer une phrase avec une histoire en français avec les mots suivants: ',
            'IT':'generare una storia in italiano con le seguenti parole: ',
            'EN-US':'generate a story in English with the following words: ',
            'RU':'сгенерируй историю на русском языке со следующими словами: ',
            'DE':'Erstellen Sie eine Geschichte auf Englisch mit den folgenden Wörtern: '
            }
        self.dictionary = dictionary
        self.native_lcode = langs[native] #source language code
        self.target_lcode = langs[trans] #target language code
        self.prompt = prompts[self.target_lcode]
        self.level = levels[dictionary] if self.dictionary in levels else 'custom'
        self.levels = levels
        self.gptkey = gptkey
        self.token = token
        self.langs = langs #dict of languages 
        self.allprompts = prompts
        self.style = style

        def __repr__(self):
            return  self.native_lcode, self.target_lcode, self.gptkey, self.level, self.dictionary,
            self.prompt,self.token, self.langs, self.phraseid, self.levels, self.allprompts



jsonbody_sample = {
    "isBase64Encoded": "false",
    "statusCode": 200,
    "headers": {"Content-Type": "application/json"},
    "body": {
        'native':'GPT API Key error',
        'target':'GPT API Key error',
        'word':'n/a',
        'translation':'n/a'
        }
                }


def read_custom_dicts(userdict, userid, db_table='userdata'):
    '''random reads DynamoDB, no sort key'''
    table = dynamodb.Table(db_table)
    result = table.get_item(
        Key={'userid':userid},
        ProjectionExpression='userdicts.%s' %userdict
        )
    customdict = result['Item']['userdicts'][userdict]

    return customdict


def readdbox(native, trans, level='rand', oxforddb='oxford5000'):
    '''randomized oxford5000 read'''
    table = dynamodb.Table(oxforddb)
    random_position = str(uuid4())
    level = level if level != 'rand' else random_position 
    result = table.scan(
        ExclusiveStartKey={'category': level, 'uuid': random_position},
        ExpressionAttributeNames={'#nat':native,'#trans':trans},
        ProjectionExpression="translations.#nat, translations.#trans",
        Limit=25
        )
    return result['Items']


def writephrase(item, db_table='main'):
    '''writing the whole object, overwriting the prev data'''
    table = dynamodb.Table(db_table)
    table.put_item(Item=item)

def espprompt(prompt):
    try: 
        '''GPT-3 prompt & options'''
        response = openai.Completion.create(
        model="text-davinci-002",
        prompt=prompt,
        temperature=0.95,
        max_tokens=450,
        top_p=1,
        frequency_penalty=0,
        presence_penalty=0
        )
        gpt_key_status = 0
        return response['choices'][0]['text'].strip(), gpt_key_status
    except openai.error.AuthenticationError:
        gpt_key_status = 1
        return 'Wrong GPT-3 API Key', gpt_key_status

def translate(text, target_lang):
    result = translator.translate_text(text=text, target_lang=target_lang)
    return result.text



def handler(event,context):

    
    jsonbody = jsonbody_sample.copy()
    reply = jsonbody['body']
    #print(event['body'])
    event=json.loads(event['body'])
    print(event)
    eventdata = userdata(
        trans=event['trans'],
        native=event['native'],
        dictionary=event['dictionary'],
        token=event['uuid'],
        style=event['style'],
        gptkey=event['gptkey']
        )
    openai.api_key = eventdata.gptkey
    target_lcode = 'EN' if eventdata.target_lcode == 'EN-US' else eventdata.target_lcode
    
    if eventdata.level == 'custom':
        #running through custom dictionaries

        words = read_custom_dicts(eventdata.dictionary,eventdata.token)
        target_lang = list(words.values())[0]
        words = list(words.keys())[:25]
        words = ", ".join(words)
        longprompt = str(eventdata.allpromps[target_lang]) + words
        target_text = espprompt(longprompt)
        native_text = translate(target_text,eventdata.native_lcode)
        reply['native'] = native_text
        reply['target'] = target_text
        reply['word'] = words
        jsonbody['body'] = json.dumps(reply).encode('uft8')
    
    


    elif eventdata.level == 'tatoeba':
        #running through oxford at all levels
        words = readdbox(eventdata.native_lcode, eventdata.target_lcode)
        target_words = [x['translations'][eventdata.target_lcode] for x in words]
        native_words = [x['translations'][eventdata.native_lcode] for x in words]
        target_words.pop(0)
        native_words.pop(0)
        target_words = ', '.join(target_words)
        native_words = ', '.join(native_words)
        longprompt = str(eventdata.allprompts[eventdata.target_lcode]) + target_words
        target_text = espprompt(longprompt)
        native_text = translate(target_text[0],eventdata.native_lcode)
        reply['native'] = native_text
        #bad, translator returns tuple:
        reply['target'] = target_text[0]
        reply['word'] = target_words
        #jsonbody['body'] = str(reply)
        jsonbody['body'] = json.dumps(reply).encode('utf8')
        print(target_text[0])

    else:
        
        #getting 30 words from the corresponding oxford level
        words = readdbox(eventdata.native_lcode, eventdata.target_lcode, level=eventdata.level)
        target_words = [x['translations'][eventdata.target_lcode] for x in words]
        native_words = [x['translations'][eventdata.native_lcode] for x in words]
        target_words.pop(0)
        native_words.pop(0)
        target_words = ', '.join(target_words)
        native_words = ', '.join(native_words)
        longprompt = str(eventdata.allprompts[eventdata.target_lcode]) + target_words
        target_text = espprompt(longprompt)
        native_text = translate(target_text[0],eventdata.native_lcode)
        reply['native'] = native_text
        #bad, translator returns tuple:
        reply['target'] = target_text[0]
        reply['word'] = target_words
        jsonbody['body'] = json.dumps(reply).encode('utf8')
    
    
    
    return(jsonbody)