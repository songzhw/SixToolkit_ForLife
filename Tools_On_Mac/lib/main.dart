import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tools_on_mac/Commons.dart';
import 'package:tools_on_mac/apps/rename/BulkRenamePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "tools on Mac",
      initialRoute: "/home",
      getPages: [
        GetPage(name: "/home", page: () => const MyHomePage()),
        GetPage(name: "/apps/rename", page: () => BulkRenamePage()),
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Home Page"),
      body: ListView(
        children: [
          Wrap(children: [
            TextButton(onPressed: (){Get.toNamed("/apps/rename"); }, child: const Text("bulk rename")),
          ])
        ]
      ),
    );
  }

}
