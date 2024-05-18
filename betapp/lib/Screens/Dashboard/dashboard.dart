import 'package:betapp/Models/tournaments.dart';
import 'package:betapp/Screens/Dashboard/life.dart';
import 'package:betapp/Screens/Dashboard/upcoming.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final tournament =
        ModalRoute.of(context)!.settings.arguments as Tournament?;

    return CupertinoPageScaffold(
        child: CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle:
              Text(tournament == null ? "EM 2024" : tournament.getName()),
          stretch: true,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          border: const Border(
            bottom:
                BorderSide(color: Color.fromARGB(255, 206, 206, 206), width: 2),
          ),
          trailing: const Icon(CupertinoIcons.group_solid,
              color: CupertinoColors.systemBlue, size: 24),
        ),
        SliverList(
          delegate: SliverChildListDelegate.fixed(
              [ const Padding(padding: EdgeInsets.fromLTRB(20,10,20,10), child: Text("Upcoming game", style: TextStyle(fontWeight: FontWeight.w300),),),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: UpcomingGame(tournament: tournament ?? Tournament(),)),
                const Padding(padding: EdgeInsets.fromLTRB(20,20,20,10), child: Text("Currently life", style: TextStyle(fontWeight: FontWeight.w300),),),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0), child: LifeGame(),)
            ]),
        ),
        const SliverFillRemaining()
      ],
    ));
  }
}
