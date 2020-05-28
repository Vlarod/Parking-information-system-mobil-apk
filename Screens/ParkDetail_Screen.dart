import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import '../Screens/EditPark_Screen.dart';
import '../Providers/Parks_Provider.dart';
import '../Providers/Park.dart';
import '../Widgets/ParkDetails.dart';
import '../Helper/AppBarMy.dart';

class ParkDetail_Screen extends StatefulWidget {
  static const routeName = 'ParkDetalScreen';

  @override
  _ParkDetail_ScreenState createState() => _ParkDetail_ScreenState();
}

class _ParkDetail_ScreenState extends State<ParkDetail_Screen> {
  bool wasRefreshed = false;

  Widget getEditIconButton(BuildContext context, Park myPark) {
    if (Platform.isIOS == true) {
      return CupertinoButton(
          child: Icon(
            Icons.edit,
            color: Colors.black87,
          ),
          onPressed: () => {
                Navigator.of(context)
                    .pushNamed(EditPark_Screen.routeName, arguments: myPark.id),
              });
    } else {
      return IconButton(
          icon: Icon(
            Icons.edit,
            color: Colors.black87,
          ),
          onPressed: () => {
                Navigator.of(context)
                    .pushNamed(EditPark_Screen.routeName, arguments: myPark.id),
              });
    }
  }

  Widget getRefreshIconButton(
      BuildContext context, Park myPark, Parks provider) {
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
                    provider.getParkFromDatabase(myPark.id).then((_) {
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
                    provider.getParkFromDatabase(myPark.id).then((_) {
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
    int parkId = ModalRoute.of(context).settings.arguments as int;
    final parkProvider = Provider.of<Parks>(context);
    final currentPark = parkProvider.findById(parkId);

    return wasRefreshed == false
        ? AppBarMy(
            title: Text(
              currentPark.name,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            myBody: ParkDetail(
                currentPark, getEditIconButton(context, currentPark)),
            icon: getRefreshIconButton(context, currentPark, parkProvider),
          )
        : AppBarMy(
            title: Text(
              currentPark.name,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            myBody: Center(
              child: CircularProgressIndicator(),
            ),
            icon: getRefreshIconButton(context, currentPark, parkProvider),
          );
  }
}
