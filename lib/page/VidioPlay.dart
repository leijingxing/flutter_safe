import 'package:flutter_safe/list/listdata.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_safe/Tab/home.dart';

class VideoApp extends StatefulWidget {

  String listfile;
  VideoApp({this.listfile});
  @override
  _VideoAppState createState() => _VideoAppState(listfile: listfile);

}

class _VideoAppState extends State<VideoApp> {

  VideoPlayerController _controller;
  String listfile;
  _VideoAppState({this.listfile});

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        '$listfile'
    )
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {

        });
      });
    print(listfile);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("$listfile"),
      ),
        body: Center(
          child: _controller.value.initialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}