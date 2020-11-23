import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/product.dart';
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
        List<String> images = await campaignApi.getImages();

        yield CampaignsLoadSuccess(
            campaigns: campaigns, products: products, images: images);
      } catch (_) {
        yield CampaignsLoadFailure();
      }
    }
    //  else if (event is AddToCart) {
    //   yield MedicinesLoadInProgress();

    //   try {
    //     List<Distributer> dists = await medicineApi.isAvilable(event.data);

    //     if (dists.length > 0) {
    //       CartMedicine cm = CartMedicine(
    //           id: event.medicine.id,
    //           image: event.medicine.image,
    //           name: event.medicine.name,
    //           price: event.medicine.price,
    //           is_package: '0',
    //           distributers: dists);

    //       await Cart.addMedicine(cm);
    //     }

    //     yield AddToCartResponse(dists: dists, id: event.medicine.id);
    //   } catch (_) {
    //     yield MedicinesLoadFailure();
    //   }
    // }
  }
}
