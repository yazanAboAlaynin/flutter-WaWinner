import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_wawinner/localization/localization_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_wawinner/Constants.dart';

import '../main.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String prefLang = "EN";

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop(context);
            },
            child: Icon(Icons.close)),
        title: Text(
          getTranslated(context, 'Settings'),
        ),
        backgroundColor: Color.fromRGBO(127, 25, 168, 1.0),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Container(
              height: sizeAware.height * 0.16,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: IsLoggedIn
                          ? NetworkImage(
                              IMAGE,
                            )
                          : AssetImage(
                              'assets/waw.png',
                            ),
                    ),
                    SizedBox(width: sizeAware.width * 0.04),
                    Text(
                      IsLoggedIn ? FIRST_NAME : 'WaWinner',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: sizeAware.height * 0.01,
              color: Colors.black26,
              thickness: 0.7,
            ),
            !IsLoggedIn
                ? Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'Login');
                        },
                        child: Container(
                          height: sizeAware.height * 0.08,
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: sizeAware.height * 0.04,
                                  width: sizeAware.width * 0.1,
                                  child: SvgPicture.asset('assets/login.svg'),
                                ),
                                SizedBox(
                                  width: sizeAware.width * 0.04,
                                ),
                                Text(
                                  getTranslated(context, 'Login'),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: sizeAware.height * 0.01,
                        color: Colors.black26,
                        thickness: 0.7,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'Register');
                        },
                        child: Container(
                          height: sizeAware.height * 0.08,
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: sizeAware.height * 0.04,
                                  width: sizeAware.width * 0.1,
                                  child:
                                      SvgPicture.asset('assets/register.svg'),
                                ),
                                SizedBox(
                                  width: sizeAware.width * 0.04,
                                ),
                                Text(
                                  getTranslated(context, 'Register'),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: sizeAware.height * 0.01,
                        color: Colors.black26,
                        thickness: 0.7,
                      ),
                    ],
                  )
                : Container(),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'Cart');
              },
              child: Container(
                height: sizeAware.height * 0.08,
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: sizeAware.height * 0.04,
                        width: sizeAware.width * 0.1,
                        child: SvgPicture.asset('assets/shopping-cart.svg'),
                      ),
                      SizedBox(
                        width: sizeAware.width * 0.04,
                      ),
                      Text(
                        getTranslated(context, 'Cart'),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              height: sizeAware.height * 0.01,
              color: Colors.black26,
              thickness: 0.7,
            ),
            IsLoggedIn
                ? Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'Wishlist');
                        },
                        child: Container(
                          height: sizeAware.height * 0.08,
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: sizeAware.height * 0.04,
                                  width: sizeAware.width * 0.1,
                                  child: SvgPicture.asset('assets/heart.svg'),
                                ),
                                SizedBox(
                                  width: sizeAware.width * 0.04,
                                ),
                                Text(
                                  getTranslated(context, 'Wish List'),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: sizeAware.height * 0.01,
                        color: Colors.black26,
                        thickness: 0.7,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'Orders');
                        },
                        child: Container(
                          height: sizeAware.height * 0.08,
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: sizeAware.height * 0.04,
                                  width: sizeAware.width * 0.1,
                                  child: SvgPicture.asset('assets/coupon.svg'),
                                ),
                                SizedBox(
                                  width: sizeAware.width * 0.04,
                                ),
                                Text(
                                  getTranslated(context, 'My Orders'),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: sizeAware.height * 0.01,
                        color: Colors.black26,
                        thickness: 0.7,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'Tickets');
                        },
                        child: Container(
                          height: sizeAware.height * 0.08,
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: sizeAware.height * 0.04,
                                  width: sizeAware.width * 0.1,
                                  child: SvgPicture.asset('assets/coupon.svg'),
                                ),
                                SizedBox(
                                  width: sizeAware.width * 0.04,
                                ),
                                Text(
                                  getTranslated(context, 'Active Coupones'),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: sizeAware.height * 0.01,
                        color: Colors.black26,
                        thickness: 0.7,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: sizeAware.height * 0.08,
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: sizeAware.height * 0.04,
                                  width: sizeAware.width * 0.1,
                                  child: SvgPicture.asset(
                                      'assets/credit-card.svg'),
                                ),
                                SizedBox(
                                  width: sizeAware.width * 0.04,
                                ),
                                Text(
                                  getTranslated(context, 'Payment Options'),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: sizeAware.height * 0.01,
                        color: Colors.black26,
                        thickness: 0.7,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'Profile');
                        },
                        child: Container(
                          height: sizeAware.height * 0.08,
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: sizeAware.height * 0.04,
                                  width: sizeAware.width * 0.1,
                                  child: SvgPicture.asset('assets/user.svg'),
                                ),
                                SizedBox(
                                  width: sizeAware.width * 0.04,
                                ),
                                Text(
                                  getTranslated(context, 'Personal Details'),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: sizeAware.height * 0.01,
                        color: Colors.black26,
                        thickness: 0.7,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'Contact Us');
                        },
                        child: Container(
                          height: sizeAware.height * 0.08,
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: sizeAware.height * 0.04,
                                  width: sizeAware.width * 0.1,
                                  child:
                                      SvgPicture.asset('assets/phone-call.svg'),
                                ),
                                SizedBox(
                                  width: sizeAware.width * 0.04,
                                ),
                                Text(
                                  getTranslated(context, 'Contact us'),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: sizeAware.height * 0.01,
                        color: Colors.black26,
                        thickness: 0.7,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'About Us');
                        },
                        child: Container(
                          height: sizeAware.height * 0.08,
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: sizeAware.height * 0.04,
                                  width: sizeAware.width * 0.1,
                                  child: Icon(
                                    Icons.info,
                                    size: 30,
                                    color: Color.fromRGBO(127, 25, 168, 1.0),
                                  ),
                                ),
                                SizedBox(
                                  width: sizeAware.width * 0.04,
                                ),
                                Text(
                                  getTranslated(context, 'About us'),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: sizeAware.height * 0.01,
                        color: Colors.black26,
                        thickness: 0.7,
                      ),
                      InkWell(
                        onTap: () async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();

                          await sharedPreferences.setBool('IsLoggedIn', false);
                          await sharedPreferences.remove('wishlist');
                          await sharedPreferences.setString(
                              'wishlist', jsonEncode([]));
                          setState(() {
                            IsLoggedIn = false;
                          });
                        },
                        child: Container(
                          height: sizeAware.height * 0.08,
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: sizeAware.height * 0.04,
                                  width: sizeAware.width * 0.1,
                                  child: SvgPicture.asset("assets/logout.svg"),
                                ),
                                SizedBox(
                                  width: sizeAware.width * 0.04,
                                ),
                                Text(
                                  getTranslated(context, 'Logout'),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : Container(),
            !IsLoggedIn
                ? Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: sizeAware.height * 0.08,
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: sizeAware.height * 0.04,
                                  width: sizeAware.width * 0.1,
                                  child:
                                      SvgPicture.asset('assets/phone-call.svg'),
                                ),
                                SizedBox(
                                  width: sizeAware.width * 0.04,
                                ),
                                Text(
                                  getTranslated(context, 'Contact us'),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: sizeAware.height * 0.01,
                        color: Colors.black26,
                        thickness: 0.7,
                      ),
                      Container(
                        width: sizeAware.width,
                        height: sizeAware.height * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 0),
                            child: DropdownButton<String>(
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Color.fromRGBO(127, 25, 168, 1.0),
                              ),
                              isExpanded: true,
                              underline: SizedBox(),
                              items: [
                                DropdownMenuItem<String>(
                                  value: "ar",
                                  child: Text(
                                    "العربية",
                                    style: TextStyle(fontFamily: 'GeSS'),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: "en",
                                  child: Text(
                                    "english",
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                if (value == "en") {
                                  setState(() {
                                    prefLang = "english";
                                  });
                                } else {
                                  setState(() {
                                    prefLang = value;
                                  });
                                }

                                changeLanguage(value);
                              },
                              hint: Text(
                                'Preferred language',
                                // "${getTranslated(context, "Preferred Language")}:     ${pharmacy.pref_lang}",
                                style: TextStyle(fontFamily: 'GeSS'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
            Divider(
              height: sizeAware.height * 0.01,
              color: Colors.black26,
              thickness: 0.7,
            ),
          ],
        ),
      ),
    );
  }

  void changeLanguage(languageCode) async {
    Locale temp = await setLocale(languageCode);
    MyApp.setLocale(context, temp);
  }
}
