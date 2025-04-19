import 'package:req_livestream_helper/main.dart';
import 'package:req_livestream_helper/src/data/data_source/runtime_memory.dart';

class AppController {
  bool isPackageOrderCacheEmpty() =>
      getIt?.get<RuntimeMemory>().packageOrderMemory.isEmpty ?? false;
  bool isExcelFileCacheEmpty() =>
      getIt?.get<RuntimeMemory>().excelFileMemory.isEmpty ?? false;
  void open(params) {}
}
