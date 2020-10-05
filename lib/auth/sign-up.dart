import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './background.dart';

class SignUpScreen extends StatefulWidget {
  final User user;

  SignUpScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";

  bool _isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    if (widget.user != null) {
      Navigator.pop(context);
    }

    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    // padding: EdgeInsets.only(left: 60),
                    width: 280,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi there!',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 40,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Sign up now,',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 25,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: EdgeInsets.fromLTRB(60, 10, 60, 5),
                    child: TextFormField(
                      style: TextStyle(
                        fontFamily: 'Calibri',
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xffffffff),
                      ),
                      decoration: InputDecoration(
                          labelText: 'Email address'),
                      onSaved: (value) {
                        _email = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(60, 10, 60, 5),
                    child: TextFormField(
                      
                      obscureText: true,
                      decoration: InputDecoration(
                         labelText: 'Password'),
                      onSaved: (value) {
                        _password = value;
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Container(
                      // padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                      width: 160.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color: const Color(0xffe3deca),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: RaisedButton(
                            onPressed: _isSigningUp ? null : _signUp,
                            child: Text('Sign up'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    color: Colors.transparent,
                    onPressed: () {
                      
                      Navigator.pop(context);
                    },
                    child: Text(
                      'I already have an account',
                      style: TextStyle(
                        fontFamily: 'Calibri',
                        fontSize: 17,
                        color: const Color(0xffe3deca),
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _isSigningUp = true;
      });

      try {
        // ignore: unused_local_variable
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      }
      setState(() {
        _isSigningUp = false;
      });
    }
  }
}
