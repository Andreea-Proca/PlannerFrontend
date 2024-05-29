import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:planner_frontend/services/firestore_service.dart';

import 'widgets/nav_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    _navigateTo('/login');
  }

  void _navigateTo(String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
    // addTopicWithQuizzesToFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: const Text('Home Page'),
          backgroundColor: Color.fromARGB(255, 81, 164, 205),
        ),
        body: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the column vertically
            children: [
              const SizedBox(height: 50),
              Container(
                width: 200, // Adjust the width as needed
                height: 200, // Adjust the height as needed
                child: const Image(
                  image: AssetImage('assets/Logo1.jpeg'),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.all(
                            20.0), // Add some margin to position the "paper" within the screen
                        decoration: BoxDecoration(
                          color: Colors.white, // Paper color
                          borderRadius:
                              BorderRadius.circular(8.0), // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 5, // How far the shadow spreads
                              blurRadius: 7, // Blur radius
                              offset: Offset(0, 3), // Shadow offset
                            ),
                          ],
                        ),
                        child: Text(
                          'Welcome to TaskTrove, your effective fun planner that helps you achieve all your goals and keep track of daily tasks and events!',
                          textAlign: TextAlign.center, // Center align the text
                          style: TextStyle(
                            fontSize: 24, // Adjust the font size
                            fontWeight: FontWeight.bold, // Bold text
                            color: Colors.black, // Text color
                            fontFamily:
                                'Roboto', // Optionally change the font family
                            letterSpacing:
                                1.2, // Add some letter spacing for better readability
                            height:
                                1.5, // Adjust the line height for better spacing
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () => _navigateTo('/profile'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color(0xFFB6D0E2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 15.0),
                      ),
                      child: const Text(
                        'See Profile',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _navigateTo('/schedule'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color(0xFFB6D0E2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 15.0),
                      ),
                      child: const Text(
                        'Check schedule',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _navigateTo('/tasks'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color(0xFFB6D0E2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 15.0),
                      ),
                      child: const Text(
                        'Check tasks',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _navigateTo('/notes'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color(0xFFB6D0E2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 15.0),
                      ),
                      child: const Text(
                        'Check notes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _navigateTo('/world_map'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color(0xFFB6D0E2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 15.0),
                      ),
                      child: const Text(
                        'See World Map',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => buildLogoutButton(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color(0xFFB6D0E2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 15.0),
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]));
  }

  Future<dynamic> buildLogoutButton(BuildContext context) {
    // return ElevatedButton(
    //   onPressed: () {
    return showDialog(
      context: context, // Use builderContext here
      builder: (BuildContext context) {
        Size screenSize = MediaQuery.of(context).size;
        double widthFactor = screenSize.width > 800
            ? 0.5
            : (screenSize.width > 600 ? 0.75 : 0.95);
        return AlertDialog(
          scrollable: true,
          backgroundColor: Color.fromARGB(255, 163, 204, 120),
          title: Text('Are you sure you want to logout?'),
          content: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20.0),
                FractionallySizedBox(
                  widthFactor: widthFactor,
                  child: ElevatedButton(
                    onPressed: () {
                      _logout(context);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Color(0xFFB6D0E2),
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                    ),
                    child: const Text(
                      'Yes',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                FractionallySizedBox(
                  widthFactor: widthFactor,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xFFB6D0E2),
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                    ),
                    child: const Text(
                      'No',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
