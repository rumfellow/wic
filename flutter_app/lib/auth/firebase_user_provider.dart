import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class WordsInContextFirebaseUser {
  WordsInContextFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

WordsInContextFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<WordsInContextFirebaseUser> wordsInContextFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<WordsInContextFirebaseUser>(
            (user) => currentUser = WordsInContextFirebaseUser(user));
