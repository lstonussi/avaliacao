import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ambar/utils/dependency_injection.dart';

import 'app/routes/app_pages.dart';

void main() {
  DependecyInjection.init();
  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
