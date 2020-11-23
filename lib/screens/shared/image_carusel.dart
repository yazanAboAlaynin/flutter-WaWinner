import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ImageCarusel extends StatelessWidget {
  final List images;

  const ImageCarusel({Key key, this.images}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<NetworkImage> list = [];
    for (int i = 0; i < images.length; i++) {
      list.add(
        NetworkImage(
          images[i],
        ),
      );
    }
    return Carousel(
      boxFit: BoxFit.contain,
      images: list,
      autoplay: false,
      animationCurve: Curves.fastOutSlowIn,
      autoplayDuration: Duration(
        milliseconds: 10000,
      ),
      animationDuration: Duration(
        milliseconds: 1000,
      ),
      dotSize: 5.0,
      indicatorBgPadding: 5.0,
      dotBgColor: Colors.transparent,
      dotIncreasedColor: Color.fromRGBO(127, 25, 168, 1.0),
    );
  }
}
