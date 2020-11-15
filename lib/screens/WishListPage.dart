import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/wishlist_bloc/wl_bloc.dart';
import 'package:flutter_wawinner/blocs/wishlist_bloc/wl_event.dart';
import 'package:flutter_wawinner/blocs/wishlist_bloc/wl_state.dart';
import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/screens/shared/AppBar.dart';
import 'package:flutter_wawinner/screens/shared/MyDrawer.dart';
import 'package:flutter_wawinner/screens/shared/WLCard.dart';

class WishListPage extends StatefulWidget {
  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  WLBloc wlBloc;
  List<Campaign> items = [];
  @override
  void initState() {
    super.initState();
    wlBloc = WLBloc();
    wlBloc.add(WlRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: wlBloc,
      builder: (context, state) {
        if (state is WlLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is WlLoadFailure) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is WlLoadSuccess) {
          items = state.items;

          return Scaffold(
            appBar: myAppBar('Wish List', null),
            body: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    wlItems(),
                  ]),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  wlItems() {
    List<WLCard> itms = [];
    for (int i = 0; i < items.length; i++) {
      itms.add(WLCard());
    }
    return Column(
      children: itms,
    );
  }
}
