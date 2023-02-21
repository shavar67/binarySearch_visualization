import 'package:flutter/material.dart';
import 'package:visualization/screens/splash_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(),
        child: Introduction(),
      ),
    );
  }
}
