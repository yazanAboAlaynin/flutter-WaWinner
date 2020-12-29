import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_wawinner/models/ticket.dart';

class ActiveTicketCard extends StatelessWidget {
  final Ticket ticket;

  const ActiveTicketCard({Key key, this.ticket}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 150,
            width: sizeAware.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  blurRadius: 5,
                  offset: Offset(1, 1),
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/waw.png',
                          height: 60,
                          width: sizeAware.width * 0.25,
                          fit: BoxFit.fill,
                        ),
                        Expanded(
                          child: Text(
                            ticket.description,
                            style: TextStyle(
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Image.network(
                            ticket.image,
                            width: sizeAware.width * 0.6,
                          ),
                        ),
                        Text(
                          'x${ticket.quantity}',
                          style: TextStyle(
                            color: Color.fromRGBO(127, 25, 168, 1.0),
                            fontSize: 20,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: sizeAware.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${ticket.codes.length} Coupones per unit'),
                Column(
                  children:
                      ticket.codes.map((e) => Text('Coupon no. $e')).toList(),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
