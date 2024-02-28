import 'package:flutter/material.dart';

import 'sticky_note.dart';

class StickyNoteContainer extends StatelessWidget {
  int selectedTileIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
            child: SizedBox(
                width: 300,
                height: 300,
                child: Container(
                    color: Colors.white,
                    child: StickyNote(child: buildList())))));
  }

  Widget buildList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'List Title',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10), // Adjust spacing as needed
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 60.0),
              controller: ScrollController(),
              itemCount: 15,
              itemBuilder: (context, index) {
                Color tileColor = index.isEven
                    ? Color.fromARGB(255, 94, 159, 211)
                    : Color.fromARGB(255, 128, 198, 130);
                return ListTile(
                    title: Text('Item $index'),
                    enabled: true,
                    onTap: () {
                      //  return Row(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           ElevatedButton(
                      //             onPressed: () {
                      //               // Handle the first button action
                      //               print('Button 1 tapped for Item $index');
                      //             },
                      //             child: Text('Button 1'),
                      //           ),
                      //           SizedBox(width: 8.0), // Add spacing between buttons
                      //           ElevatedButton(
                      //             onPressed: () {
                      //               // Handle the second button action
                      //               print('Button 2 tapped for Item $index');
                      //             },
                      //             child: Text('Button 2'),
                      //           ),
                      //         ],
                      //       )
                      //     : null,
                    });
              },
            ),
          ),
        ),
        const SizedBox(height: 20.0),

        FractionallySizedBox(
          child: Builder(
            builder: (BuildContext builderContext) {
              return ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: builderContext, // Use builderContext here
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: const Text('Edit your list'),
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Title',
                                    icon: Icon(Icons.account_box),
                                  ),
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Items',
                                    hintText:
                                        'Write list\'s items separated by a commma',
                                    icon: Icon(Icons.email),
                                  ),
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Due date',
                                    icon: Icon(Icons.message),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            child: Text("Submit"),
                            onPressed: () {
                              // your code
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color(0xFFB6D0E2),
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                ),
                child: const Text(
                  'Edit list',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ),
      ],
    );
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
}
