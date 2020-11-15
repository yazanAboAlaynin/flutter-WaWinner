import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class WlState extends Equatable {
  const WlState();

  @override
  List<Object> get props => [];
}

class WlInitial extends WlState {}

class WlLoadInProgress extends WlState {}

class ItemAdded extends WlState {}

class WlLoadSuccess extends WlState {
  List<Campaign> items;

  WlLoadSuccess({this.items});
  @override
  List<Object> get props => [items];
}

class WlLoadFailure extends WlState {}
