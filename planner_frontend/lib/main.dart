import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:planner_frontend/firebase_options.dart';
import 'package:provider/provider.dart';
import 'services/firestore.dart';
import 'services/models.dart';
import 'about.dart';
import 'event/add_event_page.dart';
import 'event/schedule_page.dart';
import 'game/quiz_page.dart';
import 'game/topics/topics.dart';
import 'game/world_map.dart';
import 'home_page.dart';
import 'leaderboard.dart';
import 'login.dart';
import 'login_page.dart';
import 'note/notes_page.dart';
import 'profile.dart';
import 'signup_page.dart';
import 'task/task_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //name: 'TaskTrove',
    // options: const FirebaseOptions(
    //   apiKey: 'AIzaSyCuI-FZ5S0FRjCZJ6oPSDj3CQfqxcsTHtA',
    //   appId: '1:352835275222:web:f3f2186d305da1c33bfc77',
    //   messagingSenderId: '352835275222',
    //   projectId: 'task-manager-b0625',
    //   authDomain: 'task-manager-b0625.firebaseapp.com',
    //   databaseURL:
    //       'https://task-manager-b0625-default-rtdb.europe-west1.firebasedatabase.app',
    //   storageBucket: 'task-manager-b0625.appspot.com',
    //   measurementId: 'G-EH7ER531SW',
    // ),
    options: kIsWeb
        ? DefaultFirebaseOptions.web
        : DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (_) => FirestoreService().streamReport(),
      catchError: (_, err) => Report(),
      initialData: Report(),
      child: MaterialApp(
        title: 'Task Trove',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/login': (_) => const LoginPage(),
          '/signup': (_) => const SignUpPage(),
          '/home': (_) => const AuthGuard(protectedPage: HomePage()),
          '/add_event': (_) => const AuthGuard(protectedPage: AddEventPage()),
          '/schedule': (_) => const SchedulePage(),
          '/notes': (_) => const NotesPage(),
          '/tasks': (_) => const TasksPage(),
          '/world_map': (_) => const WorldMapPage(),
          '/quiz': (_) => const QuizPage(),
          '/profile': (_) => const ProfileScreen(),
          '/topics': (_) => const TopicsScreen(countryId: "all"),
          '/about': (_) => const AboutScreen(),
          '/login_screen': (_) => const LoginScreen(),
          '/leaderboard': (_) => const LeaderboardScreen(),
        },
        initialRoute: '/login',
        home: const LoginPage(),
      ),
    );
  }
}

class AuthGuard extends StatelessWidget {
  final Widget protectedPage;
  const AuthGuard({Key? key, required this.protectedPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return protectedPage;
    } else {
      return const LoginPage();
    }
  }
}
