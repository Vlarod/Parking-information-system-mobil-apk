import 'package:flutter/material.dart';

class DetailInfoRow extends StatelessWidget {
  final title;
  final data;
  bool editable;

  DetailInfoRow({this.title, this.data, this.editable});

  @override
  Widget build(BuildContext context) {
    double heigh;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    if (!isLandscape) {
      heigh = MediaQuery.of(context).size.height * 0.029;
    } else {
      heigh = 25;
    }
    return Container(
      height: heigh,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FittedBox(
              child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w700),
          )),
          Row(
            children: <Widget>[
              FittedBox(child: Text(data)),
            ],
          ),
        ],
      ),
    );
  }
}
