import 'package:betapp/Models/tournaments.dart';
import 'package:betapp/Screens/Dashboard/dashboard.dart';
import 'package:betapp/Services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TournamentPage extends StatefulWidget {
  const TournamentPage({super.key});

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {
  final Database dataBase = Database();
  Future<List<Tournament>> tournamentsFuture = Database.getTournaments();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            const CupertinoSliverNavigationBar(
              largeTitle: Text("Select Tournament"),
              stretch: true,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: true,
              border: Border(
                bottom: BorderSide(
                    color: Color.fromARGB(255, 206, 206, 206), width: 2),
              ),
            ),
            SliverToBoxAdapter(
              child: FutureBuilder(
                  future: tournamentsFuture,
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return TournamentList(snapshot.data ?? List.empty());
                    } else {
                      return const Center(
                        child: CupertinoActivityIndicator(
                          radius: 20.0,
                        ),
                      );
                    }
                  })),
            ),
            const SliverFillRemaining()
          ],
        ));
  }
}

class TournamentList extends StatelessWidget {
  const TournamentList(this.tournaments, {super.key});

  final List<Tournament> tournaments;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: tournaments.length,
      itemBuilder: ((context, index) {
        return CupertinoListTile.notched(
          title: Text(tournaments.elementAt(index).getName()),
          leadingSize: 60,
          padding: const EdgeInsets.all(20),
          leading: Image.network(tournaments.elementAt(index).getImage()),
          onTap: () {
            Navigator.pushNamed(context, "/dashboard",
                arguments: tournaments.elementAt(index));
          },
        );
      }),
    );
  }
}
