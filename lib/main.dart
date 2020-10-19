import 'package:flutter/material.dart';
import 'package:flutter_wawinner/screens/auth/LoginPage.dart';
import 'package:flutter_wawinner/screens/auth/RegisterPage.dart';
import 'package:flutter_wawinner/screens/temp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WaWinner(),
    );
  }
}

class WaWinner extends StatefulWidget {
  @override
  _WaWinnerState createState() => _WaWinnerState();
}

class _WaWinnerState extends State<WaWinner> {
  @override
  Widget build(BuildContext context) {
    return Temp();
  }
}
