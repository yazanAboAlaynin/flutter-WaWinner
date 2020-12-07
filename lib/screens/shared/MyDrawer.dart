import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_wawinner/Constants.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
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
          'Settings',
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
                              'assets/shopping.jpg',
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
                                  'Login',
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
                                  'Register',
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
                        'Cart',
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
                                  'Wish List',
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
                                  child: SvgPicture.asset('assets/coupon.svg'),
                                ),
                                SizedBox(
                                  width: sizeAware.width * 0.04,
                                ),
                                Text(
                                  'Active Coupones',
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
                                  'Payment Options',
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
                                  'Personal Details',
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
                                  'Contact us',
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
                                  'About us',
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
                                  'Logout',
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
                ? InkWell(
                    onTap: () {},
                    child: Container(
                      height: sizeAware.height * 0.08,
                      child: Center(
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: sizeAware.height * 0.04,
                              width: sizeAware.width * 0.1,
                              child: SvgPicture.asset('assets/phone-call.svg'),
                            ),
                            SizedBox(
                              width: sizeAware.width * 0.04,
                            ),
                            Text(
                              'Contact us',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
}
