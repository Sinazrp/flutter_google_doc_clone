import 'package:flutter/material.dart';
import 'package:flutter_google_doc_clone/model/error_model.dart';
import 'package:flutter_google_doc_clone/repository/auth_repository.dart';
import 'package:flutter_google_doc_clone/repository/document_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import 'login_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);
  void signOut(WidgetRef ref) {
    ref.read(authRepositoryProvider).logOut();
    ref.read(userProvider.notifier).update((state) => null);
  }

  void createDocument(WidgetRef ref, BuildContext context) async {
    final navigator = Routemaster.of(context);
    final snackBar = ScaffoldMessenger.of(context);
    ErrorModel errorModel =
        await ref.read(docRepositoryProvider).createDocument();

    if (errorModel.data != null) {
      navigator.push('/document/${errorModel.data.id}');
    } else {
      snackBar.showSnackBar(SnackBar(content: Text(errorModel.error!)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () => createDocument(ref, context),
            icon: const Icon(Icons.add)),
        IconButton(
            onPressed: () => signOut(ref), icon: const Icon(Icons.logout))
      ]),
      body: Center(
        child: Text(ref.watch(userProvider)!.email),
      ),
    );
  }
}
