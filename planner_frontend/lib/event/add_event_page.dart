import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:planner_frontend/event/schedule_page.dart';
import 'package:planner_frontend/event/utils.dart';

import '../models/event.dart';
import '../services/firebase_service.dart';

class AddEventPage extends StatefulWidget {
  final DateTime? selectedDay;
  const AddEventPage({Key? key, this.selectedDay}) : super(key: key);

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  final _wmNoController = TextEditingController();
  final _startHourController = TextEditingController();
  final _inputTitleController = TextEditingController();
  String selectedPriority = '1';
  List<String> priorities = ['1', '2', '3'];
  TimeOfDay selectedTime = TimeOfDay.now();
  String inputTitle = '';
  late DateTime? selectedDay = widget.selectedDay;
  final FirebaseService firebaseService = FirebaseService();

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

  Widget buildTextField(TextEditingController controller, label,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
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
            title: const Text('Add events'),
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
                      'Add an event',
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
                      child: buildTextField(
                          _inputTitleController, 'Event\'s title'),
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
                                text: selectedTime.format(context)),
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
                          // Message newMessage =
                          //     Message('Hello from Flutter!', '1', '20:50');
                          Event newEvent = Event(
                              '',
                              selectedDay!.toIso8601String(),
                              _inputTitleController.text,
                              selectedPriority,
                              selectedTime.toString(),
                              //selectedTime,
                              false);
                          firebaseService.sendEvent(newEvent);
                          initializeKEvents();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: const Color(0xFFB6D0E2),
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        child: const Text(
                          'Add the event',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0), ////////////////////////////
                    FractionallySizedBox(
                      widthFactor: widthFactor,
                      child: ElevatedButton(
                        onPressed: () {
                          firebaseService.getEvents();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: const Color(0xFFB6D0E2),
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        child: const Text(
                          'Show events',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ), ///////////////////////////////////////////////
                    const SizedBox(height: 20.0),
                    FractionallySizedBox(
                      widthFactor: widthFactor,
                      child: ElevatedButton(
                        onPressed: () => _navigateTo('/home'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: const Color(0xFFB6D0E2),
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        child: const Text(
                          'Back to Home Page',
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
      value: selectedPriority,
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
