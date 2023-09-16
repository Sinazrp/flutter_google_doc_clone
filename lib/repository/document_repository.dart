import 'package:dio/dio.dart';
import 'package:flutter_google_doc_clone/repository/local_storage_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/document_model.dart';
import '../model/error_model.dart';

final docRepositoryProvider = Provider((ref) => DocumentRepository(
    localStorageRepository: LocalStorageRepository(), dio: Dio()));
final docProvider = StateProvider<DocumentModel?>((ref) => null);

class DocumentRepository {
  final Dio _dio;
  final LocalStorageRepository _localStorageRepository;
  DocumentRepository({
    required LocalStorageRepository localStorageRepository,
    required Dio dio,
  })  : _dio = dio,
        _localStorageRepository = localStorageRepository;

  Future<ErrorModel> createDocument() async {
    ErrorModel errorModel = ErrorModel(error: 'some Error happens', data: null);
    String? token = await _localStorageRepository.getToken();

    try {
      if (token != null) {
        var res = await _dio.post('https://doc-clone.iran.liara.run/doc/create',
            options: Options(headers: {'x-auth-token': token}),
            data: {'createdAt': DateTime.now().millisecondsSinceEpoch});

        switch (res.statusCode) {
          case 200:
            errorModel =
                ErrorModel(error: null, data: DocumentModel.fromMap(res.data));

            break;
        }
      }
    } catch (e) {
      throw Exception(e);
    }
    return errorModel;
  }
}
