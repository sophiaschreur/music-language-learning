import 'top.dart';
import 'answers_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart';
import 'fire_database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Stream<UserModel> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

//  sign in anonymously
  Future signInAnon() async {
    try {
      var result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  // sign in with email or username and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {}
  }

  // register with email or username and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await FireDatabaseService(uid: user.uid).updateUserData(
     
        userInputs[1],
        userInputs[2],
        [currentLanguage],
        {},
        {},
        0,
        [0, 0],
        [],
        [],
        false,
        {}
      );
      return _userFromFirebaseUser(user);
    } catch (e) {}
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
