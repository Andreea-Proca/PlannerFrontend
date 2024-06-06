import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:planner_frontend/services/services.dart';
import 'package:planner_frontend/shared/shared.dart';
import 'package:planner_frontend/widgets/nav_drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var report = Provider.of<Report>(context);
    var user = AuthService().user;
    Size screenSize = MediaQueryData().size;
    double widthFactor =
        screenSize.width > 800 ? 0.5 : (screenSize.width > 600 ? 0.75 : 0.95);

    if (user != null) {
      return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.orange,
          title: Text('Profile & Progress Report',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.white)),
          // Text(user.displayName ?? 'Guest'),
        ),
        body: Center(
          widthFactor: widthFactor,
          heightFactor: widthFactor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(
                // child: Wrap(
                //     direction:
                //         screenSize.width > 800 ? Axis.horizontal : Axis.vertical,
                //     // spacing: 10.0,
                //     // runSpacing: 10.0,
                //     alignment: WrapAlignment.center,
                children: [
                  Container(
                    width: screenSize.width > 800 ? 1000 : 175,
                    height: screenSize.width > 800 ? 1000 : 175,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            width: 80,
                            height: 80,
                            // margin: const EdgeInsets.only(top: 50),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage("assets/nerdIcon.png")
                                  // NetworkImage(user.photoURL ?? 'https://www.gravatar.com/avatar/placeholder'),
                                  ),
                            ),
                          ),
                          Text(user.displayName ?? 'Guest',
                              style: Theme.of(context).textTheme.headline6),
                          //SizedBox(height: 5),
                          Text(user.email ?? '',
                              style: Theme.of(context).textTheme.titleMedium),
                          // const Spacer(),
                        ]),
                  ),
                  SizedBox(width: widthFactor * 5, height: widthFactor * 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                          // direction:
                          //     screenSize.width < 800 ? Axis.horizontal : Axis.vertical,
                          // spacing: 10.0,
                          // runSpacing: 10.0,
                          //alignment: WrapAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //SizedBox(height: widthFactor * 20),
                            Container(
                                width: screenSize.width > 800 ? 1000 : 135,
                                height: screenSize.width > 800 ? 1000 : 375,
                                color: Color.fromARGB(255, 142, 190, 230),
                                child: Column(
                                  // direction: screenSize.width > 800
                                  //     ? Axis.horizontal
                                  //     : Axis.vertical,
                                  // spacing: 10.0,
                                  // runSpacing: 10.0,
                                  // alignment: WrapAlignment.center,
                                  children: [
                                    Text("Work Progress",
                                        style: screenSize.width > 800
                                            ? Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold)
                                            : Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                    Container(
                                        width:
                                            screenSize.width > 800 ? 1000 : 125,
                                        height:
                                            screenSize.width > 800 ? 1000 : 100,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        padding: EdgeInsets.all(16.0),
                                        margin: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text('${report.notes}',
                                                style: screenSize.width > 800
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .headline2
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold)
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                            Text('Notes Completed',
                                                style: screenSize.width > 800
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .titleSmall
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold)
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .titleSmall
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                          ],
                                        )),
                                    Container(
                                        width:
                                            screenSize.width > 800 ? 100 : 125,
                                        height:
                                            screenSize.width > 800 ? 100 : 100,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        padding: EdgeInsets.all(16.0),
                                        margin: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text('${report.events}',
                                                style: screenSize.width > 800
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .headline2
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold)
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                            Text('Events Completed',
                                                style: screenSize.width > 800
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .subtitle2
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold)
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .titleSmall
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                          ],
                                        )),
                                    Container(
                                        width:
                                            screenSize.width > 800 ? 100 : 125,
                                        height:
                                            screenSize.width > 800 ? 100 : 100,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        padding: EdgeInsets.all(16.0),
                                        margin: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text('${report.tasks}',
                                                style: screenSize.width > 800
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .headline2
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold)
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                            Text('Tasks Completed',
                                                style: screenSize.width > 800
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .subtitle2
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold)
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .titleSmall
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                          ],
                                        )),
                                    //SizedBox(height: widthFactor * 33),
                                  ],
                                )),
                            // const Spacer(),
                            SizedBox(width: widthFactor * 20),
                            Container(
                              width: screenSize.width > 800 ? 200 : 135,
                              height: screenSize.width > 800 ? 200 : 375,
                              color: Color.fromARGB(255, 185, 154, 198),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Game Progress",
                                        style: screenSize.width > 800
                                            ? Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold)
                                            : Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                    SizedBox(height: 10),
                                    Container(
                                        width:
                                            screenSize.width > 800 ? 100 : 125,
                                        height:
                                            screenSize.width > 800 ? 100 : 100,
                                        decoration: BoxDecoration(
                                          color: Colors.purple,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        padding: EdgeInsets.all(16.0),
                                        margin: EdgeInsets.all(8.0),
                                        child: Column(children: [
                                          Text('${report.quizzes}',
                                              style: screenSize.width > 800
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .headline2
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                          Text('Quizzes Completed',
                                              style: screenSize.width > 800
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .subtitle2
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                        ])),
                                    //SizedBox(height: widthFactor * 275),
                                  ]),
                            ),
                          ]),
                      //const SizedBox(height: 20),
                      Container(
                          width: screenSize.width > 800 ? 1000 : 600,
                          height: screenSize.width > 800 ? 1000 : 116,
                          color: Color.fromARGB(255, 244, 198, 124),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Total Progress",
                                    style: screenSize.width > 800
                                        ? Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)
                                        : Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                Container(
                                    width: screenSize.width > 800 ? 100 : 105,
                                    height: screenSize.width > 800 ? 100 : 100,
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    padding: EdgeInsets.all(16.0),
                                    margin: EdgeInsets.all(8.0),
                                    child: Column(children: [
                                      Text('${report.total}',
                                          style: screenSize.width > 800
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .headline2
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)
                                              : Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                      Text('Score points',
                                          style: screenSize.width > 800
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)
                                              : Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                    ]))
                              ])),
                      SizedBox(height: widthFactor * 20),
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
                      // const Spacer(),
                    ],
                  ),
                ]),
          ),
        ),
      );
    } else {
      return const Loader();
    }
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
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
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

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }
}
