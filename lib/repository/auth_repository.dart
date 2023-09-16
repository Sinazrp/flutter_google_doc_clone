import 'package:dio/dio.dart';
import 'package:flutter_google_doc_clone/model/error_model.dart';
import 'package:flutter_google_doc_clone/model/user_model.dart';
import 'package:flutter_google_doc_clone/repository/local_storage_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    dio: Dio(),
    localStorageRepository: LocalStorageRepository()));

class AuthRepository {
  final Dio _dio;
  final GoogleSignIn _googleSignIn;
  final LocalStorageRepository _localStorageRepository;
  AuthRepository(
      {required GoogleSignIn googleSignIn,
      required Dio dio,
      required LocalStorageRepository localStorageRepository})
      : _googleSignIn = googleSignIn,
        _localStorageRepository = localStorageRepository,
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
          final newUser = userr.copyWith(
              uid: res.data["user"]["_id"], token: res.data["token"]);
          errorModel = ErrorModel(error: null, data: newUser);
          _localStorageRepository.setToken(newUser.token);
          break;
      }
    }

    return errorModel;
  }

  Future<ErrorModel> getUserData() async {
    ErrorModel errorModel = ErrorModel(error: 'some Error happens', data: null);
    String? token = await _localStorageRepository.getToken();

    try {
      if (token != null) {
        var res = await _dio.get('https://doc-clone.iran.liara.run/',
            options: Options(headers: {'x-auth-token': token}));
        print("this is get data ${res.data.toString()}");

        switch (res.statusCode) {
          case 200:
            final newUser =
                UserModel.fromMap(res.data["user"]).copyWith(token: token);
            errorModel = ErrorModel(error: null, data: newUser);
            _localStorageRepository.setToken(newUser.token);
            break;
        }
      }
    } catch (e) {
      print(e.toString() + ' this is error from get');
    }

    return errorModel;
  }

  void logOut() async {
    LocalStorageRepository().setToken('');
    await _googleSignIn.signOut();
  }
}
