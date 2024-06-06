//import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:planner_frontend/event/add_event_page.dart';
import 'package:planner_frontend/services/firestore.dart';
import 'package:planner_frontend/services/models.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import 'utils.dart';
import 'edit_event_page.dart';
import '../models/event.dart';
import '../services/firebase_service.dart';
import '../widgets/nav_drawer.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  FirebaseService firebaseService = FirebaseService();
  FirestoreService firestoreService = FirestoreService();

  String selectedOrderType = 'Date';
  List<String> orderTypes = ['Name', 'Priority', 'Time', 'Date'];
  final _wmTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //_onRangeSelected(_rangeStart, _rangeEnd, DateTime.now());
    //_getEventsForRange(_rangeStart!, _rangeEnd!);
    //_rangeSelectionMode.toggleOn;
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    // initializeKEvents();
    // _onDaySelected(DateTime.now(), DateTime.now());
    // print("kevents :");
    // print("init ");
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  // void _navigateTo(String routeName) {
  //   Navigator.pushReplacementNamed(context, routeName);
  // }
  List<Event> sortEvents(List<Event> events, String orderType) {
    switch (orderType) {
      case 'Name':
        events.sort(
            (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
      case 'Priority':
        events.sort((a, b) => a.priority.compareTo(b.priority));
        break;
      case 'Time':
        events.sort((a, b) => a.startTime.compareTo(b.startTime));
        break;
      case 'Date':
        events.sort((a, b) => a.startTime.compareTo(b.day.substring(0, 10)));
        break;
      // Add more cases for additional order types if needed
    }

    return events;
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    // print("kevents :");
    // print(kEvents);

    initializeKEvents();
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      // print(selectedDay);
      _selectedEvents.value = _getEventsForDay(selectedDay);
      //print("sel:");
      //print(_selectedEvents.value);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
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

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthFactor =
        screenSize.width > 800 ? 0.5 : (screenSize.width > 600 ? 0.75 : 0.95);
    print(screenSize.width);
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Events'),
        backgroundColor: Color(0xFF00B4D8),
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: const CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
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
          const SizedBox(height: 15.0),
          Container(
              width: screenSize.width > 800
                  ? screenSize.width / 6
                  : screenSize.width / 3,
              margin: EdgeInsets.only(
                  left: screenSize.width > 800
                      ? widthFactor * 2500
                      : widthFactor * 250),
              child: Align(
                alignment: Alignment.topRight,
                child: buildDropdownButton(_selectedEvents.value),
              )),
          //  ],
          // ),
          const SizedBox(height: 15.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                        color: getColorForPriority(value[index].priority),
                      ),
                      child: ListTile(
                        onTap: () => print("a"),
                        title: Text(
                            '${value[index].title} | Time: ${value[index].startTime.substring(10, 15)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            buildEditButton(value[index], context),
                            SizedBox(width: 8.0), // Add spacing between buttons
                            buildDeleteButton(value[index], context),
                            SizedBox(width: 8.0),
                            buildCheckbox(value[index], context),
                          ],
                        ),
                      ),
                    );
                  },
                );
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
                  return AddEventPage(
                      selectedDay: _selectedDay, screenSize: screenSize);
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
            child: const Icon(Icons.queue_rounded),
            // child: const Text(
            //   'Add event',
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

  Widget buildDropdownButton(List<Event> events) {
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
          sortEvents(events, selectedOrderType);
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

  Widget buildDeleteButton(Event event, BuildContext context) {
    print("event: $event");
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
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              title: Text('Are you sure you want to delete this event?'),
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
                          firebaseService.deleteEvent(event);
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

  Widget buildEditButton(Event event, BuildContext context) {
    // return Builder(
    //   builder: (BuildContext builderContext) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EditEventPage(
                  selectedDay: _selectedDay,
                  event: event); // Your page content goes here
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
  // );

  buildCheckbox(Event event, BuildContext context) {
    return Checkbox(
      value: event.isCompleted,
      onChanged: (bool? value) {
        setState(() {
          event.isCompleted = !event.isCompleted;
          firebaseService.updateEvent(event);
          if (event.isCompleted)
            firestoreService.updateUserNETReport("events", 1);
          else
            firestoreService.updateUserNETReport("events", -1);
          print('Checkbox value:  ${event.isCompleted} ');
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
