
import 'dart:io';

import 'package:flutter/material.dart';

class DefaultFolder extends StatefulWidget {
  @override
  _DefaultFolderState createState() => _DefaultFolderState();
}

class _DefaultFolderState extends State<DefaultFolder> {

  List listpath = new List();

  _list() async {
    Directory appDocDir = Directory("/storage/718E-13EB/DCIM/Camera/");
    Stream<FileSystemEntity> entityList =
        appDocDir.list(recursive: false, followLinks: false);

    await for (FileSystemEntity entity in entityList) {
      print('aaaaaaaaaa=' + entity.path);
      setState(() {
        listpath.add(entity);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("默认文件夹"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext context ,int index) {
            return Container(
              child: ListTile(
                leading: Icon(Icons.image),
                title: Text("hello"),
                onTap: () {

                },
              ),
            );
          },
        )
      ),
    );
  }
}
