import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class CampaignState extends Equatable {
  const CampaignState();

  @override
  List<Object> get props => [];
}

class CampaignsInitial extends CampaignState {}

class MedicinesLoadInProgress extends CampaignState {}

class CampaignsLoadSuccess extends CampaignState {
  // List<Medicine> mds;
  // bool isMore;

  // CampaignsLoadSuccess({this.mds, this.isMore});
  // @override
  // List<Object> get props => [mds, isMore];
}

// class AddToCartResponse extends CampaignState {
//   List<Distributer> dists;
//   String id;
//   AddToCartResponse({this.dists, this.id});
//   @override
//   List<Object> get props => [dists];
// }

class CampaignsLoadFailure extends CampaignState {}
