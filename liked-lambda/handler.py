import boto3
import json

dynamodb = boto3.resource('dynamodb') 
table = dynamodb.Table('userdata')


class userdata:
    def __init__(self,trans,token,dictionary, phraseid=None, gptkey=None,native=None,phraseortext='phrase'):
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
            'C1 proficiency':'c1'
            }
        prompts = {
            'ES':'genera una frasa con %s en español',
            'FR':'générer une phrase avec un mot %s en français',
            'IT':'generare una frase con una parola %s in italiano',
            'EN-US':'generate a phrase with a word %s in English',
            'RU':'сгенерируй фразу со словом %s на русском языке',
            'DE':'eine Phrase mit %s auf Deutsch erzeugen'
            }
        self.dictionary = dictionary if dictionary != 'Train phrases' else 'tatoeba'
        #self.native_lcode = langs[native] #source language code
        self.target_lcode = langs[trans] #target language code
        self.prompt = prompts[self.target_lcode]
        self.level = levels[dictionary] if self.dictionary != 'tatoeba' else 'n/a'
        self.gptkey = gptkey
        self.token = token
        self.langs = langs #dict of languages
        self.phraseortext = 'phrase'
        self.phraseid = phraseid

        def __repr__(self):
            return  self.native_lcode, self.target_lcode, self.gptkey, self.level, self.dictionary, self.prompt,self.token, self.langs, self.phraseid,self.phraseortext

schema = {
 "userid": "2076d7c3-c86b-4341-b4f8-a94fa2f83475",
 "userdicts":
 {
     "likedwords":
     {

     },
     "tatoeba":
     {

     }
 }
}

response = {
    'statusCode': 200,
    'body': 'all good'
    }



def handler(event,context):
    event=json.loads(event['body'])
    eventdata = userdata(
        trans=event['trans'],
        dictionary=event['dictionary'],
        token=event['uuid'],
        phraseid=event['phraseid']
        )#,phraseortext=event['phraseOrText'])
    target_lcode = 'EN' if eventdata.target_lcode == 'EN-US' else eventdata.target_lcode
    if eventdata.dictionary == 'tatoeba':
        schema['userdicts']['tatoeba'].update({event['phraseid']:target_lcode})
        schema['userid'] = eventdata.token
        try:
            k = table.put_item(
                Item=schema,
                ConditionExpression='attribute_not_exists(userid)')
        except:
            k = table.update_item(
                Key={'userid':eventdata.token},
                UpdateExpression='SET userdicts.tatoeba.#key = :val1',
                ExpressionAttributeNames={'#key': eventdata.phraseid}, 
                ExpressionAttributeValues = {':val1':target_lcode})

    else:
        schema['userdicts']['likedwords'].update({event['target_word']:target_lcode})
        schema['userid'] = eventdata.token
        try:
            k = table.put_item(
                Item=schema,
                ConditionExpression='attribute_not_exists(userid)')
        except:
            k = table.update_item(
                Key={'userid':eventdata.token},
                UpdateExpression='SET userdicts.likedwords.#key = :val1',
                ExpressionAttributeNames={'#key': event['target_word']}, 
                ExpressionAttributeValues = {':val1':target_lcode})
    return response
