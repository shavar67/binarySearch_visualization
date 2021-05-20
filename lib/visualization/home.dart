import 'package:flutter/material.dart';
import 'package:visualization/visualization/visualizer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Binary Search Visualizer",
        ),
      ),
      body: Container(decoration: BoxDecoration(), child: Visualizer()),
    );
  }
}
