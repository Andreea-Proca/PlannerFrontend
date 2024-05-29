import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:planner_frontend/task/task_page.dart';
import 'package:planner_frontend/event/utils.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/task.dart';
import '../services/firebase_service.dart';

class AddTaskPage extends StatefulWidget {
  final DateTime? selectedDay;
  const AddTaskPage({Key? key, this.selectedDay}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _wmNoController = TextEditingController();
  final _dueTimeController = TextEditingController();
  final _inputTitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _subtasksController = TextEditingController();
  String selectedPriority = '1';
  List<String> priorities = ['1', '2', '3'];
  TimeOfDay selectedTime = TimeOfDay.now();
  String inputTitle = '';
  String inputDescription = '';
  String inputSubtasks = '';
  late DateTime? selectedDay = widget.selectedDay;
  final FirebaseService firebaseService = FirebaseService();

  Future<void> _navigateTo(String routeName) async {
    Navigator.pushReplacementNamed(context, routeName);
  }

  void initializeTaskList() async {
    final list = await firebaseService.getTasks();
    List<Task> tasks = [];
    for (var task in list) {
      tasks.add(task);
    }
    print(tasks.length);
    print(tasks);
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
        _dueTimeController.text = _formatTimeOfDay(picked);
      });
    }
  }

  String _formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat("HH:mm");
    return format.format(dt);
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        // _rangeStart = null; // Important to clean those
        // _rangeEnd = null;
        // _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      // print(selectedDay);
      // _selectedEvents.value = _getEventsForDay(selectedDay);
      //print("sel:");
      //print(_selectedEvents.value);
    }
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
        //  content: //SingleChildScrollView(
        //physics: AlwaysScrollableScrollPhysics(),
        // scrollable: true,
        // backgroundColor: Color.fromARGB(255, 163, 204, 120),
        // title: const Text('Edit your task'),
        // content: Padding(
        //   padding: const EdgeInsets.all(20.0),
        child: Container(
      width: 600, // Set the width of the Scaffold
      height: 600, // Set the height of the Scaffold
      //child: SingleChildScrollView(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text('Add Tasks'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Add an Task',
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
                          _inputTitleController, 'Task\'s title'),
                    ),
                    const SizedBox(height: 20.0),
                    FractionallySizedBox(
                      widthFactor: widthFactor,
                      child: buildTextField(
                          _descriptionController, 'Task\'s description'),
                    ),
                    const SizedBox(height: 20.0),
                    FractionallySizedBox(
                      widthFactor: widthFactor,
                      child: buildDropdownButton(),
                    ),
                    const SizedBox(height: 20.0),
                    FractionallySizedBox(
                      widthFactor: widthFactor,
                      child: buildTextField(_subtasksController, 'Subtasks'),
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
                              labelText: 'Due time',
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
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 212, 210, 210),
                        ),
                        child: TableCalendar<Task>(
                          firstDay: kFirstDay,
                          lastDay: kLastDay,
                          focusedDay: _focusedDay,
                          selectedDayPredicate: (day) =>
                              isSameDay(_selectedDay, day),
                          // rangeStartDay: _rangeStart,
                          //rangeEndDay: _rangeEnd,
                          calendarFormat: _calendarFormat,
                          //  rangeSelectionMode: _rangeSelectionMode,
                          // eventLoader: _getEventsForDay,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          calendarStyle: const CalendarStyle(
                            // Use `CalendarStyle` to customize the UI
                            outsideDaysVisible: false,
                          ),
                          onDaySelected: _onDaySelected,
                          // onRangeSelected: _onRangeSelected,
                          onFormatChanged: (format) {
                            if (_calendarFormat != format) {
                              setState(() {
                                _calendarFormat = format;
                              });
                            }
                          },
                          onPageChanged: (focusedDay) {
                            _focusedDay = focusedDay;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    FractionallySizedBox(
                      widthFactor: widthFactor,
                      child: ElevatedButton(
                        onPressed: () {
                          List<String> items = _subtasksController.text
                              .split(',')
                              .map((word) => word.trim())
                              .toList();
                          List<bool> completedSubtsks =
                              List.generate(items.length, (index) => false);
                          Task newTask = Task(
                              '',
                              // selectedDay!.toIso8601String(),
                              _inputTitleController.text,
                              _descriptionController.text,
                              selectedPriority,
                              _selectedDay!.toIso8601String(),
                              selectedTime.toString(),
                              items,
                              completedSubtsks,
                              false);
                          firebaseService.sendTask(newTask);
                          initializeTaskList();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: const Color(0xFFB6D0E2),
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        child: const Text(
                          'Add the Task',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0), ////////////////////////////
                    FractionallySizedBox(
                      widthFactor: widthFactor,
                      child: ElevatedButton(
                        onPressed: () {
                          firebaseService.getTasks();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: const Color(0xFFB6D0E2),
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        child: const Text(
                          'Show Tasks',
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
        // ),
      ),
    ));
    //));
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
