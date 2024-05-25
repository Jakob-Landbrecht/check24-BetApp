import 'package:betapp/Models/community.dart';
import 'package:betapp/Models/leaderboardEntry.dart';
import 'package:betapp/Models/tournaments.dart';
import 'package:betapp/Services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final TextEditingController _controller = TextEditingController();
  int selection = 0;

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
              border: const Border(),
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
                        onSubmitted: (String value) {
                          setState(() {
                            selection = 5;
                          });
                        },
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
                                onTap: () {
                                  setState(() {
                                    selection = 1;
                                  });
                                },
                              ),
                              PullDownMenuItem(
                                title: "Online",
                                icon: CupertinoIcons.flame,
                                onTap: () {
                                  setState(() {
                                    selection = 2;
                                  });
                                },
                              ),
                              PullDownMenuItem(
                                title: "Last Place",
                                icon: CupertinoIcons.down_arrow,
                                onTap: () {
                                  setState(() {
                                    selection = 3;
                                  });
                                },
                              ),
                              PullDownMenuItem(
                                title: "Pinned",
                                icon: CupertinoIcons.pin,
                                onTap: () {
                                  setState(() {
                                    selection = 4;
                                  });
                                },
                              ),
                              PullDownMenuItem(
                                title: "My Position",
                                icon: CupertinoIcons.location,
                                onTap: () {
                                  setState(() {
                                    selection = 6;
                                  });
                                },
                              ),
                            ],
                            position: Rect.fromCenter(
                                center: const Offset(300, 100),
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
              selection: selection,
              searchInput: _controller.text.trim(),
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
  final int selection;
  final String? searchInput;

  const PaginatedListView(
      {super.key, required this.tournament, required this.community, required this.selection, required this.searchInput});

  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> leaderboardStream = Database.loadCommunityLeaderboard(widget.community, widget.tournament);

    switch(widget.selection){
      case 1: {leaderboardStream = Database.loadTop3(widget.community, widget.tournament); break;}
      case 2: {leaderboardStream = Database.loadCommunityLeaderboard(widget.community, widget.tournament); break;}
      case 3: {leaderboardStream = Database.loadLastplace(widget.community, widget.tournament); break;}
      case 4: {leaderboardStream = Database.loadPinned(widget.community, widget.tournament);}
      case 5: {
        if(widget.searchInput == ""){
          leaderboardStream = Database.loadCommunityLeaderboard(widget.community, widget.tournament);
        }else{
          leaderboardStream = Database.searchPlayer(widget.community, widget.tournament, widget.searchInput!);
        }
        break;}
      case 6: {leaderboardStream = Database.loadmyCurrentPos(widget.community, widget.tournament); break;}
      
    }
   

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
                    score: leaderBoardEntry.score + leaderBoardEntry.scoreTemp,
                    rang: leaderBoardEntry.rang,
                    userId: leaderBoardEntry.userId,
                    username: leaderBoardEntry.username,
                  );
                })
                .toList()
                .cast(),
          );
        }));
  }
}

class ListTile extends StatefulWidget {
  final int score;
  final int rang;
  final String userId;
  final String username;
  const ListTile(
      {super.key,
      required this.score,
      required this.rang,
      required this.userId,
      required this.username});

  @override
  State<ListTile> createState() => _ListTileState();
}

class _ListTileState extends State<ListTile> {
   bool pinned = false;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  // Load the state from SharedPreferences
  void _loadState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      List<String> temp = prefs.getStringList('pinned') ?? [];
      if(temp.contains(widget.userId)){
        pinned = true;
      }else{
        pinned = false;
      }
    });
  }

  // Save the state to SharedPreferences
  void _saveState(bool isPinned) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringList = prefs.getStringList('pinned') ?? [];
    if(isPinned){
        stringList.add(widget.userId);
    }else{
        stringList.remove(widget.userId);
    }
    await prefs.setStringList("pinned", stringList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Text("${widget.rang}.",
              style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 5, 0),
              child: Text(widget.username,
                  style:
                      CupertinoTheme.of(context).textTheme.navTitleTextStyle)),
          
          const Spacer(),
          Text("${widget.score}"),
          CupertinoButton(
              child: pinned ? const Icon(
                CupertinoIcons.pin_fill,
                color: CupertinoColors.darkBackgroundGray,
              ):  const Icon(
                CupertinoIcons.pin,
                color: CupertinoColors.darkBackgroundGray,
              ),
              onPressed: () {
                // Obtain shared preferences.
                setState(() {
                  pinned = !pinned;
                  _saveState(pinned);
                });
              })
        ],
      ),
    );
  }
}
