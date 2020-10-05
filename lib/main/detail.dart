import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:talipapa/model/product.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/DetailScreen';
  final User user;
  DetailScreen({
    Key key,
    @required this.user,
  }) : super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Product args;
  void addBookmark(BuildContext context) async {
    String productname = args.getProdName();
    String productprice = args.getProdPrice();
    String productowner = args.getProdOwner();
    String productdescription = args.getProdDescription();
    String productimage = args.getProdImages();
    String type = '0';
    await FirebaseFirestore.instance.runTransaction((transaction) =>
        FirebaseFirestore.instance.collection("bookmarks").add({
          "bookmarkowner": widget.user.email,
          "productname": productname,
          "productprice": productprice,
          "productowner": productowner,
          "productdescription": productdescription,
          "productimage": productimage,
          "type": type
        }));
    Navigator.pop(
      context,
    );
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("Bookmark Added!!")));
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3c3a1e),
        elevation: 0,
        title: Text('Product Details', textAlign: TextAlign.center),
      ),
      body: Container(
        color: Color(0xffe3deca),
         padding: EdgeInsets.fromLTRB(10, 15, 10, 20),
          child: ListView(
            children: [
              SizedBox(height: 10),
              Container(
                child: Image.network(args.getProdImages()),
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: 300,
                height: 250,
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
                      'Product: ' + args.getProdName(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Price: Php ' + args.getProdPrice(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: 280,
                child: Text(
                  'DESCRIPTION: ',
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: 280,
                height: 150,
                child: Text(args.getProdDescription()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Seller: ' + args.getProdOwner(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  // ignore: unrelated_type_equality_checks
                  widget.user.email != args.getProdOwner()
                      ? args.getType() == '1'
                          ? Padding(
                              padding: const EdgeInsets.all(10),
                              child: IconButton(
                                onPressed: () {
                                  addBookmark(context);
                                },
                                icon: Icon(Icons.bookmark),
                              ),
                            )
                          : Container()
                      : Container(),
                ],
              ),         
              widget.user.email != args.getProdOwner()
                  ? Container(
                      width: 250,
                      child: RaisedButton(
                        color: Colors.brown,
                        onPressed: () async {
                          final doc = await FirebaseFirestore.instance
                              .collection('chats')
                              .add({
                            "bookmarkowner": widget.user.email,
                            "productname": args.getProdName(),
                            "productprice": args.getProdPrice(),
                            "productowner": args.getProdOwner(),
                            "productdescription": args.getProdDescription(),
                            "productimage": args.getProdImages(),
                            "productbuyer": widget.user.email,
                            "users": [widget.user.email, args.getProdOwner()],
                            "timestamp": FieldValue.serverTimestamp(),
                          });

                          Navigator.popAndPushNamed(
                            context,
                            'chatbox',
                            arguments: {
                              'id': doc.id,
                            },
                          );
                        },
                        child: Text('Chat Seller'),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      
    );
  }
}
