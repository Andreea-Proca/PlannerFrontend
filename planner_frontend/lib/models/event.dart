//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Event {
  late String id;
  late String day;
  late String title;
  late String priority;
  late String startTime;
  late bool isCompleted;
  late String userId;

  Event(this.id, this.day, this.title, this.priority, this.startTime,
      this.isCompleted, this.userId);

  // Convert a Message to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'day': day,
      'title': title,
      'priority': priority,
      'startTime': startTime,
      'isCompleted': isCompleted,
      'userId': userId,
    };
  }

  // Create a Message from a Map
  Event.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    day = map['day'];
    title = map['title'];
    priority = map['priority'];
    startTime = map['startTime'];
    isCompleted = checkBool(map['isCompleted']);
    userId = map['userId'];
  }

  bool checkBool(bool isCompleted) {
    //print("iscompleted: $isCompleted");
    return isCompleted;
  }

  // // Helper method to format TimeOfDay to String
  // String _formatTimeOfDay(TimeOfDay timeOfDay) {
  //   final now = DateTime.now();
  //   final dateTime = DateTime(
  //       now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  //   return DateFormat.Hm().format(dateTime);
  // }

  // // Helper method to parse String to TimeOfDay
  // TimeOfDay _parseTimeOfDay(String timeString) {
  //   final List<String> parts = timeString.split(':');
  //   TimeOfDay tod = TimeOfDay(
  //     hour: int.parse(parts[0]),
  //     minute: int.parse(parts[1]),
  //   );
  //   print("tod: $tod");
  //   return tod;
  // }
}
