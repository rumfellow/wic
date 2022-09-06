#!/bin/python3
import PySimpleGUI as sg
from credentials import openai_key, deepl_key, anki_db_path
from backend_functions import get_random_word, readdb,espprompt,deepltrans
import openai
import deepl

transl = deepl.Translator(deepl_key)
openai.api_key = openai_key


spanish = espprompt(tuple(get_random_word(anki_db_path))[0][0])
english = deepltrans(spanish, transl)

sg.theme('DarkTeal11')
sg.set_options(font=("Courier New", 14))

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
    if event == sg.WIN_CLOSED or event == "-ESCAPE-":
        break
    if event == "-RETURN-":
        window['translation'].update(spanish)
        print(spanish,english)
    if event == "-SPACE-":
        spanish = espprompt(readdb())
        english = deepltrans(spanish, transl)
        window['-ENG-'].update(english)
        window['translation'].update(' ')
            
window.close()
