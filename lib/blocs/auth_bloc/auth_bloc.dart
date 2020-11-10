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
        await authApi.login(event.email, event.password);

        yield LoginSuccess();
      } catch (_) {
        yield AuthLoadFailure();
      }
    }
  }
}
