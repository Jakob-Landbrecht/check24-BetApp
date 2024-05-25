import 'package:betapp/Models/community.dart';
import 'package:betapp/Models/tournaments.dart';
import 'package:betapp/Screens/Dashboard/life.dart';
import 'package:betapp/Screens/Dashboard/upcoming.dart';
import 'package:betapp/Services/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          trailing: CupertinoButton(
            onPressed: (){
              Navigator.pushNamed(context, "/addCommunity", arguments:tournament );},
            child: const Icon(CupertinoIcons.group_solid,
                color: CupertinoColors.systemBlue, size: 24),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate.fixed(
              [ const Padding(padding: EdgeInsets.fromLTRB(20,10,20,10), child: Text("Upcoming game", style: TextStyle(fontWeight: FontWeight.w300),),),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: UpcomingGame(tournament: tournament ?? Tournament(),)),
                const Padding(padding: EdgeInsets.fromLTRB(20,20,20,10), child: Text("Currently life", style: TextStyle(fontWeight: FontWeight.w300),),),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0), child: LifeGame(tournament: tournament ?? Tournament(),),),
                const Padding(padding: EdgeInsets.fromLTRB(20,20,20,10), child: Text("Community previews", style: TextStyle(fontWeight: FontWeight.w300),),),

            ]),
        ),
        SliverToBoxAdapter(child: CupertinoButton(child: const Text("CommunityTest"), onPressed: (){Navigator.pushNamed(context, "/communityPage", arguments: {"tournament": tournament,"community": Community(name: "Test-5",communityUid: "G0G829AxzCwFmWftGEhw")});})),
        const SliverFillRemaining(),
        SliverToBoxAdapter(child: CupertinoButton(child: const Text("Sign out"), onPressed: () => Authentication.signOut(),))
      ],
    ));
  }
}
