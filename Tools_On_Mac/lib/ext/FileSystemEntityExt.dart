import 'dart:io';

extension FileExt on FileSystemEntity {
  String getName() {
    final index = this.path.lastIndexOf("/") + 1; //+1是不要"/", 不然name就成了"/me.txt"
    final name = this.path.substring(index);
    return name;
  }

  bool isHidFile() => this.getName().startsWith(".");

  bool isVisibleFile() => !this.getName().startsWith(".");

  int compareFileAndFolder(FileSystemEntity another) {
    final a = this is Directory;
    final b = another is Directory;
    if (a && !b) return -1; //folder优先级更高
    if (b && !a)
      return 1;
    else
      return 0; //相等
  }

  void renameSyncTo(String newName) {
    final index = this.path.lastIndexOf("/") + 1;
    final newPath = this.path.replaceRange(index, null, newName); //第二参为Null即是length值
    this.renameSync(newPath);
  }
}
