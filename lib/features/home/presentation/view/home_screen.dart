import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:namoo/core/namoo_color.dart';
import 'package:namoo/core/namoo_textstyle.dart';
import 'package:namoo/features/diary/data/diary_data.dart';
import 'package:namoo/features/home/presentation/widget/home_app_bar_widget.dart';
import 'package:namoo/features/home/presentation/widget/home_body_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  final String? emotion;

  const HomeScreen({super.key, this.emotion});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<String, dynamic>? _diaryData;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _fetchDiaryForSelectedDay();
  }

  void _showMonthPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SizedBox(
          height: 300,
          child: ListView.builder(
            itemCount: 12,
            itemBuilder: (context, index) {
              final month = index + 1;
              return ListTile(
                title: Text(
                  '2025.${month.toString().padLeft(2, '0')}',
                  style: NaMooTextStyle.button1(color: NaMooColor.black),
                ),
                onTap: () {
                  setState(() {
                    _focusedDay = DateTime(2025, month, 1);
                    _selectedDay = DateTime(2025, month, 1);
                  });
                  _fetchDiaryForSelectedDay();
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _fetchDiaryForSelectedDay() async {
    if (_selectedDay == null) return;

    final dateStr = _selectedDay!.toIso8601String().split('T')[0];
    final diaryService = DiaryService();
    final diary = await diaryService.fetchDiaryByDate(_selectedDay!);

    setState(() {
      _diaryData = diary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NaMooColor.white,
      appBar: HomeAppBarWidget(
        focusedDay: _focusedDay,
        onMonthPickerTap: () => _showMonthPicker(context),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: TableCalendar(
              headerVisible: false,
              firstDay: DateTime.utc(2025, 1, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              focusedDay: _focusedDay,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                _fetchDiaryForSelectedDay();
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarStyle: CalendarStyle(
                todayDecoration: const BoxDecoration(
                  color: NaMooColor.main400,
                  shape: BoxShape.circle,
                ),
                todayTextStyle: NaMooTextStyle.caption1(
                  color: NaMooColor.black,
                ),
                selectedDecoration: const BoxDecoration(
                  color: NaMooColor.main100,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: NaMooTextStyle.caption1(
                  color: NaMooColor.black,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: NaMooTextStyle.caption1(
                  color: NaMooColor.black,
                ),
                weekendStyle: NaMooTextStyle.caption1(
                  color: Colors.red,
                ),
                dowTextFormatter: (date, locale) {
                  final weekdayNames = ['월', '화', '수', '목', '금', '토', '일'];
                  return weekdayNames[date.weekday - 1];
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: NaMooColor.white200,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 3),
                    Center(
                      child: GestureDetector(
                        child: SvgPicture.asset(
                          'assets/images/icons/down_arrow.svg',
                        ),
                        onTap: () {},
                      ),
                    ),
                    HomeBodyWidget(
                      emotion: _diaryData?['emotion'] ?? '감정 없음',
                      selectedDate: _selectedDay ?? DateTime.now(),
                      recommendation: _diaryData?['recommendation'],
                      content: _diaryData?['content'],
                      title: _diaryData?['title'],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

