import 'package:betapp/Models/community.dart';
import 'package:betapp/Models/leaderboardEntry.dart';
import 'package:betapp/Models/tournaments.dart';
import 'package:betapp/Services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_down_button/pull_down_button.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final Tournament tournament = arguments["tournament"];
    final Community community = arguments["community"];

    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              backgroundColor: CupertinoColors.extraLightBackgroundGray,
              largeTitle: Text(community.name),
              stretch: true,
              border: Border(),
              automaticallyImplyLeading: true,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoSearchTextField(
                        placeholder: "Search for Username",
                        controller: _controller,
                        onSubmitted: (String value) {},
                      ),
                    ),
                    CupertinoButton(
                        child: const Icon(
                            CupertinoIcons.line_horizontal_3_decrease_circle),
                        onPressed: () async {
                          await showPullDownMenu(
                            context: context,
                            items: [
                              PullDownMenuItem(
                                title: "Top 3",
                                icon: CupertinoIcons.rosette,
                                onTap: () {},
                              ),
                              PullDownMenuItem(
                                title: "Online",
                                icon: CupertinoIcons.flame,
                                onTap: () {},
                              ),
                              PullDownMenuItem(
                                title: "Last Place",
                                icon: CupertinoIcons.down_arrow,
                                onTap: () {},
                              ),
                              PullDownMenuItem(
                                title: "Pinned",
                                icon: CupertinoIcons.pin,
                                onTap: () {},
                              ),
                              PullDownMenuItem(
                                title: "My Position",
                                icon: CupertinoIcons.location,
                                onTap: () {},
                              ),
                            ],
                            position: Rect.fromCenter(
                                center: Offset(300, 100),
                                width: 200,
                                height: 200),
                          );
                        }),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: CupertinoButton(
                  child: const Icon(
                    CupertinoIcons.up_arrow,
                    size: 20,
                  ),
                  onPressed: () {}),
            ),
            SliverToBoxAdapter(
                child: PaginatedListView(
              tournament: tournament,
              community: community,
            )),
            SliverToBoxAdapter(
              child: CupertinoButton(
                  child: const Icon(
                    CupertinoIcons.down_arrow,
                    size: 20,
                  ),
                  onPressed: () {}),
            )
          ],
        ));
  }
}

class PaginatedListView extends StatefulWidget {
  final Tournament tournament;
  final Community community;

  const PaginatedListView(
      {super.key, required this.tournament, required this.community});

  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> leaderboardStream =
        Database.loadCommunityLeaderboard(widget.community, widget.tournament);

    return StreamBuilder<QuerySnapshot>(
        stream: leaderboardStream,
        builder:
            ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(
                radius: 20.0,
              ),
            );
          }
          return ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  LeaderBoardEntry leaderBoardEntry =
                      document.data()! as LeaderBoardEntry;
                  return ListTile(
                    score: leaderBoardEntry.score,
                    rang: leaderBoardEntry.rang,
                    username: leaderBoardEntry.username,
                  );
                })
                .toList()
                .cast(),
          );
        }));
  }
}

class ListTile extends StatelessWidget {
  final int score;
  final int rang;
  final String username;
  const ListTile(
      {super.key,
      required this.score,
      required this.rang,
      required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Text("$rang.",
              style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 5, 0),
              child: Text(username,
                  style:
                      CupertinoTheme.of(context).textTheme.navTitleTextStyle)),
          
          const Spacer(),
          Text("$score"),
          CupertinoButton(
              child: const Icon(
                CupertinoIcons.pin,
                color: CupertinoColors.darkBackgroundGray,
              ),
              onPressed: () {})
        ],
      ),
    );
  }
}
