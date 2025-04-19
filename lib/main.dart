import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:req_livestream_helper/src/app.dart';
import 'package:req_livestream_helper/src/services/dependency_service.dart';

/// global acces to SeviceLocator
GetIt? getIt;

void main() {
  getIt = DependencyService.getIt;
  DependencyService.init();

  runApp(LiveStreamHelper());
}
