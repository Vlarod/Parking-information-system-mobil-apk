import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import '../Screens/ParkFilters_Screen.dart';
import '../Widgets/ParksGrid.dart';
import '../Helper/AppBarMy.dart';
import '../Providers/Parks_Provider.dart';

class Parks_Screen extends StatefulWidget {
  Map<String, int> parksFilters;

  Parks_Screen(this.parksFilters);

  @override
  _Parks_ScreenState createState() => _Parks_ScreenState();
}

class _Parks_ScreenState extends State<Parks_Screen> {
  bool wasLoaded = false;

  Widget getRefreshIconButton(BuildContext context) {
    if (Platform.isIOS == true) {
      return CupertinoButton(
          child: Icon(
            Icons.refresh,
            color: Colors.black87,
          ),
          onPressed: () => {
                setState(() {
                  wasLoaded = false;
                }),
              });
    } else {
      return IconButton(
          icon: Icon(
            Icons.refresh,
            color: Colors.black87,
          ),
          onPressed: () => {
                setState(() {
                  wasLoaded = false;
                }),
              });
    }
  }

  Widget getLeadingIcon(BuildContext context) {
    if (Platform.isIOS == true) {
      return CupertinoButton(
          child: Icon(Icons.filter_list),
          onPressed: () => {
                Navigator.of(context)
                    .pushNamed(ParkFiltersScreen.routeName)
                    .then((value) {
                  setState(() {
                    wasLoaded = false;
                  });
                }).timeout(const Duration(seconds: 20), onTimeout: () {
                  showErrorDialog(context);
                }),
              });
    } else {
      return IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () => {
                Navigator.of(context)
                    .pushNamed(ParkFiltersScreen.routeName)
                    .then((value) {
                  setState(() {
                    wasLoaded = false;
                  });
                }).timeout(const Duration(seconds: 20), onTimeout: () {
                  showErrorDialog(context);
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
    final parkProvider = Provider.of<Parks>(context);

    if (!wasLoaded) {
      try {
        parkProvider.getParksFromServer(widget.parksFilters).then((_) {
          wasLoaded = true;
        }).timeout(const Duration(seconds: 20), onTimeout: () {
          showErrorDialog(context);
        });
      } catch (e) {
        showErrorDialog(context);
      }
    }
    return wasLoaded
        ? AppBarMy(
            title: Text(
              "Parkoviská",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            myBody: ParksGrid(),
            icon: getRefreshIconButton(context),
            leadingIcon: getLeadingIcon(context),
          )
        : AppBarMy(
            title: Text(
              "Parkoviská",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            myBody: Center(
              child: CircularProgressIndicator(),
            ),
            icon: getRefreshIconButton(context),
            leadingIcon: getLeadingIcon(context),
          );
  }
}
