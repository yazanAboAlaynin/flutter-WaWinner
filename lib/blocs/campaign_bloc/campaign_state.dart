import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/product.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class CampaignState extends Equatable {
  const CampaignState();

  @override
  List<Object> get props => [];
}

class CampaignsInitial extends CampaignState {}

class CampaignsLoadInProgress extends CampaignState {}

class CampaignsLoadSuccess extends CampaignState {
  List<Campaign> campaigns;
  List<Product> products;

  CampaignsLoadSuccess({this.campaigns, this.products});
  @override
  List<Object> get props => [campaigns, products];
}

class CampaignsLoadFailure extends CampaignState {}
