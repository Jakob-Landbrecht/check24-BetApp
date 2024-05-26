import 'dart:convert';
import 'package:betapp/Models/preview.dart';
import 'package:http/http.dart' as http;
import 'package:betapp/Models/bets.dart';
import 'package:betapp/Models/community.dart';
import 'package:betapp/Models/game.dart';
import 'package:betapp/Models/leaderboardEntry.dart';
import 'package:betapp/Models/tournaments.dart';
import 'package:betapp/Models/user.dart';
import 'package:betapp/Services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  static final db = FirebaseFirestore.instance;

  static Future<List<Tournament>> getTournaments() async {
    List<Tournament> tournaments = <Tournament>[];
    try {
      final ref = db.collection("Tournaments").withConverter(
          fromFirestore: Tournament.fromFirestore,
          toFirestore: (Tournament tournament, _) => tournament.toFirestore());
      await ref.get().then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          Tournament tournament = docSnapshot.data();
          tournament.setUID(docSnapshot.id);
          tournaments.add(tournament);
        }
      });
      return tournaments;
    } catch (e) {
      return [];
    }
  }

  static Stream<QuerySnapshot<Game>> upcomingGame(Tournament tournament) {
    return db
        .collection("Tournaments")
        .doc(tournament.getUID())
        .collection("Games")
        .withConverter(
            fromFirestore: Game.fromFirestore,
            toFirestore: (Game game, _) => game.toFirestore())
        .orderBy("DateUtc")
        .where("DateUtc",
            isGreaterThan: DateTime.now()) //.add(const Duration(days:30))
        .limit(1)
        .snapshots();
  }

  static Stream<QuerySnapshot<Game>> currentGame(Tournament tournament) {
    return db
        .collection("Tournaments")
        .doc(tournament.getUID())
        .collection("Games")
        .withConverter(
            fromFirestore: Game.fromFirestore,
            toFirestore: (Game game, _) => game.toFirestore())
        .orderBy("DateUtc")
        .where("DateUtc",
            isLessThan: DateTime.now(),
            isGreaterThan: DateTime.now().subtract(const Duration(minutes: 90)))
        .snapshots();
  }

  static Future<bool> setBet(Tournament tournament, Game game,
      int homeTeamCount, int awayTeamCount) async {
    final docRef = db
        .collection("Tournaments")
        .doc(tournament.getUID())
        .collection("Bets");

    QuerySnapshot s = await docRef
        .where("gameUid", isEqualTo: game.GameUid)
        .where("userUid", isEqualTo: Authentication.getUser())
        .get();
    if (s.size != 0) {
      return false;
    }
    final Bet bet = Bet(
        awayTeamCount: awayTeamCount,
        homeTeamCount: homeTeamCount,
        gameUid: game.GameUid!,
        userUid: Authentication.getUser());
    await docRef
        .withConverter(
            fromFirestore: Bet.fromFirestore,
            toFirestore: (Bet bet, options) => bet.toFirestore())
        .doc()
        .set(bet);
    return true;
  }

  static Future<Community> createCommunity(
      String name, Tournament tournament) async {
    final docRef = db
        .collection("Tournaments")
        .doc(tournament.getUID())
        .collection("Communities")
        .withConverter(
            fromFirestore: Community.fromFirestore,
            toFirestore: (Community community, options) =>
                community.toFirestore())
        .doc();
    Community community = Community(name: name, communityUid: docRef.id);
    await docRef.set(community);
    return community;
  }

  static Future<bool> joinCommunity(
      String communityUid, Tournament tournament) async {
    final docRef = db.collection("User").doc(Authentication.getUser());
    DocumentSnapshot<User> temp = await docRef
        .withConverter(
            fromFirestore: User.fromFirestore,
            toFirestore: (User user, options) => user.toFirestore())
        .get();
    User user = temp.data()!;
    await docRef.update({
      "Communities:${tournament.getUID()}":
          FieldValue.arrayUnion([communityUid])
    });

    final leaderBoardRef = db
        .collection("Tournaments")
        .doc(tournament.getUID())
        .collection("Communities")
        .doc(communityUid)
        .collection("Leaderboard")
        .withConverter(
            fromFirestore: LeaderBoardEntry.fromFirestore,
            toFirestore: (LeaderBoardEntry leaderboardEntry, options) =>
                leaderboardEntry.toFirestore());

    await leaderBoardRef.doc().set(LeaderBoardEntry(
        rang: await getInitialRang(leaderBoardRef) + 1,
        score: 0,
        scoreTemp: 0,
        userId: Authentication.getUser(),
        isOnline: true,
        registrationDate: await Authentication.getRegistrationDate(),
        username: user.username));
    return true;
  }


  static Future<bool> canJoinCommunity(String tournamentId)async{
    DocumentSnapshot documentSnapshot = await db.collection("User").doc(Authentication.getUser()).get();
    List<dynamic> list = (documentSnapshot.data() as Map<String,dynamic>)["Communities:$tournamentId"];
    return !(list.length > 5);
  }

  static Future<int> getInitialRang(CollectionReference leaderBoardRef) async {
    AggregateQuerySnapshot aggregateQuerySnapshot =
        await leaderBoardRef.count().get();
    return aggregateQuerySnapshot.count ?? 1;
  }

  static Future<bool> leaveCommunity(
      String communityUid, Tournament tournament) async {
    final docRef = db.collection("User").doc(Authentication.getUser());
    await docRef.update({
      "Communities:${tournament.getUID()}":
          FieldValue.arrayRemove([communityUid])
    });
    return true;
  }

  static Future<bool> communityExists(
      String potentialCommunityUid, Tournament tournament) async {
    final docRef = db
        .collection("Tournaments")
        .doc(tournament.getUID())
        .collection("Communities")
        .withConverter(
            fromFirestore: Community.fromFirestore,
            toFirestore: (Community community, options) =>
                community.toFirestore())
        .doc(potentialCommunityUid);
    DocumentSnapshot documentSnapshot = await docRef.get();
    return documentSnapshot.exists;
  }

