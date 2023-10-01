import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_doc_clone/constans.dart';
import 'package:flutter_google_doc_clone/model/document_model.dart';
import 'package:flutter_google_doc_clone/model/error_model.dart';
import 'package:flutter_google_doc_clone/repository/socket_repository.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/document_repository.dart';

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
  ErrorModel? errorModel;
  quill.QuillController? _controller;
  TextEditingController titleController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();

    super.dispose();
  }

  SocketRepsitory socketRepsitory = SocketRepsitory();

  @override
  void initState() {
    super.initState();
    socketRepsitory.joinRoom(widget.id);
    fetchDocumentsData();
    composeController();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      autoSaving();
    });
  }

  void autoSaving() {
    socketRepsitory.autoSave(<String, dynamic>{
      'delta': _controller!.document.toDelta(),
      'docId': widget.id
    });
  }

  void composeController() {
    socketRepsitory.changeListener((data) => _controller?.compose(
        quill.Delta.fromJson(data['delta']),
        _controller?.selection ?? const TextSelection.collapsed(offset: 0),
        quill.ChangeSource.REMOTE));
  }

  void fetchDocumentsData() async {
    errorModel = await ref.read(docRepositoryProvider).getDocById(widget.id);
    if (errorModel!.data != null) {
      DocumentModel doc = errorModel!.data as DocumentModel;
      titleController.text = doc.title;
      _controller = quill.QuillController(
        document: doc.content.isEmpty
            ? quill.Document()
            : quill.Document.fromDelta(quill.Delta.fromJson(doc.content)),
        selection: const TextSelection.collapsed(offset: 0),
      );

      setState(() {});
    }
    _controller!.document.changes.listen((event) {
      print(event.before);
      print(event.change);
      print(event.source);

      if (event.source == quill.ChangeSource.LOCAL) {
        Map<String, dynamic> map = {'delta': event.change, 'room': widget.id};
        socketRepsitory.typing(map);
      }
    });
  }

  void updateTitles(WidgetRef ref, String title) {
    ref.read(docRepositoryProvider).updtaeTitle(
          id: widget.id,
          title: title,
        );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
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
                onSubmitted: (value) => updateTitles(ref, titleController.text),
                controller: titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 10),
                ),
                onTapOutside: (_) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  updateTitles(ref, titleController.text);
                }),
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
        child: Column(
          children: [
            quill.QuillToolbar.basic(controller: _controller!),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.95,
                child: Card(
                  color: kWhiteColor,
                  elevation: 5,
                  surfaceTintColor: kWhiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: quill.QuillEditor.basic(
                      controller: _controller!,
                      readOnly: false, // true for view only mode
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
