import 'package:flutter/material.dart';
import 'package:flutter_wawinner/models/charity.dart';

class CharityCard extends StatelessWidget {
  final Charity charity;

  const CharityCard({Key key, this.charity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;

    return Container(
      width: sizeAware.width,
      height: sizeAware.height * 0.3,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Image.network(
        charity.image,
        fit: BoxFit.cover,
        height: sizeAware.height * 0.3,
      ),
    );
  }
}
