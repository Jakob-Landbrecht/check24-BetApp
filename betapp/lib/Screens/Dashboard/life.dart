import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LifeGame extends StatefulWidget {
  const LifeGame({super.key});

  @override
  State<LifeGame> createState() => _LifeGameState();
}

class _LifeGameState extends State<LifeGame> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color.fromARGB(255, 179, 234, 154),
      ),
      child:const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Germany vs. France"),
            Text("1:2", style: TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
      )
    );
  }
}