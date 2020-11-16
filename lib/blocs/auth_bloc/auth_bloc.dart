import 'package:flutter_wawinner/models/cart.dart';
import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:flutter_wawinner/repositories/auth_api.dart';

import 'package:flutter_wawinner/repositories/cart_api.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApi authApi;

  AuthBloc({@required this.authApi})
      : assert(authApi != null),
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginRequested) {
      yield AuthLoadInProgress();
      try {
        String status = await authApi.login(event.email, event.password);

        if (status == "the account has not been verified") {
          yield NotVerified();
        } else if (status == "Error") {
          yield LoginError();
        } else
          yield LoginSuccess();
      } catch (_) {
        yield AuthLoadFailure();
      }
    } else if (event is RegisterRequested) {
      yield AuthLoadInProgress();
      try {
        var data = {
          'email': event.email,
          'password': event.password,
          'phone': event.number,
          'name:ar': event.name_ar,
          'name:en': event.name_en,
          'address:ar': event.address_ar,
          'address:en': event.address_en,
          'password_confirmation': event.password_confirmation,
        };
        await authApi.register(data);

        yield RegisterSuccess();
      } catch (_) {
        yield AuthLoadFailure();
      }
    } else if (event is SendCode) {
      yield AuthLoadInProgress();
      try {
        // await authApi.sendCode(data);

        yield RegisterSuccess();
      } catch (_) {
        yield AuthLoadFailure();
      }
    }
  }
}
