import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  final Function onUserSignout;

  ProfileScreen({
    Key key,
    @required this.user,
    @required this.onUserSignout,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   void _onUserSignOut() {
    FirebaseAuth.instance.signOut();
    widget.onUserSignout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile', textAlign: TextAlign.center),
          backgroundColor: Color(0xff3c3a1e),
          elevation: 0,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text(widget.user.email),
                  trailing: IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: _onUserSignOut,
                  ),
                ),
              ),
            ),
            Container(
              width: 250,
              child: RaisedButton(
                child: Text('Add Product'),
                color: Colors.brown,
                onPressed: () {
                  Navigator.pushNamed(context, 'createproduct');
                },
              ),
            ),
          ],
        ));
  }
}
