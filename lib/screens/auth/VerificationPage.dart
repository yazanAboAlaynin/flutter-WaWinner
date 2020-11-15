import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/auth_bloc/auth_state.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  TextEditingController codeTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    return BlocBuilder(builder: (context, state) {
      if (state is AuthInitial || state is CodeVerified) {
        return Scaffold(
          body: Container(
            width: sizeAware.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Verification Code',
                      style: TextStyle(
                          color: Color.fromRGBO(127, 25, 168, 1),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: sizeAware.height * 0.2,
                    ),
                    TextFormField(
                      controller: codeTextEditingController,
                      decoration: InputDecoration(
                        labelText: 'Code',
                      ),
                    ),
                  ],
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
