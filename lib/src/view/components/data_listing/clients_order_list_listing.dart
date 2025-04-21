// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:req_livestream_helper/src/controller/app_controller.dart';
import 'package:req_livestream_helper/src/data/data_source/runtime_memory.dart';
import 'package:req_livestream_helper/src/view/components/base_components/base_rounded_border_wrap.dart';
import 'package:req_livestream_helper/src/view/components/base_components/base_scroll_view_list.dart';
import 'package:req_livestream_helper/src/view/theme.dart';

class ClientsOrderListPlaceHolder extends StatelessWidget {
  const ClientsOrderListPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedBorderWrap(
      backgroundColor: Colors.transparent,
      borderColor: AppTheme.disabledColor,
      padding: 5,
      child: BaseScrollViewList(
        height: MediaQuery.of(context).size.height * 0.55,
        data: [""],
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
                    width:
                        MediaQuery.of(context).size.width * 0.4, // Line length
                    color: AppTheme.disabledColor, // Line color
                  ),
                ],
              ),
            ),
      ),
    );
  }
}

class ClientsOrderList extends StatelessWidget {
  List<RuntimeMemoryData<List<ClientOrder>>> list;

  ClientsOrderList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    // return Placeholder();
    return RoundedBorderWrap(
      backgroundColor: Colors.transparent,
      borderColor: AppTheme.disabledColor,
      padding: 5,
      child: BaseScrollViewList(
        cardWidget: ({item}) => Text(item.data.length.toString()),
        data: list,
        height: MediaQuery.of(context).size.height * 0.3,
      ),
    );
  }
}
