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
    // Start animation after (default zero)
    delay: Duration(milliseconds: 0),

    // Show each item through (default 250)
    showItemInterval: Duration(milliseconds: 50),

    // Animation duration (default 250)
    showItemDuration: Duration(milliseconds: 500),

    // Animations starts at 0.05 visible
    // item fraction in sight (default 0.025)
    visibleFraction: 0.05,

    // Repeat the animation of the appearance
    // when scrolling in the opposite direction (default false)
    // To get the effect as in a showcase for ListView, set true
    reAnimateOnVisibility: false,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LiveList.options(
        itemCount: 2,
        options: options,
        itemBuilder: (context, index, animation) {
          return CartItem();
        },
      ),
    );
  }
}
