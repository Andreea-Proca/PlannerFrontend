import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: const Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
              // image: DecorationImage(
              //     fit: BoxFit.fill,
              //     image: AssetImage('assets/images/bkgr.jpeg'))
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.pushReplacementNamed(context, '/home')
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.pushReplacementNamed(context, '/profile')
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text('Schedule'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.pushReplacementNamed(context, '/schedule')
            },
          ),
          ListTile(
            leading: Icon(Icons.edit_note),
            title: Text('Notes'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.pushReplacementNamed(context, '/lists')
            },
          ),
          ListTile(
            leading: Icon(Icons.map_outlined),
            title: Text('World Map'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.pushReplacementNamed(context, '/world_map')
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async => {
              // Navigator.of(context).pop(),
              // await FirebaseAuth.instance.signOut(),
              // Navigator.pushReplacementNamed(context, '/login')
              buildLogoutButton(context)
            },
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
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
          backgroundColor: Color.fromARGB(255, 161, 197, 123),
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
