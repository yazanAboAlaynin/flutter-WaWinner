import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_bloc.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_event.dart';
import 'package:flutter_wawinner/blocs/profile_bloc/profile_state.dart';
import 'package:flutter_wawinner/models/user.dart';
import 'package:flutter_wawinner/repositories/profile_api.dart';
import 'package:flutter_wawinner/screens/shared/AppBar.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileBloc profileBloc;
  ProfileApi profileApi = ProfileApi(httpClient: http.Client());
  User user;

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
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProfileLoadFailure) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProfileLoadSuccess) {
          user = state.user;
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
                        Text('Application Settings'),
                        Container(
                          width: sizeAware.width,
                          height: sizeAware.height * 0.07,
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
                        Text('Account Settings'),
                        Container(
                          height: sizeAware.height * 0.08,
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
                                            decoration: InputDecoration(
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
                          height: sizeAware.height * 0.08,
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
                                            decoration: InputDecoration(
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
                          height: sizeAware.height * 0.08,
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
                                            decoration: InputDecoration(
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
                        Text('Account Settings'),
                        Container(
                          height: sizeAware.height * 0.08,
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
                                            decoration: InputDecoration(
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
                          height: sizeAware.height * 0.08,
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
                                            decoration: InputDecoration(
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
                          height: sizeAware.height * 0.08,
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
                                            decoration: InputDecoration(
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
                          height: sizeAware.height * 0.08,
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
                                            decoration: InputDecoration(
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
                      ],
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
