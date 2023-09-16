import 'package:flutter/material.dart';
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
      body: Center(
        child: Text(widget.id),
      ),
    );
  }
}
