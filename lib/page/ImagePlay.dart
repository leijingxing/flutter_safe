
import 'package:flutter/material.dart';

class ImagePlay extends StatefulWidget {

  String listfile;
  ImagePlay({this.listfile});

  @override
  _ImagePlayState createState() => _ImagePlayState(listfile: listfile);
}

class _ImagePlayState extends State<ImagePlay> {

  String listfile;
  _ImagePlayState({this.listfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image"),
      ),
      body: Center(
        child: Container(
          child:  Image.asset(listfile),
        ),
      ),
    );
  }
}
