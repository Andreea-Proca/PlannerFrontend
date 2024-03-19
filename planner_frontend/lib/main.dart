import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'booking_page.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'home_page.dart';
import 'schedule_page.dart';
import 'lists_page.dart';
import 'world_map.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Task Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/login': (_) => const LoginPage(),
          '/signup': (_) => const SignUpPage(),
          '/home': (_) => const AuthGuard(protectedPage: HomePage()),
          // '/dashboard': (_) => const Dashboard(),
          '/booking': (_) => const AuthGuard(protectedPage: BookingPage()),
          '/schedule': (_) => const SchedulePage(),
          '/lists': (_) => const ListsPage(),
          '/world_map': (_) => const WorldMapPage(),
        },
        initialRoute: '/login',
        home: const LoginPage());
  }
}
