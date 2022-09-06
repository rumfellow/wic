import boto3
import regex
import json

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('userdata')

class userdata:
    def __init__(self,trans,token,dictionary):
        langs = {
            'Español':'ES',
            'Française':'FR',
            'Italiana':'IT',
            'English':'EN-US',
            'Русский':'RU',
            'Deutsch':'DE'
            }
        self.dictionary = dictionary
        self.target_lcode = langs[trans] #target language code
        self.token = token

        def __repr__(self):
            return  self.target_lcode, self.dictionary, self.token, self.langs

sample_schema = {
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


def langcode_generator(langcode):
    while True:
        yield langcode


def handler(event,context):

    schema = sample_schema.copy()
    event = json.loads(event['body'])
    eventdata = userdata(
        trans=event['trans'],
        dictionary="".join(regex.findall(r'[\w+\s+_-]',event['dictionary'])).strip(),
        token=event['uuid'],
        )

    inputwords = event['words'].split(',')

    #implement cut words length to no more than 30-35 chars!!
    pattern = regex.compile('[\p{L} - \'`]*')
    words = ["".join(regex.findall(pattern,w)).lower() for w in inputwords]
    words = list(filter(None, words))

    #stripping starting/trailing whitespaces and limiting word length to 30 chars
    words = [a[:30].strip() for a in words]

    target_lcode = 'EN' if eventdata.target_lcode == 'EN-US' else eventdata.target_lcode
    words_dict = dict(zip(words,langcode_generator(target_lcode)))
    schema['userdicts'].update({eventdata.dictionary:words_dict})
    schema['userid'] = eventdata.token

    try:
        #if userid doesn't exist, putting complete schema 
        k = table.put_item(
        Item=schema,
        ConditionExpression='attribute_not_exists(userid)')

    except:

        try:
            #if userid and sctructure exist, but user defined dictionary is not
            k = table.update_item(
            Key={'userid':eventdata.token},
            UpdateExpression='SET ' + 'userdicts.' + eventdata.dictionary + ' = :var1',
            ExpressionAttributeValues = {':var1':schema['userdicts'][eventdata.dictionary]},
            ConditionExpression='attribute_not_exists(userdicts.%s)' %eventdata.dictionary)

        except:
            #if user defined dictionary exists, appending words to it
            expression_structure = ['userdicts.'+ '#dict.#index' + str(words.index(p)) + ' = :val1' for p in words]
            attribute_names_structure = {'#index'+str(words.index(p)):p for p in words}
            attribute_names_structure['#dict'] = eventdata.dictionary
            k = table.update_item(
            Key={'userid':eventdata.token},
            UpdateExpression='SET ' + ",".join(expression_structure),
            ExpressionAttributeNames=attribute_names_structure,
            ExpressionAttributeValues = {':val1':target_lcode })
    return k
