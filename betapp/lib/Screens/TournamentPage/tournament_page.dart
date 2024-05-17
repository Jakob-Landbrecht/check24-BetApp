import 'package:betapp/Models/tournaments.dart';
import 'package:betapp/Services/database.dart';
import 'package:flutter/cupertino.dart';

class TournamentPage extends StatefulWidget {
  const TournamentPage({super.key});

  @override
  State<TournamentPage> createState() => _TournamentPageState();

}

class _TournamentPageState extends State<TournamentPage> {

  final Database dataBase = Database();
  Future<List<Tournament>> tournamentsFuture = Database.getTournaments();

  

  @override
  void initState(){
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Select Tournament"),
        ),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: tournamentsFuture,
                builder: ((context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    return TournamentList(snapshot.data ?? List.empty());
                  }else{
                    return const Center(
                      child: CupertinoActivityIndicator(
                        radius: 20.0,
                      ),
                    );
                  }
                })
              )
              ),
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
      itemCount: tournaments.length,
      itemBuilder: ((context, index) {
      return CupertinoListTile.notched(
        title: Text(tournaments.elementAt(index).getName()),
        leadingSize: 60,
        padding: const EdgeInsets.all(20),
        leading: Image.network(tournaments.elementAt(index).getImage()),);
    }),
    );
  }
}

