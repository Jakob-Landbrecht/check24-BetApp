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
  final ScrollController _scrollController = ScrollController();
  int selection = 0;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final Tournament tournament = arguments["tournament"];
    final Community community = arguments["community"];
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      child: CustomScrollView(
        controller: _scrollController,
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
                            title: "All",
                            icon: CupertinoIcons.wifi,
                            onTap: () {
                              setState(() {
                                selection = 8;
                              });
                            },
                          ),
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
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: PaginatedListView(
              scrollController: _scrollController,
              tournament: tournament,
              community: community,
              selection: selection,
              searchInput: _controller.text.trim(),
            ),
          ),
        ],
      ),
    );
  }
}

class PaginatedListView extends StatefulWidget {
  final ScrollController scrollController;
  final Tournament tournament;
  final Community community;
  final int selection;
  final String? searchInput;

  const PaginatedListView({
    super.key,
    required this.scrollController,
    required this.tournament,
    required this.community,
    required this.selection,
    required this.searchInput,
  });

  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  int numberOfRequestedEntries = 10;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> leaderboardStream = Database.loadCommunityLeaderboard(
        widget.community, widget.tournament, numberOfRequestedEntries);
    switch (widget.selection) {
      case 1:
        leaderboardStream =
            Database.loadTop3(widget.community, widget.tournament);
        break;
      case 2:
        numberOfRequestedEntries = 10;
        leaderboardStream = Database.loadOnline(
            widget.community, widget.tournament, numberOfRequestedEntries);
        break;
      case 3:
        leaderboardStream =
            Database.loadLastplace(widget.community, widget.tournament);
        break;
      case 4:
        numberOfRequestedEntries = 10;
        leaderboardStream = Database.loadPinned(
            widget.community, widget.tournament, numberOfRequestedEntries);
        break;
      case 5:
        if (widget.searchInput == "") {
          leaderboardStream = Database.loadCommunityLeaderboard(
              widget.community, widget.tournament, numberOfRequestedEntries);
        } else {
          leaderboardStream = Database.searchPlayer(
              widget.community, widget.tournament, widget.searchInput!);
        }
        break;
      case 6:
        leaderboardStream = Database.loadmyCurrentPos(
            widget.community, widget.tournament, 2, 1);
        break;
      case 8:
        numberOfRequestedEntries = 10;
        leaderboardStream = Database.loadCommunityLeaderboard(
            widget.community, widget.tournament, numberOfRequestedEntries);
        break;
    }

    return StreamBuilder<QuerySnapshot>(
      stream: leaderboardStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(
              radius: 20.0,
            ),
          );
        }
        if (snapshot.data == null) {
          return const Center(
            child: Text("No Entry"),
          );
        } else {
          return Column(
            children: [
              CupertinoButton(
                onPressed: (snapshot.data!.docs.length < 10 ||
                        (snapshot.data!.docs.first.data() as LeaderBoardEntry)
                                .rang ==
                            1)
                    ? null
                    : () {},
                child: const Icon(
                  CupertinoIcons.up_arrow,
                  size: 20,
                ),
              ),
              ListView.builder(
                controller: widget.scrollController,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  LeaderBoardEntry leaderBoardEntry =
                      snapshot.data!.docs[index].data() as LeaderBoardEntry;
                  return ListTile(
                    score: leaderBoardEntry.score + leaderBoardEntry.scoreTemp,
                    rang: leaderBoardEntry.rang,
                    userId: leaderBoardEntry.userId,
                    username: leaderBoardEntry.username,
                  );
                },
              ),
              CupertinoButton(
                onPressed: (snapshot.data!.docs.length < 10)
                    ? null
                    : () {
                        setState(() {
                          
                          numberOfRequestedEntries += 10;
                        });
                      },
                child: const Icon(
                  CupertinoIcons.down_arrow,
                  size: 20,
                ),
              ),
            ],
          );
        }
      },
    );
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
      if (temp.contains(widget.userId)) {
        pinned = true;
      } else {
        pinned = false;
      }
    });
  }

  // Save the state to SharedPreferences
  void _saveState(bool isPinned) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringList = prefs.getStringList('pinned') ?? [];
    if (isPinned) {
      stringList.add(widget.userId);
    } else {
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
              child: pinned
                  ? const Icon(
                      CupertinoIcons.pin_fill,
                      color: CupertinoColors.darkBackgroundGray,
                    )
                  : const Icon(
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
