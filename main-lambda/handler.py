import boto3
import openai
import deepl
import random
from uuid import uuid4
from credentials import deepl_key
import json

dynamodb = boto3.resource('dynamodb')
translator = deepl.Translator(deepl_key)


class userdata:
    def __init__(self,native,trans,dictionary, gptkey='none',token='none',phraseid=None):
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
            'ES':'genera una frasa con %s en español',
            'FR':'générer une phrase avec un mot %s en français',
            'IT':'generare una frase con una parola %s in italiano',
            'EN-US':'generate a phrase with a word %s in English',
            'RU':'сгенерируй фразу со словом %s на русском языке',
            'DE':'eine Phrase mit %s auf Deutsch erzeugen'
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
        self.phraseid = phraseid
        self.allprompts = prompts

        def __repr__(self):
            return  self.native_lcode, self.target_lcode, self.gptkey, self.level, self.dictionary,
            self.prompt,self.token, self.langs, self.phraseid, self.levels, self.allprompts


jsonbody_sample = {
    'statusCode': 200,
    'headers': {'Content-Type': 'application/json'},
    'body': {
        'native':'GPT API Key error',
        'target':'GPT API Key error',
        'word':'n/a',
        'translation':'n/a',
        'phraseid':'n/a'}
                }

phrase_schema_sample = {
	'phrases': [{}], #LANG:phrase
	'word_transl': {},#LANG:word
	'word': None, #target_word
	'language': None #target_lang
}

userdata_schema_sample = {
    "userid": "uuid4",
    "userdicts":
    {
     "mydictionary":
     {
        "word":"lang",
        "word2":"lang"
     },
     "tatoeba":
     {
         "phraseid2":"target",
         "phraseid1":"target2"
     }
     }
     }

def read_custom_dicts(userdict, userid, db_table='userdata'):
    '''Читаем рандомно DynamoDB, сортировочного ключа нет'''
    table = dynamodb.Table(db_table)
    result = table.get_item(
        Key={'userid':userid},
        ProjectionExpression='userdicts.%s' %userdict
        )
    customdict = result['Item']['userdicts'][userdict]
    random_read = random.choice(list(customdict.items()))

    return random_read[0],random_read[1]

def readtatoeba(native_lang, target_lang, db_table='tatoeba', limit=1, key='phraseid'):
    '''Рандомно читаем базу фраз, проверяем есть ли родной язык и перевод, если нет - переводим и записываем обратно'''
    table = dynamodb.Table(db_table)
    result = table.scan(Limit=1, ExclusiveStartKey={key: str(uuid4())})
    phraseid = result['Items'][0]['phraseid']
    body = result['Items'][0]['phrase']
    native_lang = 'EN' if native_lang == 'EN-US' else native_lang
    #translate = lambda a,b: translator.translate_text(text=a, target_lang=b).text

    if native_lang not in body.keys():
        native = translate(body['EN'],native_lang)
        #UpdateExpression добавляет новые значения во вложенный словарь phrase:{language:value}
        table.update_item(
            Key={'phraseid':phraseid},
            UpdateExpression='SET phrase.'+native_lang+' = :val1',
            ExpressionAttributeValues = {':val1': native}
            )
    else:
        native = body[native_lang]

    if target_lang not in body.keys():
        trans = translate(body['EN'],target_lang)
        table.update_item(
            Key={'phraseid':phraseid},
            UpdateExpression='SET phrase.'+target_lang+' = :val1',
            ExpressionAttributeValues = {':val1': trans}
            )
    else:
        trans = body[target_lang]

    return native, trans, phraseid

def readdbox(native, trans, oxforddb='oxford5000', level='b2'): #change back to oxforf5000
    '''Читаем рандомизированную базу oxford5000'''
    table = dynamodb.Table(oxforddb)
    result = table.scan(ExclusiveStartKey={'category': level, 'uuid': str(uuid4())}, Limit=1)
    return result['Items'][0]['translations'][native], result['Items'][0]['translations'][trans]

def readphrase(word, native, db_table='main'):
    '''Читаем сохраненную фразу(объект целиком) если находим'''
    table = dynamodb.Table(db_table)
    native = 'EN' if native == 'EN-US' else native
    result = table.get_item(Key={'word': word, 'language': native})
    if 'Item' in result.keys():
        return result['Item']
    else:
        return None

def writephrase(item, db_table='main'):
    '''Пишем весь объект - фразу и все переводы, переписывая предыдущую запись'''
    table = dynamodb.Table(db_table)
    table.put_item(Item=item)

