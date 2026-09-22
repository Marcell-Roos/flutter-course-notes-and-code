import 'package:flutter/material.dart';
import 'package:flutter_template/dice_roller.dart';

// import 'package:flutter_template/styled_text.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    super.key,
    required this.colours,
  });

  GradientContainer.blackWhitePreset({super.key})
    : colours = [Colors.black, Colors.white];

  final List<Color> colours;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colours,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(child: DiceRoller()),
    );
  }
}
