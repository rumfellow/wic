# Words in Context
## About the project
It is a pet project aimed at easier foreign lexic and grammar acquisition by means of placing the words that are being learned in phrases, i.e. lexical and grammatical context, hence the name. 

In short, words either from the user dictionary or oxford 5000 frequency dictionary are passed on to GPT-3 Da-Vinci2 model for phrase generation in the learned language. Then, the phrase is translated to the user's stated native language. In its turn the app has 3 sliding pages: one with the target phrase, the second has the phrase in native language, and the third - with the word used for generation in target and native languages. 

The app also provides text generation, when a short story is generated using 25 words from the chosen dictionary. Da-Vinci is capable of creating pretty fun stories and styling can be applied in the settings page. 

The idea behind such an approach is better memorization, habitualization of the word use and exposure to new lexical and grammatical constructions.

Apart from the above mentioned is the "Train phrases" dictionary which is based off of Tatoeba projects database. It consists of human-generated random phrases in 6 languages that are supported by the app: English, Spanish, French, Italian, German, Russian. Currently it holds 1,621,780 phrases.

As mentioned, the generation is enabled by OpenAI's GPT-3 model and as the project's goal is to be zero cost, user has to provide the API key to use this function. In case it is not an option, using Tatoeba dictionary is still possible. Overall, GPT-3 generation proved to be mostly indistinguishable from native speaker generated content.

Translation services are provided by DeepL, that proved to be consistent and adequate. Much better than Google clound translate.

The backend is written in Python 3.9. The quality is very spaghetti, but it is a proof of concept, so hopefully I'll rewrite some of it.

The appliacation for IOS/Android is written in Flutter and needs some polishing, but is absolutely functional.

The application for Linux is written in Python using SimplePyGUI for prototyping purposes. Still works though.

All folders with *-lambda contain AWS lambda scripts, that were packaged and deployed with Serverless framework.

You can try the android app by installing [these apks](https://github.com/rumfellow/wic/tree/master/flutter_app/build_apks).


## Structure:

![wic](https://user-images.githubusercontent.com/109697877/188860910-f2b63509-f627-4038-afc6-8af39e104194.png)



