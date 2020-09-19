import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
    );
  }
}
