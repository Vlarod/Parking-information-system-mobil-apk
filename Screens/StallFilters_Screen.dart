import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import '../Widgets/DetailsContainer.dart';
import '../Helper/AppBarMy.dart';

class StallFiltersScreen extends StatefulWidget {
  static const routeName = 'StallFilterScreen';

  Map<String, int> stallssFilters;
  Function setFilters;

  StallFiltersScreen(this.stallssFilters, this.setFilters);

  @override
  _StallFiltersScreenState createState() => _StallFiltersScreenState();
}

class _StallFiltersScreenState extends State<StallFiltersScreen> {
  static final _form = GlobalKey<FormState>();

  bool stallTypeNoneFilter = true;
  bool stallTypeFree = false;
  bool stallTypeReserve = false;
  bool stallTypeServise = false;

  bool stallStatusNoneFilter = true;
  bool stallStatusFree = false;
  bool stallStatusReserve = false;

  int filteredStallId = 0;

  @override
  void initState() {
    if (widget.stallssFilters['type'] == 3) {
      stallTypeNoneFilter = true;
      stallTypeFree = false;
      stallTypeReserve = false;
      stallTypeServise = false;
    } else if (widget.stallssFilters['type'] == 2) {
      stallTypeNoneFilter = false;
      stallTypeFree = false;
      stallTypeReserve = false;
      stallTypeServise = true;
    } else if (widget.stallssFilters['type'] == 1) {
      stallTypeNoneFilter = false;
      stallTypeFree = false;
      stallTypeReserve = true;
      stallTypeServise = false;
    } else if (widget.stallssFilters['type'] == 0) {
      stallTypeNoneFilter = false;
      stallTypeFree = true;
      stallTypeReserve = false;
      stallTypeServise = false;
    }

    if (widget.stallssFilters['state'] == 2) {
      stallStatusNoneFilter = true;
      stallStatusReserve = false;
      stallStatusFree = false;
    } else if (widget.stallssFilters['state'] == 1) {
      stallStatusNoneFilter = false;
      stallStatusReserve = true;
      stallStatusFree = false;
    } else if (widget.stallssFilters['state'] == 0) {
      stallStatusNoneFilter = false;
      stallStatusReserve = false;
      stallStatusFree = true;
    }
    super.initState();
  }

  void setFiltersForStalls() {
    if (stallTypeNoneFilter == true) {
      widget.stallssFilters['type'] = 3;
    } else if (stallTypeServise == true) {
      widget.stallssFilters['type'] = 2;
    } else if (stallTypeReserve == true) {
      widget.stallssFilters['type'] = 1;
    } else if (stallTypeFree == true) {
      widget.stallssFilters['type'] = 0;
    }

    if (stallStatusNoneFilter == true) {
      widget.stallssFilters['state'] = 2;
    } else if (stallStatusReserve == true) {
      widget.stallssFilters['state'] = 1;
    } else if (stallStatusFree == true) {
      widget.stallssFilters['state'] = 0;
    }

    widget.stallssFilters['stallId'] = filteredStallId;
  }

  void checkTypeNoneFilter(bool newType) {
    setState(() {
      stallTypeNoneFilter = newType;
      stallTypeFree = !newType;
      stallTypeReserve = !newType;
      stallTypeServise = !newType;
    });
  }

  void checkTypeFree(bool newType) {
    setState(() {
      stallTypeNoneFilter = !newType;
      stallTypeFree = newType;
      stallTypeReserve = !newType;
      stallTypeServise = !newType;
    });
  }

  void checkTypeReserve(bool newType) {
    setState(() {
      stallTypeNoneFilter = !newType;
      stallTypeFree = !newType;
      stallTypeReserve = newType;
      stallTypeServise = !newType;
    });
  }

  void checkTypeServise(bool newType) {
    setState(() {
      stallTypeNoneFilter = !newType;
      stallTypeFree = !newType;
      stallTypeReserve = !newType;
      stallTypeServise = newType;
    });
  }

