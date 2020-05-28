import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/Parks_Provider.dart';
import '../Widgets/ParkItem.dart';

class ParksGrid extends StatefulWidget {
  @override
  _ParksGridState createState() => _ParksGridState();
}

class _ParksGridState extends State<ParksGrid> {
  int getNumberOfAxisCount(bool isLandscape) {
    if (!isLandscape) {
      return 2;
    } else {
      return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    final parksData = Provider.of<Parks>(context);
    final parks = parksData.getParks;
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: parks.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
            value: parks[index],
            child: ParkItem(),
          ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getNumberOfAxisCount(isLandscape),
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
