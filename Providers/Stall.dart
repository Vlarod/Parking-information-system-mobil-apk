import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Stall with ChangeNotifier {
  final int id;
  final int parkId;
  int type;
  final int status;
  final double x;
  final double y;
  final int orientation;
  final double lenght;
  final double width;

  Stall(
      {@required this.id,
      @required this.parkId,
      @required this.type,
      @required this.status,
      @required this.x,
      @required this.y,
      @required this.orientation,
      @required this.lenght,
      @required this.width});
}
