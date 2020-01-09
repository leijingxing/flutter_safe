import 'package:flutter/material.dart';
import 'package:flutter_safe/login/setting_page.dart';
import 'package:flutter_safe/login/verify_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  void _routeToPage(BuildContext context,Widget page) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context){
          return page;
        })
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("私密保险箱"),),
      body: Builder(
          builder: (context) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                      child: Container(
                        height: 60,
                        child: Center(
                          child: Text(
                            "设置图案",
                            style: TextStyle(fontSize: 20,color: Colors.black),
                          ),
                        ),
                      ),
                      onPressed: () => _routeToPage(context,SettingPage())
                  ),
                  MaterialButton(
                      child: Container(
                        height: 60,
                        child: Center(
                          child: Text(
                            "解锁图案",
                            style: TextStyle(fontSize: 20,color: Colors.black),
                          ),
                        ),
                      ),
                      onPressed: () => _routeToPage(context,VerifyPage())
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}
