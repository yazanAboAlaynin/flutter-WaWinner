import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileRequested extends ProfileEvent {
  ProfileRequested();
  @override
  List<Object> get props => [];
}

class UpdateProfileRequested extends ProfileEvent {
  final int id;
  final Map data;
  UpdateProfileRequested({this.data, this.id});
  @override
  List<Object> get props => [data];
}

class ChangePasswordRequested extends ProfileEvent {
  final Map data;
  ChangePasswordRequested({this.data});
  @override
  List<Object> get props => [data];
}
