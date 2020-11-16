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
  int total_tickets = 0;

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
          total_tickets = 0;
          for (int i = 0; i < items.length; i++) {
            total_price += items[i].total_price;
          }
          for (int i = 0; i < items.length; i++) {
            total_tickets += items[i].campaign.ticket_count * items[i].qty;
          }
          return Scaffold(
            appBar: myAppBar('Shopping Cart', null),
            body: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    cartItems(),
                  ]),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: 100,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Products',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${items.length}',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Coupons',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '$total_tickets',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.02,
                        ),
                        Text(
                          'Donate to recieve an additional Entry',
                          style: TextStyle(
                            color: Color.fromRGBO(127, 25, 168, 1.0),
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.01,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'I agree to donate all purchased products to charity as per " the Draw Terms and Conditions"',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Transform.scale(
                              scale: 2.0,
                              child: Switch(
                                value: is_donated,
                                onChanged: (value) {
                                  setState(() {
                                    is_donated = !is_donated;
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.02,
                        ),
                        Text(
                          'Total',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Price inclusive of VAT',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'AED $total_price',
                              style: TextStyle(
                                color: Color.fromRGBO(127, 25, 168, 1.0),
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (items.length > 0)
                              cartBloc.add(Checkout(
                                  items: items, is_donate: is_donated));
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
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: sizeAware.width,
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                    margin: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      border: Border.symmetric(
                        vertical: BorderSide(
                          color: Colors.blue[100],
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 50,
                        ),
                        SizedBox(
                          width: sizeAware.width * 0.02,
                        ),
                        Expanded(
                          child: Text(
                              'Safe and secure payerijgerijrijments. 100% Authentic products.'),
                        )
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
