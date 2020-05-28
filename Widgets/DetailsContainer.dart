import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DetailsContainer extends StatelessWidget {
  Widget details;
  String title;
  double height;
  Widget icon;

  DetailsContainer({this.details, this.title, this.height, this.icon});

  @override
  Widget build(BuildContext context) {
    return MyWidget(height: height, title: title, icon: icon, details: details);
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({
    Key key,
    @required this.height,
    @required this.title,
    @required this.icon,
    @required this.details,
  }) : super(key: key);

  final double height;
  final String title;
  final Widget icon;
  final Widget details;

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? Container(
            margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
            height: this.height,
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.all(10),
              elevation: 30,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          this.title,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600]),
                        ),
                        icon,
                      ],
                    ),
                  ),
                  Divider(
                    height: 2,
                  ),
                  this.details,
                ],
              ),
            ),
          )
        : Container(
            margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
            height: this.height,
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.all(10),
              elevation: 30,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          this.title,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 2,
                  ),
                  this.details,
                ],
              ),
            ),
          );
  }
}
