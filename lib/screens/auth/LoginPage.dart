import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isVis = true;
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: sizeAware.height * 0.01,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              TextFormField(
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
                        'Login',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      splashColor: Color.fromRGBO(53, 9, 100, 1.0),
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
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sizeAware.height * 0.03,
                    ),
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      height: sizeAware.height * 0.02,
                    ),
                    Container(
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
}
