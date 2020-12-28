import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/localization/localization_constants.dart';

class CError extends StatelessWidget {
  final Bloc bloc;
  final dynamic event;

  const CError({Key key, this.bloc, this.event}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var sizeAware = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: sizeAware.width,
          height: sizeAware.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Connection Error',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              FlatButton(
                color: Color.fromRGBO(127, 25, 168, 1.0),
                onPressed: () {
                  bloc.add(event);
                },
                child: Text(
                  'Refresh',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
