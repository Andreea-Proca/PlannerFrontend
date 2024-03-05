import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:planner_frontend/mixinMethods.dart';
import 'package:planner_frontend/services/firebase_service.dart';

import 'models/note.dart';
import 'sticky_note.dart';

class StickyNoteContainer extends StatefulWidget {
  final Note note;
  const StickyNoteContainer({Key? key, required this.note}) : super(key: key);

  @override
  State<StickyNoteContainer> createState() => _StickyNoteContainerState();
}

class _StickyNoteContainerState extends State<StickyNoteContainer> {
  late Note note = widget.note;
  int selectedTileIndex = -1;
  final FirebaseService firebaseService = FirebaseService();
  final _dueDateController = TextEditingController();
  final _inputTitleController = TextEditingController();
  final _itemListController = TextEditingController();
  List<bool> crossedDownList = List.generate(25, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromRGBO(255, 0, 0, 0),
        child: Center(
            child: SizedBox(
                width: 300,
                height: 300,
                child: Container(
                    color: const Color.fromRGBO(255, 0, 0, 0),
                    child: StickyNote(child: buildList())))));
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

  Widget buildList() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          note.title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Due ${note.dueDate}',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 15), // Adjust spacing as needed
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 60.0),
              controller: ScrollController(),
              itemCount: note.items.length,
              itemBuilder: (context, index) {
                Color tileColor = index.isEven
                    ? const Color.fromARGB(255, 94, 159, 211)
                    : const Color.fromARGB(255, 128, 198, 130);
                return ListTile(
                    title: Text(
                      note.items[index],
                      style: TextStyle(
                        decoration: crossedDownList[index]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: crossedDownList[index]
                            ? Colors
                                .grey // You can set a different color when the text is crossed out
                            : Colors.black,
                      ),
                    ),
                    enabled: true,
                    onTap: () {
                      print("TAP");
                      setState(() {
                        crossedDownList[index] = !crossedDownList[index];
                      });
                      print(crossedDownList);
                    });
              },
            ),
          ),
        ),

        const SizedBox(height: 20.0),
        FractionallySizedBox(
          alignment: Alignment.bottomLeft,
          child: Builder(
            builder: (BuildContext builderContext) {
              return ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: builderContext, // Use builderContext here
                    builder: (BuildContext context) {
                      Size screenSize = MediaQuery.of(context).size;
                      double widthFactor = screenSize.width > 800
                          ? 0.5
                          : (screenSize.width > 600 ? 0.75 : 0.95);
                      return AlertDialog(
                        scrollable: true,
                        backgroundColor: Color.fromARGB(255, 163, 204, 120),
                        title: const Text('Edit your list'),
                        content: Padding(
                          padding: const EdgeInsets.all(20.0),
                          // child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 20.0),
                              FractionallySizedBox(
                                widthFactor: widthFactor,
                                child: buildTextField(_inputTitleController,
                                    'Title', '', note.title),
                              ),
                              const SizedBox(height: 20.0),
                              FractionallySizedBox(
                                widthFactor: widthFactor,
                                child: buildTextField(_dueDateController,
                                    'Due date', 'dd/mm/yyyy', note.dueDate),
                              ),
                              const SizedBox(height: 20.0),
                              FractionallySizedBox(
                                widthFactor: widthFactor,
                                child: buildTextField(
                                    _itemListController,
                                    'Items',
                                    'Write list\'s items separated by a commma',
                                    note.items.join(', ')),
                              ),
                              const SizedBox(height: 20.0),
                              FractionallySizedBox(
                                widthFactor: widthFactor,
                                child: ElevatedButton(
                                  onPressed: () {
                                    List<String> items = _itemListController
                                        .text
                                        .split(',')
                                        .map((word) => word.trim())
                                        .toList();
                                    note.title = _inputTitleController.text;
                                    note.dueDate = _dueDateController.text;
                                    note.items = items;
                                    firebaseService.updateNote(note);
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: const Color(0xFFB6D0E2),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                  ),
                                  child: const Text(
                                    'Save the note',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                ),
                child: const Icon(Icons.edit),
              );
            },
          ),
        ),

        const SizedBox(height: 20.0),
        FractionallySizedBox(
          alignment: Alignment.bottomLeft,
          child: Builder(
            builder: (BuildContext builderContext) {
              return ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: builderContext, // Use builderContext here
                    builder: (BuildContext context) {
                      Size screenSize = MediaQuery.of(context).size;
                      double widthFactor = screenSize.width > 800
                          ? 0.5
                          : (screenSize.width > 600 ? 0.75 : 0.95);
                      return AlertDialog(
                        scrollable: true,
                        backgroundColor: Color.fromARGB(255, 163, 204, 120),
                        title:
                            Text('Are you sure you want to delete this note?'),
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
                                    firebaseService.deleteNote(note);
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Color(0xFFB6D0E2),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                  ),
                                  child: const Text(
                                    'Yes',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                  ),
                                  child: const Text(
                                    'No',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                ),
                child: const Icon(Icons.delete),
              );
            },
          ),
        ),
      ],
    );
  }
}
