import 'package:intl/intl.dart';

class Event {
  late String id;
  late String day;
  late String title;
  late String priority;
  late String startTime;

  Event(this.id, this.day, this.title, this.priority, this.startTime);

  // Convert a Message to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'day': day,
      'title': title,
      'priority': priority,
      'startTime': startTime
    };
  }

  // Create a Message from a Map
  Event.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    day = map['day'];
    title = map['title'];
    priority = map['priority'];
    startTime = map['startTime'];
  }
}
