// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Game{
    final String AwayTeam;
    final String AwayTeamCode;
    int AwayTeamScore;
    final Timestamp DateUtc;
    final String Group;
    final String HomeTeam;
    final String HomeTeamCode;
    int HomeTeamScore;
    final String Location;
    final int MatchNumber;
    final int RoundNumber;


    Game({
    required this.AwayTeam,
    required this.AwayTeamCode,
    required this.AwayTeamScore,
    required this.HomeTeamScore,
    required this.DateUtc,
    required this.Group,
    required this.HomeTeam,
    required this.HomeTeamCode,
    required this.MatchNumber,
    required this.Location,
    required this.RoundNumber,
  });

  factory Game.fromFirestore(
    DocumentSnapshot<Map<String,dynamic>> snapshot,
    SnapshotOptions? options,
  ){
    final data = snapshot.data();
    return Game(
      AwayTeam: data?["AwayTeam"],
      AwayTeamCode: data?["AwayTeamCode"],
      AwayTeamScore: data?["AwayTeamScore"],
      HomeTeamScore: data?["HomeTeamScore"],
      DateUtc: data?["DateUtc"],
      Group: data?["Group"],
      HomeTeam: data?["HomeTeam"],
      HomeTeamCode: data?["HomeTeamCode"],
      MatchNumber: data?["MatchNumber"],
      Location: data?["Location"],
      RoundNumber: data?["RoundNumber"]
       );
  }

  Map<String, dynamic> toFirestore(){
    return{
      "AwayTeam": AwayTeam,
      "AwayTeamCode": AwayTeamCode,
      "AwayTeamScore": AwayTeamScore,
      "HomeTeam": HomeTeam,
      "HomeTeamCode": HomeTeamCode,
      "HomeTeamScore": HomeTeamScore,
      "DateUtc": DateUtc,
      "Group": Group,
      "Location": Location,
      "RoundNumber": RoundNumber,
      "MatchNumber": MatchNumber
    };
  }

}