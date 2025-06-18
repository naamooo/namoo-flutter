import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:namoo/core/namoo_color.dart';
import 'package:namoo/core/namoo_textstyle.dart';

class HomeBodyWidget extends StatefulWidget {
  final String emotion;
  final DateTime selectedDate;
  final String? recommendation;
  final String? content;
  final String? title;

  const HomeBodyWidget({
    super.key,
    required this.emotion,
    required this.selectedDate,
    this.recommendation,
    this.content,
    this.title,
  });

  @override
  State<HomeBodyWidget> createState() => _HomeBodyWidgetState();
}

class _HomeBodyWidgetState extends State<HomeBodyWidget> {
  String? _diaryContent;
  String? _emotion;
  String? _recommendation;
  String? _diaryTitle;
  double _lineHeight = 60.0;

  @override
  void initState() {
    super.initState();
    _setInitialData();
  }

  @override
  void didUpdateWidget(covariant HomeBodyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate ||
        oldWidget.content != widget.content ||
        oldWidget.title != widget.title ||
        oldWidget.recommendation != widget.recommendation ||
        oldWidget.emotion != widget.emotion) {
      _setInitialData();
    }
  }

  void _setInitialData() {
    final title = widget.title;
    final content = widget.content;
    final emotion = widget.emotion;
    final recommendation = widget.recommendation;

    setState(() {
      _diaryTitle = title;
      _diaryContent = content;
      _emotion = emotion;
      _recommendation = recommendation;

      _lineHeight = content != null
          ? getDiaryTextHeight(
        content,
        NaMooTextStyle.content1(color: NaMooColor.black),
        236,
      )
          : 60.0;
    });
  }

  double getDiaryTextHeight(String content, TextStyle style, double maxWidth) {
    final textSpan = TextSpan(text: content, style: style);
    final textPainter = TextPainter(
      text: textSpan,
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return textPainter.size.height + 50;
  }

  @override
  Widget build(BuildContext context) {
    final month = widget.selectedDate.month.toString().padLeft(2, '0');
    final day = widget.selectedDate.day.toString().padLeft(2, '0');
    final weekdayNames = ['월', '화', '수', '목', '금', '토', '일'];
    final weekday = weekdayNames[widget.selectedDate.weekday - 1];
    final displayDate = '$month.$day $weekday';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 23, top: 3, right: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(displayDate, style: NaMooTextStyle.my1(color: NaMooColor.black)),
              const SizedBox(height: 10),
              _diaryContent == null
                  ? Text(
                '일기를 작성하지 않았습니다.',
                style: NaMooTextStyle.content1(color: NaMooColor.black),
              )
                  : Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: NaMooColor.main400,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: 3,
                        height: _lineHeight,
                        color: const Color(0xFFd8d8d8),
                      ),
                    ],
                  ),
                  const SizedBox(width: 21),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 180,
                              child: Text(
                                _diaryTitle ?? '제목 없음',
                                style: NaMooTextStyle.heading3(color: NaMooColor.black),
                              )),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 236,
                            child: Text(
                              _diaryContent!,
                              style: NaMooTextStyle.content1(color: NaMooColor.black),
                              maxLines: 100,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                      const SizedBox(width: 50),
                      Text(
                        getEmotionEmoji(_emotion ?? '중립'),
                        style: const TextStyle(fontSize: 33),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        _diaryContent != null
            ? Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          decoration: BoxDecoration(
            color: NaMooColor.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: NaMooColor.main400, width: 3),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '서예린님, 오늘의 기분은 ',
                            style: NaMooTextStyle.heading3(color: NaMooColor.black),
                          ),
                          TextSpan(
                            text: '${_emotion ?? widget.emotion}', // 감정
                            style: NaMooTextStyle.heading3(color: NaMooColor.main400), // 다른 색상
                          ),
                          TextSpan(
                            text: '입니다!',
                            style: NaMooTextStyle.heading3(color: NaMooColor.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 2,
                      color: Colors.black54,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _recommendation ?? '나무가 추천하는 컨텐츠를 경험해 보세요!',
                      style: NaMooTextStyle.content1(color: NaMooColor.black),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 65,
                child: SvgPicture.asset('assets/images/icons/core/tree1.svg'),
              ),
              Positioned(
                bottom: 0,
                right: 15,
                child: SvgPicture.asset('assets/images/icons/core/tree2.svg'),
              ),
            ],
          ),
        )
            : const SizedBox.shrink(),
      ],
    );
  }

  String getEmotionEmoji(String emotion) {
    switch (emotion) {
      case '행복':
        return '😊';
      case '슬픔':
        return '😢';
      case '분노':
        return '😡';
      case '중립':
        return '😐';
      case '놀람':
        return '😲';
      case '공포':
        return '😱';
      case '혐오':
        return '🤢';
      default:
        return '😊';
    }
  }
}
