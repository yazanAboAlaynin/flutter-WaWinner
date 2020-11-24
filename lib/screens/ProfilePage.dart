import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_bloc.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_event.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_state.dart';
import 'package:flutter_wawinner/models/user.dart';
import 'package:flutter_wawinner/repositories/profile_api.dart';
import 'package:flutter_wawinner/screens/shared/AppBar.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileBloc profileBloc;
  ProfileApi profileApi = ProfileApi(httpClient: http.Client());
  User user;

  @override
  void initState() {
    super.initState();
    profileBloc = ProfileBloc(profileApi: profileApi);
    profileBloc.add(ProfileRequested());
  }

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    return BlocBuilder(
      cubit: profileBloc,
      builder: (context, state) {
        if (state is ProfileLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProfileLoadFailure) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProfileLoadSuccess) {
          user = state.user;
          return Scaffold(
            appBar: myAppBar('Profile', null),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(12),
                width: sizeAware.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: sizeAware.height * 0.02,
                    ),
                    CircleAvatar(
                      radius: sizeAware.height * 0.075,
                      backgroundImage: NetworkImage(
                        user.image,
                      ),
                    ),
                    SizedBox(
                      height: sizeAware.height * 0.02,
                    ),
                    Text(
                      user.first_name + ' ' + user.last_name,
                      style: TextStyle(
                        fontSize: sizeAware.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: sizeAware.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: sizeAware.width * 0.25,
                          height: sizeAware.width * 0.25,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color.fromRGBO(127, 25, 168, 1.0),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.flag,
                                  color: Colors.white,
                                  size: sizeAware.width * 0.07,
                                ),
                                Text(
                                  user.nationality,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: sizeAware.width * 0.035,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: sizeAware.width * 0.25,
                          height: sizeAware.width * 0.25,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color.fromRGBO(127, 25, 168, 1.0),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.person_pin_circle,
                                  color: Colors.white,
                                  size: sizeAware.width * 0.07,
                                ),
                                Text(
                                  user.country_of_residence,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: sizeAware.width * 0.035,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: sizeAware.width * 0.25,
                          height: sizeAware.width * 0.25,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color.fromRGBO(127, 25, 168, 1.0),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: sizeAware.width * 0.07,
                                ),
                                Text(
                                  user.address,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: sizeAware.width * 0.035,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.phone,
                                color: Color.fromRGBO(18, 161, 154, 1.0),
                              ),
                              SizedBox(
                                width: sizeAware.width * 0.02,
                              ),
                              Text(
                                user.phone,
                                style: TextStyle(
                                  fontSize: sizeAware.width * 0.04,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: sizeAware.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.people,
                                color: Color.fromRGBO(18, 161, 154, 1.0),
                              ),
                              SizedBox(
                                width: sizeAware.width * 0.02,
                              ),
                              Text(
                                user.gender == "1" ? 'Male' : 'Female',
                                style: TextStyle(
                                  fontSize: sizeAware.width * 0.04,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: sizeAware.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: Color.fromRGBO(18, 161, 154, 1.0),
                              ),
                              SizedBox(
                                width: sizeAware.width * 0.02,
                              ),
                              Text(
                                user.status,
                                style: TextStyle(
                                  fontSize: sizeAware.width * 0.04,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: sizeAware.height * 0.02,
                          ),
                        ],
                      ),
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
