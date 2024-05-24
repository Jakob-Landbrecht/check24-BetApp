import 'package:betapp/Models/bets.dart';
import 'package:betapp/Models/community.dart';
import 'package:betapp/Models/game.dart';
import 'package:betapp/Models/leaderboardEntry.dart';
import 'package:betapp/Models/tournaments.dart';
import 'package:betapp/Models/user.dart';
import 'package:betapp/Services/authentication.dart';
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
          Tournament tournament = docSnapshot.data();
          tournament.setUID(docSnapshot.id);
          tournaments.add(tournament);
        }
      });
      return tournaments;
    }catch(e){
      print("Error fetching tournaments: $e");
      return [];
    }
  }

  static Stream<QuerySnapshot<Game>> upcomingGame(Tournament tournament){
    return db.collection("Tournaments")
                     .doc(tournament.getUID())
                     .collection("Games")
                     .withConverter(fromFirestore: Game.fromFirestore, toFirestore: (Game game,_ )=> game.toFirestore())
                     .orderBy("DateUtc")
                     .where("DateUtc", isGreaterThan: DateTime.now()) //.add(const Duration(days:30))
                     .limit(1)
                     .snapshots();
  }

  static Stream<QuerySnapshot<Game>> currentGame(Tournament tournament){
    return db.collection("Tournament")
                     .doc(tournament.getUID())
                     .collection("Games")
                    .withConverter(fromFirestore: Game.fromFirestore, toFirestore: (Game game,_ )=> game.toFirestore())
                    .where("DateUtc", isGreaterThan: DateTime.now(), isLessThan: DateTime.now().add(const Duration(minutes: 90)))
                    .snapshots();
  }

  static Future<bool> setBet(Tournament tournament, Game game, int homeTeamCount, int awayTeamCount)async{
    final docRef = db.collection("Tournaments").doc(tournament.getUID()).collection("Bets");

    QuerySnapshot s = await docRef.where("gameUid", isEqualTo: game.GameUid).where("userUid", isEqualTo: Authentication.getUser()).get();
    if(s.size != 0){
      return false;
    }
    final Bet bet = Bet(awayTeamCount: awayTeamCount, homeTeamCount: homeTeamCount, gameUid: game.GameUid!, userUid: Authentication.getUser());
    await docRef.withConverter(fromFirestore: Bet.fromFirestore, toFirestore: (Bet bet, options)=> bet.toFirestore()).doc().set(bet);
    return true;
  }

  static Future<Community> createCommunity(String name, Tournament tournament)async{
    final docRef = db.collection("Tournaments").doc(tournament.getUID()).collection("Communities").withConverter(fromFirestore: Community.fromFirestore, toFirestore: (Community community, options) => community.toFirestore()).doc();
    Community community = Community(name: name, communityUid: docRef.id);
    await docRef.set(community);
    return community;
  }

  static Future<bool> joinCommunity(String communityUid, Tournament tournament) async {
    final docRef = db.collection("User").doc(Authentication.getUser());
    DocumentSnapshot<User> temp = await docRef.withConverter(fromFirestore: User.fromFirestore, toFirestore: (User user, options) => user.toFirestore()).get();
    User user = temp.data()!;
    await docRef.update({"Communities:${tournament.getUID()}" : FieldValue.arrayUnion([communityUid])});

    final leaderBoardRef = db.collection("Tournaments").doc(tournament.getUID()).collection("Communities").doc(communityUid).collection("Leaderboard")
    .withConverter(fromFirestore: LeaderBoardEntry.fromFirestore, toFirestore: (LeaderBoardEntry leaderboardEntry, options)=> leaderboardEntry.toFirestore()).doc();
    await leaderBoardRef.set(LeaderBoardEntry(rang: 0, score: 0, scoreTemp: 0, userId: Authentication.getUser(), username: user.username));    
    return true;
  }

   static Future<bool> leaveCommunity(String communityUid, Tournament tournament) async {
    final docRef = db.collection("User").doc(Authentication.getUser());
    await docRef.update({"Communities:${tournament.getUID()}" : FieldValue.arrayRemove([communityUid])});
    return true;
  }

  static Future<bool> communityExists(String potentialCommunityUid, Tournament tournament)async{
    final docRef = db.collection("Tournaments").doc(tournament.getUID()).collection("Communities").withConverter(fromFirestore: Community.fromFirestore, toFirestore: (Community community, options) => community.toFirestore()).doc(potentialCommunityUid);
    DocumentSnapshot documentSnapshot = await docRef.get();
    return documentSnapshot.exists;
  }







//////HANDELING THE LEADERBOARD
///
///Getting Realtime Feed///
static Stream<QuerySnapshot<LeaderBoardEntry>> loadCommunityLeaderboard(Community community, Tournament tournament){
  return db.collection("Tournaments")
           .doc(tournament.getUID())
           .collection("Communities")
           .doc(community.getUid())
           .collection("Leaderboard")
           .withConverter(fromFirestore: LeaderBoardEntry.fromFirestore, toFirestore: (LeaderBoardEntry leaderboardEntry, options) => leaderboardEntry.toFirestore())
           .orderBy("rang")
           .limit(20)
           .snapshots();
}



}
