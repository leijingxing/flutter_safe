import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';


class HomeImage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeImage();
  }
}

class _HomeImage extends State<HomeImage>{

  List<File> _fileList  = [];
  List<File> list = [];
  String dir;
  Stream<FileSystemEntity> entityList;
  File newfile;
  int sum = 0;

  static const androidplatform = const MethodChannel("delete");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('隐私相册'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              child: FlatButton(
                  onPressed: getImage,
                  child: Text('添加')),
                  color: Colors.purple,
            ),
            myview(),
          ],
        ),
      )
    );
  }

  Widget myview(){
    if(_fileList.length == 0){
      return Container(
        width: 0,
        height: 0,
      );
    }else{
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: GridView.builder(
            itemCount: _fileList.length,
            shrinkWrap: true,
            physics: new NeverScrollableScrollPhysics(),
            primary: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.7),
            itemBuilder: (BuildContext context, index){
              return Image.file(_fileList[index],
                fit: BoxFit.cover,);
            }
        ),
      );
    }
  }

  Future getImage() async {
//    var image = await FilePicker.getFile(type: FileType.IMAGE);fv
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print(image.path);
    if(image != null){
      File file = new File(image.path);
      newfile = file.copySync(dir+'/pic_$sum.jpg');
      print(newfile.path);
      setState(() {
        _fileList.add(newfile);
        image.delete();
        sum++;
      });
    }
  }

  void initImage() async{
    _fileList.clear();
    list.clear();
    dir = (await getApplicationDocumentsDirectory()).path;
    newfile = new File(dir+'/default.jpg');
    var parentDir = newfile.parent;
    entityList = parentDir.list(recursive: false, followLinks: false);

    await for(FileSystemEntity entity in entityList){
      list.add(new File(entity.path));
    }
    list.removeAt(0);
    list.removeAt(0);
    setState(() {
      _fileList.addAll(list);
    });
    sum = _fileList.length;
  }

  @override
  void initState() {
    initImage();
    requestPermission();
    super.initState();

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

}