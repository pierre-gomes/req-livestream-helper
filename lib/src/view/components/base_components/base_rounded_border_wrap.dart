import 'package:flutter/material.dart';
import 'package:req_livestream_helper/src/view/theme.dart';

class RoundedBorderWrap extends StatelessWidget {
  Widget child;
  Color backgroundColor;
  Color borderColor;
  double padding;
  RoundedBorderWrap({
    super.key,
    required this.child,
    required this.backgroundColor,
    required this.borderColor,
    required this.padding,
  });
  RoundedBorderWrap.base({
    super.key,
    required this.child,
    this.backgroundColor = Colors.transparent,
    this.borderColor = AppTheme.disabledColor,
    this.padding = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}
