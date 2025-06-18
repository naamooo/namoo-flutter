import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:namoo/core/constants/base_url.dart';

class DiaryService {
  final Dio _dio = Dio(BaseOptions(baseUrl: '$BaseUrl:7777'));
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>?> fetchDiaryByDate(String date) async {
    final token = await _storage.read(key: 'access_token');
    if (token == null) return null;

    try {
      final response = await _dio.get(
        '/diary/detail/$date',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  }
}
