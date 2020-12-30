import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/campaign_bloc/campaign_bloc.dart';
import 'package:flutter_wawinner/blocs/campaign_bloc/campaign_event.dart';
import 'package:flutter_wawinner/blocs/campaign_bloc/campaign_state.dart';
import 'package:flutter_wawinner/localization/localization_constants.dart';
import 'package:flutter_wawinner/models/order.dart';
import 'package:flutter_wawinner/repositories/campaign_api.dart';
import 'package:flutter_wawinner/widgets/AppBar.dart';
import 'package:flutter_wawinner/widgets/Loading.dart';
import 'package:flutter_wawinner/widgets/OrderCard.dart';
import 'package:flutter_wawinner/widgets/error.dart';
import 'package:http/http.dart' as http;

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  CampaignApi campaignApi = CampaignApi(httpClient: http.Client());
  CampaignsBloc campaignsBloc;
  List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    campaignsBloc = CampaignsBloc(campaignApi: campaignApi);
    campaignsBloc.add(OrdersRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: campaignsBloc,
      builder: (context, state) {
        if (state is CampaignsLoadInProgress) {
          return Loading();
        }
        if (state is CampaignsLoadFailure) {
          return CError(
            bloc: campaignsBloc,
            event: OrdersRequested(),
          );
        }
        if (state is OrdersLoadSuccess) {
          orders = state.orders;
          return Scaffold(
            appBar: myAppBar(getTranslated(context, 'My Orders'), null),
            body: SingleChildScrollView(
              child: Column(
                children: getOrders(),
              ),
            ),
          );
        }
      },
    );
  }

  List<Widget> getOrders() {
    List<Widget> ords = [];

    ords = orders
        .map(
          (e) => OrderCard(order: e),
        )
        .toList();

    return ords;
  }
}
