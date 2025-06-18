import 'package:dio/dio.dart';
import 'package:namoo/core/constants/base_url.dart';

/// 감정 통계 데이터를 서버에서 가져오는 서비스 클래스
class EmotionStatsService {
  final Dio _dio;

  /// 생성자 - 외부에서 Dio 객체를 주입하거나 기본 baseUrl로 Dio를 생성
  EmotionStatsService({Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(baseUrl: '$BaseUrl'));

  /// 특정 연도(year)와 월(month)에 대한 감정 통계 데이터를 가져옴
  /// [token]: 인증 토큰이 필요함
  Future<Map<String, dynamic>?> fetchEmotionStats({
    required int year,
    required int month,
    required String token,
  }) async {
    try {
      // GET 요청: /graph/emotion?year=...&month=...
      final response = await _dio.get(
        '/graph/emotion',
        queryParameters: {
          'year': year,
          'month': month,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // 인증 헤더 추가
          },
        ),
      );

      // 요청 성공 시 응답 데이터를 반환
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        // 요청 실패 시 null 반환
        return null;
      }
    } on DioException catch (e) {
      // Dio 예외 처리: 상태 코드와 메시지 출력 후 null 반환
      print('fetchEmotionStats error: ${e.response?.statusCode} ${e.response?.data ?? e.message}');
      return null;
    }
  }
}
