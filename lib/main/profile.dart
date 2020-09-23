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

// FirebaseAuth.instance.signOut();
//           widget.onUserSignout();

class _ProfileScreenState extends State<ProfileScreen> {
  void _onUserSignOut() {
    FirebaseAuth.instance.signOut();
    widget.onUserSignout();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            child: Text('Log Out'),
            onPressed: _onUserSignOut,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Card(
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: PopupMenuButton(
                    onSelected: (value) {},
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.user.displayName ?? 'asdad'),
                    Text(widget.user.email),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
