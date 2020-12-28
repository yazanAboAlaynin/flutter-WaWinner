import 'dart:io';

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
  final Map data;
  UpdateProfileRequested({this.data});
  @override
  List<Object> get props => [data];
}

class UpdateProfileImageRequested extends ProfileEvent {
  final Map data;
  final File image;
  UpdateProfileImageRequested({this.data, this.image});
  @override
  List<Object> get props => [data, image];
}

class ChangePasswordRequested extends ProfileEvent {
  final Map data;
  ChangePasswordRequested({this.data});
  @override
  List<Object> get props => [data];
}

class ContactUsRequested extends ProfileEvent {
  final Map data;
  ContactUsRequested({this.data});
  @override
  List<Object> get props => [data];
}

class AboutUsRequested extends ProfileEvent {
  AboutUsRequested();
  @override
  List<Object> get props => [];
}
