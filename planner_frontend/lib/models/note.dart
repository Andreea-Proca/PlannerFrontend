import 'package:intl/intl.dart';

class Note {
  late String id;
  late String title;
  late List<String> items;
  late String dueDate;

  Note(this.id, this.title, this.items, this.dueDate);

  // Convert a Message to a Map
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'items': items, 'dueDate': dueDate};
  }

  // Create a Message from a Map
  Note.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    items = List<String>.from(map['items'] ?? []);
    dueDate = map['dueDate'];
  }
}
