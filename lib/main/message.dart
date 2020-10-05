import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talipapa/model/user.dart';

class MessageScreen extends StatefulWidget {
  final User user;

  MessageScreen({
    Key key,
    @required this.user,
  }) : super(key: key);
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  CollectionReference _usersData;
  List<Users> _users;
  void _loadMessages() async {
    _usersData = FirebaseFirestore.instance.collection('users');
    if (_usersData != null) {
      _users = [];
      QuerySnapshot data = await _usersData.get();
      for (QueryDocumentSnapshot item in data.docs) {
        Users currUsers = Users.withID(
            item.reference, item.get("currentuser"), item.get("productowner"));
        if (item.get("productowner") == widget.user.email) {
          _users.add(currUsers);
        }
      }
      print(_users);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_users == null) {
      _loadMessages();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3c3a1e),
        title: Text('Messages'),
      ),
      body: Container(
        color: Color(0xffe3deca),
        child: _users.length == 0
            ? Center(
                child: Container(
                  child: Text("no messages"),
                ),
              )
            : ListView(
                children: [
                  ..._users.map((item) {
                    return Container(
                      color: Color(0xffe3deca),
                      child: Column(
                        children: <Widget>[
                          FlatButton(
                            child: Text(item.getCurrentUser()),

                            onPressed: () {}, //---------------------------
                          ),
                        ],
                      ),
                    );
                  })
                ],
              ),
      ),
    );
  }
// void _loadReviewers() async {
//     _usersData = FirebaseFirestore.instance.collection('reviews');
//     if (_usersData != null) {
//       reviews = [];
//       QuerySnapshot data = await _usersData.get();
//       for (QueryDocumentSnapshot item in data.docs) {
//         Review currUser = Review.withID(item.reference, item.get("reviewer"),
//             item.get("restaurant"), item.get("review"), item.get("rating"));
//         reviews.add(currUser);
//       }
//     }
//     setState(() {});
//   }

}
