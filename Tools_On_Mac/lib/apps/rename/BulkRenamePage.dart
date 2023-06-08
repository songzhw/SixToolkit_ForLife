import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tools_on_mac/ext/FileSystemEntityExt.dart';

import '../../Commons.dart';

class BulkRenamePage extends StatelessWidget {
  final input = TextEditingController();
  final scroll = ScrollController();

  final inReplace = TextEditingController();
  final inWith = TextEditingController();
  final with_ = "".obs;

  final files_ = <FileSystemEntity>[].obs;

  @override
  Widget build(BuildContext context) {
    input.text = "/Users/zhengwangsong/tmp/xxx"; //初始值, 便于debug

    return Scaffold(
      appBar: appbar("Bulk Re-name"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              controller: input,
              decoration: InputDecoration(labelText: hint, hintText: hint, prefixIcon: Icon(Icons.folder_copy_outlined)),
              onSubmitted: (value) => _readFilesInDir(value),
            ),

            SizedBox(
              height: 300,
              child: Scrollbar(
                controller: scroll,
                child: Obx(() => ListView.builder(
                    itemCount: files_.value.length,
                    controller: scroll,
                    itemBuilder: (ctx, index) => _renderFileGrid(index))),
              ),
            ),

            Row(children: [
              Text("Replace", style: titleStyle),
              Expanded(child: TextField(controller: inReplace), flex: 1),
              Text("with"),
              Expanded(child: TextField(controller: inWith, onChanged: (v) {with_.value = v;}), flex: 1),
            ]),

            OutlinedButton(onPressed: _renameAll, child: Text("rename")),
          ],
        ),
      ),
    );
  }

  _renameAll(){
    final replaceTo = inWith.text;
    final replaceFrom = inReplace.text;
    for(final file in files_.value) {
      final newName = file.getName().replaceAll(replaceFrom, replaceTo);
      file.renameSyncTo(newName);
    }

    // 重新读取目录中所有文件, 以反应结果
    _readFilesInDir(input.text);
  }

  _readFilesInDir(String path) {
    Directory dir = Directory(path);
    List<FileSystemEntity> filesInDir = dir.listSync(); //还会有".DS_Store", ".localized"的目录, 要去除它们

    // 1). 只取可见文件;  2). 排序 (folder在前, file在后)
    // files.value = filesInDir.where((file) => file.isVisibleFile()).toList()
    //   ..sort((a,b) => a.compareFileAndFolder(b)); //sort()返回void, 所以要用"..", 而不是"."

    // 1). 只取可见文件;  2). 不取目录, 只取文件
    files_.value = filesInDir.where((file) => file.isVisibleFile() && file is! Directory).toList();
  }

  _renderFileGrid(int index) {
    final _files = files_.value;
    if(index >= _files.length) return Text("");
    final file = _files[index];
    final icon = (file is Directory) ? const Icon(Icons.folder, color: Colors.orange,) : const Icon(Icons.file_copy, color: Colors.white);
    final originalName = file.getName();
    final newName = originalName.replaceAll(inReplace.text, with_.value);
    final style = originalName == newName ? fileStyle : nextStyle;
    return Container(
      color: index % 2 == 0 ? Colors.grey : Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(flex:3, child: Row(
              children: [
                icon, const SizedBox(width: 10),
                Expanded(child: Text(originalName, style: fileStyle)),
              ],
            )),
            Expanded(flex:5, child:
              Obx(()=> Text(newName, style: style))),
          ],
        ),
      ),
    );
  }

  // - - - - - - - - - trivial members - - - - - - - - -
  final hint = "folder path";
  final fileStyle = TextStyle(fontSize: 18, color: Colors.black);
  final nextStyle = TextStyle(fontSize: 18, color: Colors.blue);
  final titleStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

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
