import 'package:flutter/material.dart';
import 'package:flutter_safe/Tab/home.dart';
import 'package:flutter_safe/Tab/tab.dart';
import 'package:gesture_recognition/gesture_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VerifyState();
  }
}

class _VerifyState extends State<VerifyPage> {
  List<int> curResult = [];
  List<int> correctResult = [8,4,0];
  int status = 0; // 0: NONE,1: SUCCESS,2: ERROR
  List<int> onlyShowItems;
  GlobalKey<GestureState> gestureStateKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        title: Text("图案解锁"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              child: Center(
                child: Text(
                  "密码: ${correctResult.toString()}",
                  style: TextStyle(fontSize: 24, color: Colors.blue),
                ),
              ),
            ),
            Container(
              height: 60,
              child: Center(
                child: Text(
                  "密码: ${curResult.toString()}",
                  style: TextStyle(fontSize: 24, color: Colors.blue),
                ),
              ),
            ),
            Container(
              height: 60,
              child: Center(
                child: Text(
                  status == 0 ? "" : (status == 1 ? "Success" : "Error"),
                  style: TextStyle(
                      fontSize: 24,
                      color: status == 1 ? Colors.blue : Colors.red),
                ),
              ),
            ),
            Center(
              child: GestureView(
                key: this.gestureStateKey,
                size: MediaQuery.of(context).size.width * 0.8,
                selectColor: Colors.blue,
                onPanUp: (List<int> items) {
                  analysisGesture(items);
                },
                onPanDown: () {
                  gestureStateKey.currentState.selectColor = Colors.blue;
                  setState(() {
                    status = 0;
                  });
                },
              ),
            ),
            RaisedButton(
              child: Text("跳转"),
              onPressed: () {
                if (status == 1) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Tabs()),
                    (route) => route == null,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  analysisGesture(List<int> items) {
    bool isCorrect = true;
    if (items.length == correctResult.length) {
      for (int i = 0; i < items.length; i++) {
        if (items[i] != correctResult[i]) {
          isCorrect = false;
          break;
        }
      }
      gestureStateKey.currentState.selectColor = Colors.blue;
    } else {
      isCorrect = false;
      gestureStateKey.currentState.selectColor = Colors.red;
    }
    setState(() {
      status = isCorrect ? 1 : 2;
      curResult = items;
      /*if(isCorrect == 1) {          //成功跳转
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Home())
        );
      }*/
    });
  }
}