//////HANDELING THE LEADERBOARD
  ///
  ///Getting Realtime Feed///
  static Stream<QuerySnapshot<LeaderBoardEntry>> loadCommunityLeaderboard(
      Community community, Tournament tournament) {
    return db
        .collection("Tournaments")
        .doc(tournament.getUID())
        .collection("Communities")
        .doc(community.getUid())
        .collection("Leaderboard")
        .withConverter(
            fromFirestore: LeaderBoardEntry.fromFirestore,
            toFirestore: (LeaderBoardEntry leaderboardEntry, options) =>
                leaderboardEntry.toFirestore())
        .orderBy("rang")
        .limit(20)
        .snapshots();
  }

  ///show only top 3
  static Stream<QuerySnapshot<LeaderBoardEntry>> loadTop3(
      Community community, Tournament tournament) {
    return db
        .collection("Tournaments")
        .doc(tournament.getUID())
        .collection("Communities")
        .doc(community.getUid())
        .collection("Leaderboard")
        .withConverter(
            fromFirestore: LeaderBoardEntry.fromFirestore,
            toFirestore: (LeaderBoardEntry leaderboardEntry, options) =>
                leaderboardEntry.toFirestore())
        .orderBy("rang")
        .limit(3)
        .snapshots();
  }

//Show online
static Stream<QuerySnapshot<LeaderBoardEntry>> loadOnline(
      Community community, Tournament tournament) {
    return db
        .collection("Tournaments")
        .doc(tournament.getUID())
        .collection("Communities")
        .doc(community.getUid())
        .collection("Leaderboard")
        .where("isOnline", isEqualTo: true)
        .withConverter(
            fromFirestore: LeaderBoardEntry.fromFirestore,
            toFirestore: (LeaderBoardEntry leaderboardEntry, options) =>
                leaderboardEntry.toFirestore())
      
        .orderBy("rang")
        .limit(20)
        .snapshots();
  }

//show last
  static Stream<QuerySnapshot<LeaderBoardEntry>> loadLastplace(
      Community community, Tournament tournament) {
    return db
        .collection("Tournaments")
        .doc(tournament.getUID())
        .collection("Communities")
        .doc(community.getUid())
        .collection("Leaderboard")
        .withConverter(
            fromFirestore: LeaderBoardEntry.fromFirestore,
            toFirestore: (LeaderBoardEntry leaderboardEntry, options) =>
                leaderboardEntry.toFirestore())
        .orderBy("rang", descending: true)
        .limit(1)
        .snapshots();
  }

//search
  static Stream<QuerySnapshot<LeaderBoardEntry>> searchPlayer(
      Community community, Tournament tournament, String name) {
    return db
        .collection("Tournaments")
        .doc(tournament.getUID())
        .collection("Communities")
        .doc(community.getUid())
        .collection("Leaderboard")
        .withConverter(
            fromFirestore: LeaderBoardEntry.fromFirestore,
            toFirestore: (LeaderBoardEntry leaderboardEntry, options) =>
                leaderboardEntry.toFirestore())
        .where("username", isEqualTo: name)
        .limit(1)
        .snapshots();
  }

