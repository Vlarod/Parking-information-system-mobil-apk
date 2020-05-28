import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import '../Widgets/StallsList.dart';
import '../Helper/AppBarMy.dart';
import '../Providers/Parks_Provider.dart';
import '../Providers/Stalls_Provider.dart';
import '../Providers/Park.dart';
import '../Screens/StallFilters_Screen.dart';

class StallsScreen extends StatefulWidget {
  static const routeName = 'StallsScreen';
  Map<String, int> stallsFilters;

  StallsScreen(this.stallsFilters);

  @override
  _StallsScreenState createState() => _StallsScreenState();
}

class _StallsScreenState extends State<StallsScreen> {
  bool wasLoaded = false;

  Widget getRefreshIconButton(
      BuildContext context, Park myPark, Stalls provider) {
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
                    .pushNamed(StallFiltersScreen.routeName)
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
                    .pushNamed(StallFiltersScreen.routeName)
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
    int parkId = ModalRoute.of(context).settings.arguments as int;
    final parkProvider = Provider.of<Parks>(context);
    final stallProvider = Provider.of<Stalls>(context);
    Park myPark = parkProvider.getParks.firstWhere((park) => park.id == parkId);
    String parkName = myPark.name;
    if (!wasLoaded) {
      try {
        stallProvider
            .getStallsFromServer(parkId, widget.stallsFilters)
            .then((_) {
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
              parkName,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            myBody: StallsList(parkId),
            icon: getRefreshIconButton(context, myPark, stallProvider),
            secondTrailingIcon: getLeadingIcon(context),
          )
        : AppBarMy(
            title: Text(
              parkName,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            myBody: Center(
              child: CircularProgressIndicator(),
            ),
            icon: getRefreshIconButton(context, myPark, stallProvider),
            secondTrailingIcon: getLeadingIcon(context),
          );
  }
}
