import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_wawinner/blocs/auth_bloc/auth_event.dart';
import 'package:flutter_wawinner/blocs/auth_bloc/auth_state.dart';
import 'package:flutter_wawinner/localization/localization_constants.dart';
import 'package:flutter_wawinner/repositories/auth_api.dart';
import 'package:flutter_wawinner/widgets/Loading.dart';
import 'package:http/http.dart' as http;

import 'VerificationPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isVis = true;
  AuthBloc authBloc;
  AuthApi authApi = AuthApi(httpClient: http.Client());
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController firstNameTextEditingController =
      TextEditingController();
  TextEditingController lastNameTextEditingController = TextEditingController();
  TextEditingController arAddressTextEditingController =
      TextEditingController();
  TextEditingController enAddressTextEditingController =
      TextEditingController();
  TextEditingController numberTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

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
        if (state is RegisterSuccess) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => VerificationPage()));
        }
      },
      child: BlocBuilder(
          cubit: authBloc,
          builder: (context, state) {
            if (state is AuthInitial || state is RegisterSuccess) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Container(
                    width: sizeAware.width,
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: sizeAware.height * 0.3,
                        ),
                        Text(
                          'Register',
                          style: TextStyle(
                              color: Color.fromRGBO(127, 25, 168, 1),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.02,
                        ),
                        TextFormField(
                          controller: firstNameTextEditingController,
                          decoration: InputDecoration(
                            labelText: 'First Name',
                          ),
                        ),
                        TextFormField(
                          controller: lastNameTextEditingController,
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                          ),
                        ),
                        TextFormField(
                          controller: arAddressTextEditingController,
                          decoration: InputDecoration(
                            labelText: 'Arabic Address',
                          ),
                        ),
                        TextFormField(
                          controller: enAddressTextEditingController,
                          decoration: InputDecoration(
                            labelText: 'English Address',
                          ),
                        ),
                        TextFormField(
                          controller: emailTextEditingController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                        TextFormField(
                          controller: numberTextEditingController,
                          decoration: InputDecoration(
                            labelText: 'Mobile number',
                          ),
                        ),
                        TextFormField(
                          obscureText: isVis,
                          controller: passwordTextEditingController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {
                                setState(() {
                                  isVis = !isVis;
                                });
                              },
                            ),
                          ),
                        ),
                        TextFormField(
                          obscureText: isVis,
                          controller: confirmPasswordTextEditingController,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {
                                setState(() {
                                  isVis = !isVis;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.03,
                        ),
                        Container(
                          width: sizeAware.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  authBloc.add(RegisterRequested(
                                      email: emailTextEditingController.text,
                                      password:
                                          passwordTextEditingController.text,
                                      address_ar:
                                          arAddressTextEditingController.text,
                                      address_en:
                                          enAddressTextEditingController.text,
                                      first_name_ar:
                                          firstNameTextEditingController.text,
                                      first_name_en:
                                          firstNameTextEditingController.text,
                                      last_name_ar:
                                          lastNameTextEditingController.text,
                                      last_name_en:
                                          lastNameTextEditingController.text,
                                      number: numberTextEditingController.text,
                                      password_confirmation:
                                          confirmPasswordTextEditingController
                                              .text));
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
                                          'Register',
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
                                height: sizeAware.height * 0.03,
                              ),
                              Container(
                                width: sizeAware.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already have an account? ',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Color.fromRGBO(53, 9, 100, 1.0),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.1,
                        ),
                      ],
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
