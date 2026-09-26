import 'package:flutter/material.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  // We don't use var since it is too restrictive in this case
  // "?" means value can be NULL
  // Widget? activeScreen;

  // Does extra initialization work
  // Only executes once before build method
  // @override
  // void initState() {
  //   activeScreen = StartScreen(switchScreen);

  //   super.initState();
  // }

  // Alternative
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      // setState re-executes the build method, re-rendering the UI if there
      // are changes
      // activeScreen = const QuestionsScreen();

      // Alternative
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentGeometry.topLeft,
              end: AlignmentGeometry.bottomRight,
              colors: [
                const Color.fromARGB(255, 169, 79, 233),
                const Color.fromARGB(255, 61, 33, 110),
              ],
            ),
          ),
          // We pass the function down, "lifting the state up"
          child: activeScreen == 'start-screen'
              ? StartScreen(switchScreen)
              : const QuestionsScreen(),
        ),
      ),
    );
  }
}
