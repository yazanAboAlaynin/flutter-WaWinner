import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/Constants.dart';
import 'package:flutter_wawinner/blocs/campaign_bloc/campaign_bloc.dart';
import 'package:flutter_wawinner/blocs/campaign_bloc/campaign_event.dart';
import 'package:flutter_wawinner/blocs/campaign_bloc/campaign_state.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_state.dart';
import 'package:flutter_wawinner/blocs/wishlist_bloc/wl_bloc.dart';
import 'package:flutter_wawinner/localization/localization_constants.dart';
import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/charity.dart';
import 'package:flutter_wawinner/models/product.dart';
import 'package:flutter_wawinner/repositories/campaign_api.dart';
import 'package:flutter_wawinner/repositories/wishlist_api.dart';
import 'package:flutter_wawinner/screens/auth/LoginPage.dart';
import 'package:flutter_wawinner/widgets/AppBar.dart';
import 'package:flutter_wawinner/widgets/CampaignCard.dart';
import 'package:flutter_wawinner/widgets/CharityCard.dart';
import 'package:flutter_wawinner/widgets/Loading.dart';
import 'package:flutter_wawinner/widgets/MyDrawer.dart';
import 'package:flutter_wawinner/widgets/error.dart';
import 'package:flutter_wawinner/widgets/image_carusel.dart';
import 'package:flutter_wawinner/widgets/productCard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CampaignsPage extends StatefulWidget {
  @override
  _CampaignState createState() => _CampaignState();
}

class _CampaignState extends State<CampaignsPage> {
  CampaignApi campaignApi = CampaignApi(httpClient: http.Client());
  WLApi wlApi = WLApi(httpClient: http.Client());
  CampaignsBloc campaignsBloc;
  WLBloc wlBloc;
  List<Campaign> campaigns = [];
  List<Product> products = [];
  List<Charity> charities = [];
  List<String> images = [];
  String currency = CURRENCY;

  @override
  void initState() {
    super.initState();
    campaignsBloc = CampaignsBloc(campaignApi: campaignApi);
    wlBloc = WLBloc(wlApi: wlApi);
    campaignsBloc.add(CampaignsRequested());
  }

  final options = LiveOptions(
    delay: Duration(milliseconds: 0),
    showItemInterval: Duration(milliseconds: 50),
    showItemDuration: Duration(milliseconds: 500),
    visibleFraction: 0.05,
    reAnimateOnVisibility: false,
  );
  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    final cartBloc = BlocProvider.of<CartBloc>(context);

    return BlocListener(
      cubit: cartBloc,
      listener: (context, state) {
        if (state is ItemAdded) {
          Fluttertoast.showToast(
              msg: getTranslated(context, "Item added to Cart"),
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Color.fromRGBO(127, 25, 168, 1.0),
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: BlocBuilder(
        cubit: campaignsBloc,
        builder: (context, state) {
          if (state is CampaignsLoadInProgress) {
            return Loading();
          }
          if (state is CampaignsLoadSuccess) {
            campaigns = state.campaigns;
            products = state.products;
            images = state.images;
            charities = state.charities;

            return Scaffold(
                appBar: myAppBar(getTranslated(context, 'Campaigns'), null),
                drawer: Drawer(
                  child: MyDrawer(),
                ),
                body: RefreshIndicator(
                  onRefresh: () {
                    campaignsBloc.add(CampaignsRequested());
                    return Future.delayed(Duration(milliseconds: 1500));
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          width: sizeAware.width,
                          height: sizeAware.height * 0.25,
                          margin: EdgeInsets.only(bottom: 15),
                          child: ImageCarusel(
                            images: images,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          width: sizeAware.width,
                          child: LiveList.options(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: campaigns.length,
                            options: options,
                            itemBuilder: (context, index, animation) {
                              return CampaignCard(
                                animation: animation,
                                campaign: campaigns[index],
                                wlBloc: wlBloc,
                              );
                            },
                          ),
                        ),
                      ),
                      //products
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: sizeAware.height * 0.07,
                              ),
                              Text(
                                getTranslated(context, 'Products'),
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(127, 25, 168, 1.0),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: productsList(),
                              )
                            ],
                          ),
                        ),
                      ),
                      // charities
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: sizeAware.height * 0.07,
                              ),
                              Text(
                                getTranslated(context, 'Charities'),
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(127, 25, 168, 1.0),
                                ),
                              ),
                              SingleChildScrollView(
                                child: charitiesList(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          }
          if (state is CampaignsLoadFailure) {
            return CError(
              bloc: wlBloc,
              event: CampaignsRequested(),
            );
          }
          return Loading();
        },
      ),
    );
  }

  productsList() {
    List<ProductCard> prs = [];
    for (int i = 0; i < products.length; i++) {
      prs.add(ProductCard(
        product: products[i],
      ));
    }
    return Row(
      children: prs,
    );
  }

  charitiesList() {
    List<CharityCard> prs = [];
    for (int i = 0; i < charities.length; i++) {
      prs.add(CharityCard(
        charity: charities[i],
      ));
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: prs,
      ),
    );
  }
}
