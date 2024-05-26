import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderBoardEntry {
  final int rang;
  final int score;
  final int scoreTemp;
  final String userId;
  final bool isOnline;
  final String username;
  final Timestamp registrationDate;
  String? id;

  LeaderBoardEntry({
    required this.rang,
    required this.score,
    required this.scoreTemp,
    required this.userId,
    required this.registrationDate,
    required this.username,
    required this.isOnline
  });

  void setUid(String uid) {
    id = uid;
  }

  String getUid() {
    return id!;
  }

  factory LeaderBoardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderBoardEntry(
      isOnline: json['isOnline'] ?? false,
      rang: json['rang'] ?? 0,
      userId: json['userId'] ?? '',
      username: json['username'] ?? '',
      score: json['score'] ?? 0,
      scoreTemp: json['scoreTemp'] ?? 0,
      registrationDate: json['registrationDate'],
    );
  }


  factory LeaderBoardEntry.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return LeaderBoardEntry(
      rang: data?["rang"],
      isOnline: data?["isOnline"],
      score: data?["score"],
      username: data?["username"],
      userId: data?["userId"],
      scoreTemp: data?["scoreTemp"],
      registrationDate: data?["registrationDate"]
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "rang": rang,
      "isOnline": isOnline,
      "score": score,
      "username": username,
      "userId": userId,
      "scoreTemp": scoreTemp,
      "registrationDate": registrationDate
    };
  }
}
