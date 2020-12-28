import 'package:flutter/material.dart';
import 'package:flutter_wawinner/widgets/AppBar.dart';
import 'package:flutter_wawinner/widgets/DetailCard.dart';
import 'package:flutter_wawinner/widgets/TicketCard.dart';

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
