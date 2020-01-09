import 'package:flutter/material.dart';
import 'package:flutter_safe/Tab/CustomImagePicker.dart';
import 'package:flutter_safe/page/ImageList.dart';
import 'package:flutter_safe/page/VidioPlay.dart';
import 'package:flutter_safe/page/cipher.dart';
import 'package:flutter_safe/page/file_manager.dart';
import 'package:flutter_safe/page/home.dart';
import 'package:image_picker/image_picker.dart';

import 'filewrite.dart';

class FileOne extends StatefulWidget {
  @override
  _FileOneState createState() => _FileOneState();
}

class _FileOneState extends State<FileOne> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("helo"),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MyHomePage())
              );
            },
          ),

          RaisedButton(
            child: Text("filepick"),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => cipher())
              );
            },
          ),
          RaisedButton(
            child: Image.network(
                "http://pics.sc.chinaz.com/Files/pic/faces/08098/01.gif",
              width: 80,
              height: 80,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomeImage())
              );
            },
          ),
          RaisedButton(
            child:
            Image.network("http://pics.sc.chinaz.com/Files/pic/faces/08092/01.gif",
              height: 80,
              width: 80,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ImageList())
              );
            },
          ),
          RaisedButton(
            child: Image.network("http://pics.sc.chinaz.com/Files/pic/faces/08103/07.gif",
              height: 80,
              width: 80,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ImageList())
              );
            },
          ),
        ],

      )

    );
  }
}
