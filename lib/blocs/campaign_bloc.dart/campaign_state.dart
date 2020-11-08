import 'package:flutter_wawinner/models/campaign.dart';
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

  CampaignsLoadSuccess({this.campaigns});
  @override
  List<Object> get props => [campaigns];
}

// class AddToCartResponse extends CampaignState {
//   List<Distributer> dists;
//   String id;
//   AddToCartResponse({this.dists, this.id});
//   @override
//   List<Object> get props => [dists];
// }

class CampaignsLoadFailure extends CampaignState {}
