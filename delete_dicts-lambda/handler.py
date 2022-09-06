import boto3
import json

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('userdata')


def handler(event,context):
    event = json.loads(event['body'])
    uuid = event['uuid']
    action = event['action']
    userdict = event['userdict'] if action != 'purge' else None

    if action == 'purge':
        k = table.update_item(
        Key={'userid':uuid},
        UpdateExpression='SET userdicts.tatoeba = :var1',
        ExpressionAttributeValues = {':var1':{}})

    elif action == 'deldict':
        k = table.update_item(
        Key={'userid':uuid},
        UpdateExpression='REMOVE userdicts.#dict',
        ExpressionAttributeNames={'#dict': userdict}
        )

    return k
