import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter_wawinner/repositories/campaign_api.dart';
import 'package:flutter_wawinner/repositories/cart_api.dart';
import 'package:flutter_wawinner/screens/AboutUsPage.dart';
import 'package:flutter_wawinner/screens/CampaignsPage.dart';
import 'package:flutter_wawinner/screens/CartPage.dart';
import 'package:flutter_wawinner/screens/ChangePasswordPage.dart';
import 'package:flutter_wawinner/screens/ContactUsPage.dart';
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

import 'localization/localization.dart';
import 'localization/localization_constants.dart';

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
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

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

  Locale _locale;
  void setLocale(locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return Container();
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WaWinner',
        theme: ThemeData(
          primarySwatch: MaterialColor(
            0xFF181861,
            <int, Color>{
              50: Color(0xFFA4A4BF),
              100: Color(0xFFA4A4BF),
              200: Color(0xFFA4A4BF),
              300: Color(0xFF9191B3),
              400: Color(0xFF7F7FA6),
              500: Color(0xFF181861),
              600: Color(0xFF6D6D99),
              700: Color(0xFF5B5B8D),
              800: Color(0xFF494980),
              900: Color(0xFF181861),
            },
          ),
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
          'Change Password': (context) => ChangePasswordPage(),
          'Contact Us': (context) => ContactUsPage(),
          'About Us': (context) => AboutUsPage(),
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
        locale: _locale,
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('ar', 'SA'),
        ],
        localizationsDelegates: [
          Localization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
      );
    }
  }
}
