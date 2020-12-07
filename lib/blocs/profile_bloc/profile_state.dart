import 'package:flutter_wawinner/models/campaign.dart';
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

class ChangePasswordFaield extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  User user;
  ProfileLoadSuccess({this.user});
  @override
  List<Object> get props => [user];
}

class ProfileLoadFailure extends ProfileState {}
