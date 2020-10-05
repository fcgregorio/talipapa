import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'dart:io';
// ignore: unused_import
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:image_picker/image_picker.dart'; // For Image Picker

class CreateProduct extends StatefulWidget {
  final User user;
  CreateProduct({
    Key key,
    @required this.user,
  }) : super(key: key);
  @override
  _CreateProduct createState() => _CreateProduct();
}

class _CreateProduct extends State<CreateProduct> {
  final _productnameController = TextEditingController();
  final _productpriceController = TextEditingController();
  final _productdescriptionController = TextEditingController();
  final maxLines = 5;
  File _imageFile;
  String filePath;
  var downloadUrl;
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://talipapa-b18df.appspot.com');
  StorageUploadTask _uploadTask;

  Future<void> _pickImage(ImageSource source) async {
    // ignore: deprecated_member_use
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }

  void addProduct(BuildContext context) async {
    String productname = _productnameController.text;
    String productprice = _productpriceController.text;
    String productdescription = _productdescriptionController.text;
    String type ='1';
    filePath = 'img/${DateTime.now()}.png';
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(_imageFile);
    });
    StorageTaskSnapshot storageSnapshot = await _uploadTask.onComplete;
    downloadUrl = await storageSnapshot.ref.getDownloadURL();
    print(downloadUrl.toString());
    if (_uploadTask.isComplete) {
      downloadUrl = downloadUrl.toString();
      print(downloadUrl);
      await FirebaseFirestore.instance.runTransaction((transaction) =>
          FirebaseFirestore.instance.collection("products").add({
            "productowner": widget.user.email,
            "productimage": downloadUrl,
            "productname": productname.toLowerCase(),
            "productprice": productprice,
            "productdescription": productdescription,
            "type": type
          }));
    }
    Navigator.pop(
      context,
    );
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("Product Added!!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Product', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown,
      ),
      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Image.file(_imageFile)),
          ],
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Builder(builder: (context) {
              return Row(children: [
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      _pickImage(ImageSource.gallery);
                    },
                    color: Colors.brown,
                    child: Text("Choose File",
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  ),
                )
              ]);
            }),
          ),

          //Product name
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              style: TextStyle(
                fontSize: 20.0,
              ),
              decoration: InputDecoration(
                labelText: 'Product Name',
                labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                // hintText: 'Enter product',
              ),
              controller: _productnameController,
            ),
          ),
          //Product Price
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 20.0,
              ),
              decoration: InputDecoration(
                labelText: 'Product Price',
                labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                // hintText: 'Enter price',
              ),
              controller: _productpriceController,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              maxLines: maxLines,
              style: TextStyle(
                fontSize: 20.0,
              ),
              decoration: InputDecoration(
                labelText: 'Product Description',
                labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                // hintText: 'Enter Description',
              ),
              controller: _productdescriptionController,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Builder(builder: (context) {
              return Row(children: [
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      addProduct(context);
                    },
                    color: Colors.brown,
                    child: Text("Save",
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  ),
                )
              ]);
            }),
          ),
        ],
      ),
    );
  }
}
