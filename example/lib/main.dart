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
        distance: 100.0,
        closeIcon: const Icon(
          Icons.close,
          color: Colors.blue,
        ),
        openIcon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        children: [
          ActionButton(
            onPressed: () => selectItem(context, 0),
            closeFabOnTap: true,
            child: const Icon(
              Icons.format_size,
              color: Colors.white,
            ),
          ),
          ActionButton(
            text: "Hello",
            onPressed: () => selectItem(context, 1),
            closeFabOnTap: true,
            child: const Icon(
              Icons.insert_photo,
              color: Colors.white,
            ),
          ),
          ActionButton(
            onPressed: () => selectItem(context, 2),
            closeFabOnTap: true,
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
