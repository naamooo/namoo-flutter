import 'package:flutter/material.dart';
import 'package:namoo/core/namoo_textstyle.dart';

class NamooButtonWidget extends StatelessWidget {

  final Color color;
  final String text;
  final Color? backgroundColor;

  const NamooButtonWidget({
    required this.color,
    required this.text,
    required this.backgroundColor,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(text, style: NaMooTextStyle.button1(color: color)),
      ),
    );
  }
}
