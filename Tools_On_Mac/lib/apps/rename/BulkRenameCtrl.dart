import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tools_on_mac/ext/FileSystemEntityExt.dart';

class BulkRenameCtrl extends GetxController {
  final input = TextEditingController();
  final scroll = ScrollController();

  final inReplace = TextEditingController();
  final inWith = TextEditingController();
  final with_ = "".obs;

  final files_ = <FileSystemEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    input.text = "/Users/zhengwangsong/tmp/xxx"; //初始值, 便于debug
  }

  renameAll(){
    final replaceTo = inWith.text;
    final replaceFrom = inReplace.text;
    for(final file in files_.value) {
      final newName = file.getName().replaceAll(replaceFrom, replaceTo);
      file.renameSyncTo(newName);
    }

    // 重新读取目录中所有文件, 以反应结果
    readFilesInDir(input.text);
  }

  readFilesInDir(String path) {
    Directory dir = Directory(path);
    List<FileSystemEntity> filesInDir = dir.listSync(); //还会有".DS_Store", ".localized"的目录, 要去除它们

    // 1). 只取可见文件;  2). 排序 (folder在前, file在后)
    // files.value = filesInDir.where((file) => file.isVisibleFile()).toList()
    //   ..sort((a,b) => a.compareFileAndFolder(b)); //sort()返回void, 所以要用"..", 而不是"."

    // 1). 只取可见文件;  2). 不取目录, 只取文件
    files_.value = filesInDir.where((file) => file.isVisibleFile() && file is! Directory).toList();
  }
}