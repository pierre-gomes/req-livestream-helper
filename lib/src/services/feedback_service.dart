import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:req_livestream_helper/main.dart';
import 'package:req_livestream_helper/src/view/components/base_components/base_coming_up_animation_wrap.dart';
import 'package:req_livestream_helper/src/view/components/base_components/base_rounded_border_wrap.dart';
import 'package:req_livestream_helper/src/view/theme.dart';

class FeedbackService {
  static showSuccessMessage(String msg) {
    ScaffoldMessenger.of(navigatorKey.currentState!.context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: ComingUpAnimation(child: Text("✨ $msg"))),
      );
  }

  static showErrMessage(String msg) {
    ScaffoldMessenger.of(navigatorKey.currentState!.context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: ComingUpAnimation(child: Text("😢 $msg")),
        ),
      );
  }
}
