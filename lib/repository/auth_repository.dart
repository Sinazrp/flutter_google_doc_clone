import 'package:dio/dio.dart';
import 'package:flutter_google_doc_clone/model/error_model.dart';
import 'package:flutter_google_doc_clone/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepositoryProvider =
    Provider((ref) => AuthRepository(googleSignIn: GoogleSignIn(), dio: Dio()));

class AuthRepository {
  final Dio _dio;
  final GoogleSignIn _googleSignIn;
  AuthRepository({required GoogleSignIn googleSignIn, required Dio dio})
      : _googleSignIn = googleSignIn,
        _dio = dio;

  Future<ErrorModel> signIn() async {
    ErrorModel errorModel = ErrorModel(error: 'some Error happens', data: null);

    final user = await _googleSignIn.signIn();
    print(user);
    if (user != null) {
      final userr = UserModel(
          name: user.displayName.toString(),
          email: user.email,
          profilePic: user.photoUrl ?? 'gffgjkgy',
          uid: '',
          token: '');
      print(userr);

      var res = await _dio.post(
        'https://doc-clone.iran.liara.run/api/signup',
        data: {
          "name": userr.name,
          "email": userr.email,
          "profilePic": userr.profilePic
        },
      );
      switch (res.statusCode) {
        case 200:
          print(res.data);
          final newUser = userr.copyWith(uid: res.data["user"]["_id"]);
          print(newUser);
          errorModel = ErrorModel(error: null, data: newUser);
          break;
      }
    }

    return errorModel;
  }
}
