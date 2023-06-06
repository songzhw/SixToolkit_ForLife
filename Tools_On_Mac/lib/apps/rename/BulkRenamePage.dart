import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Commons.dart';

class BulkRenamePage extends StatelessWidget {
  final input = TextEditingController();
  final files = <FileSystemEntity>[].obs;

  @override
  Widget build(BuildContext context) {
    input.text = "/Users/zhengwangsong/Downloads"; //初始值, 便于debug

    return Scaffold(
      appBar: appbar("Bulk Re-name"),
      body: Column(
        children: [
          TextField(
            controller: input,
            decoration: InputDecoration(labelText: "folder path", hintText: "folder path", prefixIcon: Icon(Icons.folder_copy_outlined)),
            onSubmitted: (value) {
              print('szw value = $value');
            },
          ),
          Container( height: 200,
            child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 一行几个. 这当然就确定了width了
              childAspectRatio: 10,
              mainAxisSpacing: 10,  //主轴上的空隙
              crossAxisSpacing: 10, //次轴上的空隙
            ), itemBuilder: (ctx, index) {
              return Text("aaa");
            }, itemCount: 20, scrollDirection: Axis.vertical, physics: ScrollPhysics()),
          ),
          TextButton(onPressed: f, child: Text("ccc")),
        ],
      ),
    );
  }

  _readFilesInDir(String path){
    Directory dir = Directory(path);
    List<FileSystemEntity> files = dir.listSync();
    for(var file in files) {
      print("szw file = ${file.path}, isDir = ${file is Directory}");
    }
  }

  f() async {
    _readFilesInDir(input.text);
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
    print('dir = ${dir.path}'); //=> dir = /Users/szw/Documents

5. Grid放到Column里会报错, 因为不知道GridView尺寸
这时要么给GridView(shrinkWrap: true)
要么就是Flexible(flex:1, child: Grid)
 */
