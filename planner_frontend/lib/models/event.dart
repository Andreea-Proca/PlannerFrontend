import 'package:intl/intl.dart';

class Event {
  late String day;
  late String title;
  late String priority;
  late String startTime;

  Event(this.day, this.title, this.priority, this.startTime);

  // Convert a Message to a Map
  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'title': title,
      'priority': priority,
      'startTime': startTime
    };
  }

  // Create a Message from a Map
  Event.fromMap(Map<String, dynamic> map) {
    day = map['day'];
    title = map['title'];
    priority = map['priority'];
    startTime = map['startTime'];
  }
}
