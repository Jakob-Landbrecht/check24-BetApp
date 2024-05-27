import 'package:betapp/Models/preview.dart';
import 'package:betapp/Models/tournaments.dart';
import 'package:betapp/Screens/Dashboard/communityPreviews.dart';
import 'package:betapp/Screens/Dashboard/life.dart';
import 'package:betapp/Screens/Dashboard/upcoming.dart';
import 'package:betapp/Services/authentication.dart';
import 'package:betapp/Services/database.dart';
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

    Future<List<Preview>> previewFuture =
        Database.getPreviewLeaderboard(tournament!.getUID());

    return CupertinoPageScaffold(
        child: CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle:
              Text(tournament.getName()),
          stretch: true,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          border: const Border(
            bottom:
                BorderSide(color: Color.fromARGB(255, 206, 206, 206), width: 2),
          ),
          trailing: CupertinoButton(
            onPressed: () {
              Navigator.pushNamed(context, "/addCommunity",
                  arguments: tournament);
            },
            child: const Icon(CupertinoIcons.group_solid,
                color: CupertinoColors.systemBlue, size: 24),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate.fixed([
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                "Upcoming game",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: UpcomingGame(
                  tournament: tournament,
                )),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(
                "Currently life",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: LifeGame(
                tournament: tournament,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(
                "Community previews",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
              child: FutureBuilder(
                  future: previewFuture,
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: snapshot.data!.map((preview) {
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: CommunityPreviews(
                                  preview: preview,
                                  tournament: tournament,
                                ));
                          }).toList());
                    } else {
                      return const Center(
                        child: CupertinoActivityIndicator(
                          radius: 20.0,
                        ),
                      );
                    }
                  })),
            )
          ]),
        ),

        SliverToBoxAdapter(
            child: CupertinoButton(
          child: const Text("Sign out"),
          onPressed: () => Authentication.signOut(),
        ))
      ],
    ));
  }
}
