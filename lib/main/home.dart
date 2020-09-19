// import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import './home_compoments/appBar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var sampleImages = [
    'img/a.jpg',
    'img/b.jpg',
    'img/c.jpg',
    'img/d.jpg',
    'img/e.jpg',
    'img/f.jpg',
    'img/g.jpg',
    'img/i.jpg',
    'img/j.jpg',
    'img/k.jpg',
    'img/l.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffeba857),
        elevation: 0,
        title: Text('Talipapa', textAlign: TextAlign.center),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 15, 10, 20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: ' Search...'),
            ),
            SizedBox(height: 25),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                // crossAxisSpacing: 15,
                // mainAxisSpacing: 15,

                children: [
                  ...sampleImages.map((item) {
                    String img = item;
                    return Container(
                      height: double.maxFinite,
                      child: Card(
                        // margin: EdgeInsets.all(5),
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: MediaQuery.of(context).size.height / 5.3,
                              decoration: BoxDecoration(
                                // border: Border.all(color: Colors.grey),
                                // borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage(img),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: FlatButton(
                                child: Text(''),
                                color: Colors.transparent,
                                onPressed: () {}, //---------------------------

                                // shape: RoundedRectangleBorder(
                                //   borderRadius: BorderRadius.circular(20),
                                // ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Name'),
                                  Text('Price: 1000'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
