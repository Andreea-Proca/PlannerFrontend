import 'package:flutter/material.dart';
import 'package:planner_frontend/home_page.dart';
import 'package:planner_frontend/login.dart';
import 'package:planner_frontend/login_page.dart';
import 'package:planner_frontend/services/auth.dart';
import 'package:planner_frontend/shared/shared.dart';
import 'package:planner_frontend/game/topics/topics.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const Center(
            child: ErrorMessage(),
          );
        } else if (snapshot.hasData) {
          return const TopicsScreen(countryId: "all");
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
