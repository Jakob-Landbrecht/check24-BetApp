import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String username;
  final bool isOnline;
  final int score;
  final int midnightScore; 
  final List<String>? communities;

  User({
    required this.username,
    required this.isOnline,
    required this.score,
    required this.midnightScore,
    this.communities,
  });

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      username: data?['username'],
      isOnline: data?['isOnline'],
      score: data?['score'],
      midnightScore: data?['midnightScore'],
      communities:
          data?['communities'] is Iterable ? List.from(data?['communities']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "username": username,
      "isOnline": isOnline,
      "score": score,
      "midnightScore": midnightScore,
      if (communities != null) "communities": communities,
    };
  }


}