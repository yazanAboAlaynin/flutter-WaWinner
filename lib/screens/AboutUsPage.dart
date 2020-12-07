import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_bloc.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_event.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_state.dart';
import 'package:flutter_wawinner/repositories/profile_api.dart';
import 'package:flutter_wawinner/screens/shared/AppBar.dart';
import 'package:flutter_wawinner/screens/shared/Loading.dart';
import 'package:http/http.dart' as http;

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  String text = '';
  ProfileApi profileApi = ProfileApi(httpClient: http.Client());
  ProfileBloc profileBloc;
  @override
  void initState() {
    super.initState();
    profileBloc = ProfileBloc(profileApi: profileApi);
    profileBloc.add(AboutUsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: profileBloc,
      builder: (context, state) {
        if (state is ProfileLoadInProgress) {
          return Loading();
        }
        if (state is ProfileLoadFailure) {
          return Loading();
        }
        if (state is AboutUsLoadSuccess) {
          text = state.text;
          return Scaffold(
            appBar: myAppBar('About Us', null),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      text,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
