import 'package:flutter/material.dart';
import 'package:req_livestream_helper/src/controller/app_controller.dart';
import 'package:req_livestream_helper/src/view/components/base_components/base_coming_up_animation_wrap.dart';
import 'package:req_livestream_helper/src/view/components/base_components/base_interative_icon.dart';
import 'package:req_livestream_helper/src/view/components/base_components/base_rounded_border_wrap.dart';
import 'package:req_livestream_helper/src/view/components/base_components/base_scroll_view_list.dart';
import 'package:req_livestream_helper/src/view/components/base_components/base_text.dart';
import 'package:req_livestream_helper/src/view/components/data_listing/components/clients_order/dialog/clients_order_dialog.dart';
import 'package:req_livestream_helper/src/view/components/printing/print_viewer.dart';
import 'package:req_livestream_helper/src/view/theme.dart';

class ClientOrderCard extends StatelessWidget {
  String dthr;
  List<ClientOrder> clientsOrder;
  ClientOrderCard({super.key, required this.clientsOrder, required this.dthr});

  @override
  Widget build(BuildContext context) {
    return RoundedBorderWrap(
      backgroundColor: Colors.transparent,
      borderColor: AppTheme.disabledColor,
      padding: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BaseText(dthr),
          BaseText(
            clientsOrder
                .where((cO) => cO.client != '' && cO.client != 'X')
                .toList()
                .length
                .toString(),
          ),
          Row(
            spacing: 4,
            children: [
              BaseInterativeIcon(
                Icon(
                  Icons.list,
                  color: AppTheme.primaryFontColor.withAlpha(500),
                  size: 20,
                ),
                () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ClientsOrderDialog(
                        clientsOrder:
                            clientsOrder
                                .where(
                                  (cO) => cO.client != '' && cO.client != 'X',
                                )
                                .toList(),
                      );
                    },
                  );
                },
              ),
              BaseInterativeIcon(
                Icon(
                  Icons.print,
                  color: AppTheme.primaryFontColor.withAlpha(500),
                  size: 20,
                ),
                () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PrintViewer(
                          clientOrderList:
                              clientsOrder
                                  .where(
                                    (cO) => cO.client != '' && cO.client != 'X',
                                  )
                                  .toList(),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
