import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_event.dart';
import 'package:flutter_wawinner/models/cartItem.dart';

class CartItemCard extends StatelessWidget {
  CartItem cartItem;
  CartItemCard({this.cartItem});
  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    final cartBloc = BlocProvider.of<CartBloc>(context);

    return Container(
      width: sizeAware.width,
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 3,
          shadowColor: Colors.grey,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: sizeAware.width,
                    height: sizeAware.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: sizeAware.height,
                            width: sizeAware.width,
                            child: Row(
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      cartItem.campaign.product.image,
                                      width: sizeAware.width * 0.3,
                                      height: sizeAware.width * 0.3,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Product',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                127, 25, 168, 1.0),
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          cartItem.campaign.product.name,
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          cartItem.campaign.product.name,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${cartItem.total_price}',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(127, 25, 168, 1.0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            width: sizeAware.width,
                            height: sizeAware.height,
                            child: Row(
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      cartItem.campaign.prize.image,
                                      width: sizeAware.width * 0.3,
                                      height: sizeAware.width * 0.3,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Prize',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                127, 25, 168, 1.0),
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'Nike Shoe',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          'from boots category',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        cartBloc.add(DeleteItem(id: cartItem.campaign.id));
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.red,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              cartBloc.add(Increase(id: cartItem.campaign.id));
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color.fromRGBO(127, 25, 168, 1.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '${cartItem.qty}',
                          style: TextStyle(fontSize: 24),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              cartBloc.add(Decrease(id: cartItem.campaign.id));
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color.fromRGBO(127, 25, 168, 1.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
