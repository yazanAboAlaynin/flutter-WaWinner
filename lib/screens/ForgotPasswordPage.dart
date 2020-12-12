import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_wawinner/blocs/auth_bloc/auth_event.dart';
import 'package:flutter_wawinner/blocs/auth_bloc/auth_state.dart';
import 'package:flutter_wawinner/localization/localization_constants.dart';
import 'package:flutter_wawinner/repositories/auth_api.dart';
import 'package:flutter_wawinner/screens/shared/AppBar.dart';
import 'package:flutter_wawinner/screens/shared/Loading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController codeTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  AuthApi authApi = AuthApi(httpClient: http.Client());
  AuthBloc authBloc;

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
        // if (state is PhoneNumberSent) {}
        if (state is PhoneNumberNotExist) {
          Fluttertoast.showToast(
              msg: "Phone number not exist",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Color.fromRGBO(127, 25, 168, 1.0),
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is CodePNotVerified) {
          Fluttertoast.showToast(
              msg: "Code is not valid",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Color.fromRGBO(127, 25, 168, 1.0),
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is ResetPasswordFailed) {
          Fluttertoast.showToast(
              msg: "Please try again",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Color.fromRGBO(127, 25, 168, 1.0),
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is ResetPasswordSuccess) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder(
          cubit: authBloc,
          builder: (context, state) {
            if (state is AuthLoadInProgress) {
              return Loading();
            }
            if (state is AuthLoadFailure) {
              return Loading();
            }
            if (state is AuthInitial || state is PhoneNumberNotExist) {
              return Scaffold(
                appBar: myAppBar('Reset Password', null),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: sizeAware.height * 0.07,
                        ),
                        Text(
                          'Enter your phone number:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.02,
                        ),
                        TextFormField(
                          controller: phoneTextEditingController,
                          decoration: InputDecoration(
                            labelText: 'Phone',
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.04,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              authBloc.add(SendPhoneNumber(
                                  phone: phoneTextEditingController.text));
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Next',
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
              );
            }

            if (state is PhoneNumberSent || state is CodePNotVerified) {
              return Scaffold(
                appBar: myAppBar('Reset Password', null),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: sizeAware.height * 0.07,
                        ),
                        Text(
                          'Enter verification code:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.02,
                        ),
                        TextFormField(
                          controller: codeTextEditingController,
                          decoration: InputDecoration(
                            labelText: 'Code',
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.04,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              authBloc.add(
                                SendVCode(
                                  code: codeTextEditingController.text,
                                  phone: phoneTextEditingController.text,
                                ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Next',
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
              );
            }

            if (state is CodePVerified ||
                state is ResetPasswordFailed ||
                state is ResetPasswordSuccess) {
              return Scaffold(
                appBar: myAppBar('Reset Password', null),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: sizeAware.height * 0.07,
                        ),
                        Text(
                          'Enter new password:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.01,
                        ),
                        TextFormField(
                          controller: passwordTextEditingController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.03,
                        ),
                        Text(
                          'Confirm new password:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.01,
                        ),
                        TextFormField(
                          controller: confirmPasswordTextEditingController,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.04,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              authBloc.add(
                                ResetPassword(
                                  code: codeTextEditingController.text,
                                  phone: phoneTextEditingController.text,
                                  confirm_password:
                                      confirmPasswordTextEditingController.text,
                                  password: passwordTextEditingController.text,
                                ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Reset Password',
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
              );
            }
          }),
    );
  }
}
