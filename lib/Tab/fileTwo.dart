import 'package:flutter/material.dart';
import 'package:flutter_safe/page/DefaultFolder.dart';

class FileTwo extends StatefulWidget {
  @override
  _FileTwoState createState() => _FileTwoState();
}

class _FileTwoState extends State<FileTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
          leading: Icon(
            Icons.insert_drive_file,
            color: Colors.amber,
          ),
          title: Text("默认文件夹"),
          subtitle: Text("/storage/718E-13EB/DCIM/Camera"),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DefaultFolder())
            );
          },
        ),
      ),
    );
  }
}
