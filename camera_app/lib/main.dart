import 'package:flutter/material.dart';
import 'camera_local.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One Button App',
      home: Scaffold(
        appBar: AppBar(title: const Text('One Button UI')),
        body: const Center(child: MyButton()),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Action when button is pressed
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FullScreenCameraRecorder()),
        );
      },
      child: const Text('Click Me'),
    );
  }
}
