import 'package:betapp/Models/community.dart';
import 'package:betapp/Models/tournaments.dart';
import 'package:betapp/Services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class AddCommunity extends StatefulWidget {
  const AddCommunity({super.key});

  @override
  State<AddCommunity> createState() => _AddCommunityState();
}

class _AddCommunityState extends State<AddCommunity> {
  int _selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: <Widget>[
        const CupertinoSliverNavigationBar(
          largeTitle: Text("Add Community"),
          stretch: true,
          backgroundColor: CupertinoColors.white,
          automaticallyImplyLeading: true,
          border: Border(
            bottom:
                BorderSide(color: Color.fromARGB(255, 206, 206, 206), width: 2),
          ),
          trailing: Icon(CupertinoIcons.group_solid,
              color: CupertinoColors.systemBlue, size: 24),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CupertinoSlidingSegmentedControl<int>(
              groupValue: _selectedSegment,
              onValueChanged: (int? newValue) {
                setState(() {
                  _selectedSegment = newValue!;
                });
              },
              children: const <int, Widget>{
                0: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Create Community'),
                ),
                1: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Join Community'),
                ),
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: _selectedSegment == 0 ? const CreateCommunity() : const JoinCommunity(),
        ),
      ],
    ));
  }
}




class JoinCommunity extends StatefulWidget {
  const JoinCommunity({super.key});

  @override
  State<JoinCommunity> createState() => _JoinCommunityState();
}

class _JoinCommunityState extends State<JoinCommunity> {
  late TextEditingController _textController;
  Community community = Community(name: "");

@override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     final tournament =
        ModalRoute.of(context)!.settings.arguments as Tournament?;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CupertinoTextField(
            maxLength: 40,
            placeholder: "Enter the community Id",
            controller: _textController,
          ),
          const SizedBox(
            height: 20,
          ),
          CupertinoButton.filled(
              child: const Text("Join Community"),
              onPressed: () async {
                if (_textController.text.trim().isEmpty) {
                  _showAlertDialog(
                      context, 'Please enter a community ID');
                  return;
                }
                bool communityExists = await  Database.communityExists(_textController.text.trim(), tournament!);
                if(!communityExists){
                   _showAlertDialog(
                      context, 'The Id did not match any community');
                  return;
                }
                await Database.joinCommunity(_textController.text.trim(),tournament);
                Navigator.pop(context);
                
              }),
        ],
      ),
    );
  }

   void _showAlertDialog(BuildContext context, String message) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Something went wrong'),
        content: Text(message),
      ),
    );
  }
}







class CreateCommunity extends StatefulWidget {
  const CreateCommunity({super.key});

  @override
  State<CreateCommunity> createState() => _CreateCommunityState();
}

class _CreateCommunityState extends State<CreateCommunity> {
  late TextEditingController _textController;
  Community community = Community(name: "");

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tournament =
        ModalRoute.of(context)!.settings.arguments as Tournament?;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CupertinoTextField(
            maxLength: 40,
            placeholder: "Name of your Community",
            controller: _textController,
          ),
          const SizedBox(
            height: 20,
          ),
          CupertinoButton.filled(
              child: const Text("Create Community"),
              onPressed: () async {
                if (_textController.text.trim().isEmpty) {
                  _showAlertDialog(
                      context, 'Please enter a name for your Community');
                  return;
                }

                Community temp = await Database.createCommunity(
                    _textController.text, tournament!);
                await Database.joinCommunity(temp.communityUid!,tournament);
                setState(() {
                  community = temp;
                });
              }),
          const SizedBox(
            height: 20,
          ),
          if (community.name != "") ShareDialog(community: community),
        ],
      ),
    );
  }

  void _showAlertDialog(BuildContext context, String message) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Something went wrong'),
        content: Text(message),
      ),
    );
  }
}

class ShareDialog extends StatelessWidget {
  final Community community;
  const ShareDialog({super.key, required this.community});

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
    Text(
      "Invite your friends to your Community",
      style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
    ),
    const SizedBox(height: 20,),
    SelectableText("Share this code with your friends: ${community.communityUid}"),
    CupertinoButton(
        child: const Row(
          children: [
            Icon(CupertinoIcons.share),
            SizedBox(width: 10),
            Text("Share")],
        ),
        onPressed: () {
          Share.share(community.communityUid.toString());
        })
          ],
        );
  }
}
