import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_sqflite/models/NetwrokModel.dart';
import 'package:flutter_app_sqflite/models/image_model.dart';
import 'package:flutter_app_sqflite/screens/login_iphone.dart';
import 'package:flutter_app_sqflite/widgets/ImageList.dart';
import 'package:http/http.dart' show get;

class PhotoApi extends StatefulWidget {
  static getInstanceRoute(BuildContext context) {
    CupertinoPageRoute(
      builder: (context) => PhotoApi(),
    );
  }

  @override
  _PhotoApiState createState() => _PhotoApiState();
}

class _PhotoApiState extends State<PhotoApi> {
  int counter = 0;
  List<PhotoModel> listOfImages = [];

  Future<void> fetchImage() async {
    print('Exe fetch Image');

    counter++;
    String url = NetworkModel().GET_URL + '$counter';
    print(url);
    var response = await get(url);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var mPhotoModel = PhotoModel.fromJson(json.decode(response.body));
      setState(() {
        listOfImages.add(mPhotoModel);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "API  CALL",
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Api Calls"),
          leading: CupertinoNavigationBarBackButton(
            previousPageTitle: "Sample",
            onPressed: () => Navigator.pop(context),
          ),
          trailing: GestureDetector(
            child: Text(
              'Login Screen',
              style: TextStyle(color: CupertinoColors.activeBlue),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => LoginIphone(),
                  ));
            },
          ),
        ),
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: fetchImage,
            ),
            body: Container(
              child: ImageList(listOfImages),
            )),
      ),
    );
  }
}
