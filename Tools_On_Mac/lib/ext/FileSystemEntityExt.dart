import 'dart:io';

extension FileExt on FileSystemEntity {
  String getName() {
    final index = this.path.lastIndexOf("/");
    final name = this.path.substring(index+1);
    return name;
  }

  bool isHidFile() => this.getName().startsWith(".");
  bool isVisibleFile() => !this.getName().startsWith(".");

  int compareFileAndFolder(FileSystemEntity another) {
    final a = this is Directory;
    final b = another is Directory;
    if(a && !b) return -1; //folder优先级更高
    if(b && !a) return 1;
    else return 0; //相等
  }
}