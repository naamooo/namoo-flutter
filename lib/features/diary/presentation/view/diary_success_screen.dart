import 'dart:async';
import 'package:flutter/material.dart';
import 'package:namoo/core/namoo_color.dart';
import 'package:go_router/go_router.dart'; // GoRouter 사용 시 필요

class DiarySuccessScreen extends StatefulWidget {
  final String emotion;

  const DiarySuccessScreen({super.key, required this.emotion});

  @override
  _DiarySuccessScreenState createState() => _DiarySuccessScreenState();
}

class _DiarySuccessScreenState extends State<DiarySuccessScreen> {
  List<String> dots = ['.', '..', '...'];
  int currentDotIndex = 0;

  late Timer _dotTimer;
  Timer? _navigateTimer;

  @override
  void initState() {
    super.initState();
    _startAnimation();

    _navigateTimer = Timer(const Duration(seconds: 3), () {
      context.go('/navigation', extra: widget.emotion); // emotion 전달
    });
  }


  void _startAnimation() {
    _dotTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        currentDotIndex = (currentDotIndex + 1) % dots.length;
      });
    });
  }

  @override
  void dispose() {
    _dotTimer.cancel();
    _navigateTimer?.cancel(); // null safety
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NaMooColor.white,
      body: Center(
        child: Text(
          '일기를 분석중입니다${dots[currentDotIndex]}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
