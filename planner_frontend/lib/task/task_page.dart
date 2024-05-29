//import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:planner_frontend/event/add_event_page.dart';
import 'package:planner_frontend/models/task.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../event/utils.dart';
import 'add_task.dart';
import 'edit_task.dart';
import '../models/task.dart';
import '../services/firebase_service.dart';
import '../widgets/nav_drawer.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  // late ValueNotifier<List<Task>> _selectedTasks;
  // CalendarFormat _calendarFormat = CalendarFormat.month;
  // RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
  //     .toggledOff; // Can be toggled on/off by longpressing a date
  // DateTime _focusedDay = DateTime.now();
  // DateTime? _selectedDay;
  // DateTime? _rangeStart;
  // DateTime? _rangeEnd;
  FirebaseService firebaseService = FirebaseService();

  String selectedOrderType = 'DueTime';
  List<String> orderTypes = ['Title', 'Priority', 'DueTime'];
  final _wmTypeController = TextEditingController();
  List<Task> tasks = [];
  //List<String> subtasks = [];
  // List<bool> showSubtasks = [];
  List<bool> showSubtasks = List.generate(100, (index) => false);
  //List.generate(subtasks.length, (index) => false);

  @override
  void initState() {
    super.initState();
    // _selectedDay = _focusedDay;
    //_selectedTasks = ValueNotifier(_getTasks());
    initializeTaskList();
  }

  // List<Task> _getTasks() {
  //   initializeTaskList();
  //   return tasks ?? [];
  // }

  void initializeTaskList() async {
    final list = await firebaseService.getTasks();
    List<Task> tasks = [];
    for (var task in list) {
      tasks.add(task);
    }
    print(tasks.length);
    print(tasks);
  }

  // @override
  // void dispose() {
  //   _selectedTasks.dispose();
  //   super.dispose();
  // }

  // void _navigateTo(String routeName) {
  //   Navigator.pushReplacementNamed(context, routeName);
  // }
  List<Task> sortTasks(List<Task> tasks, String orderType) {
    switch (orderType) {
      case 'Title':
        tasks.sort(
            (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
      case 'Priority':
        tasks.sort((a, b) => a.priority.compareTo(b.priority));
        break;
      case 'DueTime':
        tasks.sort((a, b) => a.dueTime.compareTo(b.dueTime));
        break;
      // case 'DueDate':
      //   tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate.substring(0, 10)));
      //   break;
      // Add more cases for additional order types if needed
    }
    return tasks;
  }

  Color getColorForPriority(String priority) {
    switch (priority) {
      case '1':
        return const Color.fromARGB(
            255, 238, 100, 90); // Set the color for 'High' priority
      case '2':
        return const Color.fromARGB(
            255, 246, 232, 112); // Set the color for 'Medium' priority
      case '3':
        return Color.fromARGB(
            255, 119, 209, 122); // Set the color for 'Low' priority
      default:
        return Colors.blue; // Default color or any fallback color
    }
  }

  Color getColorForPrioritySubtasks(String priority) {
    switch (priority) {
      case '1':
        return Color.fromARGB(
            255, 244, 155, 148); // Set the color for 'High' priority
      case '2':
        return Color.fromARGB(
            255, 249, 241, 172); // Set the color for 'Medium' priority
      case '3':
        return Color.fromARGB(
            255, 172, 215, 174); // Set the color for 'Low' priority
      default:
        return Colors.blue; // Default color or any fallback color
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthFactor =
        screenSize.width > 800 ? 0.5 : (screenSize.width > 600 ? 0.75 : 0.95);

    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Tasks'),
        backgroundColor: Color.fromARGB(255, 81, 164, 205),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30.0),
          Row(
            children: [
              SizedBox(height: 0.0, width: widthFactor * 3000),
              SizedBox(
                // widthFactor: widthFactor / 6,
                //alignment: Alignment.topRight,
                width: widthFactor * 250,
                child: buildDropdownButton(tasks),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: firebaseService.getTasks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator while data is being fetched
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // Show an error message if data fetching fails
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // Show a message if no data is available
                  return Text('No notes available.');
                } else {
                  List<Task> tasks = snapshot.data!;
                  //showSubtasks = List.generate(tasks.length, (index) => false);
                  tasks = sortTasks(tasks, selectedOrderType);
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12.0),
                                color:
                                    getColorForPriority(tasks[index].priority),
                              ),
                              child: ListTile(
                                onTap: () {
                                  print("TAP");
                                },
                                title: Text(
                                  '${tasks[index].title} | Due date & time: ${tasks[index].dueDate.substring(0, 10)}, ${tasks[index].dueTime.substring(10, 15)}',
                                  // style: TextStyle(
                                  //     decoration:
                                  //         tasks[index].completedSubtasks[index]
                                  //             ? TextDecoration.lineThrough
                                  //             : TextDecoration.none,
                                  //     color: tasks[index]
                                  //             .completedSubtasks[index]
                                  //         ? Colors
                                  //             .grey // You can set a different color when the text is crossed out
                                  //         : Colors.black,
                                  //     fontSize: 17,
                                  //     fontWeight: FontWeight.bold),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    buildEditButton(tasks[index], context),
                                    SizedBox(width: 8.0),
                                    buildDeleteButton(tasks[index], context),
                                    SizedBox(width: 8.0),
                                    buildShowSubtasksButton(
                                        tasks[index], index, context),
                                    SizedBox(width: 8.0),
                                    buildCheckbox(tasks[index], context),
                                    // Checkbox(
                                    //   value: tasks[index].isCompleted,
                                    //   onChanged: (bool? value) {
                                    //     setState(() {
                                    //       tasks[index].isCompleted =
                                    //           !tasks[index].isCompleted;
                                    //       firebaseService
                                    //           .updateTask(tasks[index]);
                                    //       print(
                                    //           'Checkbox value:  ${tasks[index].isCompleted} ');
                                    //     });
                                    //   },
                                    //   activeColor: Colors.blue,
                                    //   checkColor: Colors.white,
                                    //   fillColor: MaterialStateProperty
                                    //       .resolveWith<Color>(
                                    //     (Set<MaterialState> states) {
                                    //       if (states.contains(
                                    //           MaterialState.hovered)) {
                                    //         return Colors.blue.withOpacity(0.5);
                                    //       }
                                    //       if (states.contains(
                                    //           MaterialState.selected)) {
                                    //         return Colors.blue.withOpacity(
                                    //             1); // Color when checked
                                    //       }
                                    //       return Colors.transparent;
                                    //     },
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            ///////////////////////////////////////////SUBTASKS
                            if (showSubtasks[index] == true)
                              buildSubtasks(tasks[index], index, context)
                            else
                              Container(
                                child: Text("gol"),
                              ),
                          ]);
                    },
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: // () => _navigateTo('/booking'),
                () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddTaskPage(); // Your page content goes here
                },
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: const Color.fromARGB(255, 55, 151, 221),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
            ),
            child: const Icon(Icons.add_task_outlined),
            // child: const Text(
            //   'Add task',
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdownButton(List<Task> tasks) {
    return DropdownButtonFormField<String>(
      alignment: Alignment.topRight,
      value: selectedOrderType,
      decoration: const InputDecoration(
        labelText: 'Order by',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(),
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedOrderType = newValue!;
          _wmTypeController.text = newValue;
          sortTasks(tasks, selectedOrderType);
        });
      },
      items: orderTypes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget buildDeleteButton(Task task, BuildContext context) {
    print("Task: $task");
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context, // Use builderContext here
          builder: (BuildContext context) {
            Size screenSize = MediaQuery.of(context).size;
            double widthFactor = screenSize.width > 800
                ? 0.5
                : (screenSize.width > 600 ? 0.75 : 0.95);
            return AlertDialog(
              scrollable: true,
              backgroundColor: Color.fromARGB(255, 161, 197, 123),
              title: Text('Are you sure you want to delete this task?'),
              content: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20.0),
                    FractionallySizedBox(
                      widthFactor: widthFactor,
                      child: ElevatedButton(
                        onPressed: () {
                          firebaseService.deleteTask(task);
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Color(0xFFB6D0E2),
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        child: const Text(
                          'Yes',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    FractionallySizedBox(
                      widthFactor: widthFactor,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: const Color(0xFFB6D0E2),
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        child: const Text(
                          'No',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: const Color(0xFFB6D0E2),
        padding: const EdgeInsets.symmetric(vertical: 5.0),
      ),
      child: const Icon(Icons.delete),
    );
  }

  Widget buildEditButton(Task task, BuildContext context) {
    // return Builder(
    //   builder: (BuildContext builderContext) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EditTaskPage(task: task); // Your page content goes here
            },
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: const Color(0xFFB6D0E2),
          padding: const EdgeInsets.symmetric(vertical: 15.0),
        ),
        child: const Icon(Icons.edit));
  }

  Widget buildShowSubtasksButton(Task task, int index, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          // Toggle the visibility of subtasks for the task
          showSubtasks[index] = !showSubtasks[index];
          print(showSubtasks);
        });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: const Color(0xFFB6D0E2),
        padding: const EdgeInsets.symmetric(vertical: 5.0),
      ),
      child: showSubtasks[index] == true
          ? const Icon(Icons.arrow_drop_up_rounded)
          : const Icon(Icons.arrow_drop_down_rounded),
    );
  }

  Widget buildSubtasks(Task task, int index, BuildContext context) {
    print(showSubtasks[index]);
    return Container(
      alignment: Alignment.topRight,
      // width: 400,
      height: showSubtasks[index] ? 200 : 0,
      //height: 200,
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 100),
      margin: const EdgeInsets.symmetric(
        horizontal: 500.0,
        vertical: 4.0,
      ),
      child: ListView.builder(
          itemCount: task.subtasks.length,
          itemBuilder: (context, indexSubtasks) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 4.0,
              ),
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12.0),
                color: getColorForPrioritySubtasks(task.priority),
              ),
              child: ListTile(
                onTap: () {
                  print("TAP S");
                  setState(() {
                    task.completedSubtasks[indexSubtasks] =
                        !task.completedSubtasks[indexSubtasks];
                    firebaseService.updateTask(task);
                  });
                  print(task.completedSubtasks);
                },
                title: Text(
                  '${task.subtasks[indexSubtasks]}',
                  style: TextStyle(
                      decoration: task.completedSubtasks[indexSubtasks]
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: task.completedSubtasks[indexSubtasks]
                          ? Colors
                              .grey // You can set a different color when the text is crossed out
                          : Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  // children: [
                  //   buildEditButton(tasks[index], context),
                  //   SizedBox(
                  //       width:
                  //           8.0), // Add spacing between buttons
                  //   buildDeleteButton(tasks[index], context),
                  //   SizedBox(width: 8.0),
                  //   buildShowSubtasksButton(
                  //       tasks[index], index, context),
                  // ],
                ),
              ),
            );
          }),
    );
  }

  buildCheckbox(Task task, BuildContext context) {
    return Checkbox(
      value: task.isCompleted,
      onChanged: (bool? value) {
        setState(() {
          task.isCompleted = !task.isCompleted;
          firebaseService.updateTask(task);
          print('Checkbox value:  ${task.isCompleted} ');
        });
      },
      activeColor: Colors.blue,
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return Colors.blue.withOpacity(0.5);
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.blue.withOpacity(1); // Color when checked
          }
          return Colors.transparent;
        },
      ),
    );
  }
}
