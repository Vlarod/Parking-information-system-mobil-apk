import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import './Screens/EditStall_Screen.dart';
import './Screens/ParkFilters_Screen.dart';
import './Screens/Stalls_Screen.dart';
import './Screens/Parks_Screen.dart';
import './Screens/ParkDetail_Screen.dart';
import './Screens/StallDetailScreen.dart';
import './Screens/EditPark_Screen.dart';
import './Screens/StallFilters_Screen.dart';
import './Providers/Parks_Provider.dart';
import './Providers/Stalls_Provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, int> parksFilters = {
    'status': 2,
    'parkId': 0,
  };

  Map<String, int> stallsFilters = {
    'type': 3,
    'state': 2,
    'stallId': 0,
  };

  void _setParkFilters(Map<String, int> filtersData) {
    parksFilters = filtersData;
  }

  void _setStallFilters(Map<String, int> filtersData) {
    stallsFilters = filtersData;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Parks(),
          ),
          ChangeNotifierProvider.value(
            value: Stalls(),
          ),
        ],
        child: MaterialApp(
          title: 'Parking administration',
          theme: ThemeData(
            primaryColor: Colors.white,
          ),
          home: Parks_Screen(parksFilters),
          routes: {
            ParkDetail_Screen.routeName: (context) => ParkDetail_Screen(),
            StallsScreen.routeName: (context) => StallsScreen(stallsFilters),
            StallDetailScreen.routeName: (context) => StallDetailScreen(),
            EditPark_Screen.routeName: (context) => EditPark_Screen(),
            EditStall_Screen.routeName: (context) => EditStall_Screen(),
            ParkFiltersScreen.routeName: (context) => ParkFiltersScreen(
                  parksFilters,
                  _setParkFilters,
                ),
            StallFiltersScreen.routeName: (context) =>
                StallFiltersScreen(stallsFilters, _setStallFilters),
          },
        ));
  }
}
