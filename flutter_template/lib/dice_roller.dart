import 'package:flutter/material.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});
  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

// the "_" prefix makes the class private
class _DiceRollerState extends State<DiceRoller> {
  var activeDiceImage =
      'assets/images/dice-images/dice-1.png';

  void rollDice() {
    setState(() {
      activeDiceImage =
          'assets/images/dice-images/dice-4.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // Centre Vertically
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(activeDiceImage, width: 200),
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
