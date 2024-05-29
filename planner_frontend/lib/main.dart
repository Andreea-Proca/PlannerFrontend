import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:planner_frontend/services/firestore.dart';
import 'package:planner_frontend/game/topics/topics.dart';
import 'dart:convert';
import 'event/add_event_page.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'home_page.dart';
import 'event/schedule_page.dart';
import 'note/notes_page.dart';
import 'game/world_map.dart';
import 'game/quiz_page.dart';
import 'profile.dart';
import 'about.dart';
import 'login.dart';
import 'task/task_page.dart';
import 'package:provider/provider.dart';
import 'services/models.dart';
// import 'package:planner_frontend/quiz/quiz_page.dart';

// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
    options: const FirebaseOptions(
      // apiKey: 'AIzaSyCcDOdhthXmDRIjPThC2BFt5zziK21cCSM',
      // appId: '1:352835275222:ios:2a4e484349bc28d83bfc77',
      // messagingSenderId: '352835275222',
      // projectId: 'task-manager-b0625',
      // databaseURL:
      //     'https://task-manager-b0625-default-rtdb.europe-west1.firebasedatabase.app/',
      apiKey: 'AIzaSyCuI-FZ5S0FRjCZJ6oPSDj3CQfqxcsTHtA',
      appId: '1:352835275222:web:f3f2186d305da1c33bfc77',
      messagingSenderId: '352835275222',
      projectId: 'task-manager-b0625',
      authDomain: 'task-manager-b0625.firebaseapp.com',
      databaseURL:
          'https://task-manager-b0625-default-rtdb.europe-west1.firebasedatabase.app',
      storageBucket: 'task-manager-b0625.appspot.com',
      measurementId: 'G-EH7ER531SW',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
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

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //       title: 'Task Trove',
  //       theme: ThemeData(
  //         primarySwatch: Colors.blue,
  //       ),
  //       routes: {
  //         '/login': (_) => const LoginPage(),
  //         '/signup': (_) => const SignUpPage(),
  //         '/home': (_) => const AuthGuard(protectedPage: HomePage()),
  //         // '/dashboard': (_) => const Dashboard(),
  //         '/add_event': (_) => const AuthGuard(protectedPage: AddEventPage()),
  //         '/schedule': (_) => const SchedulePage(),
  //         '/lists': (_) => const ListsPage(),
  //         '/tasks': (_) => const TasksPage(),
  //         '/world_map': (_) => const WorldMapPage(),
  //         // '/quiz': (_) => const QuizPage(),
  //         '/quiz': (_) => Provider(
  //               create: (_) =>
  //                   Report(), // Replace YourQuizModel with your actual model
  //               child: const QuizPage(),
  //             ),
  //         //'/profile': (_) => const ProfileScreen(),
  //         '/topics': (_) => Provider(
  //             create: (_) =>
  //                 Report(), // Replace YourQuizModel with your actual model
  //             child: const TopicsScreen()),
  //         '/profile': (_) => Provider(
  //               create: (_) =>
  //                   Report(), // Replace YourQuizModel with your actual model
  //               child: const ProfileScreen(),
  //             ),
  //         '/about': (_) => const AboutScreen(),
  //         '/login_screen': (_) => const LoginScreen(),
  //       },
  //       initialRoute: '/login',
  //       home: const LoginPage());
  // }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          // Error screen
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
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
                  // '/dashboard': (_) => const Dashboard(),
                  '/add_event': (_) =>
                      const AuthGuard(protectedPage: AddEventPage()),
                  '/schedule': (_) => const SchedulePage(),
                  '/notes': (_) => const NotesPage(),
                  '/tasks': (_) => const TasksPage(),
                  '/world_map': (_) => const WorldMapPage(),
                  '/quiz': (_) => const QuizPage(),
                  // '/quiz': (_) => Provider(
                  //       create: (_) =>
                  //           Report(), // Replace YourQuizModel with your actual model
                  //       child: const QuizPage(),
                  //     ),
                  '/profile': (_) => const ProfileScreen(),
                  '/topics': (_) => const TopicsScreen(countryId: "all"),
                  // '/topics': (_) => Provider(
                  //     create: (_) =>
                  //         Report(), // Replace YourQuizModel with your actual model
                  //     child: const TopicsScreen()),
                  // '/profile': (_) => Provider(
                  //       create: (_) =>
                  //           Report(), // Replace YourQuizModel with your actual model
                  //       child: const ProfileScreen(),
                  //     ),
                  '/about': (_) => const AboutScreen(),
                  '/login_screen': (_) => const LoginScreen(),
                },
                initialRoute: '/login',
                home: const LoginPage()),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const MaterialApp();
      },
    );
  }
}
