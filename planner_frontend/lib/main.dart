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
import 'map_page.dart';
import 'lists_page.dart';
// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBvGX5ca4HGO45vRaKQMdHb6j4izNq7zTA',
      appId: '1:352835275222:ios:5d2c56463bd781553bfc77',
      messagingSenderId: '352835275222',
      projectId: 'task-manager-b0625',
      databaseURL:
          'https://task-manager-b0625-default-rtdb.europe-west1.firebasedatabase.app/',
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
          '/map': (_) => const MapPage(),
          '/lists': (_) => const ListsPage(),
        },
        initialRoute: '/login',
        home: const LoginPage());
  }
}
