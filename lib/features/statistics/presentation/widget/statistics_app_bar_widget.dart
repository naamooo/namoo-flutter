import 'package:flutter/material.dart';
import 'package:namoo/core/namoo_color.dart';
import 'package:namoo/core/namoo_textstyle.dart';

class StatisticsAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const StatisticsAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: NaMooColor.white,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('통계', style: NaMooTextStyle.heading1(color: NaMooColor.black),)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
