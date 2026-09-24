// This is not the template app anymore,
// it is heavy modified for a follow along

import 'package:flutter/material.dart';
import 'package:flutter_template/gradient_container.dart';

void main() {
  runApp(const MyApp());
}

// Claude changed from the course here for actual hot reloading
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          colours: [Colors.deepOrange, Colors.deepPurple],
        ),
      ),
    );
  }
}
