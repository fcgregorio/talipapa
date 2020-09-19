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
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
    );
  }
}
