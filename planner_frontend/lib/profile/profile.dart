import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:planner_frontend/services/services.dart';
import 'package:planner_frontend/shared/shared.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var report = Provider.of<Report>(context);
    var user = AuthService().user;

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(user.displayName ?? 'Guest'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user.photoURL ??
                        'https://www.gravatar.com/avatar/placeholder'),
                  ),
                ),
              ),
              Text(user.email ?? '',
                  style: Theme.of(context).textTheme.headline6),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('${report.notes}',
                          style: Theme.of(context).textTheme.headline2),
                      Text('Notes Completed',
                          style: Theme.of(context).textTheme.subtitle2),
                    ],
                  ),
                  Column(
                    children: [
                      Text('${report.events}',
                          style: Theme.of(context).textTheme.headline2),
                      Text('Events Completed',
                          style: Theme.of(context).textTheme.subtitle2),
                    ],
                  ),
                  Column(
                    children: [
                      Text('${report.tasks}',
                          style: Theme.of(context).textTheme.headline2),
                      Text('Tasks Completed',
                          style: Theme.of(context).textTheme.subtitle2),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Text('${report.total}',
                  style: Theme.of(context).textTheme.headline2),
              Text('Quizzes Completed',
                  style: Theme.of(context).textTheme.subtitle2),
              const Spacer(),
              ElevatedButton(
                child: const Text('logout'),
                onPressed: () async {
                  await AuthService().signOut();
                  if (mounted) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    } else {
      return const Loader();
    }
  }
}
