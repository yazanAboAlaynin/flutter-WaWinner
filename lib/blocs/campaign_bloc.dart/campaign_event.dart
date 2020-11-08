import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class CampaignEvent extends Equatable {
  const CampaignEvent();
}

class CampaignsRequested extends CampaignEvent {
  final int cnt;
  CampaignsRequested({this.cnt});
  @override
  List<Object> get props => [];
}

// class SeeMore extends CampaignEvent {
//   final int cnt;
//   SeeMore({this.cnt});
//   @override
//   List<Object> get props => [];
// }

class ViewProduct extends CampaignEvent {
  final String id;
  ViewProduct({this.id});
  @override
  List<Object> get props => [id];
}

// class AddToCart extends CampaignEvent {
//   final Map data;
//   final Medicine medicine;
//   AddToCart({this.data, this.medicine});
//   @override
//   List<Object> get props => [data, medicine];
// }
