import 'dart:async';
import 'package:intl/date_symbol_data_file.dart';
import 'package:betapp/Models/game.dart';
import 'package:betapp/Models/tournaments.dart';
import 'package:betapp/Services/database.dart';
import 'package:betapp/Services/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class UpcomingGame extends StatefulWidget {
  final Tournament tournament;

  const UpcomingGame({super.key, required this.tournament});

  @override
  State<UpcomingGame> createState() => _UpcomingGameState();
}

class _UpcomingGameState extends State<UpcomingGame> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> gameStream =
        Database.upcomingGame(widget.tournament);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color.fromARGB(255, 230, 230, 230),
      ),
      child: StreamBuilder<QuerySnapshot>(
          stream: gameStream,
          builder:
              ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(
                  radius: 20.0,
                ),
              );
            }
            DocumentSnapshot documentSnapshot = snapshot.data!.docs.first;
            Game game = documentSnapshot.data() as Game;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                       
                        children: [
                          FutureBuilder(
                              future: Storage.getFlagUrl(game.HomeTeamCode),
                              builder: (((context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Image.network(snapshot.data ?? "");
                                } else {
                                  return const CupertinoActivityIndicator();
                                }
                              }))),
                          Text(game.HomeTeam)
                        ],
                      ),
                      const Text(
                        "vs",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w100),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FutureBuilder(
                              future: Storage.getFlagUrl(game.AwayTeamCode),
                              builder: (((context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Image.network(snapshot.data ?? "");
                                } else {
                                  return const CupertinoActivityIndicator();
                                }
                              }))),
                          Text(game.AwayTeam),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text("Group: ${game.Group} ・ Location: ${game.Location} ・ Match nr.: ${game.MatchNumber} ・ Start: ${game.DateUtc.toDate().toLocal()}", style: const TextStyle(fontSize: 10),),
                const SizedBox(height: 10,),
                CupertinoButton.filled(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    onPressed: () {},
                    child: const Text("Bet now"))
              ],
            );
          })),
    );
  }
}
