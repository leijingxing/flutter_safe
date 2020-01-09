import 'dart:collection';
import 'dart:io';
import 'dart:ui' as ui show Image;
import 'package:file_utils/file_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_safe/page/ImagePlay.dart';
import 'package:flutter_safe/page/VidioPlay.dart';
import 'package:flutter_safe/page/safelist.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'evenbus.dart';
import 'package:flutter_safe/page/databasehelper.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  {

  var bus = new EventBus();

  List listImage = new List();
  List<SafeList> fileList = [];
  ui.Image _uiImageInData;
  Image _imageInData;
  VideoPlayerController _videoPlayerController;

  var db = new DatabaseHelper();

  File videoFalse;
  File imageFalse;


  @override
  void initState() {
    super.initState();

    bus.on('list', (list) {
      setState(() {
        fileList.add(list);
      });
    });

    bus.on('alllist', (alllist) {
      setState(() {
        fileList.addAll(alllist);
      });
    });
    //    _list();
  }

  //  _list() async {
//    Directory appDocDir = Directory(directory);
//    Stream<FileSystemEntity> entityList =
//        appDocDir.list(recursive: false, followLinks: false);
//
//    await for (FileSystemEntity entity in entityList) {
//      print('aaaaaaaaaa=' + entity.path);
//      setState(() {
//        listpath.add(entity);
//        listimage.add(_imageInData);
//      });
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: fileList.length,
        itemBuilder: (BuildContext content, int index) {
          if (fileList[index].path.endsWith("mp4")) {
            _imageData(fileList[index].path);
            return Container(
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  child: _imageInData,
                ),
                title: Text(FileUtils.basename(fileList[index].path)),
                subtitle: Text(fileList[index].times),
                trailing: RaisedButton(
                  child: Icon(Icons.arrow_forward_ios),
                  color: Colors.white,
                  shape: CircleBorder(side: BorderSide(color: Colors.white)),
                  elevation: 0,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("确定解密"),
                              content: Text(fileList[index].path),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("确定"),
                                  onPressed: () {
                                    if (fileList[index].path != null) {
                                      File file =
                                          new File(fileList[index].apppath);
                                      videoFalse = file.copySync(
                                          fileList[index].path);
                                      print(
                                          "VideoFlase------" + videoFalse.path);
                                      // fileList[index].delete();
                                      _delete(fileList[index].apppath);
                                      setState(() {
                                        fileList.removeAt(index);
                                      });
                                    }
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ));
                  },
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VideoApp(
                            listfile: fileList[index].path,
                          )));
                },
              ),
            );
          } else {
            return Container(
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  child: Image.file(
                    new File(fileList[index].apppath),
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text(
                  fileList[index].name,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(fileList[index].times),
                trailing: RaisedButton(
                  child: Icon(Icons.arrow_forward_ios),
                  color: Colors.white,
                  shape: CircleBorder(side: BorderSide(color: Colors.white)),
                  elevation: 0,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("确定解密"),
                              content: Text(fileList[index].apppath),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("确定"),
                                  onPressed: () {
                                    if (fileList[index].apppath != null) {
                                      File file =
                                          new File(fileList[index].apppath);
                                      file.copySync(fileList[index].apppath);
                                    }
                                    _delete(fileList[index].apppath);
                                    // fileList[index].delete();
                                    setState(() {
                                      fileList.removeAt(index);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ));
                  },
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ImagePlay(
                            listfile: fileList[index].apppath,
                          )));
                },
              ),
            );
          }
        },
      ),
    ));
  }

  Future<Image> _imageData(String path) async {
    //显示视频缩略图
    final uint8list = await VideoThumbnail.thumbnailData(
      video: path,
      imageFormat: ImageFormat.JPEG,
      maxHeightOrWidth: 128,
      quality: 25,
    );
    _imageInData = Image.memory(
      uint8list,
      fit: BoxFit.cover,
    )..image
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      setState(() {
        _uiImageInData = info.image;
      });
    }));
    return _imageInData;
  }

  _delete(String path) async{
    //
    await db.deleteItem(path);
  }
}
