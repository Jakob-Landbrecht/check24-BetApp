import 'package:betapp/Models/user.dart' as model;
import 'package:betapp/Models/tournaments.dart';
import 'package:betapp/Services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

class Authentication{

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  

   Future<User?> signInAnon(String username) async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      
      final usermodel = model.User(username: username,isOnline: true, score: 0, midnightScore: 0);

      final docRef = db.collection('User').withConverter(
       fromFirestore: model.User.fromFirestore,
       toFirestore: (model.User user, options) => user.toFirestore(),).doc(user!.uid);
      await docRef.set(usermodel);


      QuerySnapshot<Tournament> snapshot = await db.collection("Tournaments").withConverter(fromFirestore: Tournament.fromFirestore, toFirestore: (Tournament tournament, options) => tournament.toFirestore()).get();
      for(DocumentSnapshot<Tournament> document in snapshot.docs){
        await Database.joinCommunity("global", document.data()!);
      }
      return user;
    } catch (e) {
      return null;
    }
  }

  static Future<Timestamp> getRegistrationDate()async{
    DocumentSnapshot documentSnapshot = await db.collection("User").doc(getUser()).get();
    return (documentSnapshot.data() as Map<String, dynamic>)["registrationDate"];
  
  }

  static String getUser(){
    return _auth.currentUser!.uid;
  }

  Stream<User?> get user{
    return _auth.authStateChanges();
  }

  static void signOut() async{
    _auth.signOut();
  }

}