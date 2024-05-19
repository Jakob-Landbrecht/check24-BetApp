import 'package:betapp/Models/game.dart';
import 'package:betapp/Models/tournaments.dart';
import 'package:betapp/Services/database.dart';
import 'package:flutter/cupertino.dart';


class BetPopUp extends StatefulWidget {
  final Tournament tournament;
  final Game game;
  const BetPopUp({super.key,required this.tournament, required this.game});

  @override
  State<BetPopUp> createState() => _BetPopUpState();
}

class _BetPopUpState extends State<BetPopUp> {
  int _counterHome = 0;
  int _counterAway = 0;

  void _incremeantCounterHome() {
    setState(() {
      _counterHome++;
    });
  }

  void _decremeantCounterHome() {
    setState(() {
      _counterHome--;
    });
  }

  void _incremeantCounterAway() {
    setState(() {
      _counterAway++;
    });
  }

  void _decremeantCounterAway() {
    setState(() {
      _counterAway--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
      child: Container(
        color: CupertinoColors.white,
        alignment: Alignment.center,
        height: 450,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Bet on upcoming Game",
              style:
                  CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                          child: const Icon(size: 40, CupertinoIcons.plus),
                          onPressed: () {
                            _incremeantCounterHome();
                          }),
                      Text(
                        "$_counterHome",
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .navLargeTitleTextStyle,
                      ),
                      CupertinoButton(
                          onPressed:
                              _counterHome == 0 ? null : _decremeantCounterHome,
                          child: const Icon(size: 40, CupertinoIcons.minus)),
                    ],
                  ),
                ),
                Text(
                  ":",
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .navLargeTitleTextStyle,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                          child: const Icon(size: 40, CupertinoIcons.plus),
                          onPressed: () {
                            _incremeantCounterAway();
                          }),
                      Text(
                        "$_counterAway",
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .navLargeTitleTextStyle,
                      ),
                      CupertinoButton(
                          onPressed:
                              _counterAway == 0 ? null : _decremeantCounterAway,
                          child: const Icon(size: 40, CupertinoIcons.minus)),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            CupertinoButton.filled(
                borderRadius: BorderRadius.circular(50),
                onPressed: ()async{
                  bool success = await Database.setBet(widget.tournament,widget.game,_counterHome,_counterAway);
                  if(!success) {
                    _showAlertDialog(context, "You already placed a bet on this game");
                    return;
                }
                Navigator.pop(context);
                },
                child: const Text("Place Bet")),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

   void _showAlertDialog(BuildContext context, String message) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Error'),
        content: Text(message),
      ),
    );
}
}
