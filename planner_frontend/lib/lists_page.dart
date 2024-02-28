import 'package:flutter/material.dart';
import 'package:planner_frontend/sticky_note.dart';

import 'sticky_note_container.dart';
import 'widgets/nav_drawer.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({Key? key}) : super(key: key);

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: const Text('Move Container on Touch App'),
        ),
        body: //const TouchMoveExample(),
            const Stack(children: [
          TouchMoveExample(0, 0, [255, 96, 184, 232]),
          TouchMoveExample(200, 200, [255, 232, 189, 96]),
        ])
        //TouchMoveExample(500, 0),
        );
  }
}

class TouchMoveExample extends StatefulWidget {
  final double x, y;
  final List<int> argb;
  const TouchMoveExample(this.x, this.y, this.argb, {super.key});

  @override
  State<TouchMoveExample> createState() => _TouchMoveExampleState();
}

class _TouchMoveExampleState extends State<TouchMoveExample> {
  late double _xPosition = widget.x;
  late double _yPosition = widget.y;
  late List<int> argb = widget.argb;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
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
            child: StickyNoteContainer(),
          ),
        ),
      ],
    );
  }
}
