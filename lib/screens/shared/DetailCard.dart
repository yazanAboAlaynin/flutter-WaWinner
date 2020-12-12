import 'package:flutter/material.dart';
import 'package:flutter_wawinner/localization/localization_constants.dart';

class DetailCard extends StatefulWidget {
  @override
  _DetailCardState createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        height: sizeAware.height < sizeAware.width
            ? sizeAware.width * 0.3
            : sizeAware.height * 0.23,
        child: Card(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            semanticContainer: true,
            elevation: 1,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Sr. No.: 1',
                          // widget.pending.ord_date.substring(11, 16),
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          getTranslated(context, 'product(s)'),
                          // widget.pending.ord_date.substring(0, 10),
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'campaign No.',
                          style: TextStyle(
                            fontSize: sizeAware.width * 0.025,
                          ),
                        ),
                        Text(
                          getTranslated(context, 'Quantity'),
                          style: TextStyle(
                            fontSize: sizeAware.width * 0.035,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: sizeAware.height,
                  color: Colors.grey,
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          getTranslated(context, 'Unit Price'),
                        ),
                        Text(
                          getTranslated(context, 'Amount Excluding tax'),
                        ),
                        Text(
                          getTranslated(context, 'Tax Rate %'),
                        ),
                        Text(
                          getTranslated(context, 'Tax Payable'),
                        ),
                        Text(
                          getTranslated(context, 'Amount Including Tax'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
