import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatBox extends StatefulWidget {
  final User user;
  ChatBox({
    Key key,
    @required this.user,
  }) : super(key: key);
  @override
  _ChatBoxState createState() => _ChatBoxState();
}
class _ChatBoxState extends State<ChatBox> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Text(widget.user.email),
      );
    
  }
}
