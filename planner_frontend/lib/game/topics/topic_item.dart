import 'package:flutter/material.dart';
import 'package:planner_frontend/services/firestore_service.dart';
import 'package:planner_frontend/services/models.dart';
import 'package:planner_frontend/shared/progress_bar.dart';
import 'package:planner_frontend/game/topics/drawer.dart';

class TopicItem extends StatelessWidget {
  final Topic topic;
  final String countryId;
  const TopicItem({super.key, required this.topic, required this.countryId});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: topic.img,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    TopicScreen(topic: topic, countryId: countryId),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: SizedBox(
                  child: Image.asset(
                    'assets/covers/${topic.img}',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    topic.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontWeight: FontWeight.bold),
                    // style: const TextStyle(
                    //   height: 1.5,
                    //   fontWeight: FontWeight.bold,
                    // ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
              Flexible(child: TopicProgress(topic: topic)),
            ],
          ),
        ),
      ),
    );
  }
}

class TopicScreen extends StatelessWidget {
  final Topic topic;
  final String countryId;
  const TopicScreen({super.key, required this.topic, required this.countryId});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthFactor =
        screenSize.width > 800 ? 0.5 : (screenSize.width > 600 ? 0.75 : 0.95);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 138, 209, 242),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(children: [
        SizedBox(height: 10),
        SizedBox(
            height: screenSize.width > 800
                ? screenSize.width * 0.15
                : screenSize.width * 0.5,
            child: Hero(
              tag: topic.img,
              child: Image.asset('assets/covers/${topic.img}',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.contain),
              // width: screenSize.width > 800
              //     ? screenSize.width * 2
              //     : MediaQuery.of(context).size.width),
            )),
        const Divider(height: 20, color: Colors.white),
        Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: const EdgeInsets.all(20),
            child: Text(
              topic.title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            )),
        const Divider(height: 20, color: Colors.white),
        QuizList(topic: topic, countryId: countryId),
      ]),
    );
  }
}
