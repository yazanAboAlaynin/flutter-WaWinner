import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_wawinner/blocs/auth_bloc/auth_event.dart';
import 'package:flutter_wawinner/blocs/auth_bloc/auth_state.dart';
import 'package:flutter_wawinner/localization/localization_constants.dart';
import 'package:flutter_wawinner/repositories/auth_api.dart';
import 'package:flutter_wawinner/widgets/Loading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../Constants.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  TextEditingController codeTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  AuthBloc authBloc;
  AuthApi authApi = AuthApi(httpClient: http.Client());
  bool formVis = false;

  @override
  void initState() {
    super.initState();
    authBloc = AuthBloc(authApi: authApi);
  }

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    return BlocListener(
      cubit: authBloc,
      listener: (context, state) {
        if (state is CodeVerified) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, 'Campaignes');
        }
        if (state is CodeSent) {
          Fluttertoast.showToast(
              msg: "Code sent to you",
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Color.fromRGBO(127, 25, 168, 1.0),
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is Error) {
          Fluttertoast.showToast(
              msg: "Error",
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Color.fromRGBO(127, 25, 168, 1.0),
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: BlocBuilder(
          cubit: authBloc,
          builder: (context, state) {
            if (state is AuthInitial ||
                state is CodeVerified ||
                state is Error ||
                state is CodeSent ||
                state is PhoneChanged) {
              if (state is PhoneChanged) formVis = false;
              return SafeArea(
                child: Scaffold(
                  body: Container(
                    width: sizeAware.width,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Visibility(
                                visible: !formVis,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: sizeAware.height * 0.1,
                                    ),
                                    Text(
                                      'Verification Code',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(127, 25, 168, 1),
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: sizeAware.height * 0.1,
                                    ),
                                    TextFormField(
                                      controller: codeTextEditingController,
                                      decoration: InputDecoration(
                                        labelText: 'Enter Code',
                                      ),
                                    ),
                                    SizedBox(
                                      height: sizeAware.height * 0.06,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        authBloc.add(
                                          SendCode(
                                              code: codeTextEditingController
                                                  .text,
                                              id: ID),
                                        );
                                      },
                                      child: Container(
                                        width: sizeAware.width * 0.85,
                                        height: 45.0,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(127, 25, 168, 1),
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(40),
                                            right: Radius.circular(40),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Send Code',
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
                                    SizedBox(
                                      height: sizeAware.height * 0.05,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        authBloc.add(ResendCode(id: ID));
                                      },
                                      child: Text('Resend the code'),
                                    ),
                                    SizedBox(
                                      height: sizeAware.height * 0.05,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          formVis = true;
                                        });
                                      },
                                      child: Text('Change phone number'),
                                    ),
                                  ],
                                )),
                            Visibility(
                              visible: formVis,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: sizeAware.height * 0.1,
                                  ),
                                  Text(
                                    'Reset phone number',
                                    style: TextStyle(
                                        color: Color.fromRGBO(127, 25, 168, 1),
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: sizeAware.height * 0.02,
                                  ),
                                  TextFormField(
                                    controller: phoneTextEditingController,
                                    decoration: InputDecoration(
                                      labelText: 'Enter new phone number',
                                    ),
                                  ),
                                  SizedBox(
                                    height: sizeAware.height * 0.06,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      authBloc.add(
                                        ChangePhone(
                                            phone:
                                                phoneTextEditingController.text,
                                            id: ID),
                                      );
                                    },
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Reset Phone Number',
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            if (state is AuthLoadInProgress) {
              return Loading();
            }
            if (state is AuthLoadFailure) {
              return Scaffold(
                body: SafeArea(
                  child: Container(
                    width: sizeAware.width,
                    height: sizeAware.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          getTranslated(context, 'Connection Error'),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        FlatButton(
                          color: Color.fromRGBO(127, 25, 168, 1.0),
                          onPressed: () {
                            setState(() {
                              authBloc = AuthBloc(authApi: authApi);
                            });
                          },
                          child: Text(
                            getTranslated(context, 'Refresh'),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
