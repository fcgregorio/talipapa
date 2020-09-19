import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './background.dart';
import './alert.dart';

class SignInScreen extends StatefulWidget {
  final User user;

  SignInScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";

  bool _isSigningIn = false;
  @override
  Widget build(BuildContext context) {
    if (widget.user != null) {
      Navigator.pop(context);
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Background(),
          Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Log In!',
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
                          'Welcome Back,',
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(60, 10, 60, 5),
                    child: TextFormField(
                      style: TextStyle(
                        fontFamily: 'Calibri',
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                      ),
                      onSaved: (value) {
                        _email = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(60, 5, 60, 40),
                    child: TextFormField(
                      style: TextStyle(
                        fontFamily: 'Calibri',
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      onSaved: (value) {
                        _password = value;
                      },
                    ),
                  ),
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
                        child: FlatButton(
                          color: Colors.transparent,
                          onPressed: _isSigningIn ? null : _signIn,
                          child: Text(
                            'Sign in',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New Here?',
                        style: TextStyle(
                          fontFamily: 'Calibri',
                          fontSize: 17,
                          color: const Color(0xffe3deca),
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        width: 5,
                        height: 0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'auth/sign-up');
                        },
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontFamily: 'Calibri',
                              fontSize: 17,
                              color: const Color(0xffe3deca),
                              shadows: [
                                Shadow(
                                  color: const Color(0x29000000),
                                  offset: Offset(0, 3),
                                  blurRadius: 6,
                                )
                              ],
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  decoration: TextDecoration.underline,
                                  // decorationColor: Colors.blueGrey,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        _isSigningIn = true;
      });

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }

      setState(() {
        _isSigningIn = false;
      });
    }
  }
}
