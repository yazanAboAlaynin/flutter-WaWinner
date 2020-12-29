import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/Constants.dart';
import 'package:flutter_wawinner/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_wawinner/blocs/auth_bloc/auth_event.dart';
import 'package:flutter_wawinner/blocs/auth_bloc/auth_state.dart';
import 'package:flutter_wawinner/localization/localization_constants.dart';
import 'package:flutter_wawinner/repositories/auth_api.dart';
import 'package:flutter_wawinner/screens/auth/RegisterPage.dart';
import 'package:flutter_wawinner/screens/auth/VerificationPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthBloc authBloc;
  AuthApi authApi = AuthApi(httpClient: http.Client());
  bool isVis = true;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

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
        if (state is LoginSuccess) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, 'Campaignes');
        }
        if (state is LoginError) {
          Fluttertoast.showToast(msg: "Error Try Again");
        }
        if (state is NotVerified) {
          Fluttertoast.showToast(msg: "You need to verify your account");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => VerificationPage()));
        }
      },
      child: BlocBuilder(
        cubit: authBloc,
        builder: (context, state) {
          if (state is AuthInitial ||
              state is LoginError ||
              state is NotVerified) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Container(
                  width: sizeAware.width,
                  height: sizeAware.height,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                            color: Color.fromRGBO(53, 9, 100, 1.0),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: sizeAware.height * 0.01,
                      ),
                      Text(
                        'Sign in to continue',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: sizeAware.height * 0.01,
                      ),
                      TextFormField(
                        controller: emailTextEditingController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                      ),
                      TextFormField(
                        controller: passwordTextEditingController,
                        obscureText: isVis,
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
                                authBloc.add(LoginRequested(
                                    email: emailTextEditingController.text,
                                    password:
                                        passwordTextEditingController.text));
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
                                        'Login',
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
                              height: sizeAware.height * 0.02,
                            ),
                            Text(
                              'or',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(
                              height: sizeAware.height * 0.02,
                            ),
                            Container(
                              width: sizeAware.width * 0.85,
                              height: 45.0,
                              decoration: BoxDecoration(
                                border: Border.all(),
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
                                      'Login with Facebook',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: sizeAware.height * 0.03,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, 'Forgot Password');
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: sizeAware.height * 0.02,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ),
                                );
                              },
                              child: Container(
                                width: sizeAware.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Don\'t have an account? ',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Color.fromRGBO(53, 9, 100, 1.0),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: sizeAware.height * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
            );
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
          if (state is AuthLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoginSuccess) {
            return Container();
          }
        },
      ),
    );
  }
}
