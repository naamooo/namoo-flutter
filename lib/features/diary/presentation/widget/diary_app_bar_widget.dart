import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // SVG 이미지 사용
import 'package:go_router/go_router.dart'; // 라우팅 처리
import 'package:namoo/core/namoo_color.dart'; // 프로젝트의 색상 정의

// 커스텀 앱바 위젯 (일기 작성/편집 화면에서 사용)
// showSave: 저장 버튼 표시 여부
// onSave: 저장 버튼 클릭 시 실행될 콜백 함수
class DiaryAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool showSave; // 저장 버튼 표시 여부
  final VoidCallback? onSave; // 저장 버튼 클릭 시 호출되는 콜백

  const DiaryAppBarWidget({super.key, this.showSave = false, this.onSave});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: NaMooColor.white200, // 배경색 지정
      automaticallyImplyLeading: false, // 기본 뒤로가기 버튼 숨기기
      scrolledUnderElevation: 0, // 스크롤 시 음영 없음
      elevation: 0, // 기본 음영 제거
      title: Row(
        children: [
          const SizedBox(width: 15), // 왼쪽 여백
          // 뒤로가기 버튼 (SVG 이미지)
          GestureDetector(
            onTap: () {
              context.pop(); // 이전 화면으로 이동
            },
            child: SvgPicture.asset('assets/images/icons/core/back_arrow.svg'),
          ),
          const Spacer(), // 좌우 공간 분리
          // 저장 버튼 (조건부 표시)
          if (showSave)
            GestureDetector(
              onTap: onSave, // 저장 버튼 클릭 시 콜백 실행
              child: const Text(
                '저장',
                style: TextStyle(
                  color: Color(0xFF61AF87), // 텍스트 색상
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.02,
                ),
              ),
            ),
          const SizedBox(width: 20), // 오른쪽 여백
        ],
      ),
    );
  }

  // AppBar의 높이 지정
  @override
  Size get preferredSize => const Size.fromHeight(50);
}
