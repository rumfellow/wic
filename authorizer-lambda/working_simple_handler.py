#!/bin/python3
import firebase_admin
from firebase_admin import credentials,auth
#import logging


#cred = credentials.Certificate("serviceAccountKey.json")
#app_options = {'projectId': 'wicp-2c8b1'}
#app = firebase_admin.initialize_app(cred, options=app_options)


output = {
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
        "myreply":"wtfhappening",
        "seconf":"fird"
    }
  }



def handler(event,context):
    print(event)
    myvalue = event['headers']['mytok']

    if  myvalue != 'auth':
        output['policyDocument']['Statement'][0]['Effect'] = 'Deny'
        print('denied')
        print(output)
        return output
    else:
        output['policyDocument']['Statement'][0]['Effect'] = 'Allow'
        print('allowed')
        print(output)
        return output


