import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/charity.dart';
import 'package:flutter_wawinner/models/product.dart';
import 'package:flutter_wawinner/models/ticket.dart';
import 'package:flutter_wawinner/repositories/campaign_api.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'campaign_event.dart';
import 'campaign_state.dart';

class CampaignsBloc extends Bloc<CampaignEvent, CampaignState> {
  final CampaignApi campaignApi;

  CampaignsBloc({@required this.campaignApi})
      : assert(campaignApi != null),
        super(CampaignsInitial());

  @override
  Stream<CampaignState> mapEventToState(CampaignEvent event) async* {
    if (event is CampaignsRequested) {
      yield CampaignsLoadInProgress();
      try {
        List<Campaign> campaigns = await campaignApi.getCampaigns();
        List<Product> products = await campaignApi.getProducts();
        List<Charity> charities = await campaignApi.getCharities();
        List<String> images = await campaignApi.getImages();
        yield CampaignsLoadSuccess(
            campaigns: campaigns,
            products: products,
            images: images,
            charities: charities);
      } catch (_) {
        yield CampaignsLoadFailure();
      }
    } else if (event is ActiveTicketsRequested) {
      yield CampaignsLoadInProgress();
      try {
        List<Ticket> tickets = await campaignApi.getActiveTickets();

        yield TicketsLoadSuccess(
          tickets: tickets,
        );
      } catch (_) {
        yield CampaignsLoadFailure();
      }
    }
  }
}
