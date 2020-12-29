import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_event.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_state.dart';
import 'package:flutter_wawinner/blocs/wishlist_bloc/wl_bloc.dart';
import 'package:flutter_wawinner/localization/localization_constants.dart';
import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:flutter_wawinner/models/wishlist.dart';
import 'package:flutter_wawinner/widgets/AppBar.dart';
import 'package:flutter_wawinner/widgets/MyDrawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:flutter_wawinner/blocs/wishlist_bloc/wl_event.dart' as wl;

import '../Constants.dart';

class ProductDetail extends StatefulWidget {
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isAddedToWL = false;
  @override
  void initState() {
    super.initState();
    isAddedToWL = false;
  }

  Future<void> isInWL(campaign) async {
    bool x = await WishList.isInWL(campaign.id);

    setState(() {
      isAddedToWL = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    final Map args = ModalRoute.of(context).settings.arguments;
    final cartBloc = BlocProvider.of<CartBloc>(context);

    Campaign campaign = args['campaign'];
    WLBloc wlBloc = args['wlBloc'];
    isInWL(campaign);
    return BlocListener(
      cubit: cartBloc,
      listener: (context, state) {
        if (state is ItemAdded) {
          Fluttertoast.showToast(
              msg: getTranslated(context, "Item added to Cart"),
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Color.fromRGBO(127, 25, 168, 1.0),
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(getTranslated(context, 'Product Detailes'), null),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: sizeAware.height * 0.03,
              ),
              Row(
                children: [
                  SizedBox(width: sizeAware.width * 0.2),
                  Text(
                    getTranslated(context, 'Buy a'),
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: sizeAware.height * 0.02,
              ),
              Hero(
                tag: campaign.product.image,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 15,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: campaign.product.image,
                      width: sizeAware.width * 0.45,
                      height: sizeAware.width * 0.45,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: sizeAware.height * 0.03,
              ),
              Row(
                children: [
                  SizedBox(width: sizeAware.width * 0.2),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          campaign.product.name,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          'AED ${campaign.price}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          getTranslated(context, 'Get a chance to win:'),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: sizeAware.height * 0.03,
              ),
              Hero(
                tag: campaign.prize.image,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 15,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: campaign.prize.image,
                      width: sizeAware.width * 0.45,
                      height: sizeAware.width * 0.45,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: sizeAware.height * 0.03,
              ),
              Row(
                children: [
                  SizedBox(width: sizeAware.width * 0.2),
                  Expanded(
                    child: Text(
                      campaign.prize.name,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: sizeAware.height * 0.03,
              ),
              Container(
                width: sizeAware.width * 0.35,
                height: sizeAware.width * 0.35,
                child: CircularStepProgressIndicator(
                  totalSteps: campaign.product_quantity,
                  currentStep: campaign.quantity_sold,
                  stepSize: 10,
                  selectedColor: Color.fromRGBO(127, 25, 168, 1.0),
                  unselectedColor: Color.fromRGBO(217, 200, 236, 1),
                  padding: 0,
                  width: 110,
                  height: 110,
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
                              fontSize: 18,
                              height: 1.2,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(127, 25, 168, 1.0),
                            ),
                          ),
                          Text(
                            getTranslated(context, "sold"),
                            style: TextStyle(
                              height: 1.2,
                            ),
                          ),
                          Text(
                            getTranslated(context, "out of"),
                            style: TextStyle(
                              height: 1.2,
                            ),
                          ),
                          Text(
                            '${campaign.product_quantity}',
                            style: TextStyle(
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: sizeAware.height * 0.03,
              ),
              Text(
                getTranslated(context, "Offers"),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              offers(cartBloc, campaign),
              SizedBox(
                height: sizeAware.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      cartBloc.add(
                        AddItem(
                          cartItem: CartItem(
                            campaign: campaign,
                            qty: 1,
                            total_price: campaign.price,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: sizeAware.width * 0.55,
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
                              getTranslated(context, 'ADD TO CART'),
                              style: TextStyle(
                                fontSize: 20,
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (IsLoggedIn) {
                        wlBloc.add(wl.AddItem(item: campaign));
                      }
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 5,
                            offset: Offset(1, 1),
                            spreadRadius: 5,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          isAddedToWL
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: Color.fromRGBO(127, 25, 168, 1.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: sizeAware.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget offers(cartBloc, campaign) {
    List<Widget> wdgs = [];
    for (int i = 0; i < campaign.offers.length; i++) {
      wdgs.add(GestureDetector(
        onTap: () {
          cartBloc.add(
            AddItem(
              cartItem: CartItem(
                campaign: campaign,
                qty: campaign.offers[i].product_limit,
                total_price: campaign.offers[i].product_limit * campaign.price,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 28,
            height: 28,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(127, 25, 168, 1.0),
            ),
            child: Center(
              child: LANGUAGE == 'en'
                  ? Text(
                      'buy ${campaign.offers[i].product_limit} and win ${campaign.offers[i].extra_ticket_count} coupones',
                      style: TextStyle(
                        color: Colors.white,
                        height: 1,
                      ),
                    )
                  : Text(
                      ' اشتري ${campaign.offers[i].product_limit} واربح ${campaign.offers[i].extra_ticket_count} قسيمة',
                      style: TextStyle(
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
            ),
          ),
        ),
      ));
    }
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 4,
      children: wdgs,
    );
  }
}
