import 'package:betapp/Models/tournaments.dart';
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

    final tournament = ModalRoute.of(context)!.settings.arguments as Tournament?;
 

    return CupertinoPageScaffold(
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text(tournament == null ? "EM 2024": tournament.getName()),
            stretch: true,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            border: const Border(bottom: BorderSide(color: Color.fromARGB(255, 206, 206, 206), width: 2),),
            trailing: const Icon(CupertinoIcons.group_solid,color: CupertinoColors.systemBlue,size: 24),
          ),
          const SliverFillRemaining()
        ],
      )
    );
  }
}
