import 'package:firebase_database/firebase_database.dart';

import '../models/event.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Write a event to the database
  Future<void> sendEvent(Event event) async {
    await _database.child('events').push().set(event.toMap());
  }

  // Read events from the database
  Future<List<Event>> getEvents() async {
    final snapshot = await _database.child('events').get();
    List<Event> events = [];

    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      // print(snapshot.value);

      values.forEach((key, value) {
        events.add(Event.fromMap(value));
      });
    }

    // for (var element in events) {
    //   print(element.day +
    //       ", " +
    //       element.title +
    //       ", " +
    //       element.priority +
    //       ", " +
    //       element.startTime);
    // }
    return events;
  }
}
