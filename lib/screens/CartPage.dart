import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc.dart/cart_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc.dart/cart_event.dart';
import 'package:flutter_wawinner/blocs/cart_bloc.dart/cart_state.dart';
import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:flutter_wawinner/repositories/cart_api.dart';

import 'package:flutter_wawinner/screens/shared/AppBar.dart';
import 'package:flutter_wawinner/screens/shared/CartItemCard.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> items = [];
  CartApi cartApi = CartApi(httpClient: http.Client());
  CartBloc cartBloc;

  @override
  void initState() {
    super.initState();
    cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.add(CartRequested());
  }

  @override
  Widget build(BuildContext context) {
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
                    height: 200,
                    width: 100,
                    color: Colors.red,
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
