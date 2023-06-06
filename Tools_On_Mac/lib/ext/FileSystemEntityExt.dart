import 'dart:io';

extension FileExt on FileSystemEntity {
  String getName() {
    final index = this.path.lastIndexOf("/");
    final name = this.path.substring(index+1);
    print('name = $name');
    return name;
  }

  bool isHidFile() => this.getName().startsWith(".");
  bool isVisibleFile() => !this.getName().startsWith(".");
}