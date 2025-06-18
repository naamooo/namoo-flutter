import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // 원형 차트를 위한 패키지
import 'package:namoo/core/constants/base_url.dart'; // API base URL
import 'package:namoo/core/constants/flutter_secure_storage.dart'; // 토큰 저장소
import 'package:namoo/core/namoo_color.dart'; // 커스텀 컬러
import 'package:dio/dio.dart'; // HTTP 통신을 위한 패키지

/// 감정 통계 화면 위젯
class StatisticsBodyWidget extends StatefulWidget {
  const StatisticsBodyWidget({super.key});

  @override
  State<StatisticsBodyWidget> createState() => _StatisticsBodyWidgetState();
}

class _StatisticsBodyWidgetState extends State<StatisticsBodyWidget> {
  // 선택된 월 (기본: 6월)
  String selectedMonth = '6월';

  // 월 목록
  final List<String> months = [
    '1월', '2월', '3월', '4월', '5월', '6월',
    '7월', '8월', '9월', '10월', '11월', '12월',
  ];

  // 감정별 데이터 초기값
  Map<String, double> emotionData = {
    '행복': 0, '슬픔': 0, '분노': 0, '중립': 0, '혐오': 0,
    '공포': 0, '기쁨': 0, '후회': 0, '혼란': 0
  };

  // 감정별 색상 매핑
  final Map<String, Color> emotionColors = {
    '행복': NaMooColor.main500,
    '슬픔': NaMooColor.main100,
    '분노': NaMooColor.main300,
    '중립': NaMooColor.white100,
    '혐오': NaMooColor.main400,
    '공포': NaMooColor.white,
    '기쁨': Colors.greenAccent,
    '후회': Colors.blueGrey,
    '혼란': Colors.black54
  };

  @override
  void initState() {
    super.initState();
    _fetchEmotionStats(); // 화면 초기 진입 시 감정 통계 요청
  }

  /// 감정 통계를 서버로부터 가져오는 함수
  Future<void> _fetchEmotionStats() async {
    final int year = DateTime.now().year;
    final int month = months.indexOf(selectedMonth) + 1;

    try {
      final dio = Dio(BaseOptions(baseUrl: '$BaseUrl')); // Dio 설정
      final token = await AuthTokenStorage().getAccessToken(); // 토큰 불러오기
      dio.options.headers['Authorization'] = 'Bearer $token'; // 인증 헤더 추가

      // API 요청
      final response = await dio.get('/graph/emotion', queryParameters: {
        'year': year,
        'month': month,
      });

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final Map<String, dynamic> counts = data['emotion_counts'] ?? {};

        setState(() {
          // 모든 감정 초기화
          emotionData = {
            '행복': 0, '슬픔': 0, '분노': 0, '중립': 0, '혐오': 0,
            '공포': 0, '기쁨': 0, '후회': 0, '혼란': 0
          };
          // 받아온 값으로 업데이트
          counts.forEach((key, value) {
            if (emotionData.containsKey(key)) {
              emotionData[key] = (value as num).toDouble();
            }
          });
        });
      }
    } catch (e) {
      print('감정 통계 불러오기 실패: $e');
    }
  }

  /// 월 선택 바텀시트
  void _showMonthPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return ListView.separated(
          itemCount: months.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                months[index],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              onTap: () {
                setState(() {
                  selectedMonth = months[index];
                });
                Navigator.pop(context);
                _fetchEmotionStats(); // 선택한 월의 통계 새로 불러오기
              },
            );
          },
        );
      },
    );
  }

  /// 원형 차트 데이터 생성
  List<PieChartSectionData> _buildPieSections() {
    final total = emotionData.values.fold(0.0, (a, b) => a + b);
    if (total == 0) return []; // 데이터가 없을 경우

    return emotionData.entries.map((entry) {
      final emotion = entry.key;
      final value = entry.value;
      final percent = (value / total) * 100;
      final color = emotionColors[emotion] ?? Colors.grey;

      return PieChartSectionData(
        color: color,
        value: value,
        title: '${percent.toStringAsFixed(1)}%',
        radius: 130,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
    }).toList();
  }

  /// 감정 범례 UI
  Widget _buildLegend() {
    return Center(
      child: Wrap(
        spacing: 40,
        runSpacing: 22,
        children: emotionData.keys.map((emotion) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 색상 사각형
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: emotionColors[emotion],
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 16),
              // 감정 이름
              Text(
                emotion,
                style: const TextStyle(fontSize: 13),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = emotionData.values.fold(0.0, (a, b) => a + b); // 총 감정 수

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 539,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: NaMooColor.white200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 월 선택 UI
          GestureDetector(
            onTap: _showMonthPicker,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedMonth,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.keyboard_arrow_down, size: 24),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 감정 데이터가 없을 경우 메시지 출력
          if (total == 0)
            Expanded(
              child: Center(
                child: Text(
                  '결과가 없습니다.',
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),
            )
          else ...[
            // 감정 원형 차트
            Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: PieChart(
                  PieChartData(
                    sections: _buildPieSections(),
                    centerSpaceRadius: 0,
                    sectionsSpace: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            _buildLegend(), // 감정 범례
          ],
        ],
      ),
    );
  }
}
