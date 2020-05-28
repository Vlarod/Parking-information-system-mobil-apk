import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import '../Widgets/DetailsContainer.dart';
import '../Helper/AppBarMy.dart';
import '../Providers/Park.dart';
import '../Providers/Parks_Provider.dart';

class EditPark_Screen extends StatefulWidget {
  static const routeName = 'EditParkScreen';

  @override
  _EditPark_ScreenState createState() => _EditPark_ScreenState();
}

class _EditPark_ScreenState extends State<EditPark_Screen> {
  bool parkStatus = false;
  bool wasInicialized = false;
  bool wasReloaded = true;
  static final _form = GlobalKey<FormState>();
  String newParkName;

  void toogleSwitch(bool value) {
    setState(() {
      parkStatus = value;
    });
  }

  bool getParkStatus(int status) {
    if (status == 0) {
      return false;
    } else {
      return true;
    }
  }

  void _saveForm() {
    _form.currentState.save();
  }

  int getNewStatus(bool status) {
    if (status == true) {
      return 1;
    } else {
      return 0;
    }
  }

  Widget getIconButton(BuildContext context, Park myPark, Parks provider) {
    if (Platform.isIOS == true) {
      return CupertinoButton(
          child: Icon(
            Icons.refresh,
            color: Colors.black87,
          ),
          onPressed: () => {
                wasReloaded = false,
                setState(() {
                  try {
                    provider.getParkFromDatabase(myPark.id).then((_) {
                      wasReloaded = true;
                    }).timeout(const Duration(seconds: 20), onTimeout: () {
                      showErrorDialog(context);
                    });
                  } catch (e) {
                    showErrorDialog(context);
                  }
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
                  try {
                    provider.getParkFromDatabase(myPark.id).then((_) {
                      wasReloaded = true;
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
    Park myPark = parkProvider.findById(parkId);

    if (!wasInicialized) {
      parkStatus = getParkStatus(myPark.status);
      wasInicialized = true;
    }
    return wasReloaded
        ? LayoutBuilder(builder: (ctx, constraints) {
            return AppBarMy(
              title: Text(
                myPark.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              icon: getIconButton(context, myPark, parkProvider),
              myBody: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(bottom: 50),
                  child: DetailsContainer(
                    title: "Úprava informácií",
                    icon: null,
                    details: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: FittedBox(
                                child: Text(
                                  "Názov",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black45,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Form(
                                    key: _form,
                                    child: Container(
                                      width: constraints.maxWidth * 0.35,
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 12),
                                        maxLines: 2,
                                        onFieldSubmitted: (_) {
                                          _saveForm();
                                        },
                                        decoration: InputDecoration(
                                          labelText: myPark.name,
                                          border: InputBorder.none,
                                        ),
                                        textInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.text,
                                        onSaved: (value) {
                                          newParkName = value;
                                        },
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.save,
                                      color: Colors.black54,
                                    ),
                                    onPressed: () {
                                      try {
                                        parkProvider
                                            .updateParkName(
                                                myPark.id, newParkName)
                                            .then((_) {
                                          parkProvider
                                              .findById(myPark.id)
                                              .name = newParkName;
                                          parkProvider.updateParkSyncData();
                                          Navigator.of(context).pop();
                                        }).timeout(const Duration(seconds: 20),
                                                onTimeout: () {
                                          showErrorDialog(context);
                                        });
                                      } catch (e) {
                                        showErrorDialog(context);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              FittedBox(
                                child: Text(
                                  "Neaktívne/Aktívne",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black45,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Switch(
                                      value: parkStatus,
                                      onChanged: (newVal) {
                                        toogleSwitch(newVal);
                                      },
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.save,
                                        color: Colors.black54,
                                      ),
                                      onPressed: () {
                                        try {
                                          parkProvider
                                              .updateParkStatus(
                                                  myPark.id, parkStatus)
                                              .then((_) {
                                            parkProvider
                                                    .findById(myPark.id)
                                                    .status =
                                                getNewStatus(parkStatus);
                                            parkProvider.updateParkSyncData();
                                            Navigator.of(context).pop();
                                          }).timeout(
                                                  const Duration(seconds: 20),
                                                  onTimeout: () {
                                            showErrorDialog(context);
                                          });
                                        } catch (e) {
                                          showErrorDialog(context);
                                        }
                                      }),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          })
        : AppBarMy(
            title: Text(
              myPark.name,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            icon: getIconButton(context, myPark, parkProvider),
            myBody: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
