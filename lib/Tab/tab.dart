import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_safe/Tab/fileTwo.dart';
import 'package:flutter_safe/Tab/home.dart';
import 'package:flutter_safe/Util/util.dart';
import 'package:flutter_safe/page/cipher.dart';
import 'package:flutter_safe/page/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'CustomImagePicker.dart';
import 'evenbus.dart';
import 'fileOne.dart';
import 'package:flutter_safe/page/databasehelper.dart';
import 'package:flutter_safe/page/safelist.dart';
import 'package:date_format/date_format.dart';
class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  int _currentIndex = 0;

  var bus = new EventBus();

  var db = new DatabaseHelper();

  SafeList safeList;
//  List<File> _fileList  = [];
  List<SafeList> list = [];
  String dir;
  Stream<FileSystemEntity> entityList;
  File newfile;

  List _pageList = [
    Home(),
    // Test(),
    FileTwo(),
  ];

  @override
  void initState() {
    requestPermission();
    _controller = AnimationController(vsync: this);
    initImage();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    db.close();
    super.dispose();
  }

  void initImage() async {
    list.clear();

    dir = (await getApplicationDocumentsDirectory()).path;
    List listsafe= await db.getTotalList();


    for(int i =0; i< listsafe.length; i ++ ){
      SafeList  safe = SafeList.fromMap(listsafe[i]);
      print("safe.path-------"+safe.path);
      setState(() {
        list.add(safe);
      });
    }
    /*
    dir = (await getApplicationDocumentsDirectory()).path;
    newfile = new File(dir + '/default.jpg');
    var parentDir = newfile.parent;
    entityList = parentDir.list(recursive: false, followLinks: false);

*/
/*
    await for (FileSystemEntity entity in entityList) {
      if (entity.path.endsWith("mp4") || entity.path.endsWith("jpg")) {
        list.add(new File(entity.path));
      }
      print("entity--------" + entity.path);
    }*/
    bus.emit('alllist', list);
  }

  Future getImage() async {
//    var image = await FilePicker.getFile(type: FileType.IMAGE);fv
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    print(image.path);
    if (image != null) {
      File file = new File(image.path);
      String nameImage = FileUtils.basename(image.path);
      print('nameImage-----' + nameImage);
      newfile = file.copySync(dir + "/" + nameImage);
      safeList = new SafeList();
      safeList.path = image.path;
      safeList.apppath = newfile.path;
      safeList.times = formatDate(DateTime.now(), [yyyy, '年', mm, '月', d]);
      print(formatDate(DateTime.now(), [yyyy, '年', mm, '月', d]));
      safeList.name = nameImage;
      await db.saveItemSafe(safeList);
      list.add(safeList);
      print(newfile.path);
      bus.emit('list', safeList);
      image.delete();
    }
  }

  Future getVideo() async {
//    var image = await FilePicker.getFile(type: FileType.IMAGE);fv
    var video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    print(video.path);
    if (video != null) {
      File file = new File(video.path);
      String nameVidio = FileUtils.basename(video.path);
      newfile = file.copySync(dir + "/" + nameVidio);
      safeList = new SafeList();
      safeList.path = video.path;
      safeList.times = formatDate(DateTime.now(), [yyyy, '年', mm, '月', d]);
      print(formatDate(DateTime.now(), [yyyy, '年', mm, '月', d]));
      safeList.name = nameVidio;
      await db.saveItemSafe(safeList);
      bus.emit('list', newfile);
      video.delete();
    }
  }

  Future requestPermission() async {
    // 申请权限
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);

    // 申请结果
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (permission == PermissionStatus.granted) {
      print("权限申请通过");
    } else {
      print("权限申请通过");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "私密保险箱",
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(
              Icons.apps,
              color: Colors.black,
            ),
            itemBuilder: (BuildContext context ) => <PopupMenuItem<String>>[
              PopupMenuItem(
                value: "选项一的内容",
                child: Text("使用须知"),
              ),
              PopupMenuItem(value: "选项二的内容", child: Text("更新升级")),
              PopupMenuItem(value: "选项san的内容", child: Text("给个好评")),
              PopupMenuItem(value: "选项si的内容", child: Text("意见反馈")),
              PopupMenuItem(value: "选项wu的内容", child: Text("隐私政策")),
            ],
            elevation: 20,
            onSelected: (String action) {
              switch (action) {
                case "选项一的内容":
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeImage())
                  );
                  break;
                case "选项二的内容":
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyHomePage())
                  );
                  break;
                case "选项san的内容":
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => cipher())
                  );
                  break;
                case "选项si的内容":
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => cipher())
                  );
                  break;

              }
            },
          ),
        ],
      ),
      body: this._pageList[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex,
        onTap: (int index) {
          setState(() {
            this._currentIndex = index;
          });
        },
        fixedColor: Colors.green,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("首页"),
          ),
          /*BottomNavigationBarItem(
                icon: Icon(Icons.category), title: Text("添加")),*/
          BottomNavigationBarItem(
              icon: Icon(Icons.insert_drive_file), title: Text("文件")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 50,
        ),
        onPressed: () {
          moreOP();
        },
        elevation: 30,
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void moreOP() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 140,
        padding: EdgeInsets.only(bottom: 10),
        child: Column(children: <Widget>[
          InkWell(
              child: Container(
                  alignment: Alignment.center,
                  height: 60.0,
                  child: Text(
                    '图片',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  )),
              onTap: () {
                Navigator.pop(context);
                getImage();
              }),
          InkWell(
              child: Container(
                  alignment: Alignment.center,
                  height: 60.0,
                  child: Text(
                    '视频',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  )),
              onTap: () {
                Navigator.pop(context);
                getVideo();
              })
        ]),
        decoration: BoxDecoration(),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
    );
  }
}
