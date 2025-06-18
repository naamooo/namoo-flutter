import 'package:dio/dio.dart';

class SignUpService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.1.26:8000/',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ));

  Future<bool> signup(String name, String username, String password) async {
    try {
      final response = await _dio.post(
        'signup',
        data: {
          'name': name,
          'username': username,
          'password': password,
        },
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      print('회원가입 에러: ${e.response?.data ?? e.message}');
      return false;
    }
  }
}
