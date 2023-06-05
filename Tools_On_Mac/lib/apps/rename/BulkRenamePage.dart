import 'package:filepicker_macos/filepicker_macos.dart';
import 'package:flutter/material.dart';

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
    final ss = await FilepickerMacos.pick(
        canChooseFiles: true,
        allowsMultipleSelection: true,
        directoryURL: "~/Downloads",
        prompt: "hello"
    );
    print('ss = ${ss}');
  }
}

/*
1.
final dir = await getApplicationDocumentsDirectory();
print('dir = ${dir.path}'); //=> /Users/szw/Library/Containers/ca.six.tools.mac.toolsOnMac/Data/Documents

final dir = await getDownloadsDirectory();
print('dir = ${dir?.path}'); //=> /Users/szw/Library/Containers/ca.six.tools.mac.toolsOnMac/Data/Downloads
 */
