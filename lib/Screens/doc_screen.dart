import 'package:flutter/material.dart';
import 'package:flutter_google_doc_clone/constans.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocScreen extends ConsumerStatefulWidget {
  final String id;
  const DocScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  ConsumerState<DocScreen> createState() => _DocScreenState();
}

class _DocScreenState extends ConsumerState<DocScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(11),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.lock,
                size: 16,
                color: kWhiteColor,
              ),
              label: const Text(
                'share',
                style: TextStyle(color: kWhiteColor),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Text(widget.id),
      ),
    );
  }
}
