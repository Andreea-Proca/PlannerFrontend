import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:planner_frontend/game/quiz/quiz.dart';
import 'package:planner_frontend/services/models.dart';

class TopicDrawer extends StatelessWidget {
  final List<Topic> topics;
  final String countryId;
  const TopicDrawer({super.key, required this.topics, required this.countryId});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Colors.deepPurple,
      child: ListView.separated(
          shrinkWrap: true,
          itemCount: topics.length,
          itemBuilder: (BuildContext context, int idx) {
            Topic topic = topics[idx];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    topic.title,
                    // textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                ),
                QuizList(topic: topic, countryId: countryId)
              ],
            );
          },
          separatorBuilder: (BuildContext context, int idx) => const Divider()),
    ));
  }
}

class QuizList extends StatelessWidget {
  final Topic topic;
  final String countryId;
  const QuizList({super.key, required this.topic, required this.countryId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: topic.quizzes.map(
        (quiz) {
          if (quiz.id.startsWith(countryId)) {
            return Card(
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              elevation: 4,
              margin: const EdgeInsets.all(4),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          QuizScreen(quizId: quiz.id),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(
                      quiz.title,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    subtitle: Text(
                      quiz.description,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    leading: QuizBadge(topic: topic, quizId: quiz.id),
                  ),
                ),
              ),
            );
          } else
            return const SizedBox.shrink();
        },
      ).toList(),
    );
  }
}

class QuizBadge extends StatelessWidget {
  final String quizId;
  final Topic topic;

  const QuizBadge({super.key, required this.quizId, required this.topic});

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    List completed = report.topics[topic.id] ?? [];
    if (completed.contains(quizId)) {
      return const Icon(FontAwesomeIcons.checkDouble, color: Colors.green);
    } else {
      return const Icon(FontAwesomeIcons.solidCircle, color: Colors.grey);
    }
  }
}
