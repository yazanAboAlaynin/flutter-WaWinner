import 'package:flutter/material.dart';
import 'package:flutter_wawinner/localization/localization_constants.dart';
import 'package:flutter_wawinner/models/order.dart';
import 'package:flutter_wawinner/widgets/AppBar.dart';
import 'package:flutter_wawinner/widgets/OrderCard.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(getTranslated(context, 'My Orders'), null),
      body: SingleChildScrollView(
        child: Column(
          children: getOrders(),
        ),
      ),
    );
  }

  List<Widget> getOrders() {
    List<Widget> ords = [];
    ords.add(OrderCard(
      order: Order(invoice_no: 1, order_no: 2),
    ));
    return ords;
  }
}
