import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:planner_frontend/services/auth.dart';
import 'package:planner_frontend/services/models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Reads all documments from the topics collection
  Future<List<Topic>> getTopics() async {
    var ref = _db.collection('topics');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    debugPrint('Datafirestore: $data');
    var topics = data.map((d) => Topic.fromJson(d));

    debugPrint('Topics firestore: ${topics.toList()[0]}');
    return topics.toList();
  }

  // Retrieves a single quiz document
  Future<Quiz> getQuiz(String quizId) async {
    var ref = _db.collection('quizzes').doc(quizId);
    var snapshot = await ref.get();
    return Quiz.fromJson(snapshot.data() ?? {});
  }

  // Listens to current user's report document in Firestore
  Stream<Report> streamReport() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('reports').doc(user.uid);
        return ref.snapshots().map((doc) => Report.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([Report()]);
      }
    });
  }

  // Updates the current user's report document after completing quiz
  Future<void> updateUserReport(Quiz? quiz) {
    var user = AuthService().user!;
    var ref = _db.collection('reports').doc(user.uid);

    var data;
    if (quiz == null) {
      data = {
        'quizzes': FieldValue.increment(0),
        'total': FieldValue.increment(0),
        'name': user.displayName,
      };
    } else {
      data = {
        'quizzes': FieldValue.increment(1),
        'topics': {
          quiz!.topic: FieldValue.arrayUnion([quiz.id])
        },
        'total': FieldValue.increment(1),
      };
    }
    return ref.set(data, SetOptions(merge: true));
  }

  Future<void> updateUserNETReport(String type, int value) {
    var user = AuthService().user!;
    var ref = _db.collection('reports').doc(user.uid);

    if (type == 'notes') {
      var data = {
        'notes': FieldValue.increment(value),
        'total': FieldValue.increment(value),
      };
      return ref.set(data, SetOptions(merge: true));
    } else if (type == 'events') {
      var data = {
        'events': FieldValue.increment(value),
        'total': FieldValue.increment(value),
      };
      return ref.set(data, SetOptions(merge: true));
    } else if (type == 'tasks') {
      var data = {
        'tasks': FieldValue.increment(value),
        'total': FieldValue.increment(value),
      };
      return ref.set(data, SetOptions(merge: true));
    } else {
      return Future.value();
    }
  }
}
