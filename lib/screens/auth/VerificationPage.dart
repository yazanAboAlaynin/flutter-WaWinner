import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_wawinner/blocs/auth_bloc/auth_event.dart';
import 'package:flutter_wawinner/blocs/auth_bloc/auth_state.dart';
import 'package:flutter_wawinner/repositories/auth_api.dart';
import 'package:http/http.dart' as http;

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  TextEditingController codeTextEditingController = TextEditingController();
  AuthBloc authBloc;
  AuthApi authApi = AuthApi(httpClient: http.Client());

  @override
  void initState() {
    super.initState();
    authBloc = AuthBloc(authApi: authApi);
  }

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    return BlocBuilder(
        cubit: authBloc,
        builder: (context, state) {
          if (state is AuthInitial || state is CodeVerified) {
            return SafeArea(
              child: Scaffold(
                body: Container(
                  width: sizeAware.width,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: sizeAware.height * 0.1,
                          ),
                          Text(
                            'Verification Code',
                            style: TextStyle(
                                color: Color.fromRGBO(127, 25, 168, 1),
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
                                SendCode(code: codeTextEditingController.text),
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
                          Text('Resend the code'),
                        ],
                      ),
                    ),
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
          if (state is AuthLoadFailure) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
