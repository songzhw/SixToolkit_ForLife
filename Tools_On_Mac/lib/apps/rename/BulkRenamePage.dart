import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../Commons.dart';



class BulkRenamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Bulk Re-name"),
      body: Column(
        children: [
          TextButton(onPressed: f, child: Text("ccc")),
        ],
      ),
    );
  }

  f() async {
    print('11');
    final dir = await getApplicationDocumentsDirectory();
    print('dir = ${dir.path}'); //=> dir = /Users/zhengwangsong/Documents
  }
}

/*
1.
final dir = await getApplicationDocumentsDirectory();
print('dir = ${dir.path}'); //=> /Users/szw/Library/Containers/ca.six.tools.mac.toolsOnMac/Data/Documents

final dir = await getDownloadsDirectory();
print('dir = ${dir?.path}'); //=> /Users/szw/Library/Containers/ca.six.tools.mac.toolsOnMac/Data/Downloads

2.
//只能pick文件, 没有我想像的列出文件列表之类的操作, 故删除了些库
import 'package:filepicker_macos/filepicker_macos.dart';

3. 要能访问mac本地文件, 就得去 macos/Runner/DebugProfile.entitlements 文件中修改
	<key>com.apple.security.app-sandbox</key>
	<false/>
这个sandbox的值不能为true !!!

4. 当把app-sandbox设为false后, 那下面的值就变了!!!
    final dir = await getApplicationDocumentsDirectory();
    print('dir = ${dir.path}'); //=> dir = /Users/zhengwangsong/Documents
 */
