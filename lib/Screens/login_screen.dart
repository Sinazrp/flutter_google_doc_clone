import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Google Doc'),
        ),
        body: Center(
          child: ElevatedButton.icon(
              onPressed: () {}, icon: Icon(Icons.abc_rounded), label: label),
        ));
  }
}
