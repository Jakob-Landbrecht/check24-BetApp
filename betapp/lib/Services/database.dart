// ignore_for_file: avoid_print

import 'package:betapp/Models/tournaments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static final db = FirebaseFirestore.instance;

  static Future<List<Tournament>> getTournaments() async{
    List<Tournament> tournaments = <Tournament>[];
    try{
  final ref = db.collection("Tournaments").withConverter(
      fromFirestore: Tournament.fromFirestore,
      toFirestore: (Tournament tournament, _) => tournament.toFirestore()
      );
      await ref.get().then((querySnapshot) {
        for(var docSnapshot in querySnapshot.docs){
          print(docSnapshot.data().name);
          tournaments.add(docSnapshot.data());
        }
      });
      return tournaments;
    }catch(e){
      print("Error fetching tournaments: $e");
      return [];
    }
  }
}
