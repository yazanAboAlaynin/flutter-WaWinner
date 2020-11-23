import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter_wawinner/repositories/campaign_api.dart';
import 'package:flutter_wawinner/repositories/cart_api.dart';
import 'package:flutter_wawinner/screens/CampaignsPage.dart';
import 'package:flutter_wawinner/screens/CartPage.dart';
import 'package:flutter_wawinner/screens/ProductDetail.dart';
import 'package:flutter_wawinner/screens/ProfilePage.dart';
import 'package:flutter_wawinner/screens/WishListPage.dart';
import 'package:flutter_wawinner/screens/auth/LoginPage.dart';
import 'package:flutter_wawinner/screens/auth/RegisterPage.dart';
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
      FIRST_NAME = preferences.getString('first_name');
      LAST_NAME = preferences.getString('last_name');
      ADDRESS = preferences.getString('address');
      IMAGE = preferences.getString('image');
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
      initialRoute: 'Campaignes',
      routes: {
        'Campaignes': (context) => BlocProvider(
            create: (context) => CartBloc(cartApi: widget.cartApi),
            child: CampaignsPage()),
        'Campaign Detailes': (context) => BlocProvider(
            create: (context) => CartBloc(cartApi: widget.cartApi),
            child: ProductDetail()),
        'Login': (context) => LoginPage(),
        'Register': (context) => RegisterPage(),
        'Profile': (context) => ProfilePage(),
        'Cart': (context) => BlocProvider(
            create: (context) => CartBloc(cartApi: widget.cartApi),
            child: CartPage()),
        'Wishlist': (context) => BlocProvider(
            create: (context) => CartBloc(cartApi: widget.cartApi),
            child: WishListPage()),
      },
    );
  }
}
