import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderBoardEntry {
  final int rang;
  final int score;
  final int scoreTemp;
  final String userId;
  final String username;
  String? id;

  LeaderBoardEntry({
    required this.rang,
    required this.score,
    required this.scoreTemp,
    required this.userId,
    required this.username
  });

  void setUid(String uid) {
    id = uid;
  }

  String getUid() {
    return id!;
  }


  factory LeaderBoardEntry.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return LeaderBoardEntry(
      rang: data?["rang"],
      score: data?["score"],
      username: data?["username"],
      userId: data?["userId"],
      scoreTemp: data?["scoreTemp"]
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "rang": rang,
      "score": score,
      "username": username,
      "userId": userId,
      "scoreTemp": scoreTemp
    };
  }
}
