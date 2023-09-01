import 'package:flutter/material.dart';
import 'package:flutter_google_doc_clone/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);
  void singInwithGoogle(WidgetRef ref) {
    ref.watch(authRepositoryProvider).signIn();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Doc'),
        ),
        body: Center(
          child: ElevatedButton.icon(
            onPressed: () => singInwithGoogle(ref),
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
