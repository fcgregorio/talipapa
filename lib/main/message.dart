import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    final chatsRef = FirebaseFirestore.instance
        .collection('chats')
        .where('users', arrayContains: widget.user.email)
        .orderBy('timestamp', descending: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3c3a1e),
        title: Text('Messages'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: chatsRef.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return null;
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Spacer();
          }

          if (snapshot.data.size == 0) {
            return Container(
              color: Color(0xffe3deca),
              child: Center(
                child: Container(
                  child: Text("no messages"),
                ),
              ),
            );
          }

          return Container(
            color: Color(0xffe3deca),
            padding: EdgeInsets.fromLTRB(10, 15, 10, 20),
            child: GridView.count(
              crossAxisCount: 2,
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Container(
                        width: double.maxFinite,
                        height: 130,
                        child: FlatButton(
                          child: Image.network(document.data()['productimage'],
                              fit: BoxFit.cover),
                          color: Colors.transparent,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              'chatbox',
                              arguments: {
                                'id': document.id,
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(document.data()['productname']),
                            Text(document.data()['productowner']),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
