import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class CampaignEvent extends Equatable {
  const CampaignEvent();
}

class CampaignsRequested extends CampaignEvent {
  CampaignsRequested();
  @override
  List<Object> get props => [];
}

class ActiveTicketsRequested extends CampaignEvent {
  @override
  List<Object> get props => [];
}

class ViewProduct extends CampaignEvent {
  final String id;
  ViewProduct({this.id});
  @override
  List<Object> get props => [id];
}
