import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talipapa/main/detail.dart';
import 'package:talipapa/model/product.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference _productsData;
  List<Product> _products;
  var file;
  bool isSearch = false;
  void _loadProducts() async {
    _productsData = FirebaseFirestore.instance.collection('products');
    if (_productsData != null) {
      _products = [];
      QuerySnapshot data = await _productsData.get();
      for (QueryDocumentSnapshot item in data.docs) {
        Product currProduct = Product.withID(
            item.reference,
            item.get("productowner"),
            item.get("productname"),
            item.get("productprice"),
            item.get("productdescription"),
            item.get("productimage"),
            item.get("type"));

        _products.add(currProduct);
      }
      print(_products);
    }
    setState(() {});
  }

  var resultSearch = [];
  var tempSearch = [];

  _search(String val) async {
    if (val.length == 0) {
      setState(() {
        _loadProducts();
      });
    }
    if (val.length > 0) {
      var toCapVal = val.toLowerCase();

      List<DocumentSnapshot> documentList;
      documentList = (await FirebaseFirestore.instance
              .collection("products")
              .where("productname", isGreaterThanOrEqualTo: toCapVal)
              .where("productname", isLessThan: toCapVal + 'z')
              .get())
          .docs;
      _products.clear();
      for (DocumentSnapshot item in documentList) {
        Product currProduct = Product.withID(
            item.reference,
            item.get("productowner"),
            item.get("productname"),
            item.get("productprice"),
            item.get("productdescription"),
            item.get("productimage"),
            item.get('type'));
        _products.add(currProduct);
      }
      setState(() {
        print(_products);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_products == null) {
      _loadProducts();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3c3a1e),
        elevation: 0,
        title: !isSearch
            ? Text('Talipapa', textAlign: TextAlign.center)
            : TextField(
                onChanged: (val) {
                  _search(val);
                },
                style: TextStyle(color: Colors.white),

                // onEditingComplete: _loadProducts,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Search...',
                ),
              ),
        actions: [
          IconButton(
              icon: !isSearch ? Icon(Icons.search) : Icon(Icons.cancel),
              onPressed: () {
                setState(() {
                  isSearch = !isSearch;
                  if (!isSearch) _loadProducts();
                });
              })
        ],
      ),
      body: Container(
        color: Color(0xffe3deca),
        padding: EdgeInsets.fromLTRB(10, 15, 10, 20),
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            Expanded(
              child: _products.length == 0
                  ? Center(
                      child: Container(
                        // width: 50,
                        child: Text("no products listed"),
                      ),
                    )
                  : GridView.count(
                      crossAxisCount: 2,
                      children: [
                        ..._products.map((item) {
                          return Container(
                            color: Colors.transparent,
                            height: double.maxFinite,
                            child: Card(
                              elevation: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),
                                  Container(
                                    width: double.maxFinite,
                                    height: 130,
                                    child: FlatButton(
                                      child: Image.network(item.getProdImages(),
                                          fit: BoxFit.cover),
                                      color: Colors.transparent,
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, DetailScreen.routeName,
                                            arguments: Product(
                                                item.getProdOwner(),
                                                item.getProdName(),
                                                item.getProdPrice(),
                                                item.getProdDescription(),
                                                item.getProdImages(),
                                                item.getType()));
                                      }, //---------------------------
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(item.getProdName()),
                                        Text('Price: ' + item.getProdPrice()),
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
