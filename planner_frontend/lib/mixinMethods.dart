import 'package:flutter/material.dart';

import 'models/note.dart';
import 'services/firebase_service.dart';

mixin SharedMethods {
  //late Note note = widget.note;
  int selectedTileIndex = -1;
  final FirebaseService firebaseService = FirebaseService();
  final _dueDateController = TextEditingController();
  final _inputTitleController = TextEditingController();
  final _itemListController = TextEditingController();

  void sharedMethod() {
    // Your implementation here
  }

  Widget buildTextField(TextEditingController controller, label, hint,
      {bool obscureText = false}) {
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

  Widget buildAddNoteButton() {
    return FractionallySizedBox(
      child: Builder(builder: (BuildContext builderContext) {
        return ElevatedButton(
            onPressed: () {
              showDialog(
                context: builderContext, // Use the correct variable name here
                builder: (BuildContext context) {
                  Size screenSize = MediaQuery.of(context).size;
                  double widthFactor = screenSize.width > 800
                      ? 0.5
                      : (screenSize.width > 600 ? 0.75 : 0.95);

                  return AlertDialog(
                    scrollable: true,
                    backgroundColor: Color.fromARGB(255, 163, 204, 120),
                    title: const Text('Create new list'),
                    content: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 20.0),
                          FractionallySizedBox(
                            widthFactor: widthFactor,
                            child: buildTextField(
                                _inputTitleController, 'Title', ''),
                          ),
                          const SizedBox(height: 20.0),
                          FractionallySizedBox(
                            widthFactor: widthFactor,
                            child: buildTextField(
                                _dueDateController, 'Due date', 'dd/mm/yyyy'),
                          ),
                          const SizedBox(height: 20.0),
                          FractionallySizedBox(
                            widthFactor: widthFactor,
                            child: buildTextField(_itemListController, 'Items',
                                'Write list\'s items separated by a commma'),
                          ),
                          const SizedBox(height: 20.0),
                          FractionallySizedBox(
                            widthFactor: widthFactor,
                            child: ElevatedButton(
                              onPressed: () {
                                List<String> items = _itemListController.text
                                    .split(',')
                                    .map((word) => word.trim())
                                    .toList();
                                Note newNote = Note(
                                    '',
                                    _inputTitleController.text,
                                    items,
                                    _dueDateController.text);
                                firebaseService.sendNote(newNote);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: const Color(0xFFB6D0E2),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                              ),
                              child: const Text(
                                'Save the note',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //),
                    ),
                    // actions: [
                    //   ElevatedButton(
                    //     child: Text("Submit"),
                    //     onPressed: () {
                    //       // Note newNote = Note();
                    //       // firebaseService.sendNote(newNote);
                    //     },
                    //   ),
                    // ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: const Color(0xFFB6D0E2),
              padding: const EdgeInsets.symmetric(vertical: 15.0),
            ),
            child: const Icon(Icons.plus_one_outlined)
            // child: const Text(
            //   'Edit list',
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            );
      }),
    );
  }
}
