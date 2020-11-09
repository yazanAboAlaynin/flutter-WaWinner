import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartRequested extends CartEvent {
  CartRequested();
  @override
  List<Object> get props => [];
}

class AddItem extends CartEvent {
  CartItem cartItem;
  AddItem({this.cartItem});
  @override
  List<Object> get props => [];
}

class DeleteItem extends CartEvent {
  String idx;
  DeleteItem({this.idx});
  @override
  List<Object> get props => [];
}

class Increase extends CartEvent {
  String idx;
  Increase({this.idx});
  @override
  List<Object> get props => [];
}

class Decrease extends CartEvent {
  String idx;
  Decrease({this.idx});
  @override
  List<Object> get props => [];
}
