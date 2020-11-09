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
  int id;
  DeleteItem({this.id});
  @override
  List<Object> get props => [];
}

class Increase extends CartEvent {
  int id;
  Increase({this.id});
  @override
  List<Object> get props => [];
}

class Decrease extends CartEvent {
  int id;
  Decrease({this.id});
  @override
  List<Object> get props => [];
}
