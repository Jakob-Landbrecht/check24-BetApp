

import 'package:betapp/Models/User.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication{

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  

   Future<User?> signInAnon(String username) async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      
      final usermodel = model.User(username: username,isOnline: true, score: 0, midnightScore: 0);

      final docRef = db.collection('User').withConverter(
       fromFirestore: model.User.fromFirestore,
       toFirestore: (model.User user, options) => user.toFirestore(),).doc(user!.uid);

      await docRef.set(usermodel);
      return user;
    } catch (e) {
      return null;
    }
  }

  static String getUser(){
    return _auth.currentUser!.uid;
  }

  Stream<User?> get user{
    return _auth.authStateChanges();
  }

  void signOut() async{
    _auth.signOut();
  }

}