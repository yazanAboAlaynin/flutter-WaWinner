import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/cart.dart';
import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:flutter_wawinner/models/wishlist.dart';

import 'package:flutter_wawinner/repositories/cart_api.dart';
import 'package:flutter_wawinner/repositories/wishlist_api.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'wl_event.dart';
import 'wl_state.dart';

class WLBloc extends Bloc<WlEvent, WlState> {
  final WLApi wlApi;

  WLBloc({@required this.wlApi})
      : assert(wlApi != null),
        super(WlInitial());

  @override
  Stream<WlState> mapEventToState(WlEvent event) async* {
    if (event is WlRequested) {
      yield WlLoadInProgress();
      try {
        List<Campaign> items = await wlApi.getItems();

        yield WlLoadSuccess(items: items);
      } catch (_) {
        yield WlLoadFailure();
      }
    } else if (event is AddItem) {
      yield WlLoadInProgress();
      try {
        bool t = await WishList.addItem(event.item);
        await wlApi.addToWishlist(event.item.id);
        List<Campaign> items = await wlApi.getItems();

        yield WlLoadSuccess(items: items);
      } catch (_) {
        yield WlLoadFailure();
      }
    }
  }
}
