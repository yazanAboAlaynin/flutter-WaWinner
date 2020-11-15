import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/cart.dart';
import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:flutter_wawinner/models/wishlist.dart';

import 'package:flutter_wawinner/repositories/cart_api.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'wl_event.dart';
import 'wl_state.dart';

class WLBloc extends Bloc<WlEvent, WlState> {
  WLBloc() : super(WlInitial());

  @override
  Stream<WlState> mapEventToState(WlEvent event) async* {
    if (event is WlRequested) {
      yield WlLoadInProgress();
      try {
        List<Campaign> items = await WishList.getItems();

        yield WlLoadSuccess(items: items);
      } catch (_) {
        yield WlLoadFailure();
      }
    } else if (event is AddItem) {
      yield WlLoadInProgress();
      try {
        await WishList.addItem(event.item);

        yield ItemAdded();
      } catch (_) {
        yield WlLoadFailure();
      }
    } else if (event is DeleteItem) {
      try {
        await WishList.deleteItem(event.id);
        List<Campaign> items = await WishList.getItems();

        yield WlLoadSuccess(items: items);
      } catch (_) {
        yield WlLoadFailure();
      }
    }
  }
}
