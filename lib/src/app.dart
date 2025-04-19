import 'package:flutter/material.dart';
import 'package:req_livestream_helper/main.dart';
import 'package:req_livestream_helper/src/controller/app_controller.dart';
import 'package:req_livestream_helper/src/domain/constants.dart';
import 'package:req_livestream_helper/src/view/pages/home.dart';

class LiveStreamHelper extends StatefulWidget {
  const LiveStreamHelper({super.key});

  @override
  State<LiveStreamHelper> createState() => _LiveStreamHelperState();
}

class _LiveStreamHelperState extends State<LiveStreamHelper> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_LABEL,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SafeArea(
        child: MyHomePage(
          title: Constants.APP_LABEL,
          appController: getIt?.get<AppController>() ?? AppController(),
        ),
      ),
    );
  }
}
