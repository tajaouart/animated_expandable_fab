import 'package:animated_expandable_fab/animated_expandable_fab.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ExampleExpandableFab(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class ExampleExpandableFab extends StatefulWidget {
  const ExampleExpandableFab({super.key});

  @override
  State<ExampleExpandableFab> createState() => _ExampleExpandableFabState();
}

class _ExampleExpandableFabState extends State<ExampleExpandableFab> {
  final _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];

  String action = 'Choose an action';

  void selectItem(BuildContext context, int index) {
    setState(() {
      action = _actionTitles[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expandable Fab'),
      ),
      body: Center(child: Text(action)),
      floatingActionButton: ExpandableFab(
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: () => selectItem(context, 0),
            child: const Icon(
              Icons.format_size,
              color: Colors.white,
            ),
          ),
          ActionButton(
            onPressed: () => selectItem(context, 1),
            child: const Icon(
              Icons.insert_photo,
              color: Colors.white,
            ),
          ),
          ActionButton(
            onPressed: () => selectItem(context, 2),
            child: const Icon(
              Icons.videocam,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
