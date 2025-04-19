import 'package:file_picker/file_picker.dart';
import 'package:req_livestream_helper/main.dart';
import 'package:req_livestream_helper/src/data/data_source/runtime_memory.dart';
import 'package:req_livestream_helper/src/data/models/excel_file.dart';

class AppController {
  RuntimeMemory? runtimeMemory = getIt?.get<RuntimeMemory>();
  bool isPackageOrderCacheEmpty() =>
      runtimeMemory?.packageOrderMemory.isEmpty ?? false;
  bool isExcelFileCacheEmpty() =>
      runtimeMemory?.excelFileMemory.isEmpty ?? false;

  Future pickXlsx() async {
    // Open the file picker
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      runtimeMemory?.excelFileMemory.add(
        ExcelFile(path: result.files.first.path ?? '-'),
      );
    } else {
      // User canceled the picker
    }
  }
}
