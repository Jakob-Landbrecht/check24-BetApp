import 'package:betapp/Services/authentication.dart';
import 'package:flutter/cupertino.dart';

class TournamentPage extends StatelessWidget {
  TournamentPage({super.key});
  final Authentication _authentication = Authentication();
  

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
         child: CupertinoButton.filled(
          child: const Text('Sign out'),
          onPressed: () => _authentication.signOut(),
          ),
      ),
    );
  }
}