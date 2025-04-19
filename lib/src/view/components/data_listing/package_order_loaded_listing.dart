import 'package:flutter/material.dart';
import 'package:req_livestream_helper/src/view/components/base_components/base_scroll_view_list.dart';
import 'package:req_livestream_helper/src/view/theme.dart';

class PackageOrderLoadedListingPlaceHolder extends StatelessWidget {
  const PackageOrderLoadedListingPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScrollViewList(
      height: MediaQuery.of(context).size.height * 0.4,
      data: ["", "", "", ""],
      cardWidget:
          ({item}) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.circle_outlined, color: AppTheme.disabledColor),
                SizedBox(width: 5),
                Container(
                  height: 2, // Line thickness
                  width: MediaQuery.of(context).size.width * 0.5, // Line length
                  color: AppTheme.disabledColor, // Line color
                ),
              ],
            ),
          ),
    );
  }
}

class PackageOrderLoadedListing extends StatelessWidget {
  const PackageOrderLoadedListing({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: Placeholder());
  }
}
