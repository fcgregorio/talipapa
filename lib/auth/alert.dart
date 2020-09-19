import 'package:flutter/Material.dart';

class Alert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Error"),
      content: Text("Complete the form."),
      actions: [
        FlatButton(
          onPressed: () {},
          child: Text('Ok'),
        ),
      ],
    );
  }
}
