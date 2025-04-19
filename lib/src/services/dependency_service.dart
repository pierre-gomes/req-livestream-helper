import 'package:get_it/get_it.dart';
import 'package:req_livestream_helper/src/controller/app_controller.dart';
import 'package:req_livestream_helper/src/data/data_source/runtime_memory.dart';

class DependencyService {
  static GetIt getIt = GetIt.instance;
  static void init() {
    getIt.registerSingleton(AppController());
    getIt.registerSingleton(RuntimeMemory());
  }
}
