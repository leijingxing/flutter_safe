import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_safe/page/VidioPlay.dart';

import 'package:video_thumbnail/video_thumbnail.dart';

class ImageList extends StatefulWidget {

  @override
  _ImageListState createState() => _ImageListState();

}

class _ImageListState extends State<ImageList> {



  List<String> listpath = new List<String>();

  // List listimage = new List();


  String value; // 每次input的值
  String allText = '/storage/718E-13EB/DCIM/test/demo.txt'; // 从本地文件获取的值
  String directory = '/storage/emulated/0/Android/data/com.safe.flutter_safe/files/flutter/'; // 从本地文件获取的值

  /**
   * 此方法返回本地文件地址
   */

  Future _getLocalFile() async {
    Directory appDocDir =  Directory(directory);
    //列出所有文件，不包括链接和子文件夹
    Stream<FileSystemEntity> entityList =
    appDocDir.list(recursive: false, followLinks: false);
    await for (FileSystemEntity entity in entityList) {
      //文件、目录和链接都继承自FileSystemEntity
      //FileSystemEntity.type静态函数返回值为FileSystemEntityType
      //FileSystemEntityType有三个常量：
      //Directory、FILE、LINK、NOT_FOUND
      //FileSystemEntity.isFile .isLink .isDerectory可用于判断类型
      print(entity.path);
    }
    return new File('demo.txt');

  }

  /**
   * 保存value到本地文件里面
   *
   */

  /**
   * 读取本地文件的内容
   */
  _list() async {
    Directory appDocDir = Directory(directory);
    Stream<FileSystemEntity> entityList =
    appDocDir.list(recursive: false, followLinks: false);

    await for (FileSystemEntity entity in entityList) {
      print('bbbbbbbbbbb=' + entity.path);

      /* //显示视频缩略图
      final uint8list = await VideoThumbnail.thumbnailData(
        video: entity.path,
        imageFormat: ImageFormat.JPEG,
        maxHeightOrWidth: 128,
        quality: 25,
      );
*/
      setState(() {
        listpath.add(entity.path);
        //listimage.add(uint8list);
      });
    }
  }

  // 清空本地保存的文件
  void _clearContent() async {
    File f = await _getLocalFile();
    await f.writeAsString('');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _list();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: listpath.length,
            itemBuilder: (BuildContext content, int index) {
              return Container(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: /*Image.file(listimage[index])*/ Icon(
                      Icons.image),
                  title: Text(listpath[index]),
                  trailing: RaisedButton(
                    child: Icon(Icons.arrow_forward_ios),
                    color: Colors.white,
                    shape: CircleBorder(side: BorderSide(color: Colors.white)),
                    elevation: 0,
                    onPressed: () {

                    },
                  ),
                  onTap: () {
                    /* Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MainPage())
                );*/
                  },
                ),
              );
            },
          ),
        ));
  }
}
