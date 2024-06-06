import 'package:intl/intl.dart';

class Note {
  late String id;
  late String title;
  late List<String> items;
  late String dueDate;
  late List<bool> crossedDownList;
  late bool isCompleted;
  late String userId;

  Note(this.id, this.title, this.items, this.dueDate, this.crossedDownList,
      this.isCompleted, this.userId);

  // Convert a Message to a Map
  Map<String, dynamic> toMap() {
    return {
      'crossedDownList': crossedDownList,
      'id': id,
      'title': title,
      'items': items,
      'dueDate': dueDate,
      'isCompleted': isCompleted,
      'userId': userId,
    };
  }

  // Create a Message from a Map
  Note.fromMap(Map<String, dynamic> map) {
    crossedDownList = List<bool>.from(map['crossedDownList'] ?? []);
    id = map['id'];
    title = map['title'];
    items = List<String>.from(map['items'] ?? []);
    dueDate = map['dueDate'];
    isCompleted = map['isCompleted'];
    userId = map['userId'];
  }
}
