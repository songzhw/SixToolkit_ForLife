import 'dart:io';

extension FileExt on FileSystemEntity {
  String getName() {
    final index = this.path.lastIndexOf("/");
    final name = this.path.substring(index+1);
    return name;
  }

  bool isHidFile() => this.getName().startsWith(".");
  bool isVisibleFile() => !this.getName().startsWith(".");
}