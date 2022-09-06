#!/bin/python3
from backend_functions import upload,get_word
from credentials import anki_db_path

'''ANKI db to dictionary'''

dictionary = {r[0].split('\x1f')[0]:r[0].split('\x1f')[1] for r in get_word(anki_db_path)}

'''Updating DynamoDB'''

upload(dictionary) #or batch_upload()
