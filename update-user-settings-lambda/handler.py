import boto3
from boto3.dynamodb.types import TypeDeserializer
tds = TypeDeserializer()
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('userdata')
client = boto3.client("dynamodb", region_name="eu-central-1")


def readdb(uuid, db_table='usersettings'):
    response = client.get_item(TableName='userdata', Key={'userid':{'S':'universalsettings'}})
    result = {a : tds.deserialize(b) for a,b in response['Item'].items()}
    try:
        userdicts = list(table.get_item(Key={'userid': uuid})['Item']['userdicts'].keys())
        userdicts.remove('tatoeba')
    except:
        userdicts = []
    return result,userdicts

def handler(event,context):
    print(event)
    parameters,userdicts = readdb(event['uuid'])
    #uuid check?
    try:
        langList = parameters['langList'][0]
        dictList = parameters['dictList'][0] 
        styles = parameters['styles']
        defaultDict = parameters['defaultDict']
        defaultLang = parameters['defaultLang']
        defaultStyle = parameters['defaultStyle']
        converted_lang = [x for x in langList.keys()]
        converted_dict = [x for a,x in dictList.items()] + userdicts
        converted_dict.sort()
    except:
        langList,dictList = "user setting not available"

    return {'isBase64Encoded':'false', 'statusCode': 200,
    'headers': {'Content-Type': 'application/json'},
            'body': {'languages': converted_lang, 'dictionaries': converted_dict, 
                     'styles': styles, 'defaultDict': defaultDict, 
                     'defaultLang': defaultLang, 'defaultStyle': defaultStyle, 'userDicts':userdicts}
    }
