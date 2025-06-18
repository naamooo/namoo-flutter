import 'package:dio/dio.dart';
import 'package:namoo/core/constants/base_url.dart';
import 'package:namoo/core/constants/flutter_secure_storage.dart';

class LoginService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: '$BaseUrl/',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  final AuthTokenStorage _tokenStorage = AuthTokenStorage();

  Future<bool> login(String userId, String password) async {
    try {
      final response = await _dio.post(
        'auth/login',
        data: {
          'user_id': userId,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final accessToken = response.data['access_token'];
        if (accessToken != null) {
          await _tokenStorage.saveAccessToken(accessToken); // ✅ 토큰 저장
          print('로그인 성공: $accessToken');
          return true;
        }
      }
      return false;
    } on DioException catch (e) {
      print('로그인 에러: ${e.response?.data ?? e.message}');
      return false;
    }
  }
}
