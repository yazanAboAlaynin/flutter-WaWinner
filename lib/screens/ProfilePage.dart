import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_bloc.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_event.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_state.dart';
import 'package:flutter_wawinner/models/user.dart';
import 'package:flutter_wawinner/repositories/profile_api.dart';
import 'package:flutter_wawinner/screens/shared/AppBar.dart';
import 'package:flutter_wawinner/screens/shared/Loading.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileBloc profileBloc;
  ProfileApi profileApi = ProfileApi(httpClient: http.Client());
  User user;

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
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProfileLoadSuccess) {
          user = state.user;
          emailTextEditingController.text = user.email;

          phoneTextEditingController.text = user.phone;

          f_nameTextEditingController.text = user.first_name;

          l_nameTextEditingController.text = user.last_name;

          addressTextEditingController.text = user.address;

          corTextEditingController.text = user.country_of_residence;

          nationalityTextEditingController.text = user.nationality;

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
                            onTap: () {},
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
                          'Application Settings',
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
                                  color: Color.fromRGBO(18, 161, 154, 1.0),
                                ),
                                isExpanded: true,
                                underline: SizedBox(),
                                items: [
                                  DropdownMenuItem<String>(
                                    value: "ar",
                                    child: Text(
                                      "العربية",
                                      style: TextStyle(fontFamily: 'GeSS'),
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "en",
                                    child: Text(
                                      "english",
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value == "en") {
                                    setState(() {
                                      // prefLang = "english";
                                    });
                                  } else {
                                    setState(() {
                                      // prefLang = value;
                                    });
                                  }
                                  //   Map<String, String> dataa = {
                                  //     'ph_name_en': pharmacy.ph_name_en,
                                  //     'ph_name_ar': pharmacy.ph_name_ar,
                                  //     'ph_phone1': pharmacy.ph_phone1,
                                  //     'ph_mobile': pharmacy.ph_mobile,
                                  //     'ph_address_en': pharmacy.ph_address_en,
                                  //     'ph_address_ar': pharmacy.ph_address_ar,
                                  //     'region_id': pharmacy.region_id,
                                  //     'pref_lang': prefLang
                                  //   };
                                  //   profileBloc
                                  //       .add(UpdateProfileRequested(data: dataa));
                                  //   changeLanguage(value);
                                },
                                hint: Text(
                                  'pref lang',
                                  // "${getTranslated(context, "Preferred Language")}:     ${pharmacy.pref_lang}",
                                  style: TextStyle(fontFamily: 'GeSS'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.03,
                        ),
                        Text(
                          'Account Settings',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.01,
                        ),
                        Container(
                          height: sizeAware.height * 0.09,
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
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10),
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
                                          ' Email:  ',
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
                                                emailTextEditingController,
                                            decoration: InputDecoration(
                                              hintText: 'test@test.c',
                                              // disabledBorder: InputBorder.none,
                                              // enabledBorder: InputBorder.none,
                                              border: InputBorder.none,
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
                                    borderRadius: BorderRadius.only(
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
                          height: sizeAware.height * 0.09,
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
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10),
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
                                          ' Phone:  ',
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
                                              hintText: 'test@test.c',
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
                                    borderRadius: BorderRadius.only(
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
                          'Personal Settings',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: sizeAware.height * 0.01,
                        ),
                        Container(
                          height: sizeAware.height * 0.09,
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
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10),
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
                                          ' First Name:  ',
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
                                              hintText: 'test@test.c',
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
                                    borderRadius: BorderRadius.only(
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
                          height: sizeAware.height * 0.09,
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
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10),
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
                                          ' Last Name:  ',
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
                                              hintText: 'test@test.c',
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
                                    borderRadius: BorderRadius.only(
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
                          height: sizeAware.height * 0.09,
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
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10),
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
                                          ' Address:  ',
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
                                              hintText: 'test@test.c',
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
                                    borderRadius: BorderRadius.only(
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
                          height: sizeAware.height * 0.09,
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
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10),
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
                                          ' Nationality:  ',
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
                                              hintText: 'test@test.c',
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
                                    borderRadius: BorderRadius.only(
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
                                            "Single",
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: "Married",
                                          child: Text(
                                            "Married",
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
                                        'Status',
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
                                      // value: statusTextEditingController.text,
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      ),
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: "Male",
                                          child: Text(
                                            "Male",
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: "Female",
                                          child: Text(
                                            "Female",
                                          ),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          genderTextEditingController.text =
                                              value;
                                        });
                                      },
                                      hint: Text(
                                        'Gender',
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
                        SizedBox(height: sizeAware.height * 0.03),
                        GestureDetector(
                          onTap: () {
                            var data = {
                              // '': ''
                            };
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
                                      'Save',
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
}
