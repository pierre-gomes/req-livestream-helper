import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:req_livestream_helper/main.dart';
import 'package:req_livestream_helper/src/data/data_source/runtime_memory.dart';
import 'package:req_livestream_helper/src/data/models/excel_file.dart';
import 'package:req_livestream_helper/src/services/feedback_service.dart';

class AppController {
  RuntimeMemory? runtimeMemory = getIt?.get<RuntimeMemory>();
  bool isPackageOrderCacheEmpty() =>
      runtimeMemory?.packageOrderMemory.isEmpty ?? false;
  bool isExcelFileCacheEmpty() =>
      runtimeMemory?.excelFileMemory.isEmpty ?? false;

  Future pickXlsx() async {
    // Open the file picker
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && (result.files.first.path != null)) {
      runtimeMemory?.excelFileMemory.add(
        ExcelFile(path: result.files.first.path!),
      );
      FeedbackService.showSuccessMessage("Arquivo carregado com sucesso");
      try {
        await processXlsx(result.files.first.path!);
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

  Future processXlsx(String filePath) async {
    //   List<String> clients

    //   File file = File(filePath);
    //   var bytes = await file.readAsBytes();
    //   var excel = Excel.decodeBytes(bytes);

    //   // ignore: unnecessary_null_comparison
    //   if (excel != null) {

    //     // Loop through all sheets and find names
    //     excel.tables.forEach((tableName, table) {
    //       print("Searching in table: $tableName");

    //       // Loop through rows and columns
    //       for (var rowIndex = 0; rowIndex < table.rows.length; rowIndex++) {
    //         for (var colIndex = 0; colIndex < table.rows[rowIndex].length; colIndex++) {
    //           var cellValue = table.rows[rowIndex][colIndex];

    //           // Check if the cell contains a non-null value (assumed to be a name)
    //           if (cellValue != null && cellValue is String) {
    //             // If the name already exists in the map, add the position
    //             if (_nameOccurrences.containsKey(cellValue)) {
    //               _nameOccurrences[cellValue]?.add('Row: $rowIndex, Column: $colIndex');
    //             } else {
    //               // Initialize with the first occurrence
    //               _nameOccurrences[cellValue] = ['Row: $rowIndex, Column: $colIndex'];
    //             }
    //           }
    //         }
    //       }
    //     });
    // }
  }
}
