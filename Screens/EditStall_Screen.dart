import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import '../Helper/AppBarMy.dart';
import '../Providers/Stall.dart';
import '../Providers/Stalls_Provider.dart';
import '../Widgets/DetailsContainer.dart';

class EditStall_Screen extends StatefulWidget {
  static const routeName = 'EditStallScreen';

  @override
  _EditStall_ScreenState createState() => _EditStall_ScreenState();
}

class _EditStall_ScreenState extends State<EditStall_Screen> {
  bool typeFree;
  bool typeReserve;
  bool typeService;
  bool wasInicialized = false;
  bool wasReloaded = true;

  void freeToogleType(bool value) {
    setState(() {
      typeFree = value;
      typeReserve = !value;
      typeService = !value;
    });
  }

  void reserveToogleType(bool value) {
    setState(() {
      typeFree = !value;
      typeReserve = value;
      typeService = !value;
    });
  }

  void serviceToogleType(bool value) {
    setState(() {
      typeFree = !value;
      typeReserve = !value;
      typeService = value;
    });
  }

  void setCheckedBoxes(Stall stall) {
    if (stall.type == 0) {
      typeFree = true;
      typeReserve = false;
      typeService = false;
    } else if (stall.type == 1) {
      typeFree = false;
      typeReserve = true;
      typeService = false;
    } else if (stall.type == 2) {
      typeFree = false;
      typeReserve = false;
      typeService = true;
    }
  }

  int getNewType() {
    if (typeFree == true) {
      return 0;
    } else if (typeReserve == true) {
      return 1;
    } else if (typeService == true) {
      return 2;
    }
  }

  Widget getIconButton(BuildContext context, Stall myStall, Stalls provider) {
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
                    provider
                        .getStallFromServer(myStall.parkId, myStall.id)
                        .then((_) {
                      wasReloaded = true;
                      wasInicialized = false;
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
                wasReloaded = false,
                setState(() {
                  try {
                    provider
                        .getStallFromServer(myStall.parkId, myStall.id)
                        .then((_) {
                      wasReloaded = true;
                      wasInicialized = false;
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
    int myStallId = ModalRoute.of(context).settings.arguments as int;
    final stallProvider = Provider.of<Stalls>(context);
    Stall myStall = stallProvider.findById(myStallId);

    if (wasInicialized == false) {
      setCheckedBoxes(myStall);
      wasInicialized = true;
    }
    return wasReloaded
        ? LayoutBuilder(builder: (ctx, constraints) {
            return AppBarMy(
              title: Text(
                "Miesto ID: " + myStall.id.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              icon: getIconButton(context, myStall, stallProvider),
              myBody: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(bottom: 50),
                  child: DetailsContainer(
                    title: "Úprava informácii",
                    details: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: constraints.maxWidth * 0.04,
                              ),
                              FittedBox(
                                  child: Text(
                                "Typ miesta",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45,
                                    fontStyle: FontStyle.italic),
                              )),
                            ],
                          ),
                          CheckboxListTile(
                            title: Text(
                              "Voľné",
                              style: TextStyle(color: Colors.black87),
                            ),
                            value: typeFree,
                            onChanged: (newvalue) {
                              freeToogleType(newvalue);
                            },
                          ),
                          CheckboxListTile(
                            title: Text(
                              "Rezervačné",
                              style: TextStyle(color: Colors.black87),
                            ),
                            value: typeReserve,
                            onChanged: (newvalue) {
                              reserveToogleType(newvalue);
                            },
                          ),
                          CheckboxListTile(
                            title: Text(
                              "Servis",
                              style: TextStyle(color: Colors.black87),
                            ),
                            value: typeService,
                            onChanged: (newvalue) {
                              serviceToogleType(newvalue);
                            },
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.save,
                                color: Colors.black54,
                              ),
                              onPressed: () {
                                try {
                                  stallProvider
                                      .updateStallType(myStall.parkId,
                                          myStall.id, getNewType())
                                      .then((_) {
                                    stallProvider
                                        .updateStallSyncData(myStall.parkId);
                                    stallProvider.findById(myStall.id).type =
                                        getNewType();
                                    Navigator.of(context).pop();
                                  }).timeout(const Duration(seconds: 20),
                                          onTimeout: () {
                                    showErrorDialog(context);
                                  });
                                } catch (e) {
                                  showErrorDialog(context);
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          })
        : AppBarMy(
            title: Text(
              "Miesto ID: " + myStall.id.toString(),
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            icon: getIconButton(context, myStall, stallProvider),
            myBody: Center(
              child: CircularProgressIndicator(),
            ));
  }
}
