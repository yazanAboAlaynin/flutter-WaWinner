import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_event.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_state.dart';
import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:flutter_wawinner/repositories/cart_api.dart';

import 'package:flutter_wawinner/screens/shared/AppBar.dart';
import 'package:flutter_wawinner/screens/shared/CartItemCard.dart';
import 'package:flutter_wawinner/screens/shared/MyDrawer.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> items = [];
  CartApi cartApi = CartApi(httpClient: http.Client());
  CartBloc cartBloc;
  bool is_donated = false;
  int total_price = 0;

  @override
  void initState() {
    super.initState();
    cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.add(CartRequested());
  }

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;

    return BlocBuilder(
      cubit: cartBloc,
      builder: (context, state) {
        if (state is CartLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CartLoadFailure) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CartLoadSuccess) {
          items = state.items;
          total_price = 0;
          for (int i = 0; i < items.length; i++) {
            total_price += items[i].total_price;
          }
          return Scaffold(
            appBar: myAppBar('Shopping Cart', null),
            drawer: Drawer(
              child: MyDrawer(),
            ),
            body: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    cartItems(),
                  ]),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 200,
                    width: 100,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Products'),
                            Text('${items.length}')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Total Coupons'), Text('2')],
                        ),
                        Text('Donate to recieve an additional Entry'),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'I agree to donate all purchased products to charity as per " the Draw Terms and Conditions"',
                              ),
                            ),
                            Switch(
                              value: is_donated,
                              onChanged: (value) {
                                setState(() {
                                  is_donated = !is_donated;
                                });
                              },
                              activeTrackColor: Colors.lightGreenAccent,
                              activeColor: Colors.green,
                            ),
                          ],
                        ),
                        Text('Total'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Price inclusive of VAT'),
                            Text('AED $total_price'),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            cartBloc.add(
                                Checkout(items: items, is_donate: is_donated));
                          },
                          child: Container(
                            width: sizeAware.width * 0.85,
                            height: 45.0,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(127, 25, 168, 1),
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(40),
                                right: Radius.circular(40),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Checkout',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }

  cartItems() {
    List<CartItemCard> itms = [];
    for (int i = 0; i < items.length; i++) {
      itms.add(CartItemCard(
        cartItem: items[i],
      ));
    }
    return Column(
      children: itms,
    );
  }
}
