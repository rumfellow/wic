import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _gptKey = prefs.getString('ff_gptKey') ?? _gptKey;
    _currentDict = prefs.getString('ff_currentDict') ?? _currentDict;
    _currentNative = prefs.getString('ff_currentNative') ?? _currentNative;
    _currentTarget = prefs.getString('ff_currentTarget') ?? _currentTarget;
  }

  SharedPreferences prefs;

  String _gptKey = '';
  String get gptKey => _gptKey;
  set gptKey(String _value) {
    _gptKey = _value;
    prefs.setString('ff_gptKey', _value);
  }

  String _currentDict = 'Train phrases';
  String get currentDict => _currentDict;
  set currentDict(String _value) {
    _currentDict = _value;
    prefs.setString('ff_currentDict', _value);
  }

  String currentStyle = 'Normal';

  String _currentNative = 'English';
  String get currentNative => _currentNative;
  set currentNative(String _value) {
    _currentNative = _value;
    prefs.setString('ff_currentNative', _value);
  }

  String _currentTarget = 'Español';
  String get currentTarget => _currentTarget;
  set currentTarget(String _value) {
    _currentTarget = _value;
    prefs.setString('ff_currentTarget', _value);
  }

  List<String> like = [];

  String textOrPhrase = 'phrase';

  bool likedOrNot = false;

  bool startApp = false;

  bool startappTexts = false;

  List<String> dictList = [];

  List<String> styleList = [];

  List<String> customDict = [];

  List<String> langList = [];
}

LatLng _latLngFromString(String val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
