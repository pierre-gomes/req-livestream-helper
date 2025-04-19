import 'package:flutter/material.dart';
import 'package:req_livestream_helper/src/controller/app_controller.dart';
import 'package:req_livestream_helper/src/view/components/base_components/base_rounded_border_wrap.dart';
import 'package:req_livestream_helper/src/view/components/data_listing/excel_loaded_files_listing.dart';
import 'package:req_livestream_helper/src/view/components/data_listing/package_order_loaded_listing.dart';
import 'package:req_livestream_helper/src/view/theme.dart';

class LoadedDataListing extends StatefulWidget {
  AppController appController;
  LoadedDataListing({super.key, required this.appController});

  @override
  State<LoadedDataListing> createState() => _LoadedDataListingState();
}

class _LoadedDataListingState extends State<LoadedDataListing> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        widget.appController.isExcelFileCacheEmpty()
            ? ExcelLoadedFilesListingPlaceHolder()
            : ExcelLoadedFilesListing(
              list: widget.appController.runtimeMemory?.excelFileMemory ?? [],
            ),
        widget.appController.isPackageOrderCacheEmpty()
            ? PackageOrderLoadedListingPlaceHolder()
            : PackageOrderLoadedListing(),
      ],
    );
  }
}
