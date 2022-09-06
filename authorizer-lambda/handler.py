#!/bin/python3
import firebase_admin
from firebase_admin import credentials,auth
#import logging


cred = credentials.Certificate("serviceAccountKey.json")
app_options = {'projectId': 'wicp-2c8b1'}
app = firebase_admin.initialize_app(cred, options=app_options)


output_sample = {
  "principalId": "user", 
  "policyDocument": {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "execute-api:Invoke",
        "Effect": None,
        "Resource": "arn:aws:execute-api:eu-central-1:599952981457:uvjuhrkchl/*"
      }
    ]
  },
    "context":{
        "reply_context":"field1",
        "reply_context_ext":"field2"
    }
  }



def handler(event,context):
    print(event)
    token = event['headers']['mytok']
    output = output_sample.copy()
    

    try:
        decoded_token = auth.verify_id_token(token)
        output['policyDocument']['Statement'][0]['Effect'] = 'Allow'
        print('allowed')
        return output
    except:
        output['policyDocument']['Statement'][0]['Effect'] = 'Deny'
        print('denied')
        return output


