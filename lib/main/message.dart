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
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 15, 10, 20),
        child: Column(
          children: <Widget>[
            //  map((item)
            FlatButton(
              onPressed: () => {Navigator.pushNamed(context, 'chatbox')},
              color: Colors.orange,
              padding: EdgeInsets.all(10.0),
              child: Row(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[Icon(Icons.image), Text("Name")],
              ),
              
            ),
          ],
        ),
      ),
    );
  }
}
