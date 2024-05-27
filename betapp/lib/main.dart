// ignore_for_file: avoid_print

import 'package:betapp/Screens/CommunityDahboard/communityPage.dart';
import 'package:betapp/Screens/CommunityPage/addCommunity.dart';
import 'package:betapp/Screens/Dashboard/dashboard.dart';
import 'package:betapp/Screens/TournamentPage/tournament_page.dart';
import 'package:betapp/Screens/Wrapper.dart';
import 'package:betapp/Services/authentication.dart';
import 'package:betapp/Services/database.dart';
import 'package:betapp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    //Authentication.signOut();
    WidgetsBinding.instance.addObserver(this);

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    super.didChangeAppLifecycleState(state);

    if(state == AppLifecycleState.inactive || state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;
    Database.changeOnlineStatus(!isBackground);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: Authentication().user,
      initialData: null,
      child: CupertinoApp(
        theme: const CupertinoThemeData(brightness: Brightness.light),
        routes: {
          "/tournaments": (context)  => const TournamentPage(),
          "/dashboard": (context) => const Dashboard(),
          "/addCommunity": (context) => const AddCommunity(),
          "/communityPage": (context) => const CommunityPage(),

        },
        title: 'Betting App',
        home: const Wrapper(),
      ),
    );
  }
}
