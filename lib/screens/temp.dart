import 'package:flutter/material.dart';
import 'package:flutter_wawinner/shared/ProductCard.dart';

class Temp extends StatefulWidget {
  @override
  _TempState createState() => _TempState();
}

class _TempState extends State<Temp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            ProductCard()
          ],
        ),
      ),
    );
  }
}
