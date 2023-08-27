import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Doc'),
        ),
        body: Center(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: Image.asset(
              'assets/logo/g-logo-2.png',
              height: 20,
            ),
            label: const Text('Sign in with google'),
            style: ElevatedButton.styleFrom(minimumSize: const Size(150, 50)),
          ),
        ));
  }
}
