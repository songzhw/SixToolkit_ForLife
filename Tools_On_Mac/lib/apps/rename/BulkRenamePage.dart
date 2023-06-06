import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tools_on_mac/ext/FileSystemEntityExt.dart';

import '../../Commons.dart';

class BulkRenamePage extends StatelessWidget {
  final input = TextEditingController();
  final scroll = ScrollController();

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
            decoration: InputDecoration(labelText: hint, hintText: hint, prefixIcon: Icon(Icons.folder_copy_outlined)),
            onSubmitted: (value) => _readFilesInDir(value),
          ),
          SizedBox(
            height: 200,
            child: Scrollbar(
              controller: scroll,
              child: Obx(() => GridView.builder(
                  gridDelegate: fileGridDelegate,
                  itemCount: files.value.length,
                  controller: scroll,
                  itemBuilder: (ctx, index) => _renderFileGrid(index))),
            ),
          ),
          TextButton(onPressed: f, child: Text("ccc")),
        ],
      ),
    );
  }

  _readFilesInDir(String path) {
    Directory dir = Directory(path);
    List<FileSystemEntity> filesInDir = dir.listSync(); //还会有".DS_Store", ".localized"的目录, 要去除它们
    files.value = filesInDir.where((file) => file.isVisibleFile()).toList();
  }

  _renderFileGrid(int index) {
    final _files = files.value;
    if(index >= _files.length) return Text("");
    return Text(_files[index].path);
  }

  f() async {
    _readFilesInDir(input.text);
  }

  // - - - - - - - - - trivial members - - - - - - - - -
  final hint = "folder path";
  final fileGridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2, // 一行几个. 这当然就确定了width了
    childAspectRatio: 10,
    mainAxisSpacing: 10, //主轴上的空隙
    crossAxisSpacing: 10, //次轴上的空隙
  );

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
要么就是Container(height: 200, child: Grid)

6. Grid放到Column中, 当grid.height不高, 明显有东西没展示时, 其实默认不会滑动的
要想能滑动看到更多内容, 就得用ScrollBar包一下, 并把scrollController放到grid与scrollbar里去:
           Scrollbar(
              controller: scroll,
              child: GridView.builder(...,
                        controller: scroll,),
注意, 父子两个地方都加这个controller哦!
 */
