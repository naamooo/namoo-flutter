import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:namoo/core/namoo_color.dart';
import 'package:namoo/features/home/presentation/view/home_screen.dart';
import 'package:namoo/features/statistics/presentation/view/statistics_screen.dart';

class BottomNavigation extends StatefulWidget {
  final String? emotion; // 감정 상태 추가

  const BottomNavigation({super.key, this.emotion});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _index = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(emotion: widget.emotion),
      const StatisticsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: SizedBox(
        height: 90,
        child: BottomAppBar(
          color: NaMooColor.white,
          elevation: 0,
          padding: const EdgeInsets.only(bottom: 0, top: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/icons/core/home_icon.svg',
                    color: _index == 0 ? NaMooColor.main400 : NaMooColor.main500,
                  ),
                  onPressed: () {
                    setState(() {
                      _index = 0;
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    context.push('/diary');
                  },
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                      color: NaMooColor.main500,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/icons/core/statistics_icon.svg',
                    color: _index == 1 ? NaMooColor.main400 : NaMooColor.main500,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    setState(() {
                      _index = 1;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
