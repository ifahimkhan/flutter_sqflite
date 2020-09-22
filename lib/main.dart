import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_sqflite/screens/iphone.dart';

import 'screens/note_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: IphoneStateFull(),
        ),
      ),

//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//        brightness: Brightness.light,
//      ),
      debugShowCheckedModeBanner: false,
      title: "Note Keeper",
    );
  }
}
