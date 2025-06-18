import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // SVG 이미지를 불러오기 위한 패키지
import 'package:go_router/go_router.dart'; // 라우팅을 위한 패키지
import 'package:namoo/core/namoo_color.dart'; // 프로젝트 내 커스텀 컬러 모음
import 'package:namoo/core/namoo_textstyle.dart'; // 프로젝트 내 커스텀 텍스트 스타일 모음

// Splash 화면 위젯
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
// Splash 화면의 상태 관리 클래스
class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // 1.5초 후에 온보딩 화면으로 이동
    Future.delayed(const Duration(milliseconds: 1500)).then(
          (value) => context.go("/onboarding"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: NaMooColor.white, // 배경색 지정
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 수직 가운데 정렬
            crossAxisAlignment: CrossAxisAlignment.start, // 수평 시작점 정렬
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 200), // 상단 여백
                    SvgPicture.asset('assets/images/logo/title_icon.svg'), // 앱 로고 SVG 이미지
                    const SizedBox(height: 30), // 로고와 텍스트 사이 여백
                    Text(
                      '당신의 하루를 기록하세요.',
                      style: NaMooTextStyle.heading1(color: NaMooColor.main500), // 커스텀 텍스트 스타일 적용
                    )
                  ],
                ),
              ),
              const SizedBox(height: 180), // 로고/텍스트 그룹과 하단 이미지 사이 여백
              Image.asset('assets/images/icons/calender.png') // 하단에 달력 이미지 표시
            ]
        )
    );
  }
}
