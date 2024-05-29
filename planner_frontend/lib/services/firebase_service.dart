import 'package:firebase_database/firebase_database.dart';
import 'package:planner_frontend/models/task.dart';

import '../models/event.dart';
import '../models/note.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Write a event to the database
  Future<void> sendEvent(Event event) async {
    //await _database.child('events').push().set(event.toMap());
    DatabaseReference reference = _database.child('events');
    DatabaseReference newEventRef = reference.push();
    await newEventRef.set(event.toMap());
    event.id = newEventRef.key!;
    updateEvent(event);
  }

  // Write a note to the database
  Future<void> updateEvent(Event event) async {
    await _database.child('events').child(event.id).update(event.toMap());
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

    return events;
  }

  Future<void> deleteEvent(Event event) async {
    try {
      await _database.child('event').child(event.id).remove();
      print(' deleted event: ${event.id}');
    } catch (e) {
      print('Error deleting event: $e');
    }
  }

// NOTES
  // Write a note to the database
  Future<void> sendNote(Note note) async {
    // var result = await _database.child('notes').push().set(note.toMap());
    DatabaseReference reference = _database.child('notes');
    DatabaseReference newNoteRef = reference.push();
    await newNoteRef.set(note.toMap());
    note.id = newNoteRef.key!;
    updateNote(note);
  }

  // Write a note to the database
  Future<void> updateNote(Note note) async {
    await _database.child('notes').child(note.id).update(note.toMap());
  }

  // Read notes from the database
  Future<List<Note>> getNotes() async {
    final snapshot = await _database.child('notes').get();
    List<Note> notes = [];

    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      // print(snapshot.value);

      values.forEach((key, value) {
        notes.add(Note.fromMap(value));
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
    return notes;
  }

  Future<void> deleteNote(Note note) async {
    try {
      await _database.child('notes').child(note.id).remove();
      print(' deleted note: ${note.id}');
    } catch (e) {
      print('Error deleting note: $e');
    }
  }

  // TASKS
  // Write a note to the database
  Future<void> sendTask(Task task) async {
    // var result = await _database.child('notes').push().set(note.toMap());
    DatabaseReference reference = _database.child('tasks');
    DatabaseReference newTaskRef = reference.push();
    await newTaskRef.set(task.toMap());
    task.id = newTaskRef.key!;
    updateTask(task);
  }

  // Write a note to the database
  Future<void> updateTask(Task task) async {
    await _database.child('tasks').child(task.id).update(task.toMap());
  }

  // Read notes from the database
  Future<List<Task>> getTasks() async {
    final snapshot = await _database.child('tasks').get();
    List<Task> tasks = [];

    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      // print(snapshot.value);

      values.forEach((key, value) {
        tasks.add(Task.fromMap(value));
      });
    }
    return tasks;
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _database.child('tasks').child(task.id).remove();
      print(' deleted task: ${task.id}');
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}
