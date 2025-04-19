// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BaseScrollViewList extends StatelessWidget {
  double height;
  List<dynamic> data;
  Widget Function({dynamic item}) cardWidget;
  BaseScrollViewList({
    super.key,
    required this.height,
    required this.data,
    required this.cardWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: height, // Fixed height for the ListView
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return cardWidget(item: data[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
