import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_google_doc_clone/consts.dart';
import 'package:flutter_google_doc_clone/model/error_model.dart';
import 'package:flutter_google_doc_clone/model/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider =
    Provider((ref) => AuthRepository(googleSignIn: GoogleSignIn(), dio: Dio()));
final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final Dio _dio;
  final GoogleSignIn _googleSignIn;
  AuthRepository({required GoogleSignIn googleSignIn, required Dio dio})
      : _googleSignIn = googleSignIn,
        _dio = dio;

  Future<ErrorModel> signIn() async {
    ErrorModel errorModel = ErrorModel(error: 'some Error happens', data: null);
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userr = UserModel(
            name: user.displayName!,
            email: user.email,
            profilePic: user.photoUrl!,
            uid: '',
            token: '');
        var res = await _dio.post(
          '$host/api/signin',
          data: userr.toJson(),
        );
        switch (res.statusCode) {
          case 200:
            final newUser =
                userr.copyWith(uid: jsonDecode(res.data)['user']['_id']);
            errorModel = ErrorModel(error: null, data: newUser);
            break;
        }
      }
    } catch (e) {
      errorModel = ErrorModel(error: e.toString(), data: null);
    }
    return errorModel;
  }
}
