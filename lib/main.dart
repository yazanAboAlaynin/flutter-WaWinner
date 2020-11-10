import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter_wawinner/repositories/campaign_api.dart';
import 'package:flutter_wawinner/repositories/cart_api.dart';
import 'package:flutter_wawinner/screens/CampaignsPage.dart';
import 'package:flutter_wawinner/screens/CartPage.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants.dart';
import 'blocs/simple_bloc_observer.dart';
import 'package:http/http.dart' as http;

void main() {
  Bloc.observer = SimpleBlocObserver();
  CartApi cartApi = CartApi(httpClient: Client());
  runApp(MyApp(
    cartApi: cartApi,
  ));
}

class MyApp extends StatefulWidget {
  final CartApi cartApi;

  const MyApp({Key key, this.cartApi}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  isLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey('IsLoggedIn') &&
        preferences.getBool('IsLoggedIn')) {
      IsLoggedIn = true;
      EMAIL = preferences.getString('email');
      NAME = preferences.getString('name');
      ADDRESS = preferences.getString('address');
      TOKEN = preferences.getString('token');
    } else {}
  }

  @override
  void initState() {
    super.initState();
    isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WaWinner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
          create: (context) => CartBloc(cartApi: widget.cartApi),
          child: CampaignsPage()),
    );
  }
}
