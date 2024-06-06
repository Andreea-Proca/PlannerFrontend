import 'package:flutter/material.dart';
import 'package:planner_frontend/models/leaderboard.dart';
import 'package:provider/provider.dart';
import 'services/leaderboard_service.dart';
import 'widgets/nav_drawer.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late Future<List<LeaderboardEntry>> leaderboardFuture;

  @override
  void initState() {
    super.initState();
    leaderboardFuture = LeaderboardService().getLeaderboard();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthFactor =
        screenSize.width > 800 ? 0.5 : (screenSize.width > 600 ? 0.75 : 0.95);

    return Scaffold(
      drawer: const NavDrawer(),
      backgroundColor: Color.fromARGB(255, 138, 209, 242),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple,
        title: Text('Leaderboard',
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: Colors.white)),
      ),
      body: FutureBuilder<List<LeaderboardEntry>>(
        future: leaderboardFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            List<LeaderboardEntry> leaderboard = snapshot.data!;
            return ListView.builder(
              itemCount: leaderboard.length,
              itemBuilder: (context, index) {
                LeaderboardEntry entry = leaderboard[index];
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Wrap(
                      direction: screenSize.width > 800
                          ? Axis.horizontal
                          : Axis.vertical,
                      spacing: 10.0,
                      runSpacing: 10.0,
                      alignment: WrapAlignment.center,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage('assets/nerdIcon.png'),
                              ),
                              SizedBox(width: 15),
                              // Expanded(
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                                size: 10,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                                size: 20,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                                size: 30,
                              ),
                              Text(
                                entry.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                                size: 30,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                                size: 20,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                                size: 10,
                              ),
                              const SizedBox(width: 50),
                            ]),
                        // Wrap(
                        //     direction: screenSize.width > 800
                        //         ? Axis.horizontal
                        //         : Axis.vertical,
                        //     spacing: 10.0,
                        //     runSpacing: 10.0,
                        //     children: [
                        // SizedBox(width: 50),
                        //SizedBox(width: 10),
                        Row(children: [
                          SizedBox(width: 30),
                          Text(
                            'Tasks: ${entry.tasks}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Notes: ${entry.notes}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Events: ${entry.events}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ]),
                        // SizedBox(width: 5),
                        Row(children: [
                          SizedBox(width: 60),
                          Text(
                            'Quizzes: ${entry.quizzes}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Score: ${entry.score}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ]),
                      ]),
                  // ],
                  // ),
                  // ),
                  //SizedBox(width: 50),
                  //],
                  //),
                );
              },
            );
          }
        },
      ),
    );
  }
}
