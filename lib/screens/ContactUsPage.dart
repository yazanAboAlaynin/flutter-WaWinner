import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_bloc.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_event.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_state.dart';
import 'package:flutter_wawinner/localization/localization_constants.dart';
import 'package:flutter_wawinner/repositories/profile_api.dart';
import 'package:flutter_wawinner/widgets/AppBar.dart';
import 'package:flutter_wawinner/widgets/Loading.dart';
import 'package:flutter_wawinner/widgets/error.dart';
import 'package:http/http.dart' as http;

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController messageTextEditingController = TextEditingController();

  ProfileApi profileApi = ProfileApi(httpClient: http.Client());
  ProfileBloc profileBloc;

  @override
  void initState() {
    super.initState();
    profileBloc = ProfileBloc(profileApi: profileApi);
  }

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;

    return BlocBuilder(
      cubit: profileBloc,
      builder: (context, state) {
        if (state is ProfileLoadInProgress) {
          return Loading();
        }
        if (state is ProfileLoadFailure) {
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
                          profileBloc = ProfileBloc(profileApi: profileApi);
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

        if (state is ProfileInitial ||
            state is MessageSent ||
            state is MessageFaield) {
          nameTextEditingController.text = '';
          emailTextEditingController.text = '';
          messageTextEditingController.text = '';
          return Scaffold(
            appBar: myAppBar(getTranslated(context, 'Contact Us'), null),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTranslated(context, 'Contact'),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: sizeAware.height * 0.01),
                    Text(
                      getTranslated(context,
                          'Please fill in the form below and a dedicated member of our team will be in touch within 24'),
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: sizeAware.height * 0.01),
                    TextFormField(
                      controller: nameTextEditingController,
                      decoration: InputDecoration(
                        labelText: getTranslated(context, 'Name'),
                      ),
                    ),
                    TextFormField(
                      controller: emailTextEditingController,
                      decoration: InputDecoration(
                        labelText: getTranslated(context, 'Email'),
                      ),
                    ),
                    Container(
                      height: sizeAware.height * 0.12,
                      child: TextFormField(
                        controller: messageTextEditingController,
                        expands: true,
                        decoration: InputDecoration(
                          labelText: getTranslated(context, 'Message'),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    ),
                    SizedBox(
                      height: sizeAware.height * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (nameTextEditingController.text != '' &&
                            emailTextEditingController.text != '' &&
                            messageTextEditingController.text != '') {
                          var data = {
                            'name': nameTextEditingController.text,
                            'email': emailTextEditingController.text,
                            'message': messageTextEditingController.text,
                          };
                          profileBloc.add(ContactUsRequested(data: data));
                        }
                      },
                      child: Center(
                        child: Container(
                          width: sizeAware.width * 0.85,
                          height: 50.0,
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
                                  getTranslated(context, 'Send Message'),
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
      },
    );
  }
}
