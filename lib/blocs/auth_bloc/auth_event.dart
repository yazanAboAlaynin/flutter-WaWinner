import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginRequested extends AuthEvent {
  String email;
  String password;

  LoginRequested({this.email, this.password});
  @override
  List<Object> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  String email;
  String password;
  String name_ar;
  String name_en;
  String address_ar;
  String address_en;
  String password_confirmation;
  String number;

  RegisterRequested(
      {this.email,
      this.password,
      this.address_ar,
      this.address_en,
      this.name_ar,
      this.name_en,
      this.number,
      this.password_confirmation});
  @override
  List<Object> get props => [email, password];
}

class SendCode extends AuthEvent {
  String code;

  SendCode({
    this.code,
  });
  @override
  List<Object> get props => [code];
}
