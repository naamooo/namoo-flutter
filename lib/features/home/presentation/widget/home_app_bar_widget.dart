import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:namoo/core/namoo_color.dart';
import 'package:namoo/core/namoo_textstyle.dart';

class HomeAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMonthPickerTap;
  final DateTime focusedDay;

  const HomeAppBarWidget({
    super.key,
    required this.onMonthPickerTap,
    required this.focusedDay,
  });

  @override
  Widget build(BuildContext context) {
    final displayMonth =
        '${focusedDay.year}.${focusedDay.month.toString().padLeft(2, '0')}';

    return AppBar(
      backgroundColor: NaMooColor.white,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  displayMonth,
                  style: NaMooTextStyle.cal1(color: NaMooColor.black),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: onMonthPickerTap,
                  child: SvgPicture.asset('assets/images/icons/under_arrow_icon.svg'),
                ),
              ],
            ),
            SvgPicture.asset('assets/images/icons/user_icon.svg')
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
