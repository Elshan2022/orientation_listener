import 'package:flutter/material.dart';
import 'package:orientation_listener/orientation_listener.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  final OrientationController _controller = OrientationController();
  Orientation _orientation = Orientation.portrait;

  @override
  void initState() {
    super.initState();
    _controller.listen((orientation) {
      setState(() => _orientation = orientation);
      debugPrint('Orientation: $orientation');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OrientationController demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('OrientationController demo')),
        body: Center(
          child: Text(
            'Current orientation:\n${_orientation.name}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }
}
