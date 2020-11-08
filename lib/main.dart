import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/screens/campaign.dart';

import 'blocs/simple_bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WaWinner',
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
    return Campaign();
  }
}
