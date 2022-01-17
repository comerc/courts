import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CourtsFirebaseUser {
  CourtsFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

CourtsFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<CourtsFirebaseUser> courtsFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<CourtsFirebaseUser>((user) => currentUser = CourtsFirebaseUser(user));
