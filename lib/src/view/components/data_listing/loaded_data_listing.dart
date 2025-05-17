import 'package:flutter/material.dart';
import 'package:req_livestream_helper/src/controller/app_controller.dart';
import 'package:req_livestream_helper/src/view/components/data_listing/components/excel_loaded_files_listing.dart';
import 'package:req_livestream_helper/src/view/components/data_listing/components/clients_order_list_listing.dart';
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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        widget.appController.isExcelFileCacheEmpty()
            ? ExcelLoadedFilesListingPlaceHolder()
            : ExcelLoadedFilesListing(
              list: widget.appController.runtimeMemory?.excelFileMemory ?? [],
            ),
        widget.appController.isClientsOrderListCacheEmpty()
            ? ClientsOrderListPlaceHolder()
            : ClientsOrderList(
              list:
                  widget.appController.runtimeMemory?.clientOrderListMemory ??
                  [],
            ),

        /// TODO: app version
        Text(
          'v1.0.0+2#1',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w600,
            color: AppTheme.disabledColor.withAlpha(50),
          ),
        ),
      ],
    );
  }
}
