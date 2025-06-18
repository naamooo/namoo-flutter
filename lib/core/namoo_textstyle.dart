import 'package:flutter/material.dart';

const String pretendard = 'Pretendard';

class NaMooTextStyle{

  static TextStyle heading1({
    required Color color,
  }) {
    return TextStyle(
      color: color,
      fontSize: 20,
      fontFamily: pretendard,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.visible,
    );
  }

  static TextStyle heading2({
    required Color color,
  }) {
    return TextStyle(
      color: color,
      fontSize: 12,
      fontFamily: pretendard,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.visible,
    );
  }

  static TextStyle heading3({
    required Color color,
  }) {
    return TextStyle(
      color: color,
      fontSize: 18,
      fontFamily: pretendard,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.visible,
    );
  }

  static TextStyle button1({
    required Color color,
  }) {
    return TextStyle(
      color: color,
      fontSize: 16,
      fontFamily: pretendard,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.visible,
    );
  }

  static TextStyle my1({
    required Color color,
  }) {
    return TextStyle(
      color: color,
      fontSize: 21,
      fontFamily: pretendard,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.visible,
    );
  }

  static TextStyle caption1({
    required Color color,
  }) {
    return TextStyle(
      color: color,
      fontSize: 12,
      fontFamily: pretendard,
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.visible,
    );
  }

  static TextStyle caption2({
    required Color color,
  }) {
    return TextStyle(
      color: color,
      fontSize: 22,
      fontFamily: pretendard,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.visible,
    );
  }

  static TextStyle content1({
    required Color color,
  }) {
    return TextStyle(
      color: color,
      fontSize: 14,
      fontFamily: pretendard,
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.visible,
    );
  }

  static TextStyle cal1({
    required Color color,
  }) {
    return TextStyle(
      color: color,
      fontSize: 19,
      fontFamily: pretendard,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.visible,
    );
  }

}