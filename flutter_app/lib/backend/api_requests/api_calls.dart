import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class GetsentencesCall {
  static Future<ApiCallResponse> call({
    String gptAPI = 'nokey',
    String dictionary = 'Train phrases',
    String trans = 'Español',
    String native = 'English',
    String mytok = 'auth',
    String uuid = 'notset',
  }) {
    final body = '''
{
  "gptAPI": "${gptAPI}",
  "native": "${native}",
  "trans": "${trans}",
  "dictionary": "${dictionary}",
  "uuid": "${uuid}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getsentences',
      apiUrl:
          'https://uvjuhrkchl.execute-api.eu-central-1.amazonaws.com/default',
      callType: ApiCallType.POST,
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'mytok': '${mytok}',
      },
      params: {
        'gptAPI': gptAPI,
        'dictionary': dictionary,
        'trans': trans,
        'native': native,
        'uuid': uuid,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }

  static dynamic nativePhrase(dynamic response) => getJsonField(
        response,
        r'''$.native''',
      );
  static dynamic targetPhrase(dynamic response) => getJsonField(
        response,
        r'''$.target''',
      );
  static dynamic nativeWord(dynamic response) => getJsonField(
        response,
        r'''$.word''',
      );
  static dynamic targetWord(dynamic response) => getJsonField(
        response,
        r'''$.translation''',
      );
}

class GetgeneralsettingsCall {
  static Future<ApiCallResponse> call({
    String uuid = 'na',
    String mytok = '',
  }) {
    final body = '''
{
  "uuid": "${uuid}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getgeneralsettings',
      apiUrl:
          'https://uvjuhrkchl.execute-api.eu-central-1.amazonaws.com/default/usersettings',
      callType: ApiCallType.POST,
      headers: {
        'mytok': '${mytok}',
      },
      params: {
        'uuid': uuid,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }

  static dynamic dictionaries(dynamic response) => getJsonField(
        response,
        r'''$.body.dictionaries''',
      );
  static dynamic languages(dynamic response) => getJsonField(
        response,
        r'''$.body.languages''',
      );
  static dynamic styles(dynamic response) => getJsonField(
        response,
        r'''$.body.styles''',
      );
  static dynamic defaultDict(dynamic response) => getJsonField(
        response,
        r'''$.body.defaultDict''',
      );
  static dynamic defaultStyle(dynamic response) => getJsonField(
        response,
        r'''$.body.defaultStyle''',
      );
  static dynamic defaultLant(dynamic response) => getJsonField(
        response,
        r'''$.body.defaultLang''',
      );
  static dynamic userDicts(dynamic response) => getJsonField(
        response,
        r'''$.body.userDicts''',
      );
}

class LikedButtonActionCall {
  static Future<ApiCallResponse> call({
    String trans = 'Español',
    String dictionary = 'A2 beginner',
    String uuid = 'Mytoken11',
    String phraseid = 'none',
    String targetWord = 'manzana',
    String mytok = 'auth',
  }) {
    final body = '''
{
  "trans": "${trans}",
  "dictionary": "${dictionary}",
  "uuid": "${uuid}",
  "phraseid": "${phraseid}",
"target_word":"${targetWord}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Liked button action',
      apiUrl:
          'https://uvjuhrkchl.execute-api.eu-central-1.amazonaws.com/default/liked-button-api-dev-writeliked',
      callType: ApiCallType.POST,
      headers: {
        'mytok': '${mytok}',
      },
      params: {
        'trans': trans,
        'dictionary': dictionary,
        'uuid': uuid,
        'phraseid': phraseid,
        'target_word': targetWord,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class DeldictsCall {
  static Future<ApiCallResponse> call({
    String uuid = 'Mytoken11',
    String action = 'purge',
    String userdict = 'nope',
    String mytok = '',
  }) {
    final body = '''
{
  "uuid": "${uuid}",
  "action": "${action}",
  "userdict": "${userdict}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'deldicts',
      apiUrl:
          'https://uvjuhrkchl.execute-api.eu-central-1.amazonaws.com/default/deldict',
      callType: ApiCallType.POST,
      headers: {
        'mytok': '${mytok}',
      },
      params: {
        'uuid': uuid,
        'action': action,
        'userdict': userdict,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class AddDictsCall {
  static Future<ApiCallResponse> call({
    String uuid = 'Mytoken11',
    String trans = 'Español',
    String words = 'peach',
    String dictionary = 'testcustomdict',
    String mytok = 'auth',
  }) {
    final body = '''
{
"trans":"${trans}",
"dictionary":"${dictionary}",
"uuid":"${uuid}",
"words":"${words}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'addDicts',
      apiUrl:
          'https://uvjuhrkchl.execute-api.eu-central-1.amazonaws.com/default/adddicts',
      callType: ApiCallType.POST,
      headers: {
        'mytok': '${mytok}',
      },
      params: {
        'uuid': uuid,
        'trans': trans,
        'words': words,
        'dictionary': dictionary,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class TextgenCall {
  static Future<ApiCallResponse> call({
    String mytok = 'auth',
    String trans = '',
    String native = '',
    String dictionary = '',
    String style = '',
    String gptkey = '',
    String uuid = 'Mytoken11',
  }) {
    final body = '''
{
  "uuid": "${uuid}",
  "trans": "${trans}",
  "native": "${native}",
  "dictionary": "${dictionary}",
  "style": "${style}",
  "gptkey": "${gptkey}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'textgen',
      apiUrl:
          'https://uvjuhrkchl.execute-api.eu-central-1.amazonaws.com/default/textgen',
      callType: ApiCallType.POST,
      headers: {
        'mytok': '${mytok}',
      },
      params: {
        'trans': trans,
        'native': native,
        'dictionary': dictionary,
        'style': style,
        'gptkey': gptkey,
        'uuid': uuid,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }

  static dynamic native(dynamic response) => getJsonField(
        response,
        r'''$.native''',
      );
  static dynamic target(dynamic response) => getJsonField(
        response,
        r'''$.target''',
      );
  static dynamic words(dynamic response) => getJsonField(
        response,
        r'''$.word''',
      );
}
