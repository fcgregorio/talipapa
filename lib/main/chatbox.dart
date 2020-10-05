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

          return Column(
            children: [
              Expanded(
                child: ListView(
                  reverse: true,
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return ListTile(
                      title: Row(
                        children: [
                          Spacer(),
                          Text(
                            document.data()['text'],
                            textAlign:
                                document.data()['user'] == widget.user.email
                                    ? TextAlign.right
                                    : TextAlign.left,
                          )
                        ],
                      ),
                      // subtitle: Text(
                      //   document.data()['timestamp'].toString(),
                      // ),
                    );
                  }).toList(),
                ),
              ),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
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
                child: Text('Send'),
              ),
            ],
          );
        },
      ),
    );
  }
}
