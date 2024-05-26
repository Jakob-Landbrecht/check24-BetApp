import 'package:betapp/Models/leaderboardEntry.dart';
import 'package:betapp/Models/preview.dart';
import 'package:betapp/Models/tournaments.dart';
import 'package:flutter/cupertino.dart';

class CommunityPreviews extends StatefulWidget {
  final Preview preview;
  final Tournament tournament;

  const CommunityPreviews(
      {super.key, required this.preview, required this.tournament});

  @override
  State<CommunityPreviews> createState() => _CommunityPreviewsState();
}

class _CommunityPreviewsState extends State<CommunityPreviews> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color.fromARGB(255, 230, 230, 230),
            boxShadow: CupertinoContextMenu.kEndBoxShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 47, 121, 200),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  boxShadow: CupertinoContextMenu.kEndBoxShadow,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.preview.community.name,
                        style: const TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
              ListView(
                shrinkWrap: true,
                children: widget.preview.leaderboard.map((leaderboardEntry) {
                  return _ListTile(leaderBoardEntry: leaderboardEntry,);
                }
              ).toList(),
              )
            ],
          ),
        ),
        CupertinoButton(
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Show leaderbard"),
                Icon(CupertinoIcons.right_chevron)
              ],
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/communityPage", arguments: {
                    "tournament": widget.tournament,
                    "community": widget.preview.community,
                  });
            })
      ],
    );
  }
}

// ignore: must_be_immutable
class _ListTile extends StatelessWidget {
  LeaderBoardEntry leaderBoardEntry;
  _ListTile({required this.leaderBoardEntry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: Color.fromARGB(255, 202, 202, 202), width: 1.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${leaderBoardEntry.rang}."),
          const SizedBox(
            width: 30,
          ),
          Text(leaderBoardEntry.username),
          const Spacer(),
          Text("${leaderBoardEntry.score+leaderBoardEntry.scoreTemp}")
        ],
      ),
    );
  }
}
