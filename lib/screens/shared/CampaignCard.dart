import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc.dart/cart_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc.dart/cart_event.dart';
import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CampaignCard extends StatelessWidget {
  final animation;
  final Campaign campaign;

  const CampaignCard({this.animation, this.campaign});
  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    final cartBloc = BlocProvider.of<CartBloc>(context);

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
                              Text(campaign.product.name),
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
                          Container(
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
                                color: Colors.white,
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
                              totalSteps: int.parse(campaign.product_quantity),
                              currentStep: int.parse(campaign.quantity_sold),
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
                                      campaign.quantity_sold,
                                      style: TextStyle(
                                        fontSize: sizeAware.width * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromRGBO(127, 25, 168, 1.0),
                                      ),
                                    ),
                                    Text('sold'),
                                    Text('out of'),
                                    Text(campaign.product_quantity),
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
                                    campaign: campaign,
                                    qty: 0,
                                    total_price: 0,
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
                                      campaign.prize.name,
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
                  ).animate(animation),
                  child: Container(
                    decoration: BoxDecoration(
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
                      child: Image.asset(
                        'assets/shopping.jpg',
                        width: sizeAware.width * 0.3,
                        height: sizeAware.width * 0.35,
                        fit: BoxFit.cover,
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
                  ).animate(animation),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/shopping.jpg',
                          width: sizeAware.width * 0.3,
                          height: sizeAware.width * 0.35,
                          fit: BoxFit.cover,
                        ),
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
                          Container(
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
                          Text(
                            '1',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Container(
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
                    'AED ${campaign.price_after_vat}',
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