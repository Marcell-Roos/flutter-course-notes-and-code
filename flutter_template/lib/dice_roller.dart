import 'dart:math';

import 'package:flutter/material.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});
  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

// the "_" prefix makes the class private
class _DiceRollerState extends State<DiceRoller> {
  int currentDiceRoll = 1;
  var activeDiceImage =
      'assets/images/dice-images/dice-1.png';

  void rollDice() {
    setState(() {
      currentDiceRoll = randomizer.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // Centre Vertically
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/dice-images/dice-$currentDiceRoll.png',
          width: 200,
        ),
        const SizedBox(
          height: 200,
        ), // Alternative to Padding
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            // padding: const EdgeInsets.only(top: 200.0), this makes the button look weird
            foregroundColor: Colors.black,
            textStyle: const TextStyle(fontSize: 28),
          ),
          child: Text("Roll Dice"),
        ),
      ],
    );
  }
}
