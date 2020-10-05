import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatBox extends StatefulWidget {
  final User user;
  final String id;
  ChatBox({
    Key key,
    @required this.user,
    @required this.id,
  }) : super(key: key);

  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();

    final messagesRef = FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.id)
        .collection('messages')
        .orderBy('timestamp', descending: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        backgroundColor: Color(0xff3c3a1e),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: messagesRef.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return null;
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Spacer();
          }

          return Container(
            color: Color(0xffe3deca),
            padding: EdgeInsets.fromLTRB(10, 15, 10, 20),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    reverse: true,
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: document.data()['user'] == widget.user.email
                              ? Color(0xffdda35d)
                              : Color(0xffaa6231),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.brown, spreadRadius: 2),
                          ],
                        ),
                        child: ListTile(
                          title: Container(
                            child: Text(
                              document.data()['text'],
                              textAlign:
                                  document.data()['user'] == widget.user.email
                                      ? TextAlign.right
                                      : TextAlign.left,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 26,
                              ),
                            ),
                          ),
                          // subtitle: Text(
                          //   document.data()['timestamp'].toString(),
                          // ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.brown, spreadRadius: 3),
                    ],
                  ),
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Enter Message",
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    if (_controller.text.trim().isNotEmpty) {
                      await FirebaseFirestore.instance
                          .collection('chats')
                          .doc(widget.id)
                          .collection('messages')
                          .add({
                        'text': _controller.text,
                        'user': widget.user.email,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                      _controller.clear();
                    }
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff5c2c0c),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
