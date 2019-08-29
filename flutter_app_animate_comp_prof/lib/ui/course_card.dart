import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_animate_comp_prof/models/company.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseCard extends StatelessWidget {
  CourseCard(this.Course);

  final course Course;

  BoxDecoration _createBoxDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.4),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black26,
          spreadRadius: 2.0,
          blurRadius: 10.0,
        ),
      ],
    );
  }

  Widget _createThumbnail() {
    return ClipRect(
      child: new Stack(
        children: <Widget>[
          new Image.asset(Course.thumbnail, width: 500, height: 180,),
          new Positioned(
            child: _createLinkButton(),
            right: 5.0,
            bottom: 5.0,
          )
        ],
      ),
    );
  }

  Widget _createLinkButton() {
    return Material(
      color: Colors.white24,
      type: MaterialType.circle,
      child: IconButton(
          icon: Icon(Icons.link),
          onPressed: () async {
            if (await canLaunch(Course.url)) {
              await launch(Course.url);
            }
          }),
    );
  }

  Widget _createInfo() {
    return Padding(padding: EdgeInsets.only(top: 16.0 , left: 4.0 , right: 4.0),
    child: Text(Course.title,
    style: TextStyle(
      color: Colors.white.withOpacity(0.85),
    ),
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 175.0,
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      decoration: _createBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: _createThumbnail(),
            flex: 3,
          ),

          Flexible(
            child: _createInfo(),
            flex: 2,
          ),
        ],
      ),
    );
  }
}
