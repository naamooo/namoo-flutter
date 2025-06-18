import 'package:dio/dio.dart';
import 'package:namoo/core/constants/base_url.dart';
import 'package:namoo/core/constants/flutter_secure_storage.dart';

class DiaryService {
  final Dio _dio;
  final AuthTokenStorage _tokenStorage;

  DiaryService({
    Dio? dio,
    AuthTokenStorage? tokenStorage,
  })  : _dio = dio ??
      Dio(BaseOptions(
        baseUrl: '$BaseUrl/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      )),
        _tokenStorage = tokenStorage ?? AuthTokenStorage();

  /// 일기 쓰기
  /// [content] 본문, [date] ISO8601 형식("yyyy-MM-dd")
  /// 반환: 서버에서 받은 Map(id, date, content, emotion, recommendation)
  Future<Map<String, dynamic>?> writeDiary({
    required String title,
    required String content,
    required String date,
  }) async {
    final token = await _tokenStorage.getAccessToken();
    if (token == null) {
      throw Exception('No access token found');
    }

    try {
      final resp = await _dio.post(
        'diary/',
        data: {
          'title' : title,
          'content': content,
          'date': date,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (resp.statusCode == 200) {
        // 응답 JSON을 Map<String,dynamic>으로 리턴
        return Map<String, dynamic>.from(resp.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      // 에러 로그 출력
      print('일기 쓰기 에러: ${e.response?.statusCode} ${e.response?.data ?? e.message}');
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchDiaryByDate(DateTime date) async {
    final token = await _tokenStorage.getAccessToken();
    if (token == null) {
      throw Exception('No access token found');
    }

    final dateString = date.toIso8601String().substring(0, 10); // yyyy-MM-dd

    try {
      final resp = await _dio.get(
        'diary/detail/$dateString',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (resp.statusCode == 200) {
        return Map<String, dynamic>.from(resp.data);
      } else if (resp.statusCode == 404) {
        return null;
      } else {
        return null;
      }
    } on DioException catch (e) {
      print('fetchDiaryByDate 에러: ${e.response?.statusCode} ${e.response?.data ?? e.message}');
      return null;
    }
  }

}

