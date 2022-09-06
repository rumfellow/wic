import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations);

  static List<String> languages() => ['en', 'es', 'ru', 'de', 'it'];

  String get languageCode => locale.toString();
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String enText = '',
    String esText = '',
    String ruText = '',
    String deText = '',
    String itText = '',
  }) =>
      [enText, esText, ruText, deText, itText][languageIndex] ?? '';
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      FFLocalizations.languages().contains(locale.toString());

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // loginpage
  {
    'mdd2a0qp': {
      'en': 'Please log in with Google or Apple',
      'de': 'Bitte melden Sie sich mit Google oder Apple an',
      'es': 'Inicie sesión con Google o Apple',
      'it': 'Accedi con Google o Apple',
      'ru': 'Пожалуйста, войдите с помощью Google или Apple',
    },
    '8ylh2f7v': {
      'en': 'Sign in with Google',
      'de': 'Anmeldung mit Google',
      'es': 'Inicia sesión con Google',
      'it': 'Accedi con Google',
      'ru': 'Войти через Google',
    },
    '34sfknef': {
      'en': 'Sign in with Apple',
      'de': 'Melden Sie sich bei Apple an',
      'es': 'Iniciar sesión con Apple',
      'it': 'Accedi con Apple',
      'ru': 'Войти через Apple',
    },
  },
  // gptinput
  {
    'jpksrffm': {
      'en':
          'Words in context uses GPT-3 artificial intelligence model to generate phrases, please provide an openAI API key: ',
      'de':
          'Wörter im Kontext verwenden das GPT-3-Modell der künstlichen Intelligenz, um Sätze zu generieren. Bitte geben Sie einen openAI-API-Schlüssel an:',
      'es':
          'Words in context usa el modelo de inteligencia artificial GPT-3 para generar frases, proporcione una clave API de openAI:',
      'it':
          'Words in context utilizza il modello di intelligenza artificiale GPT-3 per generare frasi, fornisci una chiave API openAI:',
      'ru':
          'Words in context использует модель искусственного интеллекта GPT-3 для генерации фраз, предоставьте ключ API openAI:',
    },
    'h1pz2mnc': {
      'en': 'Please paste GPT-3 API key',
      'de': 'Bitte fügen Sie den GPT-3-API-Schlüssel ein',
      'es': 'Pegue la clave API GPT-3',
      'it': 'Incolla la chiave API GPT-3',
      'ru': 'Пожалуйста, вставьте ключ API GPT-3',
    },
    'a63lodh9': {
      'en': 'Continue',
      'de': 'Fortsetzen',
      'es': 'Continuar',
      'it': 'Continua',
      'ru': 'Далее',
    },
    '2ki8msc8': {
      'en': 'See the instructions how to get the key',
      'de': 'Sehen Sie sich die Anweisungen an, wie Sie den Schlüssel erhalten',
      'es': 'Consultar las instrucciones sobre cómo obtener la llave.',
      'it': 'Oppure consulta le istruzioni su come ottenere la chiave',
      'ru': 'Инструкция как получить ключ',
    },
    'yaspb5fp': {
      'en': 'Instructions',
      'de': 'Anweisungen',
      'es': 'Instrucciones',
      'it': 'Istruzioni',
      'ru': 'Инструкция',
    },
    'lnnfr91j': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'it': 'Casa',
      'ru': 'Обратно',
    },
  },
  // Main
  {
    'bur0xqf3': {
      'en': 'Double tap to start',
      'de': 'Zum Starten doppeltippen',
      'es': 'Toca dos veces para empezar',
      'it': 'Tocca due volte per iniziare',
      'ru': 'Нажмите дважды, чтобы начать',
    },
    'da8s3q7m': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'it': 'Casa',
      'ru': 'Дом',
    },
  },
  // MainTexts
  {
    'qxlw24h0': {
      'en': 'Double tap to start\nwait 30 seconds',
      'de': 'Zum Starten doppeltippen',
      'es': 'Toca dos veces para empezar',
      'it': 'Tocca due volte per iniziare',
      'ru': 'Нажмите дважды, чтобы начать',
    },
    'cot4fwla': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'it': 'Casa',
      'ru': 'Дом',
    },
  },
  // settings
  {
    '1ib5hf8n': {
      'en': 'Email Address',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
      'it': 'Indirizzo e-mail',
      'ru': 'Адрес электронной почты',
    },
    '6bvxrgfn': {
      'en': '[Some hint text...]',
      'de': '[Einige Hinweistexte...]',
      'es': '[Algún texto de pista...]',
      'it': '[Alcuni suggerimenti di testo...]',
      'ru': '[Некоторый текст подсказки...]',
    },
    'xgoyz4ks': {
      'en': 'GPT-3 API Key',
      'de': 'GPT-3-API-Schlüssel',
      'es': 'Clave API GPT-3',
      'it': 'Chiave API GPT-3',
      'ru': 'Ключ API GPT-3',
    },
    'njhmn9gi': {
      'en': '[Some hint text...]',
      'de': '[Einige Hinweistexte...]',
      'es': '[Algún texto de pista...]',
      'it': '[Alcuni suggerimenti di testo...]',
      'ru': '[Некоторый текст подсказки...]',
    },
    'l8dec08a': {
      'en': 'Available dictionaries',
      'de': 'Verfügbare Wörterbücher',
      'es': 'Diccionarios disponibles',
      'it': 'Dizionari disponibili',
      'ru': 'Доступные словари',
    },
    'bhhis4js': {
      'en': 'Option 1',
      'de': 'Option 1',
      'es': 'Opción 1',
      'it': 'opzione 1',
      'ru': 'Опция 1',
    },
    'y6bp2uhj': {
      'en': 'Please select...',
      'de': 'Bitte auswählen...',
      'es': 'Por favor selecciona...',
      'it': 'Si prega di selezionare...',
      'ru': 'Пожалуйста выберите...',
    },
    '0dzaibsq': {
      'en': 'Foreign language:',
      'de': 'Fremdsprache:',
      'es': 'Idioma extranjero:',
      'it': 'Lingua straniera:',
      'ru': 'Иностранный язык:',
    },
    'uafjfpbj': {
      'en': 'Español',
      'de': 'Spanisch',
      'es': 'ingles',
      'it': 'spagnolo',
      'ru': 'испанский',
    },
    'ib9andpf': {
      'en': 'Foreign language',
      'de': 'Fremdsprache',
      'es': 'Idioma extranjero',
      'it': 'Lingua straniera',
      'ru': 'Иностранный язык',
    },
    'yu1z2thy': {
      'en': 'Native language:',
      'de': 'Muttersprache:',
      'es': 'Lengua materna:',
      'it': 'Lingua nativa:',
      'ru': 'Родной язык:',
    },
    'zc95yczn': {
      'en': 'English',
      'de': 'Englisch',
      'es': 'inglés',
      'it': 'inglese',
      'ru': 'Английский',
    },
    '7oz1zh22': {
      'en': 'Native language',
      'de': 'Muttersprache',
      'es': 'Lengua materna',
      'it': 'Lingua nativa',
      'ru': 'Родной язык',
    },
    'tib5trw0': {
      'en': 'Text generation styles',
      'de': 'Textgenerierungsstile',
      'es': 'Estilos de generación de texto',
      'it': 'Stili di generazione del testo',
      'ru': 'Стили генерации текста',
    },
    '71z3wm2v': {
      'en': 'Normal',
      'de': 'Normal',
      'es': 'Normal',
      'it': 'Normale',
      'ru': 'Обычный',
    },
    '5scuwc7f': {
      'en': 'Normal',
      'de': 'Normal',
      'es': 'Normal',
      'it': 'Normale',
      'ru': 'Обычный',
    },
    'r3uzbk9t': {
      'en': 'Add/delete user dictionaries',
      'de': 'Wörterbücher hinzufügen/löschen',
      'es': 'Agregar/eliminar diccionarios de usuario',
      'it': 'Aggiungi/elimina dizionari utente',
      'ru': 'Добавить/удалить  словари',
    },
    'y31mbutt': {
      'en': 'GPT-3 registration & instructions',
      'de': 'GPT-3-Registrierung und Anweisungen',
      'es': 'Registro e instrucciones de GPT-3',
      'it': 'Registrazione e istruzioni GPT-3',
      'ru': 'Регистрация и инструкции GPT-3',
    },
    'app5r6eb': {
      'en': 'Update settings/back',
      'de': 'Einstellungen aktualisieren/zurück',
      'es': 'Actualizar configuración/atrás',
      'it': 'Aggiorna impostazioni/indietro',
      'ru': 'Обновить настройки/назад',
    },
    'f6gq3j56': {
      'en': 'Logout',
      'de': 'Ausloggen',
      'es': 'Cerrar sesión',
      'it': 'Disconnettersi',
      'ru': 'Выйти',
    },
    'h88spajf': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'it': 'Casa',
      'ru': 'Дом',
    },
  },
  // gptinstructions
  {
    'lscwdxm1': {
      'en': 'GPT-3 instructions',
      'de': 'GPT-3-Anweisungen',
      'es': 'Instrucciones GPT-3',
      'it': 'Istruzioni GPT-3',
      'ru': 'Инструкции GPT-3',
    },
    'vobznaz5': {
      'en':
          'GPT-3 is OpenAI\'s artificial intelligence that is specifically trained to generate phrases and/or texts. Words in context uses GPT-3 model for generation based on words from oxford5000 frequency dictionary depending on language level you have chosen or from your custom dictionary.',
      'de':
          'GPT-3 ist die künstliche Intelligenz von OpenAI, die speziell darauf trainiert ist, Phrasen und/oder Texte zu generieren. Wörter im Kontext verwendet das GPT-3-Modell zur Generierung basierend auf Wörtern aus dem Oxford5000-Häufigkeitswörterbuch, abhängig von der von Ihnen gewählten Sprachstufe, oder aus Ihrem benutzerdefinierten Wörterbuch.',
      'es':
          'GPT-3 es la inteligencia artificial de OpenAI que está entrenada específicamente para generar frases y/o textos. Palabras en contexto utiliza el modelo GPT-3 para la generación basada en palabras del diccionario de frecuencia oxford5000 según el nivel de idioma que haya elegido o de su diccionario personalizado.',
      'it':
          'GPT-3 è l&#39;intelligenza artificiale di OpenAI specificamente addestrata per generare frasi e/o testi. Parole nel contesto utilizza il modello GPT-3 per la generazione basato su parole dal dizionario di frequenza oxford5000 a seconda del livello di lingua che hai scelto o dal tuo dizionario personalizzato.',
      'ru':
          'GPT-3 — это искусственный интеллект OpenAI, специально обученный генерировать фразы и/или тексты. Слова в контексте используют модель GPT-3 для генерации на основе слов из частотного словаря oxford5000 в зависимости от выбранного вами уровня языка или из вашего пользовательского словаря.',
    },
    '3sw0fl4t': {
      'en':
          'GPT-3 API Key is the key that you provide so we can generate phrases/texts for you.\n\nThese are the steps to follow:',
      'de':
          'Der GPT-3-API-Schlüssel ist der Schlüssel, den Sie bereitstellen, damit wir Phrasen/Texte für Sie generieren können. Dies sind die folgenden Schritte:',
      'es':
          'La clave API GPT-3 es la clave que proporciona para que podamos generar frases/textos para usted. Estos son los pasos a seguir:',
      'it':
          'La chiave API GPT-3 è la chiave che fornisci in modo che possiamo generare frasi/testi per te. Questi sono i passaggi da seguire:',
      'ru':
          'Ключ API GPT-3 — это ключ, который вы предоставляете, чтобы мы могли генерировать для вас фразы/тексты. Вот шаги, которые необходимо выполнить:',
    },
    '2y78s6rl': {
      'en': '1. Press here for registration',
      'de': '1. Drücken Sie hier, um sich zu registrieren',
      'es': '1. Pulse aquí para registrarse',
      'it': '1. Premi qui per la registrazione',
      'ru': '1. Нажмите здесь для регистрации',
    },
    '1thlzwhc': {
      'en': '2. Press here to copy API Key - secret key, copy',
      'de':
          '2. Drücken Sie hier, um den API-Schlüssel zu kopieren  - secret key, copy',
      'es': '2. Presione aquí para copiar la clave API - secret key, copy',
      'it': '2. Premere qui per copiare la chiave API  - secret key, copy',
      'ru': '2. Нажмите здесь, чтобы скопировать ключ API  - secret key, copy',
    },
    'g6lpac21': {
      'en': '3. Paste the key in the form below:',
      'de': '3. Fügen Sie den Schlüssel in das folgende Formular ein:',
      'es': '3. Pegue la clave en el siguiente formulario:',
      'it': '3. Incolla la chiave nel modulo seguente:',
      'ru': '3. Вставьте ключ в форму ниже:',
    },
    '783v1731': {
      'en': 'API Key',
      'de': 'API-Schlüssel',
      'es': 'Clave API',
      'it': 'Chiave API',
      'ru': 'API-ключ',
    },
    'juin3h5z': {
      'en': 'Save key and return',
      'de': 'Schlüssel speichern und zurück',
      'es': 'Guardar clave y volver',
      'it': 'Salva la chiave e torna',
      'ru': 'Сохранить ключ и вернуться',
    },
    '7xzfzy9m': {
      'en':
          'Please note the following:\n1. Free OpenAI account is valid for 3 month\n2. Your key will be used only by you',
      'de':
          'Bitte beachten Sie Folgendes: 1. Das kostenlose OpenAI-Konto ist 3 Monate lang gültig. \n2. Ihr Schlüssel wird nur von Ihnen verwendet',
      'es':
          'Tenga en cuenta lo siguiente: 1. La cuenta gratuita de OpenAI es válida durante 3 meses \n2. Solo usted utilizará su clave',
      'it':
          'Si prega di notare quanto segue: 1. L&#39;account OpenAI gratuito è valido per 3 mesi \n2. La tua chiave sarà utilizzata solo da te',
      'ru':
          'Обратите внимание на следующее: 1. Бесплатная учетная запись OpenAI действительна в течение 3 месяцев \n2. Ваш ключ будет использоваться только вами',
    },
    '13ykobxt': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'it': 'Casa',
      'ru': 'Дом',
    },
  },
  // testpage
  {
    'h5qwfr96': {
      'en': 'Button',
      'de': 'Taste',
      'es': 'Botón',
      'it': 'Pulsante',
      'ru': 'Кнопка',
    },
    'yhkigsz7': {
      'en': 'Button',
      'de': 'Taste',
      'es': 'Botón',
      'it': 'Pulsante',
      'ru': 'Кнопка',
    },
    '35l4wbel': {
      'en': '[Some hint text...]',
      'de': '[Einige Hinweistexte...]',
      'es': '[Algún texto de pista...]',
      'it': '[Alcuni suggerimenti di testo...]',
      'ru': '[Некоторый текст подсказки...]',
    },
    '3xdgfeac': {
      'en': 'Hello World',
      'de': 'Hallo Welt',
      'es': 'Hola Mundo',
      'it': 'Ciao mondo',
      'ru': 'Привет, мир',
    },
    'ppij620o': {
      'en': 'Page Title',
      'de': 'Seitentitel',
      'es': 'Título de la página',
      'it': 'Titolo della pagina',
      'ru': 'Заголовок страницы',
    },
    'l2legfqe': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'it': 'Casa',
      'ru': 'Дом',
    },
  },
  // addDicts
  {
    'bcxuyxpj': {
      'en': 'Add/delete dictionaries',
      'de': 'Wörterbücher hinzufügen/löschen',
      'es': 'Agregar/eliminar diccionarios',
      'it': 'Aggiungi/elimina dizionari',
      'ru': 'Добавить/удалить словари',
    },
    'gd7urc3b': {
      'en':
          'Add words to your personal dictionary which can be selected in the settings page',
      'de':
          'Fügen Sie Ihrem persönlichen Wörterbuch Wörter hinzu, die auf der Einstellungsseite ausgewählt werden können',
      'es':
          'Agregue palabras a su diccionario personal que se pueden seleccionar en la página de configuración',
      'it':
          'Aggiungi parole al tuo dizionario personale che può essere selezionato nella pagina delle impostazioni',
      'ru':
          'Добавляйте слова в свой личный словарь, которые можно выбрать на странице настроек',
    },
    'dozhszdo': {
      'en': 'Dictionary name:',
      'de': 'Wörterbuchname:',
      'es': 'Nombre del diccionario:',
      'it': 'Nome del dizionario:',
      'ru': 'Название словаря:',
    },
    'sovrbmwi': {
      'en': 'Dictionary name',
      'de': 'Wörterbuchname',
      'es': 'Nombre del diccionario',
      'it': 'Nome del dizionario',
      'ru': 'Название словаря',
    },
    '8f9iurt7': {
      'en': 'Dictionary language:',
      'de': 'Wörterbuchsprache:',
      'es': 'Idioma del diccionario:',
      'it': 'Lingua del dizionario:',
      'ru': 'Язык словаря:',
    },
    '4wv6nif6': {
      'en': 'Option 1',
      'de': 'Option 1',
      'es': 'Opción 1',
      'it': 'opzione 1',
      'ru': 'Опция 1',
    },
    '03wy60mc': {
      'en': 'Please select...',
      'de': 'Bitte auswählen...',
      'es': 'Por favor selecciona...',
      'it': 'Si prega di selezionare...',
      'ru': 'Пожалуйста выберите...',
    },
    'dqeffi13': {
      'en': 'Please input your words, comma sperated:',
      'de': 'Bitte geben Sie Ihre Wörter kommagetrennt ein:',
      'es': 'Por favor ingrese sus palabras, separadas por comas:',
      'it': 'Per favore inserisci le tue parole, virgola separata:',
      'ru': 'Пожалуйста, введите ваши слова, через запятую:',
    },
    'rv2ij9ut': {
      'en': 'Your word, another word, third word etc',
      'de': 'Ihr Wort, ein anderes Wort, drittes Wort usw',
      'es': 'Tu palabra, otra palabra, tercera palabra, etc.',
      'it': 'La tua parola, un&#39;altra parola, terza parola ecc',
      'ru': 'Ваше слово, другое слово, третье слово и т. д.',
    },
    'awy7pfnv': {
      'en': 'Update/create dictionary',
      'de': 'Wörterbuch aktualisieren/erstellen',
      'es': 'Actualizar/crear diccionario',
      'it': 'Aggiorna/crea dizionario',
      'ru': 'Обновить/создать словарь',
    },
    'l43hxkdh': {
      'en':
          'Delete  your personal dictionaries.\nNote that the action is irreversible',
      'de':
          'Löschen Sie Ihre persönlichen Wörterbücher. Beachten Sie, dass die Aktion irreversibel ist',
      'es':
          'Elimina tus diccionarios personales. Tenga en cuenta que la acción es irreversible.',
      'it':
          'Elimina i tuoi dizionari personali. Si noti che l&#39;azione è irreversibile',
      'ru':
          'Удалите свои личные словари. Обратите внимание, что действие необратимо',
    },
    'q4uttvhx': {
      'en': 'Delete ',
      'de': 'Löschen',
      'es': 'Borrar',
      'it': 'Elimina',
      'ru': 'Удалить',
    },
    '4n6y2agz': {
      'en': 'Personal dict',
      'de': 'Persönliche Wörterbuch',
      'es': 'Diccionario personal',
      'it': 'Вizionari personale',
      'ru': 'Личный словарь',
    },
    'wxrj6bg4': {
      'en': 'Personal dict',
      'de': 'Persönliche Wörterbuch',
      'es': 'Diccionario personal',
      'it': 'Вizionari personale',
      'ru': 'Личный словарь',
    },
    'z542txof': {
      'en': 'User dictionaries',
      'de': 'Benutzerwörterbücher',
      'es': 'Diccionarios de usuario',
      'it': 'Dizionari utente',
      'ru': 'Пользовательские словари',
    },
    'ndiia25y': {
      'en': 'Delete all liked phrases:',
      'de': 'Alle mit „Gefällt mir“ markierten Phrasen löschen:',
      'es': 'Eliminar todas las frases que me gustan:',
      'it': 'Elimina tutte le frasi piaciute:',
      'ru': 'Удалить все выбранные фразы:',
    },
    's27wqdv5': {
      'en': 'Purge',
      'de': 'Säubern',
      'es': 'Purga',
      'it': 'Epurazione',
      'ru': 'Удалить',
    },
    '58w48qgy': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'it': 'Casa',
      'ru': 'Дом',
    },
  },
  // Miscellaneous
  {
    '2jlsa3oi': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    'xjdr5jcr': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    'ck4509te': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    'ebwmhnh6': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    'cabrvj5k': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    'qqqsrrtq': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    'ltfqmfgl': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    'qx6u6wso': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    'ntv665jr': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    'fdupk0j0': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    'c9ocpfwo': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    'rttlk8rw': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    'dl5quz0l': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    'lbbyt1y9': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    'ptggh2nt': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    '07ly31zz': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    'm4vpjz3f': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    '8vmwmqsn': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    '3i74gpnk': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
    'l63bq3iv': {
      'en': '',
      'de': '',
      'es': '',
      'it': '',
      'ru': '',
    },
  },
].reduce((a, b) => a..addAll(b));
