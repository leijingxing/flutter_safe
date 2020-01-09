import 'dart:io';

import "package:file_utils/file_utils.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_safe/page/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:storage_path/storage_path.dart';
import 'package:video_player/video_player.dart';

class Test extends StatefulWidget {

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  File _image;
  File _video;

  VideoPlayerController _videoPlayerController;


  String imagePath = "";
  @override
  void initState() {
    super.initState();
    getImagesPath();
  }
  Future<void> getImagesPath() async {
    String imagespath = "";
//    try {
      imagespath = await StoragePath.imagesPath;

    return imagespath;
  }



  _CreateDir() async {

    final filepath = await getExternalStorageDirectory();
    var file = Directory(filepath.path+"/"+"flutter");
    try {
      bool exists = await file.exists();
      if (!exists) {
        await file.create();
      }
    } catch (e) {
      print(e);
    }

  }

  _pickImageFromGallery() async {

    File image = await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    var name = FileUtils.basename(image.path);
    print("img路径aaa: " + image.path); //文件路径
    print("img name bbb-----"+name);
    print("img name CCCC-----");

    image.rename("/storage/emulated/0/Android/data/com.safe.flutter_safe/files/flutter/"+name);

  }

  ImageDecrypt() async {

    var name = FileUtils.basename(_image.path);
    print("img路径aaa: " + _image.path); //文件路径
    var  file = await getExternalStorageDirectory();
    _image.rename("");
  }

  _pickVideo() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    _video = video;
    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {
        });
        _videoPlayerController.play();
      });

    print("视频路径" + _video.path); //视频路径
    //getname
    String nameVidio = FileUtils.basename(_video.path);
    print("vidio name------"+nameVidio);
    video.rename("/storage/718E-13EB/DCIM/justin/"+nameVidio);
  }

  VidioDecrypt() async {

    String nameVidio1 = FileUtils.basename(_video.path);
    File vidio = new File("/storage/718E-13EB/DCIM/justin/"+nameVidio1);
    vidio.rename("/storage/718E-13EB/DCIM/justin/"+nameVidio1);

  }

  Future<File> _getLocalFile() async {
    // 获取文档目录的路径
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dir = appDocDir.path;
    final file = new File('$dir/demo.txt');
    return file;
  }

  Future copyVideo()  {
    //    _video.path：Camera/xxx/aa.jpg
    File copymp4 =  File(_video.path);
    copymp4.copy(_video.path);
  }

  delete() async {
    File del = File(_image.path);
    await del.delete();
  }



  deleteVideo() async {
    File del = File(_video.path);
    await del.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: EdgeInsets.only(top: 100),
            child: Center(
              child: Row(
                children: <Widget>[

                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomeImage())
                      );
                    },
                    child: Icon(Icons.image,color: Colors.green,size: 50,),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _pickVideo();
                    },
                    child: Icon(Icons.video_library,color: Colors.green,size: 50,)

                  ),

                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close),

        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}
