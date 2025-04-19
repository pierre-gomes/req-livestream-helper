import 'package:flutter/material.dart';
import 'package:req_livestream_helper/src/controller/app_controller.dart';
import 'package:req_livestream_helper/src/view/components/data_listing/loaded_data_listing.dart';
import 'package:req_livestream_helper/src/view/theme.dart';

class MyHomePage extends StatefulWidget {
  final AppController appController;
  const MyHomePage({
    super.key,
    required this.title,
    required this.appController,
  });
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LoadedDataListing(appController: widget.appController),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.primaryBackgroundColor,
        child: Icon(Icons.add, color: AppTheme.primaryFontColor),
      ),
    );
  }
}
