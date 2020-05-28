import 'package:flutter/material.dart';
import 'package:parking_administration/Helper/AppBarMy.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../Providers/Stall.dart';
import '../Providers/Stalls_Provider.dart';
import '../Widgets/StallDetails.dart';
import '../Screens/EditStall_Screen.dart';

class StallDetailScreen extends StatefulWidget {
  static const routeName = "StallDetailScreen";

  @override
  _StallDetailScreenState createState() => _StallDetailScreenState();
}

class _StallDetailScreenState extends State<StallDetailScreen> {
  bool wasRefreshed = false;

  Widget getEditIconButton(BuildContext context, Stall myStall) {
    if (Platform.isIOS == true) {
      return CupertinoButton(
          child: myStall.status == 0
              ? Icon(
                  Icons.edit,
                  color: Colors.black87,
                )
              : Icon(
                  Icons.edit,
                  color: Colors.black26,
                ),
          onPressed: myStall.status == 0
              ? () => {
                    Navigator.of(context).pushNamed(EditStall_Screen.routeName,
                        arguments: myStall.id),
                  }
              : null);
    } else {
      return IconButton(
          icon: myStall.status == 0
              ? Icon(
                  Icons.edit,
                  color: Colors.black87,
                )
              : Icon(
                  Icons.edit,
                  color: Colors.black26,
                ),
          onPressed: myStall.status == 0
              ? () => {
                    Navigator.of(context).pushNamed(EditStall_Screen.routeName,
                        arguments: myStall.id),
                  }
              : null);
    }
  }

  Widget getRefreshIconButton(
      BuildContext context, Stall myStall, Stalls provider) {
    if (Platform.isIOS == true) {
      return CupertinoButton(
          child: Icon(
            Icons.refresh,
            color: Colors.black87,
          ),
          onPressed: () => {
                wasRefreshed = true,
                setState(() {
                  try {
                    provider
                        .getStallFromServer(myStall.parkId, myStall.id)
                        .then((_) {
                      wasRefreshed = false;
                    }).timeout(const Duration(seconds: 20), onTimeout: () {
                      showErrorDialog(context);
                    });
                  } catch (e) {
                    showErrorDialog(context);
                  }
                })
              });
    } else {
      return IconButton(
          icon: Icon(
            Icons.refresh,
            color: Colors.black87,
          ),
          onPressed: () => {
                wasRefreshed = true,
                setState(() {
                  try {
                    provider
                        .getStallFromServer(myStall.parkId, myStall.id)
                        .then((_) {
                      wasRefreshed = false;
                    }).timeout(const Duration(seconds: 20), onTimeout: () {
                      showErrorDialog(context);
                    });
                  } catch (e) {
                    showErrorDialog(context);
                  }
                }),
              });
    }
  }

  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text('Chyba'),
            content: Text('Pripojenie k databaze zlyhalo.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Rozumiem'),
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Stall stall1 = ModalRoute.of(context).settings.arguments as Stall;
    final stallProvider = Provider.of<Stalls>(context);
    Stall stall = stallProvider.findById(stall1.id);
    return !wasRefreshed
        ? AppBarMy(
            title: Text(
              "Informácie o mieste",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            myBody: StallDetails(stall, getEditIconButton(context, stall)),
            icon: getRefreshIconButton(context, stall, stallProvider),
          )
        : AppBarMy(
            title: Text(
              "Informácie o mieste",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            myBody: Center(
              child: CircularProgressIndicator(),
            ),
            icon: getRefreshIconButton(context, stall, stallProvider),
          );
  }
}
