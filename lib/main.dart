import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:talipapa/main/bookmarks.dart';

import 'auth/sign-in.dart';
import 'auth/sign-up.dart';
import 'main/chatbox.dart';
import 'main/detail.dart';
import 'main/main.dart';
import 'main/message.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _initialized = false;
  bool _error = false;

  User _user;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });

      FirebaseAuth.instance.authStateChanges().listen((User user) {
        setState(() {
          _user = user;
        });
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Center(
        child: Text(
          'error',
          textDirection: TextDirection.ltr,
        ),
      );
    }

    if (!_initialized) {
      return Center(
        child: Text(
          'loading',
          textDirection: TextDirection.ltr,
        ),
      );
    }

    return MaterialApp(
      // theme: ThemeData(
      //   primarySwatch: Colors.amber,
      //   buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
      // ),
      title: 'Talipapa',
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(
              user: _user,
            ),
        'auth/sign-in': (context) => SignInScreen(
              user: _user,
            ),
        'auth/sign-up': (context) => SignUpScreen(
              user: _user,
            ),
        'bookmarks': (context) => BookmarkScreen(
              user: _user,
            ),
        'messages': (context) => MessageScreen(
              user: _user,
            ),
        'detail': (context) => DetailScreen(),
        'chatbox': (context) => ChatBox(
          user: _user,
        ),
      },
    );
  }
}
