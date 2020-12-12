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
  String first_name_ar;
  String last_name_ar;
  String last_name_en;
  String first_name_en;
  String address_ar;
  String address_en;
  String password_confirmation;
  String number;

  RegisterRequested(
      {this.email,
      this.password,
      this.address_ar,
      this.address_en,
      this.first_name_ar,
      this.first_name_en,
      this.last_name_ar,
      this.last_name_en,
      this.number,
      this.password_confirmation});
  @override
  List<Object> get props => [
        email,
        password,
        address_ar,
        address_en,
        first_name_ar,
        first_name_en,
        last_name_ar,
        last_name_en,
        number,
        password_confirmation,
      ];
}

class SendCode extends AuthEvent {
  int id;
  String code;

  SendCode({this.code, this.id});
  @override
  List<Object> get props => [code, id];
}

class ResendCode extends AuthEvent {
  final int id;

  ResendCode({this.id});
  @override
  List<Object> get props => [id];
}

class ChangePhone extends AuthEvent {
  final int id;
  final String phone;

  ChangePhone({this.id, this.phone});
  @override
  List<Object> get props => [id, phone];
}

class SendPhoneNumber extends AuthEvent {
  final String phone;

  SendPhoneNumber({this.phone});
  @override
  List<Object> get props => [phone];
}

class SendVCode extends AuthEvent {
  final String phone;
  final String code;

  SendVCode({this.phone, this.code});
  @override
  List<Object> get props => [phone, code];
}

class ResetPassword extends AuthEvent {
  final String phone;
  final String code;
  final String password;
  final String confirm_password;

  ResetPassword({this.password, this.confirm_password, this.phone, this.code});
  @override
  List<Object> get props => [phone, code, password, confirm_password];
}
