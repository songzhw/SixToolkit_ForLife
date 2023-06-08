import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tools_on_mac/apps/rename/BulkRenameCtrl.dart';
import 'package:tools_on_mac/ext/FileSystemEntityExt.dart';

import '../../Commons.dart';

class BulkRenamePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(BulkRenameCtrl());

    return Scaffold(
      appBar: appbar("Bulk Re-name"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              controller: ctrl.input,
              decoration: InputDecoration(labelText: hint, hintText: hint, prefixIcon: const Icon(Icons.folder_copy_outlined)),
              onSubmitted: (value) => ctrl.readFilesInDir(value),
            ),

            SizedBox(
              height: 300,
              child: Scrollbar(
                controller: ctrl.scroll,
                child: Obx(() => ListView.builder(
                    itemCount: ctrl.files_.value.length,
                    controller: ctrl.scroll,
                    itemBuilder: (ctx, index) => _renderFileGrid(index))),
              ),
            ),

            Row(children: [
              Text("Replace", style: titleStyle),
              const SizedBox(width: 10),
              // 有时replace与with全有了内容; 但要想修改下replace, 希望也能刷新列表, 所以这里也得加上onChanged
              Expanded(flex: 1, child: TextField(controller: ctrl.inReplace, onChanged: ctrl.updateReplaceString)),
              const SizedBox(width: 10),
              const Text("with"),
              const SizedBox(width: 10),
              Expanded(flex: 1, child: TextField(controller: ctrl.inWith, onChanged: ctrl.updateWithString)),
            ]),

            OutlinedButton(onPressed: ctrl.renameAll, child: const Text("rename")),
          ],
        ),
      ),
    );
  }




  _renderFileGrid(int index) {
    final ctrl = Get.find<BulkRenameCtrl>();
    final _files = ctrl.files_.value;
    if(index >= _files.length) return const Text("");
    final file = _files[index];
    final icon = (file is Directory) ? const Icon(Icons.folder, color: Colors.orange,) : const Icon(Icons.file_copy, color: Colors.indigo);
    final originalName = file.getName();

    return Container(
      color: index % 2 == 0 ? Colors.grey[50] : Colors.green[50],
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
              Obx(() {
                final isNotFullDone = ctrl.replace_.value.isEmpty || ctrl.with_.value.isEmpty;
                final newName = isNotFullDone ? originalName : originalName.replaceAll(ctrl.replace_.value, ctrl.with_.value);
                final style = originalName == newName ? fileStyle : nextStyle;
                return Text(newName, style: style);
              })),
          ],
        ),
      ),
    );
  }

  // - - - - - - - - - trivial members - - - - - - - - -
  final hint = "folder path";
  final fileStyle = const TextStyle(fontSize: 18, color: Colors.black);
  final nextStyle = const TextStyle(fontSize: 18, color: Colors.blueAccent);
  final titleStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

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
