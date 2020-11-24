import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoadInProgress extends CartState {}

class ItemAdded extends CartState {}

class CouponValid extends CartState {}

class CouponNotValid extends CartState {
  String code;

  CouponNotValid({this.code});
  @override
  List<Object> get props => [code];
}

class CartLoadSuccess extends CartState {
  List<CartItem> items;

  CartLoadSuccess({this.items});
  @override
  List<Object> get props => [items];
}

class CartLoadFailure extends CartState {}
