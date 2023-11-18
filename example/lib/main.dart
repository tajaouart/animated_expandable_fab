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
  final _titles = ['Create Post', 'Upload Photo', 'Upload Video'];
  final _icons = [Icons.format_size, Icons.insert_photo, Icons.videocam];

  String action = 'Choose an action';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expandable Fab'),
      ),
      body: Center(child: Text(action)),
      floatingActionButton: ExpandableFab(
        closeBackgroundColor: Colors.white,
        closeShadowColor: Colors.grey,
        closeElevation: 5,
        openElevation: 4,
        distance: 100.0,
        closeIcon: const Icon(
          Icons.close,
          color: Colors.blue,
        ),
        openIcon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        children: List.generate(_titles.length, (index) {
          return ActionButton(
            onPressed: () => setState(() {
              action = _titles[index];
            }),
            closeFabOnTap: true,
            text: Padding(
              padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
              child: Text(
                _titles[index],
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            icon: Icon(
              _icons[index],
              color: Colors.white,
            ),
          );
        }),
      ),
    );
  }
}
