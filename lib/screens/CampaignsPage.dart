import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/Constants.dart';
import 'package:flutter_wawinner/blocs/campaign_bloc/campaign_bloc.dart';
import 'package:flutter_wawinner/blocs/campaign_bloc/campaign_event.dart';
import 'package:flutter_wawinner/blocs/campaign_bloc/campaign_state.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter_wawinner/blocs/cart_bloc/cart_state.dart';
import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/repositories/campaign_api.dart';
import 'package:flutter_wawinner/screens/auth/LoginPage.dart';
import 'package:flutter_wawinner/screens/shared/AppBar.dart';
import 'package:flutter_wawinner/screens/shared/CampaignCard.dart';
import 'package:flutter_wawinner/screens/shared/ProductCard.dart';
import 'package:http/http.dart' as http;

class CampaignsPage extends StatefulWidget {
  @override
  _CampaignState createState() => _CampaignState();
}

class _CampaignState extends State<CampaignsPage> {
  CampaignApi campaignApi = CampaignApi(httpClient: http.Client());
  CampaignsBloc campaignsBloc;
  List<Campaign> campaigns = [];
  List<Campaign> products = [];

  @override
  void initState() {
    super.initState();
    campaignsBloc = CampaignsBloc(campaignApi: campaignApi);
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
          Navigator.of(context).pop();
          print('Cart Item Added');
        }
        if (state is CartLoadFailure) {
          Navigator.of(context).pop();
          print('Fail');
        }
        if (state is CartLoadInProgress) {
          showDialog<void>(
            context: context,
            barrierDismissible: true, // user must tap button!
            builder: (BuildContext context) {
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            },
          );
        }
      },
      child: BlocBuilder(
        cubit: campaignsBloc,
        builder: (context, state) {
          if (state is CampaignsLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CampaignsLoadSuccess) {
            campaigns = state.campaigns;
            products = state.products;
            return Scaffold(
              appBar: myAppBar('Campaigns', [
                IsLoggedIn
                    ? Text(NAME)
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()))
                              .then((value) {
                            setState(() {});
                          });
                        },
                        child: Center(child: Text('Login')),
                      )
              ]),
              body: LiveList.options(
                itemCount: campaigns.length + 1,
                options: options,
                itemBuilder: (context, index, animation) {
                  if (index == campaigns.length) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: sizeAware.height * 0.07,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Products',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(127, 25, 168, 1.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ProductCard(),
                                ProductCard(),
                                ProductCard(),
                                ProductCard(),
                                ProductCard(),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return CampaignCard(
                    animation: animation,
                    campaign: campaigns[index],
                  );
                },
              ),
            );
          }
          if (state is CampaignsLoadFailure) {
            return Container();
          }
        },
      ),
    );
  }
}
