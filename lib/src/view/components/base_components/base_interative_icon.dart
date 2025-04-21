import 'package:flutter/material.dart';
import 'package:req_livestream_helper/src/view/components/base_components/base_rounded_border_wrap.dart';

import '../../theme.dart';

class BaseInterativeIcon extends StatefulWidget {
  Icon icon;
  Function onTap;
  BaseInterativeIcon(this.icon, this.onTap, {super.key});

  @override
  State<BaseInterativeIcon> createState() => _BaseInterativeIconState();
}

class _BaseInterativeIconState extends State<BaseInterativeIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(),
      child: RoundedBorderWrap(
        backgroundColor: Colors.transparent,
        borderColor: AppTheme.primaryFontColor,
        padding: 5,
        child: widget.icon,
      ),
    );
  }
}
