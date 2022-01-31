import 'dart:io';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ExelFilesScreenController extends GetxController {
  String screenName = 'Exel Files';
  RxList<FileSystemEntity> files = <FileSystemEntity>[].obs;

  void getAllExelRecord() async {
    final String path = (await getApplicationDocumentsDirectory()).path;
    String dir = '$path/';
    final myDir = new Directory(dir);
    var v = myDir.listSync(recursive: true, followLinks: false);
    for (var d in v) {
      if (d.toString().lastIndexOf('.xlsx') > -1) {
        files.add(d);
      }
    }
  }

  void openFile(filename) {
    String v = '';
    for (int i = 1; i < filename.length - 1; i++) {
      v += (filename[i]);
    }
    OpenFile.open(v);
  }

  @override
  void onInit() {
    getAllExelRecord();
    // TODO: implement onInit
    super.onInit();
  }
}
