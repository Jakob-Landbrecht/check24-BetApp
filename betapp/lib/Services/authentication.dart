

import 'package:firebase_auth/firebase_auth.dart';

class Authentication{

  final FirebaseAuth _auth = FirebaseAuth.instance;

   Future<User?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<User?> get user{
    return _auth.authStateChanges();
  }

  void signOut() async{
    _auth.signOut();
  }

}