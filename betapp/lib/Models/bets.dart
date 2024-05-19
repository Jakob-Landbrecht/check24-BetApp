import 'package:cloud_firestore/cloud_firestore.dart';

class Bet{
  final int homeTeamCount;
  final int awayTeamCount;
  final String gameUid;
  final String userUid;

  Bet({
    required this.homeTeamCount,
    required this.awayTeamCount,
    required this.gameUid,
    required this.userUid
  });

  factory Bet.fromFirestore(
    DocumentSnapshot<Map<String,dynamic>> snapshot,
    SnapshotOptions? options,
  ){
    final data = snapshot.data();
    return Bet(
      awayTeamCount: data?["awayTeamCount"],
      homeTeamCount: data?["homeTeamCount"],
      gameUid: data?["gameUid"],
      userUid: data?["userUid"],
       );
  }


  Map<String, dynamic> toFirestore(){
    return{
      "awayTeamCount": awayTeamCount,
      "homeTeamCount": homeTeamCount,
      "gameUid": gameUid,
      "userUid": userUid,
    };
  }

}