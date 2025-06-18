import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:namoo/core/namoo_color.dart';
import 'package:namoo/features/diary/data/diary_data.dart';
import 'package:namoo/features/diary/presentation/widget/diary_app_bar_widget.dart';
import 'package:namoo/features/diary/presentation/widget/diary_top_widget.dart';
import 'package:namoo/features/diary/presentation/widget/diary_write_widget.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  bool _isFilled = false;
  final DiaryService _diaryService = DiaryService();

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_checkInput);
    _bodyController.addListener(_checkInput);
  }

  void _checkInput() {
    final filled = _titleController.text.trim().isNotEmpty &&
        _bodyController.text.trim().isNotEmpty;
    if (_isFilled != filled) {
      setState(() {
        _isFilled = filled;
      });
    }
  }

  void _onSave() async {
    final title = _titleController.text.trim();
    final content = _bodyController.text.trim();
    final today = DateTime.now().toIso8601String().split('T').first; // "yyyy-MM-dd"

    final result = await _diaryService.writeDiary(
      title: title,
      content: content,
      date: today,
    );

    if (!mounted) return;

    if (result != null) {
      final emotion = result['emotion'] as String? ?? '알 수 없음';
      final recommendation = result['recommendation'] as String? ?? '';

      context.push(
        '/diarySuccess',
        extra: {
          'emotion': emotion,
          'recommendation': recommendation,
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('일기 저장에 실패했습니다.')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DiaryAppBarWidget(
        showSave: _isFilled,
        onSave: _onSave,
      ),
      backgroundColor: NaMooColor.white200,
      body: Column(
        children: [
          const SizedBox(height: 10),
          const DiaryTopWidget(),
          const SizedBox(height: 13),
          DiaryWriteWidget(
            titleController: _titleController,
            bodyController: _bodyController,
          ),
        ],
      ),
    );
  }
}
