import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:req_livestream_helper/src/app.dart';
import 'package:req_livestream_helper/src/services/dependency_service.dart';
import 'package:window_size/window_size.dart';

/// global acces to SeviceLocator
GetIt? getIt;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  getIt = DependencyService.getIt;
  DependencyService.init();
  // if (Platform.isWindows) {
  //   setWindowMinSize(Size(750, 600));
  //   setWindowMaxSize(Size(750, 600));
  // }

  runApp(LiveStreamHelper());
}
