// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BaseText extends StatelessWidget {
  String text;
  BaseText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle());
  }
}
