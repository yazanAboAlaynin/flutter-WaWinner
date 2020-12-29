import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_event.dart';
import 'package:flutter_wawinner/blocs/wishlist_bloc/wl_bloc.dart';
import 'package:flutter_wawinner/blocs/wishlist_bloc/wl_event.dart' as wl;
import 'package:flutter_wawinner/localization/localization_constants.dart';
import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class WLCard extends StatelessWidget {
  Campaign campaign;
  WLBloc wlBloc;
  WLCard({this.campaign, this.wlBloc});
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
                                      campaign.product.image,
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
                                          getTranslated(context, 'Product'),
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                127, 25, 168, 1.0),
                                            fontSize: 17,
                                            height: 1.5,
                                          ),
                                        ),
                                        Text(
                                          campaign.product.name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            height: 1.5,
                                          ),
                                        ),
                                        Text(
                                          'from boots category',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                            height: 1.5,
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
                              'AED ${campaign.price}',
                              style: TextStyle(
                                fontSize: 20,
                                height: 1.5,
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
                                      campaign.prize.image,
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
                                          getTranslated(context, 'Prize'),
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                127, 25, 168, 1.0),
                                            fontSize: 17,
                                            height: 1.5,
                                          ),
                                        ),
                                        Text(
                                          campaign.prize.name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            height: 1.5,
                                          ),
                                        ),
                                        Text(
                                          campaign.prize.name,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                            height: 1.5,
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        cartBloc.add(
                          AddItem(
                            cartItem: CartItem(
                              campaign: campaign,
                              qty: 1,
                              total_price: 1 * campaign.price,
                            ),
                          ),
                        );
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
                            Icons.add_shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        wlBloc.add(wl.AddItem(item: campaign));
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
                    Container(
                      width: sizeAware.width * 0.25,
                      height: sizeAware.width * 0.25,
                      child: CircularStepProgressIndicator(
                        totalSteps: campaign.product_quantity,
                        currentStep: campaign.quantity_sold,
                        stepSize: 10,
                        selectedColor: Color.fromRGBO(127, 25, 168, 1.0),
                        unselectedColor: Color.fromRGBO(217, 200, 236, 1),
                        padding: 0,
                        width: 40,
                        height: 40,
                        selectedStepSize: 10,
                        roundedCap: (_, __) => true,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${campaign.quantity_sold}',
                                  style: TextStyle(
                                    height: 1,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(127, 25, 168, 1.0),
                                  ),
                                ),
                                Text(
                                  'sold',
                                  style: TextStyle(
                                    fontSize: sizeAware.width * 0.03,
                                    height: 1,
                                  ),
                                ),
                                Text(
                                  'out of',
                                  style: TextStyle(
                                      height: 1,
                                      fontSize: sizeAware.width * 0.03),
                                ),
                                Text(
                                  '${campaign.product_quantity}',
                                  style: TextStyle(
                                      height: 1,
                                      fontSize: sizeAware.width * 0.03),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
