import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'main/main.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _initialized = false;
  bool _error = false;


  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
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
      return Center(child: Text('error', textDirection: TextDirection.ltr));
    }

    if (!_initialized) {
      return Center(child: Text('loading', textDirection: TextDirection.ltr));
    }

    return MaterialApp(
      title: 'Talipapa',
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
      },
    );
  }
}
