import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiaryTopWidget extends StatefulWidget {
  const DiaryTopWidget({super.key});

  @override
  State<DiaryTopWidget> createState() => _DiaryTopWidgetState();
}

class _DiaryTopWidgetState extends State<DiaryTopWidget> {
  late final DateTime _today;
  late final String _dateString;
  late final String _weekdayString;

  @override
  void initState() {
    super.initState();
    _today = DateTime.now();
    _dateString = _formatDate(_today);
    _weekdayString = _formatWeekday(_today);
  }

  String _formatDate(DateTime date) {
    final year = date.year;
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year.$month.$day';
  }

  String _formatWeekday(DateTime date) {
    const weekdayNames = ['월', '화', '수', '목', '금', '토', '일'];
    return weekdayNames[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _dateString,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _weekdayString,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
              SvgPicture.asset('assets/images/icons/diary/tree.svg')
            ],
          ),
        ),
      ],
    );
  }
}
