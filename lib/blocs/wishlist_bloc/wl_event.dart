import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class WlEvent extends Equatable {
  const WlEvent();
}

class WlRequested extends WlEvent {
  WlRequested();
  @override
  List<Object> get props => [];
}

class AddItem extends WlEvent {
  Campaign item;
  AddItem({this.item});
  @override
  List<Object> get props => [];
}

class DeleteItem extends WlEvent {
  int id;
  DeleteItem({this.id});
  @override
  List<Object> get props => [];
}
