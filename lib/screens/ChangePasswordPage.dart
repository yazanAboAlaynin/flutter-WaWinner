import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_bloc.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_event.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_state.dart';
import 'package:flutter_wawinner/repositories/profile_api.dart';
import 'package:flutter_wawinner/screens/shared/AppBar.dart';
import 'package:flutter_wawinner/screens/shared/Loading.dart';

import 'package:http/http.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  ProfileApi profileApi = ProfileApi(httpClient: Client());
  ProfileBloc profileBloc;
  String old_password;
  String new_password;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    profileBloc = ProfileBloc(profileApi: profileApi);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    final Map args = ModalRoute.of(context).settings.arguments;
    return BlocBuilder(
        cubit: profileBloc,
        builder: (context, state) {
          if (state is ChangePasswordFaield) {
            return Container();
          }
          if (state is ProfileInitial || state is ChangePasswordSccess) {
            return Scaffold(
              appBar: myAppBar('Change Password', null),
              body: Container(
                height: sizeAware.height,
                width: sizeAware.width,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter Old Password',
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.01,
                        ),
                        TextFormField(
                          initialValue: old_password,
                          decoration: InputDecoration(
                            labelText: 'Enter Old Password',
                            filled: true,
                            labelStyle: TextStyle(fontFamily: 'Gess'),
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Enter Old Password' : null,
                          onChanged: (val) {
                            setState(() {
                              old_password = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.03,
                        ),
                        Text(
                          'Enter New Password',
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.01,
                        ),
                        TextFormField(
                          initialValue: new_password,
                          decoration: InputDecoration(
                            labelText: 'Enter New Password',
                            filled: true,
                            labelStyle: TextStyle(fontFamily: 'Gess'),
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Enter New Password' : null,
                          onChanged: (val) {
                            setState(() {
                              new_password = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            var data = {
                              'user_id': '${args['user_id']}',
                              'old_password': old_password,
                              'password': new_password,
                              'password_confirmation': new_password
                            };
                            profileBloc
                                .add(ChangePasswordRequested(data: data));
                          },
                          child: Center(
                            child: Container(
                              width: sizeAware.width * 0.85,
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(127, 25, 168, 1),
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(40),
                                  right: Radius.circular(40),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Change Password',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          if (state is ProfileLoadInProgress) {
            return Loading();
          }

          if (state is ProfileLoadFailure) {}
        });
  }
}
