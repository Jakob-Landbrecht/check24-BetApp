import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
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
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            const CupertinoSliverNavigationBar(
              backgroundColor: CupertinoColors.extraLightBackgroundGray,
              largeTitle: Text("Community Name"),
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
            const SliverToBoxAdapter(child: PaginatedListView()),
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
  const PaginatedListView({super.key});

  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        const ListTile(),
        const ListTile(),
        const ListTile(),
        const ListTile(),
        const ListTile(),
        const ListTile(),
        const ListTile(),
        const ListTile(),
        const ListTile(),
        const ListTile(),
      ],
    );
  }
}

class ListTile extends StatelessWidget {
  const ListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Text("1.",
              style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 5, 0),
              child: Text("JayJay3006",
                  style:
                      CupertinoTheme.of(context).textTheme.navTitleTextStyle)),
          Container(
            width: 10.0,
            height: 10.0, // Height of the circle
            decoration: const BoxDecoration(
              color: CupertinoColors.activeGreen, // Circle color
              shape: BoxShape.circle, // Shape of the container
            ),
          ),
          const Spacer(),
          const Text("12"),
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
