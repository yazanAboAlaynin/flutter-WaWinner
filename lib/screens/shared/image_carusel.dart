import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ImageCarusel extends StatelessWidget {
  final List images;

  const ImageCarusel({Key key, this.images}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<AssetImage> list = [];
    for (int i = 0; i < images.length; i++) {
      list.add(
        AssetImage(
          images[i],
        ),
      );
    }
    return Carousel(
      boxFit: BoxFit.cover,
      images: list,
      autoplay: true,
      animationCurve: Curves.fastOutSlowIn,
      autoplayDuration: Duration(
        milliseconds: 10000,
      ),
      animationDuration: Duration(
        milliseconds: 1000,
      ),
      dotSize: 5.0,
      indicatorBgPadding: 5.0,
      dotBgColor: Colors.black,
      dotIncreasedColor: Colors.red,
    );
  }
}
