import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:planner_frontend/services/services.dart';
import 'package:planner_frontend/shared/shared.dart';
import 'package:planner_frontend/game/topics/drawer.dart';
import 'package:planner_frontend/game/topics/topic_item.dart';
import 'package:planner_frontend/widgets/nav_drawer.dart';

class TopicsScreen extends StatelessWidget {
  final String countryId;
  const TopicsScreen({Key? key, required this.countryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthFactor =
        screenSize.width > 800 ? 0.5 : (screenSize.width > 600 ? 0.75 : 0.95);

    return FutureBuilder<List<Topic>>(
      future: FirestoreService().getTopics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var topics = snapshot.data!;
          debugPrint('Topics: ${topics[0].quizzes.length}');

          return Scaffold(
            drawer: const NavDrawer(),
            backgroundColor: Color.fromARGB(255, 138, 209, 242),
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.deepPurple,
              title: Text('Topics',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.white)),
              actions: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.circleUser,
                    color: Colors.pink[200],
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/profile'),
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.list,
                    color: Colors.pink[200],
                  ),
                  onPressed: () =>
                      TopicDrawer(topics: topics, countryId: countryId),
                )
              ],
            ),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: screenSize.width > 800 ? 4 : 2,
              children: topics
                  .map((topic) => TopicItem(
                        topic: topic,
                        countryId: countryId,
                      ))
                  .toList(),
            ),
            bottomNavigationBar: const BottomNavBar(),
          );
        } else {
          return const Text('No topics found in Firestore. Check database');
        }
      },
    );
  }
}
