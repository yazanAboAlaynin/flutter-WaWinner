import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
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
                decoration: InputDecoration(
                  labelText: 'First name',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Last name',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mobile number',
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: Icon(Icons.remove_red_eye),
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
                    MaterialButton(
                      onPressed: () {},
                      height: 45.0,
                      minWidth: sizeAware.width * 0.85,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(40),
                            right: Radius.circular(40)),
                      ),
                      color: Color.fromRGBO(127, 25, 168, 1),
                      textColor: Colors.white,
                      child: new Text(
                        'Register',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      splashColor: Color.fromRGBO(53, 9, 100, 1.0),
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
}
