import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_event.dart';
import 'package:flutter_wawinner/blocs/wishlist_bloc/wl_event.dart' as wl;
import 'package:flutter_wawinner/blocs/wishlist_bloc/wl_bloc.dart';
import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:flutter_wawinner/models/wishlist.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../Constants.dart';

class CampaignCard extends StatefulWidget {
  final animation;
  final Campaign campaign;
  final WLBloc wlBloc;

  CampaignCard({this.animation, this.campaign, this.wlBloc});

  @override
  _CampaignCardState createState() => _CampaignCardState();
}

class _CampaignCardState extends State<CampaignCard> {
  int qty = 1;
  bool isAddedToWL = false;
  @override
  void initState() {
    super.initState();
    isAddedToWL = false;
  }

  Future<void> isInWL() async {
    bool x = await WishList.isInWL(widget.campaign.id);
    if (mounted) {
      setState(() {
        isAddedToWL = x;
      });
    }
    if (isAddedToWL == false && widget.campaign.added_to_wishlist) {
      // await WishList.addItem(widget.campaign);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    final cartBloc = BlocProvider.of<CartBloc>(context);
    isInWL();
    return Container(
      width: sizeAware.width,
      margin: EdgeInsets.symmetric(vertical: 8),
      height: 420,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Card(
          elevation: 3,
          shadowColor: Colors.grey,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                width: sizeAware.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Buy a',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(widget.campaign.product.name),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.grey,
                            height: 1,
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (IsLoggedIn) {
                                widget.wlBloc
                                    .add(wl.AddItem(item: widget.campaign));
                              }
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
                                  Icons.favorite,
                                  color:
                                      isAddedToWL ? Colors.red : Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.grey,
                            height: 1,
                            width: 20,
                          ),
                          Container(
                            width: sizeAware.width * 0.3,
                            height: sizeAware.width * 0.3,
                            child: CircularStepProgressIndicator(
                              totalSteps: widget.campaign.product_quantity,
                              currentStep: widget.campaign.quantity_sold,
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
                                      '${widget.campaign.quantity_sold}',
                                      style: TextStyle(
                                        fontSize: sizeAware.width * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromRGBO(127, 25, 168, 1.0),
                                      ),
                                    ),
                                    Text('sold'),
                                    Text('out of'),
                                    Text('${widget.campaign.product_quantity}'),
                                  ],
                                )),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.grey,
                            height: 1,
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              cartBloc.add(
                                AddItem(
                                  cartItem: CartItem(
                                    campaign: widget.campaign,
                                    qty: qty,
                                    total_price: qty * widget.campaign.price,
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
                          Container(
                            color: Colors.grey,
                            height: 1,
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: sizeAware.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Get a chance to win:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    width: sizeAware.width / 2,
                                    child: Text(
                                      widget.campaign.prize.name,
                                      style: TextStyle(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: -20,
                top: 25,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(-2, 0),
                    end: Offset.zero,
                  ).animate(widget.animation),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        widget.campaign.product.image,
                        width: sizeAware.width * 0.3,
                        height: sizeAware.width * 0.3,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -20,
                bottom: 10,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(4, 0),
                    end: Offset.zero,
                  ).animate(widget.animation),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        widget.campaign.prize.image,
                        width: sizeAware.width * 0.3,
                        height: sizeAware.width * 0.3,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -20,
                top: 70,
                child: Container(
                  height: 135,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 9,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Card(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (qty < widget.campaign.product_quantity) {
                                setState(() {
                                  qty++;
                                });
                              }
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color.fromRGBO(127, 25, 168, 1.0),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                          Text(
                            '$qty',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (qty > 1) {
                                setState(() {
                                  qty--;
                                });
                              }
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color.fromRGBO(127, 25, 168, 1.0),
                              ),
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: -54,
                child: RawMaterialButton(
                  onPressed: () {},
                  child: CustomPaint(
                    painter: TrianglePainter(
                      strokeColor: Color.fromRGBO(36, 9, 63, 1.0),
                      strokeWidth: 10,
                      paintingStyle: PaintingStyle.fill,
                    ),
                    child: Container(
                      height: 16,
                      width: 20,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 32,
                right: -20,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(53, 9, 100, 1.0),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Color.fromRGBO(127, 25, 168, 1.0),
                  ),
                  width: 120,
                  height: 35,
                  child: Center(
                      child: Text(
                    'AED ${widget.campaign.price}',
                    overflow: TextOverflow.clip,
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(x, y)
      ..lineTo(0, 0)
      ..lineTo(0, 0)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
