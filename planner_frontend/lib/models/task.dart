import 'package:intl/intl.dart';

class Task {
  late String id;
  late String title;
  late String description;
  late String priority;
  late String dueDate;
  late String dueTime;
  late List<String> subtasks;
  late List<bool> completedSubtasks;
  late bool isCompleted;
  late String userId;

  Task(
      this.id,
      this.title,
      this.description,
      this.priority,
      this.dueDate,
      this.dueTime,
      this.subtasks,
      this.completedSubtasks,
      this.isCompleted,
      this.userId);

  // Convert a Message to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'dueDate': dueDate,
      'dueTime': dueTime,
      'subtasks': subtasks,
      'completedSubtasks': completedSubtasks,
      'isCompleted': isCompleted,
      'userId': userId,
    };
  }

  // Create a Message from a Map
  Task.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    priority = map['priority'];
    dueDate = map['dueDate'];
    dueTime = map['dueTime'];
    subtasks = List<String>.from(map['subtasks'] ?? []);
    completedSubtasks = List<bool>.from(map['completedSubtasks'] ?? []);
    isCompleted = map['isCompleted'];
    userId = map['userId'];
  }
}
