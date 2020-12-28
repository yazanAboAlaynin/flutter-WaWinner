import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

Widget myAppBar(title, actions) {
  return AppBar(
    title: Text(title),
    actions: actions,
    shape: continuousRectangleBorder,
    centerTitle: true,
    backgroundColor: Color.fromRGBO(127, 25, 168, 1.0),
  );
}

ContinuousRectangleBorder continuousRectangleBorder = ContinuousRectangleBorder(
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(25),
    bottomRight: Radius.circular(25),
  ),
);
