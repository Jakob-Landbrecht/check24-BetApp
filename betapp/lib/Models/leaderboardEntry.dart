import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderBoardEntry{
  final int rang;
  final int score;
  final String userID;
  String? Id;

  LeaderBoardEntry({
    required this.rang,
    required this.score,
    required this.userID,
  });

void setUid(String uid){
  Id = uid;
}

String getUid(){
  return Id!;
}

  factory LeaderBoardEntry.fromFirestore(
    DocumentSnapshot<Map<String,dynamic>> snapshot,
    SnapshotOptions? options,
  ){
    final data = snapshot.data();
    return LeaderBoardEntry(
      rang: data?["rang"],
      score: data?["score"],
      userID: data?["userID"],
       );
  }


  Map<String, dynamic> toFirestore(){
    return{
      "rang": rang,
      "score": score,
      "userID": userID,
    };
  }

}