  void checkStatusNoneFilter(bool newStatus) {
    setState(() {
      stallStatusNoneFilter = newStatus;
      stallStatusFree = !newStatus;
      stallStatusReserve = !newStatus;
    });
  }

  void checkStatusFree(bool newStatus) {
    setState(() {
      stallStatusNoneFilter = !newStatus;
      stallStatusFree = newStatus;
      stallStatusReserve = !newStatus;
    });
  }

  void checkStatusReserve(bool newStatus) {
    setState(() {
      stallStatusNoneFilter = !newStatus;
      stallStatusFree = !newStatus;
      stallStatusReserve = newStatus;
    });
  }

  void _saveForm() {
    _form.currentState.save();
  }

  Widget getIconButton(
      BuildContext context, Function setStallFilters, Function saveForm) {
    if (Platform.isIOS == true) {
      return CupertinoButton(
          child: Icon(
            Icons.save,
            color: Colors.black87,
          ),
          onPressed: () => {
                setStallFilters(),
                widget.setFilters(widget.stallssFilters),
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
                setStallFilters(),
                widget.setFilters(widget.stallssFilters),
                saveForm(),
                Navigator.of(context).pop(),
              });
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
        myBody: ListView(
          children: <Widget>[
            DetailsContainer(
              title: 'Typ parkovacieho miesta',
              height: constraints.maxHeight * 0.45,
              details: Column(
                children: <Widget>[
                  CheckboxListTile(
                    value: stallTypeNoneFilter,
                    onChanged: (newValue) {
                      checkTypeNoneFilter(newValue);
                    },
                    title: Text('Žiadny filter'),
                  ),
                  CheckboxListTile(
                    value: stallTypeFree,
                    onChanged: (newValue) {
                      checkTypeFree(newValue);
                    },
                    title: Text('Voľné park. miesto'),
                  ),
                  CheckboxListTile(
                    value: stallTypeReserve,
                    onChanged: (newValue) {
                      checkTypeReserve(newValue);
                    },
                    title: Text('Rezervačné park. miesto'),
                  ),
                  CheckboxListTile(
                    value: stallTypeServise,
                    onChanged: (newValue) {
                      checkTypeServise(newValue);
                    },
                    title: Text('Servisné park. miesto'),
                  ),
                ],
              ),
            ),
            DetailsContainer(
              title: 'Stav parkovacieho miesta',
              height: constraints.maxHeight * 0.38,
              details: Column(
                children: <Widget>[
                  CheckboxListTile(
                    value: stallStatusNoneFilter,
                    onChanged: (newValue) {
                      checkStatusNoneFilter(newValue);
                    },
                    title: Text('Žiadny filter'),
                  ),
                  CheckboxListTile(
                    value: stallStatusFree,
                    onChanged: (newValue) {
                      checkStatusFree(newValue);
                    },
                    title: Text('Voľné park. miesto'),
                  ),
                  CheckboxListTile(
                    value: stallStatusReserve,
                    onChanged: (newValue) {
                      checkStatusReserve(newValue);
                    },
                    title: Text('Obsadené park. miesto'),
                  ),
                ],
              ),
            ),
            DetailsContainer(
              title: 'ID parkoviska',
              height: constraints.maxHeight * 0.22,
              details: Container(
                width: constraints.maxWidth * 0.35,
                child: Form(
                  key: _form,
                  child: TextFormField(
                    onFieldSubmitted: (_) {
                      _saveForm();
                    },
                    maxLines: 1,
                    onSaved: (value) {
                      if (value != '') {
                        filteredStallId = int.parse(value);
                      } else {
                        filteredStallId = 0;
                      }
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: widget.stallssFilters['stallId'] == 0
                            ? 'Park. miesto'
                            : 'Park. miesto:' +
                                widget.stallssFilters['stallId'].toString()),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            )
          ],
        ),
        icon: getIconButton(context, setFiltersForStalls, _saveForm),
      );
    });
  }
}
