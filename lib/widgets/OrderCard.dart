import 'package:flutter/material.dart';
import 'package:flutter_wawinner/localization/localization_constants.dart';
import 'package:flutter_wawinner/models/order.dart';

class OrderCard extends StatefulWidget {
  final Order order;

  const OrderCard({Key key, this.order}) : super(key: key);
  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        height: 200,
        child: Card(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          semanticContainer: true,
          elevation: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            'Order no: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('${widget.order.order_no}'),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Invoice no: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('${widget.order.transaction_no}'),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Status: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('${widget.order.status}'),
                        ],
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'View Order');
                        },
                        height: 50,
                        minWidth: sizeAware.width * 0.4,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Color.fromRGBO(127, 25, 168, 1.0),
                        textColor: Colors.white,
                        child: Text(
                          getTranslated(context, "View"),
                        ),
                        splashColor: Color.fromRGBO(127, 25, 168, 1.0),
                      ),
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
