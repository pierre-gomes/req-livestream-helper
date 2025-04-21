// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:req_livestream_helper/src/view/theme.dart';

class BaseText extends StatelessWidget {
  String text;
  BaseText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppTheme.primaryFontColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
