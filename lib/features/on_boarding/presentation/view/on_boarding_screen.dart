import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:namoo/core/namoo_color.dart';
import 'package:namoo/core/namoo_textstyle.dart';
import 'package:namoo/core/router.dart';
import 'package:namoo/widgets/namoo_button_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NaMooColor.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 200),
                SvgPicture.asset('assets/images/logo/title_icon.svg'),
                const SizedBox(height: 30,),
                Text('당신의 하루를 기록하세요.', style: NaMooTextStyle.heading1(color: NaMooColor.main500),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top : 260,left: 45, right: 45),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    context.push('/login');
                  },
                  child: NamooButtonWidget(
                    color: NaMooColor.white,
                    text: '로그인',
                    backgroundColor: Color(0xFFE0C08B),
                  ),
                ),
                const SizedBox(height: 18),
                GestureDetector(
                  onTap: (){
                    context.push('/sign_up');
                  },
                  child: NamooButtonWidget(
                    color: NaMooColor.white,
                    text: '회원가입',
                    backgroundColor: NaMooColor.main500,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
