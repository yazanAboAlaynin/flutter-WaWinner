import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/currency.dart';
import 'package:flutter_wawinner/models/product.dart';
import 'package:flutter_wawinner/models/user.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadInProgress extends ProfileState {}

class ChangePasswordSccess extends ProfileState {}

class MessageSent extends ProfileState {}

class ChangePasswordFaield extends ProfileState {}

class MessageFaield extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  final User user;
  final List<Currency> currencies;
  ProfileLoadSuccess({this.user, this.currencies});
  @override
  List<Object> get props => [user, currencies];
}

class AboutUsLoadSuccess extends ProfileState {
  final String text;
  AboutUsLoadSuccess({this.text});
  @override
  List<Object> get props => [text];
}

class ProfileLoadFailure extends ProfileState {}
