import 'package:betapp/Screens/LoginPage/login_page.dart';
import 'package:betapp/Screens/TournamentPage/tournament_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {


    final user = Provider.of<User?>(context);

    return user != null ? const TournamentPage() : LoginPage();
  }
}