def espprompt(prompt):
    try: 
        '''передаём GPT-3 запрос на генерацию фразы'''
        response = openai.Completion.create(
        model="text-davinci-002",
        prompt=prompt,
        temperature=0.9,
        max_tokens=50,
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
    event = json.loads(event['body'])
    eventdata = userdata(
        native=event['native'],
        trans=event['trans'],
        dictionary=event['dictionary'],
        gptkey=event['gptAPI'],
        token=event['uuid']
        )
    
    openai.api_key = eventdata.gptkey
    #temporary userdata.level vs dictionary bug
    
    if eventdata.level == 'custom':
        reply = jsonbody['body']
        target_word,target_lang =  read_custom_dicts(eventdata.dictionary, eventdata.token)
        item = readphrase(target_word,target_lang)
        array_len = len(item['phrases']) if item != None else 0
        random_index = random.randrange(array_len) if item != None else 0
        prompt = eventdata.allprompts[target_lang] %target_word
        native_lcode = 'EN' if eventdata.native_lcode == 'EN-US' else eventdata.native_lcode
        custom_translator = lambda a,b,c: translator.translate_text(text=a,target_lang=b,source_lang=c).text        


        if array_len == 0:
            target_phrase, gpt_key_status = espprompt(prompt)
            native_phrase = translate(target_phrase,eventdata.native_lcode)
            native_word = custom_translator(target_word,eventdata.native_lcode,target_lang)
            print(native_lcode, native_word)
            item={
                'phrases' : [{native_lcode:native_phrase,target_lang:target_phrase}],
                'word_transl':{native_lcode:native_word,target_lang:target_word},
                'word':target_word,
                'language':target_lang
                }
            jsonbody['body'] = json.dumps({
                'native':native_phrase,
                'target':target_phrase,
                'word':native_word,
                'translation':target_word
                }).encode('utf8')
            writephrase(item) if gpt_key_status == 0 else True
            return jsonbody
        
        
        elif array_len < 10:
            target_phrase, gpt_key_status = espprompt(prompt)
            
            native_word = custom_translator(target_word,eventdata.native_lcode,target_lang) if native_lcode not in item['word_transl'].keys() else item['word_transl'][native_lcode] 
            #print('target word:', target_word, "\nnative lcode:", native_lcode, '\nitem:', item)
            native_phrase = translate(target_phrase,eventdata.native_lcode)
            item['phrases'].append({native_lcode:native_phrase,target_lang:target_phrase})
 
            if native_lcode not in item['word_transl'].keys():
                item['word_transl'].update({native_lcode:target_word})
            
            jsonbody['body'] = json.dumps({
                'native':native_phrase,
                'target':target_phrase,
                'word':native_word,
                'translation':target_word
                }).encode('utf8')
            writephrase(item) if gpt_key_status == 0 else True
            return jsonbody
        
        else:
            print('ARRAY MORE THAN 10 ITEMS\n')
            print('lcode & items:\n',item['phrases'][random_index].keys())
            if native_lcode not in item['phrases'][random_index].keys():
                native_phrase = translate(item['phrases'][random_index][target_lang],eventdata.native_lcode)
                item['phrases'][random_index].update({native_lcode:native_phrase})
                if native_lcode not in item['word_transl'].keys():
                    item['word_transl'].update({native_lcode:target_word})
                writephrase(item)
            else:
                native_phrase = item['phrases'][random_index][native_lcode]

            jsonbody['body'] = json.dumps({
                'native':native_phrase,
                'target':item['phrases'][random_index][target_lang],
                'word':item['word'],
                #stupid, translation = native
                'translation':item['word_transl'][native_lcode]
                }).encode('utf8')

            return jsonbody
    
    
    elif eventdata.level != 'tatoeba':
        
        reply = jsonbody['body']

        #reading oxford5000
        native_word, target_word = readdbox(eventdata.native_lcode, eventdata.target_lcode, level=eventdata.level)

        #searching for a phrase by lang and word
        item = readphrase(target_word, eventdata.target_lcode)

        #getting random phrases array index or zero if empty
        array_len = len(item['phrases']) if item != None else 0
        random_index = random.randrange(array_len) if item != None else 0
        native_lcode = 'EN' if eventdata.native_lcode == 'EN-US' else eventdata.native_lcode

        if array_len == 0:
            target_phrase, gpt_key_status = espprompt(eventdata.prompt % target_word)
            native_phrase = translate(target_phrase,eventdata.native_lcode)
            item={
                'phrases' : [{native_lcode:native_phrase,eventdata.target_lcode:target_phrase}],
                'word_transl':{native_lcode:native_word,eventdata.target_lcode:target_word},
                'word':target_word,
                'language':eventdata.target_lcode
                }
            jsonbody['body'] = json.dumps({
                'native':native_phrase,
                'target':target_phrase,
                'word':native_word,
                'translation':target_word
                }).encode('utf8')
            writephrase(item) if gpt_key_status == 0 else True
            return jsonbody

        elif array_len < 10:
            target_phrase, gpt_key_status = espprompt(eventdata.prompt % target_word) 
            native_phrase = translate(target_phrase,eventdata.native_lcode)
            item['phrases'].append({native_lcode:native_phrase,eventdata.target_lcode:target_phrase})
 
            if native_lcode not in item['word_transl'].keys():
                    item['word_transl'].update({native_lcode:target_word})
            jsonbody['body'] = json.dumps({
                'native':native_phrase,
                'target':target_phrase,
                'word':native_word,
                'translation':target_word
                }).encode('utf8')
            writephrase(item) if gpt_key_status == 0 else True


        else:

            if eventdata.native_lcode not in item['phrases'][random_index].keys():
                native_phrase = translate(item['phrases'][random_index][eventdata.target_lcode],eventdata.native_lcode)
                item['phrases'][random_index].update({native_lcode:native_phrase})
                if native_lcode not in item['word_transl'].keys():
                    item['word_transl'].update({native_lcode:target_word})
                writephrase(item)
            else:
                native_phrase = item['phrases'][random_index][eventdata.native_lcode]

            jsonbody['body'] = json.dumps({
                'native':native_phrase,
                'target':item['phrases'][random_index][eventdata.target_lcode],
                'word':item['word'],
                #translation = native!
                'translation':item['word_transl'][native_lcode]
                }).encode('utf8')


    elif eventdata.level == 'tatoeba':
        reply = jsonbody['body']
        native_lcode = 'EN' if eventdata.native_lcode == 'EN-US' else eventdata.native_lcode
        result = readtatoeba(native_lcode,eventdata.target_lcode)
        reply['native'] = result[0]
        reply['target'] = result[1]
        reply['phraseid'] = result[2]
        jsonbody['body'] = json.dumps(reply).encode('utf8')
        return jsonbody

    else:
        return jsonbody
