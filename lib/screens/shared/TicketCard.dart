import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TicketCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;

    return Container(
      width: sizeAware.width,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            'assets/ticket.jpg',
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: SvgPicture.asset(
                      'assets/wawlogo.svg',
                      width: 50,
                      height: 70,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'product',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Elan testt'),
                    ],
                  ),
                  SizedBox(height: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'purchased on:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '04:28 pm october, 2020',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: sizeAware.width * 0.35,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(127, 25, 168, 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'CS- 78686786786',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text('   Coupon No'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
