import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;

    return Container(
      width: sizeAware.width * 0.4,
      height: sizeAware.height * 0.35,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/shopping.jpg',
                width: sizeAware.width * 0.4,
                height: sizeAware.width * 0.4,
                fit: BoxFit.fill,
              ),
            ),
            Text('name here'),
          ],
        ),
      ),
    );
  }
}
