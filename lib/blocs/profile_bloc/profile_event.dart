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
