import 'package:flutter/material.dart';
import 'package:flutter_wawinner/screens/shared/AppBar.dart';
import 'package:flutter_wawinner/screens/shared/DetailCard.dart';
import 'package:flutter_wawinner/screens/shared/TicketCard.dart';

class ViewOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('View order', null),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getDetailes(),
            getTickets(),
          ],
        ),
      ),
    );
  }

  getDetailes() {
    List<Widget> list = [];
    list.add(DetailCard());
    return Column(children: list);
  }

  getTickets() {
    List<Widget> list = [];
    list.add(TicketCard());
    list.add(TicketCard());
    return Column(children: list);
  }
}
