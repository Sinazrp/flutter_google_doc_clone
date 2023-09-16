import 'package:flutter/material.dart';
import 'package:flutter_google_doc_clone/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);
  void signOut(WidgetRef ref) {
    ref.read(authRepositoryProvider).logOut();
    ref.read(userProvider.notifier).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
      ]),
      body: Center(
        child: Text(ref.watch(userProvider)!.email),
      ),
    );
  }
}
