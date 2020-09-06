import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talipapa/main/home.dart';
import 'package:talipapa/main/profile.dart';

class MainScreen extends StatefulWidget {
  final User user;

  MainScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (index == 1) {
      if (widget.user == null) {
        Navigator.pushNamed(context, 'auth/sign-in');
        return;
      }
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          switch (_selectedIndex) {
            case 0:
              return HomeScreen();
            case 1:
              return ProfileScreen(
                user: widget.user,
                onUserSignout: () {
                  setState(() {
                    _onItemTapped(0);
                  });
                },
              );
            default:
              throw Error();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
