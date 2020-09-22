import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_sqflite/models/image_model.dart';

class ImageList extends StatelessWidget {
  final List<PhotoModel> images;

  ImageList(this.images);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return buildContainer(images[index]);
      },
      itemCount: images.length,
    );
  }

  Widget buildContainer(PhotoModel model) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.inactiveGray)),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.network(model.url),
          SizedBox(
            height: 10.0,
          ),
          Container(
              width: double.infinity,
              alignment: Alignment.center,
              color: Colors.black45,
              padding: EdgeInsets.all(8.0),
              child: Text(
                model.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              )),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
