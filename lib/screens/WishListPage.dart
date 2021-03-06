import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/wishlist_bloc/wl_bloc.dart';
import 'package:flutter_wawinner/blocs/wishlist_bloc/wl_event.dart';
import 'package:flutter_wawinner/blocs/wishlist_bloc/wl_state.dart';
import 'package:flutter_wawinner/localization/localization_constants.dart';
import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/repositories/wishlist_api.dart';
import 'package:flutter_wawinner/widgets/AppBar.dart';
import 'package:flutter_wawinner/widgets/Loading.dart';
import 'package:flutter_wawinner/widgets/error.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_wawinner/widgets/WLCard.dart';

class WishListPage extends StatefulWidget {
  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  WLBloc wlBloc;
  WLApi wlApi = WLApi(httpClient: http.Client());
  List<Campaign> items = [];
  @override
  void initState() {
    super.initState();
    wlBloc = WLBloc(wlApi: wlApi);
    wlBloc.add(WlRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: wlBloc,
      builder: (context, state) {
        if (state is WlLoadInProgress) {
          return Loading();
        }
        if (state is WlLoadFailure) {
           return CError(
             bloc: wlBloc,
             event: WlRequested(),
            );
        }
        if (state is WlLoadSuccess ||
            state is ItemDeleted ||
            state is ItemAdded) {
          items = state.items;

          return Scaffold(
            appBar: myAppBar(getTranslated(context, 'Wish List'), null),
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
      itms.add(WLCard(
        wlBloc: wlBloc,
        campaign: items[i],
      ));
    }
    return Column(
      children: itms,
    );
  }
}
