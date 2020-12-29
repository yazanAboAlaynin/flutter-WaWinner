import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_bloc.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_event.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_state.dart';
import 'package:flutter_wawinner/localization/localization_constants.dart';
import 'package:flutter_wawinner/models/currency.dart';
import 'package:flutter_wawinner/models/user.dart';
import 'package:flutter_wawinner/repositories/profile_api.dart';
import 'package:flutter_wawinner/widgets/AppBar.dart';
import 'package:flutter_wawinner/widgets/Loading.dart';
import 'package:flutter_wawinner/widgets/error.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';
import '../main.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileBloc profileBloc;
  ProfileApi profileApi = ProfileApi(httpClient: http.Client());
  User user;
  String prefLang = "EN";
  bool isEdited = false;
  List<Currency> currences = [];

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController f_nameTextEditingController = TextEditingController();
  TextEditingController l_nameTextEditingController = TextEditingController();
  TextEditingController statusTextEditingController = TextEditingController();
  TextEditingController genderTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController corTextEditingController = TextEditingController();
  TextEditingController nationalityTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    profileBloc = ProfileBloc(profileApi: profileApi);
    profileBloc.add(ProfileRequested());
  }

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    if (_image != null) {
      var data = {
        'email': emailTextEditingController.text,
        'first_name:ar': f_nameTextEditingController.text,
        'first_name:en': f_nameTextEditingController.text,
        'last_name:ar': l_nameTextEditingController.text,
        'last_name:en': l_nameTextEditingController.text,
        'address:ar': addressTextEditingController.text,
        'address:en': addressTextEditingController.text,
        'phone': phoneTextEditingController.text,
        'gender': genderTextEditingController.text,
        'status': statusTextEditingController.text,
        'nationality': nationalityTextEditingController.text,
        'country_of_residence': corTextEditingController.text,
      };

      profileBloc.add(UpdateProfileImageRequested(
        data: data,
        image: _image,
      ));
    }
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
          return CError(
            bloc: profileBloc,
            event: ProfileRequested(),
          );
        }
        if (state is ProfileLoadSuccess) {
          if (state.currencies != null) {
            currences = state.currencies;
          }

          user = state.user;

          if (!isEdited) {
            emailTextEditingController.text = user.email;

            phoneTextEditingController.text = user.phone;

            f_nameTextEditingController.text = user.first_name;

            l_nameTextEditingController.text = user.last_name;

            addressTextEditingController.text = user.address;

            corTextEditingController.text = user.country_of_residence;

            nationalityTextEditingController.text = user.nationality;
            genderTextEditingController.text = user.gender;

            statusTextEditingController.text = user.status;
            isEdited = true;
          }

          return Scaffold(
            appBar: myAppBar(getTranslated(context, 'Profile'), null),
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
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: sizeAware.height * 0.08,
                          backgroundImage: NetworkImage(
                            user.image,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              getImage();
                            },
                            child: Container(
                              width: sizeAware.height * 0.05,
                              height: sizeAware.height * 0.05,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[400],
                                      blurRadius: 5,
                                      offset: Offset(1, 1),
                                      spreadRadius: 2),
                                ],
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Color.fromRGBO(127, 25, 168, 1.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: sizeAware.height * 0.025,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getTranslated(context, 'Application Settings'),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.01,
                        ),
                        Container(
                          width: sizeAware.width,
                          height: sizeAware.height * 0.08,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22.0, vertical: 0),
                              child: DropdownButton<String>(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color.fromRGBO(127, 25, 168, 1.0),
                                ),
                                isExpanded: true,
                                underline: SizedBox(),
                                items: [
                                  DropdownMenuItem<String>(
                                    value: "ar",
                                    child: Text(
                                      "العربية",
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "en",
                                    child: Text(
                                      "english",
                                    ),
                                  ),
                                ],
                                onChanged: (value) async {
                                  if (value == "en") {
                                    setState(() {
                                      prefLang = "english";
                                    });
                                  } else {
                                    setState(() {
                                      prefLang = value;
                                    });
                                  }

                                  await changeLanguage(value);
                                  Navigator.popUntil(
                                      context, (route) => route.isFirst);
                                  Navigator.pushReplacementNamed(
                                      context, 'Campaignes');
                                },
                                hint: Text(
                                  getTranslated(context, 'Language'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.01,
                        ),
                        Container(
                          width: sizeAware.width,
                          height: sizeAware.height * 0.08,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22.0, vertical: 0),
                              child: DropdownButton<String>(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color.fromRGBO(127, 25, 168, 1.0),
                                ),
                                isExpanded: true,
                                underline: SizedBox(),
                                items: currences.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.value,
                                    child: Text(
                                      item.name,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  preferences.setString('currency', value);
                                  CURRENCY = value;
                                  await changeLanguage(value);
                                  Navigator.popUntil(
                                      context, (route) => route.isFirst);
                                  Navigator.pushReplacementNamed(
                                      context, 'Campaignes');
                                },
                                hint: Text(
                                  getTranslated(context, 'Currency'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.03,
                        ),
                        Text(
                          getTranslated(context, 'Account Settings'),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.01,
                        ),
                        Container(
                          height: sizeAware.height * 0.11,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: sizeAware.height,
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: LANGUAGE == 'en'
                                          ? BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                            )
                                          : BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[400],
                                          blurRadius: 5,
                                          offset: Offset(1, 1),
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          ' ${getTranslated(context, 'Email')}:  ',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                127, 25, 168, 1.0),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: TextFormField(
                                              controller:
                                                  emailTextEditingController,
                                              decoration: InputDecoration(
                                                hintText: 'test@test.c',
                                                // disabledBorder: InputBorder.none,
                                                // enabledBorder: InputBorder.none,
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: sizeAware.height,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(127, 25, 168, 1.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[400],
                                          blurRadius: 5,
                                          offset: Offset(2, 1),
                                          spreadRadius: 2),
                                    ],
                                    borderRadius: LANGUAGE == 'ar'
                                        ? BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          )
                                        : BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: sizeAware.height * 0.11,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: sizeAware.height,
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: LANGUAGE == 'en'
                                          ? BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                            )
                                          : BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[400],
                                            blurRadius: 5,
                                            offset: Offset(1, 1),
                                            spreadRadius: 2),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          ' ${getTranslated(context, 'Phone')}:  ',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                127, 25, 168, 1.0),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                                phoneTextEditingController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: '09999999',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: sizeAware.height,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(127, 25, 168, 1.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[400],
                                          blurRadius: 5,
                                          offset: Offset(2, 1),
                                          spreadRadius: 2),
                                    ],
                                    borderRadius: LANGUAGE == 'ar'
                                        ? BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          )
                                        : BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                  ),
                                  child: Icon(Icons.edit, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.03,
                        ),
                        Text(
                          getTranslated(context, 'Personal Settings'),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.01,
                        ),
                        Container(
                          height: sizeAware.height * 0.11,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: sizeAware.height,
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: LANGUAGE == 'en'
                                          ? BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                            )
                                          : BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[400],
                                            blurRadius: 5,
                                            offset: Offset(1, 1),
                                            spreadRadius: 2),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          ' ${getTranslated(context, 'First Name')}:  ',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                127, 25, 168, 1.0),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                                f_nameTextEditingController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'First Name',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: sizeAware.height,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(127, 25, 168, 1.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[400],
                                          blurRadius: 5,
                                          offset: Offset(2, 1),
                                          spreadRadius: 2),
                                    ],
                                    borderRadius: LANGUAGE == 'ar'
                                        ? BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          )
                                        : BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                  ),
                                  child: Icon(Icons.edit, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: sizeAware.height * 0.11,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: sizeAware.height,
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: LANGUAGE == 'en'
                                          ? BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                            )
                                          : BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[400],
                                            blurRadius: 5,
                                            offset: Offset(1, 1),
                                            spreadRadius: 2),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          ' ${getTranslated(context, 'Last Name')}:  ',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                127, 25, 168, 1.0),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                                l_nameTextEditingController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Last Name',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: sizeAware.height,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(127, 25, 168, 1.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[400],
                                          blurRadius: 5,
                                          offset: Offset(2, 1),
                                          spreadRadius: 2),
                                    ],
                                    borderRadius: LANGUAGE == 'ar'
                                        ? BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          )
                                        : BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                  ),
                                  child: Icon(Icons.edit, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: sizeAware.height * 0.11,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: sizeAware.height,
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: LANGUAGE == 'en'
                                          ? BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                            )
                                          : BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[400],
                                            blurRadius: 5,
                                            offset: Offset(1, 1),
                                            spreadRadius: 2),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          ' ${getTranslated(context, 'Address')}:  ',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                127, 25, 168, 1.0),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                                addressTextEditingController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Address',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: sizeAware.height,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(127, 25, 168, 1.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[400],
                                          blurRadius: 5,
                                          offset: Offset(2, 1),
                                          spreadRadius: 2),
                                    ],
                                    borderRadius: LANGUAGE == 'ar'
                                        ? BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          )
                                        : BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                  ),
                                  child: Icon(Icons.edit, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: sizeAware.height * 0.11,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: sizeAware.height,
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: LANGUAGE == 'en'
                                          ? BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                            )
                                          : BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[400],
                                            blurRadius: 5,
                                            offset: Offset(1, 1),
                                            spreadRadius: 2),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          ' ${getTranslated(context, 'Nationality')}:  ',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                127, 25, 168, 1.0),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                                nationalityTextEditingController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Nationality',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: sizeAware.height,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(127, 25, 168, 1.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[400],
                                          blurRadius: 5,
                                          offset: Offset(2, 1),
                                          spreadRadius: 2),
                                    ],
                                    borderRadius: LANGUAGE == 'ar'
                                        ? BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          )
                                        : BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                  ),
                                  child: Icon(Icons.edit, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: sizeAware.height * 0.11,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: sizeAware.height,
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: LANGUAGE == 'en'
                                          ? BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                            )
                                          : BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[400],
                                            blurRadius: 5,
                                            offset: Offset(1, 1),
                                            spreadRadius: 2),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          ' ${getTranslated(context, 'Country of residence')}:  ',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                127, 25, 168, 1.0),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                                corTextEditingController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Country of residence',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: sizeAware.height,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(127, 25, 168, 1.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[400],
                                          blurRadius: 5,
                                          offset: Offset(2, 1),
                                          spreadRadius: 2),
                                    ],
                                    borderRadius: LANGUAGE == 'ar'
                                        ? BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          )
                                        : BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                  ),
                                  child: Icon(Icons.edit, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.02,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: sizeAware.height * 0.08,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(127, 25, 168, 1.0),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0, vertical: 4),
                                    child: DropdownButton<String>(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      ),
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: "Single",
                                          child: Text(
                                            getTranslated(context, "Single"),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: "Married",
                                          child: Text(
                                            getTranslated(context, "Married"),
                                          ),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          statusTextEditingController.text =
                                              value;
                                        });
                                      },
                                      hint: Text(
                                        getTranslated(context, 'Status'),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: sizeAware.width * 0.02,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: sizeAware.height * 0.08,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(127, 25, 168, 1.0),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0, vertical: 4),
                                    child: DropdownButton<String>(
                                      value: genderTextEditingController.text ??
                                          null,
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      ),
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      dropdownColor:
                                          Color.fromRGBO(127, 25, 168, 1.0),
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: "1",
                                          child: Text(
                                            getTranslated(context, "Male"),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: "0",
                                          child: Text(
                                            getTranslated(context, "Female"),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          isEdited = true;
                                          genderTextEditingController.text =
                                              value;
                                        });
                                      },
                                      hint: Text(
                                        getTranslated(context, 'Gender'),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: sizeAware.height * 0.03),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'Change Password',
                                arguments: {'user_id': user.id});
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
                                      getTranslated(context, 'Change Password'),
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
                        SizedBox(height: sizeAware.height * 0.03),
                        GestureDetector(
                          onTap: () {
                            var data = {
                              'email': emailTextEditingController.text,
                              'first_name:ar': f_nameTextEditingController.text,
                              'first_name:en': f_nameTextEditingController.text,
                              'last_name:ar': l_nameTextEditingController.text,
                              'last_name:en': l_nameTextEditingController.text,
                              'address:ar': addressTextEditingController.text,
                              'address:en': addressTextEditingController.text,
                              'phone': phoneTextEditingController.text,
                              'gender': genderTextEditingController.text,
                              'status': statusTextEditingController.text,
                              'nationality':
                                  nationalityTextEditingController.text,
                              'country_of_residence':
                                  corTextEditingController.text,
                            };

                            profileBloc.add(UpdateProfileRequested(
                              data: data,
                            ));
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
                                      getTranslated(context, 'Save'),
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
                    SizedBox(
                      height: sizeAware.height * 0.1,
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

  void changeLanguage(languageCode) async {
    Locale temp = await setLocale(languageCode);
    MyApp.setLocale(context, temp);
  }
}
