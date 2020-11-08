import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wawinner/screens/shared/AppBar.dart';
import 'package:flutter_wawinner/screens/shared/ProductCard.dart';

class Campaign extends StatefulWidget {
  @override
  _CampaignState createState() => _CampaignState();
}

class _CampaignState extends State<Campaign> {
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
      appBar: myAppBar('Campaign', null),
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
