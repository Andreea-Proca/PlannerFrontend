import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:planner_frontend/note/mixinMethods.dart';
import 'package:planner_frontend/services/firebase_service.dart';
import 'package:planner_frontend/note/sticky_note.dart';

import '../models/note.dart';
import 'sticky_note_container.dart';
import 'sticky_note_container.dart';
import '../widgets/nav_drawer.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> with SharedMethods {
  final FirebaseService firebaseService = FirebaseService();
  // var notes = [];
  List<Note> notes = [];

  void getNoteList() async {
    final list = await firebaseService.getNotes();
    List<Note> notes = [];
    for (var note in list) {
      notes.add(note);
    }
    print(notes.length);
    print(notes);

    // return notes ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: Color(0xFF00B4D8),
      ),
      body: FutureBuilder<List<Note>>(
        future: firebaseService
            .getNotes(), // Assuming getNoteList returns a Future<List<Note>>
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
            // Use the fetched data to build the UI
            List<Note> notes = snapshot.data!;
            return Stack(
              children: List.generate(
                notes.length,
                (index) => TouchMoveExample(
                  notes[index],
                  index * 50,
                  index * 50,
                  [255, 232, 189, 96],
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: buildAddNoteButton(),
    );
  }

  // Widget buildDropdownButtons() {
  //   return DropdownButton<String>(
  //     value: 'One',
  //     items: <String>['One', 'Two', 'Free', 'Four']
  //         .map<DropdownMenuItem<String>>((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: Text(value),
  //       );
  //     }).toList(),
  //     onChanged: (String? newValue) {
  //       setState(() {
  //         // dropdownValue = newValue!;
  //       });
  //     },
  //   );
  // }
}

class TouchMoveExample extends StatefulWidget {
  final Note note;
  final double x, y;
  final List<int> argb;
  const TouchMoveExample(this.note, this.x, this.y, this.argb, {super.key});

  @override
  State<TouchMoveExample> createState() => _TouchMoveExampleState();
}

class _TouchMoveExampleState extends State<TouchMoveExample> {
  late Note _note = widget.note;
  late double _xPosition = widget.x;
  late double _yPosition = widget.y;
  late List<int> argb = widget.argb;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          width: 400,
          height: 400,
          left: _xPosition,
          top: _yPosition,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _xPosition += details.delta.dx;
                _yPosition += details.delta.dy;
              });
            },
            // child: Container(
            //   width: 200,
            //   height: 200,
            //   color: Color.fromARGB(argb[0], argb[1], argb[2], argb[3]),
            // ),
            child: StickyNoteContainer(note: _note),
          ),
        ),
      ],
    );
  }
}
