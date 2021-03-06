import 'package:flutter_wawinner/models/cart.dart';
import 'package:flutter_wawinner/models/cartItem.dart';

import 'package:flutter_wawinner/repositories/cart_api.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartApi cartApi;

  CartBloc({@required this.cartApi})
      : assert(cartApi != null),
        super(CartInitial());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is CartRequested) {
      yield CartLoadInProgress();
      try {
        List<CartItem> items = await Cart.getItems();

        yield CartLoadSuccess(items: items);
      } catch (_) {
        yield CartLoadFailure();
      }
    } else if (event is AddItem) {
      yield CartLoadInProgress();
      try {
        await Cart.addItem(event.cartItem);

        yield ItemAdded();
      } catch (_) {
        yield CartLoadFailure();
      }
    } else if (event is Increase) {
      try {
        await Cart.increase(event.id);
        List<CartItem> items = await Cart.getItems();

        yield CartLoadSuccess(items: items);
      } catch (_) {
        yield CartLoadFailure();
      }
    } else if (event is Decrease) {
      try {
        await Cart.decrease(event.id);
        List<CartItem> items = await Cart.getItems();

        yield CartLoadSuccess(items: items);
      } catch (_) {
        yield CartLoadFailure();
      }
    } else if (event is DeleteItem) {
      try {
        await Cart.deleteItem(event.id);
        List<CartItem> items = await Cart.getItems();

        yield CartLoadSuccess(items: items);
      } catch (_) {
        yield CartLoadFailure();
      }
    } else if (event is Checkout) {
      yield CartLoadInProgress();

      try {
        await cartApi.checkOut(event.items, event.is_donate, event.coupon);
        await Cart.emptyCart();

        yield CartLoadSuccess(items: []);
      } catch (_) {
        yield CartLoadFailure();
      }
    } else if (event is CheckCoupon) {
      try {
        var data = {
          'code': event.coupon,
        };
        bool t = await cartApi.checkCoupon(data);

        if (t) {
          yield CouponValid();
        } else {
          yield CouponNotValid(code: event.coupon);
        }
      } catch (_) {
        yield CartLoadFailure();
      }
    }
  }
}
