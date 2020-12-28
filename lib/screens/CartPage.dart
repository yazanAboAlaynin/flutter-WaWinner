import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_event.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_state.dart';
import 'package:flutter_wawinner/localization/localization_constants.dart';
import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:flutter_wawinner/repositories/cart_api.dart';

import 'package:flutter_wawinner/widgets/AppBar.dart';
import 'package:flutter_wawinner/widgets/CartItemCard.dart';
import 'package:flutter_wawinner/widgets/Loading.dart';
import 'package:flutter_wawinner/widgets/error.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  bool is_valid = false;
  double total_price = 0;
  int total_tickets = 0;
  int total_products = 0;

  TextEditingController codeTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.add(CartRequested());
  }

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;

    return BlocListener(
      cubit: cartBloc,
      listener: (context, state) {
        if (state is CouponNotValid) {
          Fluttertoast.showToast(
              msg: getTranslated(context, "Coupon is not valid"),
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Color.fromRGBO(127, 25, 168, 1.0),
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: BlocBuilder(
        cubit: cartBloc,
        builder: (context, state) {
          if (state is CartLoadInProgress) {
            return Loading();
          }
          if (state is CartLoadFailure) {
            return CError(
              bloc: cartBloc,
              event: CartRequested(),
            );
          }
          if (state is CartLoadSuccess ||
              state is CouponValid ||
              state is CouponNotValid) {
            if (state is CartLoadSuccess) items = state.items;
            if (state is CouponValid) is_valid = true;

            total_price = 0;
            total_tickets = 0;
            total_products = 0;
            for (int i = 0; i < items.length; i++) {
              total_price += items[i].total_price;
              total_products += items[i].qty;
            }
            for (int i = 0; i < items.length; i++) {
              total_tickets += items[i].campaign.ticket_count * items[i].qty;
              int n = items[i].qty;
              for (int j = 0; j < items[i].campaign.offers.length; j++) {
                int temp = (n ~/ items[i].campaign.offers[j].product_limit);
                n -= temp * items[i].campaign.offers[j].product_limit;

                total_tickets +=
                    temp * items[i].campaign.offers[j].extra_ticket_count;
              }
            }
            if (is_valid) {
              total_tickets++;
              if (is_donated) total_tickets++;
            }

            return Scaffold(
              appBar: myAppBar(getTranslated(context, 'Shopping Cart'), null),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                getTranslated(context, 'Total Products'),
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${total_products}',
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
                                getTranslated(context, 'Total Coupons'),
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
                            getTranslated(context,
                                'Donate to recieve an additional Entry'),
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
                                  getTranslated(context,
                                      'I agree to donate all purchased products to charity as per  the Draw Terms and Conditions'),
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
                            getTranslated(context, 'Total'),
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
                                getTranslated(
                                    context, 'Price inclusive of VAT'),
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
                          Center(
                            child: Container(
                              height: 45,
                              width: sizeAware.width * 0.85,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: sizeAware.height,
                                      decoration: BoxDecoration(
                                        borderRadius: LANGUAGE == 'ar'
                                            ? BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(30),
                                                topRight: Radius.circular(30),
                                              )
                                            : BorderRadius.only(
                                                bottomLeft: Radius.circular(30),
                                                topLeft: Radius.circular(30),
                                              ),
                                        color: Colors.grey[400],
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 2,
                                      ),
                                      child: TextFormField(
                                        enabled: !is_valid,
                                        controller: codeTextEditingController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Code',
                                          border: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (codeTextEditingController
                                                  .text.length >
                                              0 &&
                                          !is_valid) {
                                        cartBloc.add(CheckCoupon(
                                            coupon: codeTextEditingController
                                                .text));
                                      }
                                    },
                                    child: Container(
                                      height: sizeAware.height,
                                      decoration: BoxDecoration(
                                        borderRadius: LANGUAGE == 'en'
                                            ? BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(30),
                                                topRight: Radius.circular(30),
                                              )
                                            : BorderRadius.only(
                                                bottomLeft: Radius.circular(30),
                                                topLeft: Radius.circular(30),
                                              ),
                                        color: is_valid
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 2,
                                      ),
                                      child: Center(
                                        child: is_valid
                                            ? Icon(Icons.check)
                                            : Text(
                                                getTranslated(context, 'Check'),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: sizeAware.height * 0.03,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (items.length > 0)
                                cartBloc.add(Checkout(
                                    items: items,
                                    is_donate: is_donated,
                                    coupon: codeTextEditingController.text));
                            },
                            child: Center(
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
                                        getTranslated(context, 'Checkout'),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      width: sizeAware.width,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 12),
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
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: sizeAware.width * 0.02,
                          ),
                          Expanded(
                            child: Text(getTranslated(
                              context,
                              'Safe and secure payments. 100% Authentic products.',
                            )),
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
      ),
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
