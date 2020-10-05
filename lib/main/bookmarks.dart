import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talipapa/main/detail.dart';
import 'package:talipapa/model/bookmark.dart';
import 'package:talipapa/model/product.dart';

class BookmarkScreen extends StatefulWidget {
  final User user;
  BookmarkScreen({
    Key key,
    @required this.user,
  }) : super(key: key);
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  CollectionReference _bookmarksData;
  List<Bookmark> _bookmarks;
  bool isSearch = false;
  void _loadBookmarks() async {
    _bookmarksData = FirebaseFirestore.instance.collection('bookmarks');
    if (_bookmarksData != null) {
      _bookmarks = [];
      QuerySnapshot data = await _bookmarksData.get();
      for (QueryDocumentSnapshot item in data.docs) {
        Bookmark currBookmark = Bookmark.withID(
            item.reference,
            item.get("bookmarkowner"),
            item.get("productname"),
            item.get("productprice"),
            item.get("productowner"),
            item.get("productdescription"),
            item.get("productimage"),
            item.get("type"));
        if (item.get("bookmarkowner") == widget.user.email) {
          _bookmarks.add(currBookmark);
        }
      }
      print(_bookmarks);
    }
    setState(() {});
  }

  var resultSearch = [];
  var tempSearch = [];

  _search(String val) async {
    if (val.length == 0) {
      setState(() {
        _loadBookmarks();
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
      _bookmarks.clear();
      for (DocumentSnapshot item in documentList) {
        Bookmark currProduct = Bookmark.withID(
            item.reference,
            item.get("bookmarkowner"),
            item.get("productname"),
            item.get("productprice"),
            item.get("productowner"),
            item.get("productdescription"),
            item.get("productimage"),
            item.get("type"));
        _bookmarks.add(currProduct);
      }
      setState(() {
        print(_bookmarks);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_bookmarks == null) {
      _loadBookmarks();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3c3a1e),
        elevation: 0,
        title: !isSearch
            ? Text('Bookmarks', textAlign: TextAlign.center)
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
                  if (!isSearch) _loadBookmarks();
                });
              })
        ],
      ),
      body: Container(
        color: Color(0xffe3deca),
        padding: EdgeInsets.fromLTRB(10, 15, 10, 20),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  if (_bookmarks.length == 0)
                    Container(
                      child: Text('There are no saved products.'),
                    )
                  else
                    ..._bookmarks.map((item) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.getProdName()),
                                    Text('Price:' + item.getProdPrice()),
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
