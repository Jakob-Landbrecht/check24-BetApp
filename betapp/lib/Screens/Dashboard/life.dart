import 'package:betapp/Models/game.dart';
import 'package:betapp/Models/tournaments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../Services/database.dart';

class LifeGame extends StatefulWidget {
  final Tournament tournament;
  const LifeGame({super.key, required this.tournament});

  @override
  State<LifeGame> createState() => _LifeGameState();
}

class _LifeGameState extends State<LifeGame> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> gameStream =
        Database.currentGame(widget.tournament);

    return StreamBuilder<QuerySnapshot>(
        stream: gameStream,
        builder:
            ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CupertinoActivityIndicator(
              radius: 20.0,
            ));
          }
          if (snapshot.data?.size == 0) {
            return Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color.fromARGB(255, 230, 230, 230),
                ),
                child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Currently there is no game being played")));
          }
          DocumentSnapshot documentSnapshot = snapshot.data!.docs.first;
          Game game = documentSnapshot.data() as Game;
          game.GameUid = documentSnapshot.id;
          return Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color.fromARGB(255, 179, 234, 154),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${game.HomeTeam} vs. ${game.AwayTeam}"),
                    Text(
                      "${game.HomeTeamScore}:${game.AwayTeamScore}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ));
        }));
  }
}
