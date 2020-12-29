import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/campaign_bloc/campaign_bloc.dart';
import 'package:flutter_wawinner/blocs/campaign_bloc/campaign_event.dart';
import 'package:flutter_wawinner/blocs/campaign_bloc/campaign_state.dart';
import 'package:flutter_wawinner/localization/localization_constants.dart';
import 'package:flutter_wawinner/models/ticket.dart';
import 'package:flutter_wawinner/repositories/campaign_api.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_wawinner/widgets/ActiveTicketCard.dart';
import 'package:flutter_wawinner/widgets/AppBar.dart';
import 'package:flutter_wawinner/widgets/Loading.dart';
import 'package:flutter_wawinner/widgets/error.dart';

class ActiveTickets extends StatefulWidget {
  @override
  _ActiveTicketsState createState() => _ActiveTicketsState();
}

class _ActiveTicketsState extends State<ActiveTickets> {
  List<Ticket> tickets = [];
  CampaignApi campaignApi = CampaignApi(httpClient: http.Client());

  CampaignsBloc campaignsBloc;
  @override
  void initState() {
    super.initState();
    campaignsBloc = CampaignsBloc(campaignApi: campaignApi);
    campaignsBloc.add(ActiveTicketsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        cubit: campaignsBloc,
        builder: (context, state) {
          if (state is TicketsLoadSuccess) {
            return Scaffold(
              appBar: myAppBar(getTranslated(context, 'Active Coupones'), null),
              body: SingleChildScrollView(
                child: getTickets(),
              ),
            );
          }
          if (state is CampaignsLoadInProgress) {
            return Loading();
          }
          if (state is CampaignsLoadFailure) {
            return CError(
              bloc: campaignsBloc,
              event: CampaignsRequested(),
            );
          }
        });
  }

  Widget getTickets() {
    List<ActiveTicketCard> list = [];

    for (int i = 0; i < tickets.length; i++) {
      list.add(ActiveTicketCard(
        ticket: tickets[i],
      ));
    }
    return Column(
      children: list,
    );
  }
}
