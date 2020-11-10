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
