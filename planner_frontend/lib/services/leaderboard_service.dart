import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planner_frontend/models/leaderboard.dart';

class LeaderboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<LeaderboardEntry>> getLeaderboard() async {
    QuerySnapshot snapshot = await _firestore
        .collection('reports')
        .orderBy('total', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => LeaderboardEntry(
              name: doc['name'],
              score: doc['total'],
              quizzes: doc['quizzes'],
              tasks: doc['tasks'],
              notes: doc['notes'],
              events: doc['events'],
              //profilePictureUrl: doc['profilePictureUrl'],
            ))
        .toList();
  }
}
