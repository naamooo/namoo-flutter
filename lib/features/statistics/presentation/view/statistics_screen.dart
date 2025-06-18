import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:namoo/core/namoo_color.dart';
import 'package:namoo/core/namoo_textstyle.dart';
import 'package:namoo/features/statistics/presentation/widget/statistics_app_bar_widget.dart';
import 'package:namoo/features/statistics/presentation/widget/statistics_body_widget.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StatisticsAppBarWidget(),
      backgroundColor: NaMooColor.white,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 19, right: 19, top: 30
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('서예린', style: NaMooTextStyle.my1(color: NaMooColor.main400),),
                          Text('님,', style: NaMooTextStyle.my1(color: NaMooColor.black),)
                        ],
                      ),
                      Text('이번달의 결과에요!', style: NaMooTextStyle.my1(color: NaMooColor.black),)
                    ],
                  ),
                  SvgPicture.asset('assets/images/icons/core/tree_icon.svg')
                ],
              ),
            ),
            const SizedBox(height: 30),
            StatisticsBodyWidget()
          ],
        ),
      ),
    );
  }
}
