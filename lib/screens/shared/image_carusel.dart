import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ImageCarusel extends StatelessWidget {
  final List images;

  const ImageCarusel({Key key, this.images}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<CachedNetworkImage> list = [];
    for (int i = 0; i < images.length; i++) {
      list.add(
        CachedNetworkImage(
          imageUrl: images[i],
          fit: BoxFit.fill,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
              child:
                  CircularProgressIndicator(value: downloadProgress.progress)),
          errorWidget: (context, url, error) => Icon(Icons.error),
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