//show pinned only
  static Stream<QuerySnapshot<LeaderBoardEntry>> loadPinned(
      Community community, Tournament tournament) async* {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the pinned users list.
    List<String> pinnedUsers = prefs.getStringList('pinned') ?? [];

    // Return the Firestore query stream.
    yield* db
        .collection("Tournaments")
        .doc(tournament.getUID())
        .collection("Communities")
        .doc(community.getUid())
        .collection("Leaderboard")
        .withConverter(
            fromFirestore: LeaderBoardEntry.fromFirestore,
            toFirestore: (LeaderBoardEntry leaderboardEntry, options) =>
                leaderboardEntry.toFirestore())
        .where("userId", whereIn: pinnedUsers.isEmpty ? null : pinnedUsers)
        .snapshots();
  }

  //show current position
  static Stream<QuerySnapshot<LeaderBoardEntry>> loadmyCurrentPos(
      Community community, Tournament tournament) async* {
    final docRef = db
        .collection("Tournaments")
        .doc(tournament.getUID())
        .collection("Communities")
        .doc(community.getUid())
        .collection("Leaderboard")
        .withConverter(
            fromFirestore: LeaderBoardEntry.fromFirestore,
            toFirestore: (LeaderBoardEntry leaderboardEntry, options) =>
                leaderboardEntry.toFirestore())
        .where("userId", isEqualTo: Authentication.getUser());

    QuerySnapshot<LeaderBoardEntry> doc = await docRef.get();
    DocumentSnapshot<LeaderBoardEntry> snapshot = doc.docs.first;

    yield* db
        .collection("Tournaments")
        .doc(tournament.getUID())
        .collection("Communities")
        .doc(community.getUid())
        .collection("Leaderboard")
        .withConverter(
            fromFirestore: LeaderBoardEntry.fromFirestore,
            toFirestore: (LeaderBoardEntry leaderboardEntry, options) =>
                leaderboardEntry.toFirestore())
        .orderBy("rang")
        .startAtDocument(snapshot)
        .limit(3)
        .snapshots();
  }

  static Future<void> changeOnlineStatus(bool isOnline) {
    return db
        .collection("User")
        .doc(Authentication.getUser())
        .update({"isOnline": isOnline});
  }

  static Future<List<Preview>> getPreviewLeaderboard(
      String tournamentId) async {
    const String apiUrl =
        "https://getleaderboardpreview-csjycr6t2q-ey.a.run.app";

    //get All Communities of loged In user
    final doc = await db.collection("User").doc(Authentication.getUser()).get();
    Map<String, dynamic>? data = doc.data();


    var communities = data!["Communities:$tournamentId"];
    List<Preview> result = [];

    for (String communityId in communities) {
      //get community Name
      DocumentSnapshot communityReference = await db
          .collection("Tournaments")
          .doc(tournamentId)
          .collection("Communities")
          .doc(communityId)
          .withConverter(
              fromFirestore: Community.fromFirestore,
              toFirestore: (Community community, options) =>
                  community.toFirestore())
          .get();
        Community community = communityReference.data() as Community;
        community.setUid(communityReference.id);

      // Define the request body
      Map<String, dynamic> requestBody = {
        "communityId": communityId,
        "loggedInUserId": Authentication.getUser(),
        "tournamentId": tournamentId,
      };
      // Make the HTTP POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'text/plain',
        },
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the response body
        List<dynamic> data = jsonDecode(response.body);
        List<LeaderBoardEntry> leaderboardEntries = [];
        try {
          // Convert the response data to the desired format (List<Map<String, dynamic>>)

          data.forEach((entry) {
            leaderboardEntries.add(LeaderBoardEntry(
                rang: entry["rang"],
                score: entry["score"],
                scoreTemp: entry["scoreTemp"],
                userId: entry["userId"],
                isOnline: entry["isOnline"],
                username: entry["username"],
                registrationDate: Timestamp(entry["registrationDate"]["_seconds"],entry["registrationDate"]["_nanoseconds"])));
          });
        } catch (e) {
          print(e.toString());
        }

        result.add(Preview(
            leaderboard: leaderboardEntries,
            community: community));
      } else {
        // If the request was not successful, throw an exception or handle the error accordingly
        throw Exception('Failed to load leaderboard preview');
      }
    }

    return result;
  }
}
