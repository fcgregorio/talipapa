import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              // shape: BoxShape.rectangle,
              // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(370)),
              gradient: LinearGradient(
                begin: Alignment(0.0, -0.91),
                end: Alignment(0.0, 1.0),
                colors: [const Color(0xb2eba857), const Color(0xb25c2c0c)],
                stops: [0.0, 1.0],
              ),
              border: Border.all(width: .5, color: const Color(0xb2707070)),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.maxFinite,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(350)),
              // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(300)),
              gradient: LinearGradient(
                begin: Alignment(0.0, -0.64),
                end: Alignment(0.0, 0.90),
                colors: [const Color(0xffeba857), const Color(0xff5c2c0c)],
                stops: [0.0, 1.0],
              ),
              border: Border.all(width: .5, color: const Color(0xff707070)),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.2,
              width: double.maxFinite,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(350)),
              // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(200)),
              gradient: LinearGradient(
                begin: Alignment(0.0, -0.8),
                end: Alignment(0.0, 1.0),
                colors: [const Color(0xb2eba857), const Color(0xb25c2c0c)],
                stops: [0.0, 1.0],
              ),
              border: Border.all(width: .50, color: const Color(0xb2707070)),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.maxFinite,
            ),
          ),
        ],
      ),
    );
  }
}
