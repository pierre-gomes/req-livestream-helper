import 'package:req_livestream_helper/src/controller/app_controller.dart';
import 'package:req_livestream_helper/src/data/models/excel_file.dart';
import 'package:req_livestream_helper/src/data/models/package_order.dart';

class RuntimeMemory {
  List<RuntimeMemoryData<ExcelFile>> excelFileMemory = [];
  List<RuntimeMemoryData<PackageOrder>> packageOrderMemory = [];
  List<RuntimeMemoryData<List<ClientOrder>>> clientOrderListMemory = [];

  addExcelFile(ExcelFile excelFile) {
    excelFileMemory.add(
      RuntimeMemoryData(excelFileMemory.length, DateTime.now(), excelFile),
    );
  }

  addPackageOrder(PackageOrder packageOrder) {
    packageOrderMemory.add(
      RuntimeMemoryData(
        packageOrderMemory.length,
        DateTime.now(),
        packageOrder,
      ),
    );
  }

  addClientOrderList(List<ClientOrder> clientOrder) {
    clientOrderListMemory.add(
      RuntimeMemoryData(
        clientOrderListMemory.length,
        DateTime.now(),
        clientOrder,
      ),
    );
  }
}

class RuntimeMemoryData<T> {
  int id;
  DateTime dthrModified;
  T data;
  RuntimeMemoryData(this.id, this.dthrModified, this.data);
}
