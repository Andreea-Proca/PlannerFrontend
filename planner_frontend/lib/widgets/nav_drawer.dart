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
              Navigator.of(context).pop(),
              await FirebaseAuth.instance.signOut(),
              Navigator.pushReplacementNamed(context, '/login')
            },
          ),
        ],
      ),
    );
  }
}
