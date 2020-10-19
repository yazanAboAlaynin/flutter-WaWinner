import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;

    return Container(
      width: sizeAware.width,
      height: 400,
      color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Card(
          color: Colors.red,
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
                              Text('Buy a'),
                              SizedBox(
                                height: 10,
                              ),
                              Text('H2H Hoodie'),
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
                          Icon(Icons.lock_outline),
                          Container(
                            color: Colors.grey,
                            height: 1,
                            width: 20,
                          ),
                          Container(
                            width: 110,
                            child: CircularStepProgressIndicator(
                              totalSteps: 100,
                              currentStep: 74,
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
                                      '383',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromRGBO(127, 25, 168, 1.0),
                                      ),
                                    ),
                                    Text('sold'),
                                    Text('out of'),
                                    Text('975'),
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
                          Icon(Icons.lock_outline),
                          Container(
                            color: Colors.grey,
                            height: 1,
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('here'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: -20,
                top: 30,
                child: Image.asset(
                  'assets/shopping.jpg',
                  width: 120,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: -20,
                bottom: 10,
                child: Image.asset(
                  'assets/shopping.jpg',
                  width: 120,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: -20,
                top: 50,
                child: Card(
                  child: Column(
                    children: [
                      Icon(Icons.pie_chart_outlined),
                      Icon(Icons.pie_chart_outlined),
                      Icon(Icons.pie_chart_outlined),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
