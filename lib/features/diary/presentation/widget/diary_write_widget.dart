import 'package:flutter/material.dart';
import 'package:namoo/core/namoo_color.dart'; // 프로젝트에서 정의한 색상 클래스

// 일기 작성 위젯. 제목과 본문을 입력받는다.
class DiaryWriteWidget extends StatefulWidget {
  final TextEditingController titleController; // 제목 입력 제어
  final TextEditingController bodyController; // 본문 입력 제어

  const DiaryWriteWidget({
    super.key,
    required this.titleController,
    required this.bodyController,
  });

  @override
  State<DiaryWriteWidget> createState() => _DiaryWriteWidgetState();
}

class _DiaryWriteWidgetState extends State<DiaryWriteWidget> {
  // 제목과 본문 각각의 포커스 노드
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _bodyFocusNode = FocusNode();

  double _fontSize = 16; // 본문 글자 크기
  TextAlign _textAlign = TextAlign.left; // 본문 정렬 방식

  // 정렬 변경 함수
  void _setAlignment(TextAlign align) {
    setState(() {
      _textAlign = align;
    });
  }

  // 글자 크기 증가
  void _increaseFontSize() {
    setState(() {
      if (_fontSize < 30) _fontSize += 2;
    });
  }

  // 글자 크기 감소
  void _decreaseFontSize() {
    setState(() {
      if (_fontSize > 12) _fontSize -= 2;
    });
  }

  @override
  void dispose() {
    // 포커스 노드 해제
    _titleFocusNode.dispose();
    _bodyFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 배경을 터치하면 키보드 숨기기
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 688, // 고정 높이
        decoration: const BoxDecoration(
          color: NaMooColor.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.only(left: 35, right: 35, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목 입력창과 밑줄
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                // 밑줄은 DashedUnderlinePainter로 커스텀
                CustomPaint(
                  painter: DashedUnderlinePainter(
                    isFocused: _titleFocusNode.hasFocus,
                  ),
                  child: Container(height: 30),
                ),
                // 제목 입력 TextField
                TextField(
                  controller: widget.titleController,
                  focusNode: _titleFocusNode,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.02,
                  ),
                  decoration: const InputDecoration(
                    hintText: '제목을 입력하세요',
                    hintStyle: TextStyle(
                      color: Color(0xFFD2D2D2),
                      fontSize: 21,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.02,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 5, bottom: 8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // 본문 입력창 (자동 확장, 정렬 및 글자 크기 적용)
            Expanded(
              child: TextField(
                controller: widget.bodyController,
                focusNode: _bodyFocusNode,
                maxLines: null,
                expands: true, // 부모에 맞춰 자동 확장
                textAlign: _textAlign, // 정렬 반영
                style: TextStyle(
                  color: Colors.black,
                  fontSize: _fontSize,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  hintText: '오늘의 이야기를 적어보세요',
                  hintStyle: TextStyle(
                    color: Color(0xFFD2D2D2),
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(5),
                ),
                keyboardType: TextInputType.multiline,
              ),
            ),
            // 정렬/글자크기 조절 아이콘 버튼들
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.format_align_left),
                  onPressed: () => _setAlignment(TextAlign.left),
                  color: _textAlign == TextAlign.left ? NaMooColor.main400 : NaMooColor.main200,
                ),
                IconButton(
                  icon: const Icon(Icons.format_align_center),
                  onPressed: () => _setAlignment(TextAlign.center),
                  color: _textAlign == TextAlign.center ? NaMooColor.main400 : NaMooColor.main200,
                ),
                IconButton(
                  icon: const Icon(Icons.format_align_right),
                  onPressed: () => _setAlignment(TextAlign.right),
                  color: _textAlign == TextAlign.right ? NaMooColor.main400 : NaMooColor.main200,
                ),
                IconButton(
                  icon: const Icon(Icons.text_decrease),
                  onPressed: _decreaseFontSize,
                  color: NaMooColor.main400,
                ),
                IconButton(
                  icon: const Icon(Icons.text_increase),
                  onPressed: _increaseFontSize,
                  color: NaMooColor.main400,
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// 제목 밑에 점선 밑줄을 그리는 커스텀 페인터
class DashedUnderlinePainter extends CustomPainter {
  final bool isFocused;
  DashedUnderlinePainter({required this.isFocused});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = isFocused ? Colors.black : const Color(0xFFD2D2D2)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5;
    const double dashSpace = 3;
    double startX = 0;
    final y = size.height - 1;

    // 점선 형태로 선을 그린다.
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(DashedUnderlinePainter oldDelegate) {
    // 포커스 여부가 변경되었을 때만 다시 그리기
    return isFocused != oldDelegate.isFocused;
  }
}
