import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_offline/map_controller.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => MyHomePage(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => MapController());
          }),
        ),
      ],
    );
  }
}
