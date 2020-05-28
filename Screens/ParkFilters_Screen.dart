import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import '../Helper/AppBarMy.dart';
import '../Widgets/DetailsContainer.dart';

class ParkFiltersScreen extends StatefulWidget {
  static const routeName = 'ParkFiltersScreen';
  Map<String, int> parksFilters;
  Function setFilters;
  ParkFiltersScreen(this.parksFilters, this.setFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<ParkFiltersScreen> {
  bool noneFilter = true;
  bool activeFilter = false;
  bool nonActiveFilter = false;
  static final _form = GlobalKey<FormState>();
  int filterParkId = 0;

  @override
  void initState() {
    if (widget.parksFilters['status'] == 0) {
      noneFilter = false;
      activeFilter = false;
      nonActiveFilter = true;
    } else if (widget.parksFilters['status'] == 1) {
      noneFilter = false;
      activeFilter = true;
      nonActiveFilter = false;
    } else if (widget.parksFilters['status'] == 2) {
      noneFilter = true;
      activeFilter = false;
      nonActiveFilter = false;
    }
    super.initState();
  }

  void checkNoneFiler(bool newValue) {
    setState(() {
      noneFilter = newValue;
      activeFilter = !newValue;
      nonActiveFilter = !newValue;
    });
  }

  void checkNonActiveFiler(bool newValue) {
    setState(() {
      noneFilter = !newValue;
      activeFilter = !newValue;
      nonActiveFilter = newValue;
    });
  }

  void checkActiveFiler(bool newValue) {
    setState(() {
      noneFilter = !newValue;
      activeFilter = newValue;
      nonActiveFilter = !newValue;
    });
  }

  void setFilterParkStatus() {
    if (noneFilter == true) {
      widget.parksFilters['status'] = 2;
    } else if (activeFilter == true) {
      widget.parksFilters['status'] = 1;
    } else if (nonActiveFilter == true) {
      widget.parksFilters['status'] = 0;
    }

    widget.parksFilters['parkId'] = filterParkId;
  }

  void _saveForm() {
    _form.currentState.save();
  }

  Widget getIconButton(
      BuildContext context, Function setFilterParkStatus, Function saveForm) {
    if (Platform.isIOS == true) {
      return CupertinoButton(
          child: Icon(
            Icons.save,
            color: Colors.black87,
          ),
          onPressed: () => {
                setFilterParkStatus(),
                widget.setFilters(widget.parksFilters),
                saveForm(),
                Navigator.of(context).pop(),
              });
    } else {
      return IconButton(
          icon: Icon(
            Icons.save,
            color: Colors.black87,
          ),
          onPressed: () => {
                setFilterParkStatus(),
                widget.setFilters(widget.parksFilters),
                saveForm(),
                Navigator.of(context).pop(),
              });
    }
  }

  String getTextFieldTitle(int parkId) {
    if (parkId != 0) {
      return 'ID parkoviska: ' + parkId.toString();
    } else {
      return 'ID parkoviska';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return AppBarMy(
        title: Text(
          'Filtre',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        icon: getIconButton(
          context,
          setFilterParkStatus,
          _saveForm,
        ),
        myBody: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DetailsContainer(
                details: Column(
                  children: <Widget>[
                    CheckboxListTile(
                      value: noneFilter,
                      onChanged: (newValue) {
                        checkNoneFiler(newValue);
                      },
                      title: Text('Žiadny filter'),
                    ),
                    CheckboxListTile(
                      value: activeFilter,
                      onChanged: (newValue) {
                        checkActiveFiler(newValue);
                      },
                      title: Text('Aktívne parkoviská'),
                    ),
                    CheckboxListTile(
                      value: nonActiveFilter,
                      onChanged: (newValue) {
                        checkNonActiveFiler(newValue);
                      },
                      title: Text('Neaktívne parkoviská'),
                    ),
                  ],
                ),
                height: constraints.maxHeight * 0.4,
                title: 'Aktivita parkoviska',
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: DetailsContainer(
                  height: constraints.maxHeight * 0.2,
                  title: 'ID parkoviska',
                  details: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: constraints.maxWidth * 0.25,
                        child: Form(
                          key: _form,
                          child: TextFormField(
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: getTextFieldTitle(
                                  widget.parksFilters['parkId']),
                            ),
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              if (value != '') {
                                filterParkId = int.parse(value);
                              } else {
                                filterParkId = 0;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
