import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class WLCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;

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
                                    child: Image.asset(
                                      'assets/shopping.jpg',
                                      width: sizeAware.width * 0.25,
                                      height: sizeAware.width * 0.28,
                                      fit: BoxFit.fill,
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
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'AED 250',
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
                                    child: Image.asset(
                                      'assets/shopping.jpg',
                                      width: sizeAware.width * 0.25,
                                      height: sizeAware.width * 0.28,
                                      fit: BoxFit.fill,
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                          Icons.add_shopping_cart,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
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
                    Container(
                      width: sizeAware.width * 0.25,
                      height: sizeAware.width * 0.25,
                      child: CircularStepProgressIndicator(
                        totalSteps: 975,
                        currentStep: 400,
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
                                '400',
                                style: TextStyle(
                                  fontSize: sizeAware.width * 0.035,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(127, 25, 168, 1.0),
                                ),
                              ),
                              Text(
                                'sold',
                                style: TextStyle(
                                  fontSize: sizeAware.width * 0.03,
                                ),
                              ),
                              Text(
                                'out of',
                                style: TextStyle(
                                  fontSize: sizeAware.width * 0.03,
                                ),
                              ),
                              Text(
                                '975',
                                style: TextStyle(
                                  fontSize: sizeAware.width * 0.03,
                                ),
                              ),
                            ],
                          )),
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
