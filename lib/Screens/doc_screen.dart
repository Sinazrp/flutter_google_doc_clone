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
  void dispose() {
    titleController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  TextEditingController titleController =
      TextEditingController(text: 'untitled documents');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                backgroundColor: Colors.lightBlue,
              ),
            ),
          )
        ],
        title: Row(children: [
          Image.asset(
            'assets/logo/docs-logo.png',
            height: 30,
          ),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(left: 10),
              ),
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
          )
        ]),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 229, 227, 227))),
            )),
      ),
      body: Center(
        child: Text(widget.id),
      ),
    );
  }
}
