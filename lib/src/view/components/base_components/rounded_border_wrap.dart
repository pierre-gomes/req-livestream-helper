import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
