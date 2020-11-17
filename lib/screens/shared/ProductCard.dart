import 'package:flutter/material.dart';
import 'package:flutter_wawinner/models/product.dart';

class ProductCard extends StatelessWidget {
  Product product;
  ProductCard({this.product});
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
            Container(
              color: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  product.image,
                  width: sizeAware.width * 0.4,
                  height: sizeAware.width * 0.4,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Text(
              product.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
