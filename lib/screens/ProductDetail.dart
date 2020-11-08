import 'package:flutter/material.dart';
import 'package:flutter_wawinner/screens/shared/AppBar.dart';
import 'package:flutter_wawinner/screens/shared/MyDrawer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar('Product Detailes', null),
      drawer: Drawer(
        child: MyDrawer(),
      ),
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
                  'Buy a',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: sizeAware.height * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
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
                child: Image.asset(
                  'assets/shopping.jpg',
                  width: sizeAware.width * 0.45,
                  height: sizeAware.width * 0.45,
                  fit: BoxFit.cover,
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
                        'H2H Hoodie',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'AED 10000',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Get a chance to win:',
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
            Container(
              decoration: BoxDecoration(
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
                child: Image.asset(
                  'assets/shopping.jpg',
                  width: sizeAware.width * 0.45,
                  height: sizeAware.width * 0.45,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: sizeAware.height * 0.03,
            ),
            Row(
              children: [
                SizedBox(width: sizeAware.width * 0.1),
                Expanded(
                  child: Text(
                    'blah blah blahblahblahblahbl ahbl ahblahblahblah',
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
                totalSteps: 975,
                currentStep: 400,
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
                          '400',
                          style: TextStyle(
                            fontSize: sizeAware.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(127, 25, 168, 1.0),
                          ),
                        ),
                        Text('sold'),
                        Text('out of'),
                        Text('975'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: sizeAware.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
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
                          'ADD TO CART',
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
              ],
            ),
            SizedBox(
              height: sizeAware.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
