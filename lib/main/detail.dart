import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  // final _index;
  // Detail(this._index);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // final _index;
  // _DetailState(this._index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffeba857),
        elevation: 0,
        title: Text('Product Details', textAlign: TextAlign.center),
      ),
      body: Center(
        child: Container(
          width: 320,
          // decoration: BoxDecoration(
          //   border: Border.all(width: .5),
          // ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: ,
            children: [
              SizedBox(height: 10),
              Container(
                //image here
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(width: .5),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      '[Product Name]',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text('[Price]'),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: 280,
                // decoration: BoxDecoration(border: Border.all(width: 2)),
                child: Text(
                  'DESCRIPTION',
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: 280,
                height: 150,
                // decoration: BoxDecoration(border: Border.all(width: 1)),
                child: Text('blah blah blah'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '[Author]',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.bookmark),
                    ),
                  ),
                ],
              ),
              Container(
                width: 250,
                child: RaisedButton(
                  color: Colors.orange,
                  onPressed: () {},
                  child: Text('Chat Seller'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
