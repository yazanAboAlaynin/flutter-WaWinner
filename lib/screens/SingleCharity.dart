import 'package:flutter/material.dart';
import 'package:flutter_wawinner/models/charity.dart';
import 'package:flutter_wawinner/widgets/AppBar.dart';

class SingleCharity extends StatelessWidget {
  Charity charity;

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    final Map args = ModalRoute.of(context).settings.arguments;
    charity = args['charity'];
    return Scaffold(
      appBar: myAppBar('Charity', null),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Image.network(
                  charity.image,
                  height: sizeAware.height * 0.4,
                  width: sizeAware.width,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                charity.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(charity.description),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: Center(
                  child: Container(
                    width: sizeAware.width,
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
                            'Learn More',
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
}
