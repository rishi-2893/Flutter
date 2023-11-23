import 'package:flutter/material.dart';

// ex_1 is the name of this project
import 'package:ex_1/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(Color.fromARGB(255, 62, 8, 156), Color.fromARGB(255, 47, 9, 113))
      ),
    ),
  );
}