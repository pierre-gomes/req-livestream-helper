import 'dart:developer';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:req_livestream_helper/main.dart';
import 'package:req_livestream_helper/src/data/data_source/runtime_memory.dart';
import 'package:req_livestream_helper/src/data/models/excel_file.dart';
import 'package:req_livestream_helper/src/domain/constants.dart';
import 'package:req_livestream_helper/src/services/feedback_service.dart';

class AppController {
  RuntimeMemory? runtimeMemory = getIt?.get<RuntimeMemory>();
  bool isClientsOrderListCacheEmpty() =>
      runtimeMemory?.clientOrderListMemory.isEmpty ?? false;
  bool isPackageOrderCacheEmpty() =>
      runtimeMemory?.packageOrderMemory.isEmpty ?? false;
  bool isExcelFileCacheEmpty() =>
      runtimeMemory?.excelFileMemory.isEmpty ?? false;

  Future pickXlsx() async {
    // Open the file picker
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && (result.files.first.path != null)) {
      runtimeMemory?.addExcelFile(ExcelFile(path: result.files.first.path!));
      FeedbackService.showSuccessMessage("Arquivo carregado com sucesso");
      try {
        List<ClientOrder> clientOrderList = await processXlsx(
          result.files.first.path!,
        );
        runtimeMemory?.addClientOrderList(clientOrderList);
        FeedbackService.showSuccessMessage(
          "Planilha processada. Resultado encontra-se no arquivo em: ...",
        );
      } catch (err, stk) {
        FeedbackService.showErrMessage(
          "Algo deu errado no processamento dessa planlha\n mais infos (tira um print e envia p dev se persistir):\n ${err.toString()}\n${stk.toString()}",
        );
      }
    } else {
      // User canceled the picker
    }
  }

  Future<List<ClientOrder>> processXlsx(String filePath) async {
    File file = File(filePath);
    var bytes = await file.readAsBytes();
    var excel = Excel.decodeBytes(bytes);

    List<String> cList = fetchOrderClientList(excel);
    List<ClientOrder> clientOrderList =
        cList.map((String c) => ClientOrder(c, [])).toList();

    // // ignore: unnecessary_null_comparison
    if (excel != null) {
      /// fetchs all clients in excel
      excel.tables.forEach((tableName, table) {
        /// iterates in sheet rows
        for (var rowIndex = 0; rowIndex < table.rows.length; rowIndex++) {
          /// iterate in sheets specific row columns
          for (
            var colIndex = 0;
            colIndex < table.rows[rowIndex].length;
            colIndex++
          ) {
            var cellValue =
                table.rows[rowIndex][colIndex]?.value.toString() ?? '';

            if (rowIndex == 0) {
              //collect labels
            } else {
              // if in client instagram @ colunm range
              if (colIndex >= 3) {
                // if cell is empty
                if (cellValue == '') {
                  if (Constants.XTREME_DEBUG) {
                    log(
                      '[${rowIndex.toString()}][${colIndex.toString()}]',
                      name: 'app_controller.processXlxs.skipping_cell_at_index',
                    );
                  }
                  continue;
                }
                // collect client @
                List<Data?> rowCursor = table.rows[rowIndex];
                var codVal = rowCursor[0]?.value;
                var dscVal = rowCursor[1]?.value;
                var priceVal = rowCursor[2]?.value;
                var sizeVal = table.rows[0][colIndex]?.value;

                // treats empty cod/dsc values
                if (codVal == null) {
                  codVal = treatCodDscOffSet(table.rows, rowIndex, 0);
                  dscVal = treatCodDscOffSet(table.rows, rowIndex, 1);
                  priceVal = treatCodDscOffSet<double>(table.rows, rowIndex, 2);
                }

                // transforms collected data to runtime data type
                int cod = codVal is int ? codVal : -1;
                if (codVal is SharedString) {
                  cod = int.tryParse(codVal.toString()) ?? cod;
                }
                // int cod = codVal is int ? codVal : -1;

                String prodDsc =
                    dscVal is SharedString ? dscVal.toString() : '-';
                // double price = priceVal is/
                String prodSize =
                    sizeVal is SharedString ? sizeVal.toString() : '-';

                /// adds product to client order
                clientOrderList
                    .firstWhere(
                      (ClientOrder clientOrder) =>
                          clientOrder.client == cellValue,
                    )
                    .products
                    .add(Product(cod, dscVal.toString(), prodSize));

                if (Constants.DEBUG) {
                  log(
                    'cod: ${cod}\ndsc: ${prodDsc}\nsize: ${prodSize}\n price: ${priceVal}',
                    name:
                        'app_controller.processXlxs.adding_product_to_client: $cellValue',
                  );
                }
              }
            }
          }
        }
      });
    }
    return clientOrderList;
  }

  dynamic treatCodDscOffSet<T>(var excelCursor, int rI, int cI) {
    int limit = 10;
    var rowIndexOffSet = rI;
    while (limit >= 0 && rowIndexOffSet >= 0) {
      var cellVal = excelCursor[rowIndexOffSet][cI]?.value;
      if (cellVal != null) {
        if (cellVal is SharedString) {
          if (cellVal.toString().isNotEmpty && cellVal.toString() != '') {
            // logging
            if (Constants.XTREME_DEBUG) {
              log('string val: $cellVal', name: 'crawler found value');
            }
            return cellVal;
          }
        }
        if (cellVal is int) {
          if (Constants.XTREME_DEBUG) {
            log('int val: $cellVal', name: 'crawler found value');
          }
          return cellVal;
        }

        if (cellVal is double) {
          if (Constants.XTREME_DEBUG) {
            log('double val: $cellVal', name: 'crawler found value');
          }
          return cellVal;
        }
      }
      // craw back
      rowIndexOffSet--;
      limit--;
    }
    return null;
  }

  List<String> fetchOrderClientList(Excel excel) {
    List<String> clients = [];

    // ignore: unnecessary_null_comparison
    if (excel != null) {
      /// fetchs all clients in excel
      excel.tables.forEach((tableName, table) {
        /// iterates in sheet rows
        for (var rowIndex = 0; rowIndex < table.rows.length; rowIndex++) {
          /// iterate in sheets specific row columns
          for (
            var colIndex = 0;
            colIndex < table.rows[rowIndex].length;
            colIndex++
          ) {
            var cellValue =
                table.rows[rowIndex][colIndex]?.value.toString() ?? '';

            if (rowIndex == 0) {
              //collect labels
            } else {
              // if in client instagram @ colunm range
              if (colIndex >= 3) {
                // collect client @
                if (!clients.contains(cellValue)) {
                  /// TODO: exclude X + ""(empty space) from crawling search
                  clients.add(cellValue);
                  if (Constants.XTREME_DEBUG) {
                    log(
                      cellValue,
                      name:
                          'app_controller.fetchOrderClientList.adding_to_orders_client_list',
                    );
                  }
                }
              }
            }
          }
        }
      });
    }
    if (Constants.DEBUG) {
      log(
        clients.length.toString(),
        name: 'app_controller.fetchOrderClientList.final_client_list_size',
      );
    }
    return clients;
  }
}

class ClientOrder {
  String client;
  List<Product> products;
  ClientOrder(this.client, this.products);
}

class Product {
  int cod;
  String dsc;
  String prodSize;
  // Double price;

  Product(this.cod, this.dsc, this.prodSize);
}
