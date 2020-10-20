import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wawinner/shared/CartItem.dart';
import 'package:flutter_wawinner/shared/ProductCard.dart';
import 'package:flutter_wawinner/shared/WLCard.dart';

class Temp extends StatefulWidget {
  @override
  _TempState createState() => _TempState();
}

class _TempState extends State<Temp> {
  final options = LiveOptions(
    delay: Duration(milliseconds: 0),
    showItemInterval: Duration(milliseconds: 50),
    showItemDuration: Duration(milliseconds: 500),
    visibleFraction: 0.05,
    reAnimateOnVisibility: false,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LiveList.options(
        itemCount: 8,
        options: options,
        itemBuilder: (context, index, animation) {
          return ProductCard(
            animation: animation,
          );
        },
      ),
    );
  }
}
