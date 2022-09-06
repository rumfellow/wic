#!/bin/python3
import PySimpleGUI as sg
from credentials import openai_key, deepl_key
from backend_functions import deepltrans, readdb,espprompt
import openai
from multiprocessing.pool import ThreadPool
import threading
import time
import deepl

transl = deepl.Translator(deepl_key)
openai.api_key = openai_key

status_code=0
myarray = []
words = []

##Sending queries to gpt-3 and caching
def gptpolling(array):
    global myarray
    global words
    while status_code == 0:
        if len(myarray) < 3:
            words.append(readdb())
            myarray.append(espprompt(words[-1]))
            print('added 1 sentence:\n', myarray[-1],'\nadded 1 word:\n', words[-1])
        else:
            #print('array full')
            time.sleep(10)

def gui():
    sg.theme('DarkTeal11')
    sg.set_options(font=("Courier New", 14))
    myarray.append('comenzamos estudiar')
    words.append('test')
    spanish = myarray.pop()
    current_word = words.pop()
    print(spanish)
    english = deepltrans(spanish, transl)
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
            spanish = myarray.pop()
            english = deepltrans(spanish, transl)
            window['-ENG-'].update(english)
            window['translation'].update(' ')
            words.pop()
        if event == "BackSpace:22":
            print(words[-1])
            spanish = espprompt(words[-1])
            english = deepltrans(spanish, transl)
            window['-ENG-'].update(english)
            window['translation'].update(' ')
    window.close()

async_gui = threading.Thread(target=gui)
async_gui.start()
async_gpt_polling = threading.Thread(target=gptpolling, args=("myarray",))
async_gpt_polling.start()

