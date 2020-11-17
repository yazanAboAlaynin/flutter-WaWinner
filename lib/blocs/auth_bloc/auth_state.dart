import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoadInProgress extends AuthState {}

class LoginSuccess extends AuthState {}

class NotVerified extends AuthState {}

class LoginError extends AuthState {}

class Error extends AuthState {}

class RegisterSuccess extends AuthState {}

class CodeVerified extends AuthState {}

class CodeSent extends AuthState {}

class AuthLoadFailure extends AuthState {}
