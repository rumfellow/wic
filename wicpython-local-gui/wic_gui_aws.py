#!/bin/python3
import PySimpleGUI as sg
from multiprocessing.pool import ThreadPool
import threading
import time
import json
import requests

key = {"key":"123qwertqwerty"}
r = requests.post('https://vr75xxhy0e.execute-api.eu-central-1.amazonaws.com/readytofuckup', json=key)


status_code=0
myarray = []
def gptpolling(array, key):
    global myarray
    while status_code == 0:
        if len(myarray) < 3:
            r = requests.post('https://vr75xxhy0e.execute-api.eu-central-1.amazonaws.com/readytofuckup', json=key)
            myarray.append(r.json()['body'])
            print('added 1 sentence:\n', myarray[-1])
        else:
            #print('array full')
            time.sleep(10)


def gui():
    sg.theme('DarkTeal11')  # please make your windows colorful
    sg.set_options(font=("Courier New", 14))
    myarray.append({'spanish':'comenzamos estudiar', 'english':'watchalookingat'})
    current_dict=myarray.pop(0)
    spanish = current_dict['spanish']
    english = current_dict['english']
    layout = [[sg.VPush()],
            [sg.Text(english, size=(45,None),key='-ENG-',justification='center')],
            [sg.VPush()],
            [sg.Text("_" * 60)],
            [sg.VPush()],
            [sg.Text('',size=(45,None), key=('translation'), justification='center')],
            [sg.VPush()]
            ]
    window = sg.Window('*', layout, size=(700, 450), 
            finalize=True, return_keyboard_events=True,element_justification='center', no_titlebar=False)
    
    window.bind("<Return>", "-RETURN-")
    window.bind("<Escape>", "-ESCAPE-")
    window.bind("<space>", "-SPACE-")
    while True:  # Event Loop
        event, values = window.read()
        print(event, values)
        global status_code
        status_code = 0
        if event == sg.WIN_CLOSED or event == "-ESCAPE-":
            status_code = 1
            break
        if event == "-RETURN-":
            window['translation'].update(spanish)
            print(spanish,'\n',english)
        if event == "-SPACE-":
            current_dict=myarray.pop(0)
            spanish = current_dict['spanish']
            english = current_dict['english']
            window['-ENG-'].update(english)
            window['translation'].update(' ')
        if event == "BackSpace:22":
            #print(words[-1])
            #spanish = espprompt(words[-1])
            #english = translate(spanish)
            #window['-ENG-'].update(english)
            #window['translation'].update(' ')
            pass
    window.close()

async_gui = threading.Thread(target=gui)
async_gui.start()
async_gpt_polling = threading.Thread(target=gptpolling, args=("myarray",key,))
async_gpt_polling.start()

