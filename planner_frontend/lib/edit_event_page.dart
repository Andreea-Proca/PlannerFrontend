import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:planner_frontend/schedule_page.dart';
import 'package:planner_frontend/utils.dart';

import 'models/event.dart';
import 'services/firebase_service.dart';

class EditEventPage extends StatefulWidget {
  final DateTime? selectedDay;
  final Event event;
  const EditEventPage({Key? key, this.selectedDay, required this.event})
      : super(key: key);

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  late Event event = widget.event;
  final _formKey = GlobalKey<FormState>();
  final _wmNoController = TextEditingController();
  final _startHourController = TextEditingController();
  final _inputTitleController = TextEditingController();
  String selectedPriority = '1';
  List<String> priorities = ['1', '2', '3'];
  // TimeOfDay selectedTime = TimeOfDay.now();
  String inputTitle = '';
  late DateTime? selectedDay = widget.selectedDay;
  final FirebaseService firebaseService = FirebaseService();

  TimeOfDay parseTimeString(String timeString) {
    List<String> parts = timeString.substring(10, 15).split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    return TimeOfDay(hour: hour, minute: minute);
  }

  late TimeOfDay selectedTime = parseTimeString(event.startTime);

  Future<void> _navigateTo(String routeName) async {
    Navigator.pushReplacementNamed(context, routeName);
  }

  void showErrorSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        _startHourController.text = _formatTimeOfDay(picked);
      });
    }
  }

  String _formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat("HH:mm");
    return format.format(dt);
  }

  Widget buildTextField(
      TextEditingController controller, label, hint, initialValue,
      {bool obscureText = false}) {
    controller.text = initialValue;
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: Colors.black),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 54, 54, 54)),
        ),
      ),
      obscureText: obscureText,
      autocorrect: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthFactor =
        screenSize.width > 800 ? 0.5 : (screenSize.width > 600 ? 0.75 : 0.95);

    return Dialog(
      child: Container(
        width: 500, // Set the width of the Scaffold
        height: 600, // Set the height of the Scaffold
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 161, 197, 123),
          appBar: AppBar(
            title: const Text('Edit event'),
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Edit event',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),
                    FractionallySizedBox(
                      widthFactor: widthFactor,
                      child: buildTextField(_inputTitleController,
                          'Event\'s title', '', event.title),
                    ),
                    const SizedBox(height: 20.0),
                    FractionallySizedBox(
                      widthFactor: widthFactor,
                      child: buildDropdownButton(),
                    ),
                    const SizedBox(height: 20.0),
                    FractionallySizedBox(
                      widthFactor: widthFactor,
                      child: GestureDetector(
                        onTap: () => _selectTime(context),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: TextEditingController(
                                text: event.startTime
                                    .toString()
                                    .substring(10, 15)),
                            //selectedTime.format(context)),
                            decoration: const InputDecoration(
                              labelText: 'Start time',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    FractionallySizedBox(
                      widthFactor: widthFactor,
                      child: ElevatedButton(
                        onPressed: () {
                          //selectedDay!.toIso8601String(),
                          event.priority = selectedPriority;
                          event.startTime = selectedTime.toString();
                          event.title = _inputTitleController.text;
                          firebaseService.updateEvent(event);
                          initializeKEvents();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: const Color(0xFFB6D0E2),
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        child: const Text(
                          'Save changes',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdownButton() {
    return DropdownButtonFormField<String>(
      value: event.priority,
      //selectedPriority,
      decoration: const InputDecoration(
        labelText: 'Priority',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(),
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedPriority = newValue!;
          _wmNoController.text = newValue;
        });
      },
      items: priorities.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
