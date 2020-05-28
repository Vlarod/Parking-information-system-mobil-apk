import 'package:flutter/material.dart';

import '../Providers/Park.dart';
import '../Helper/LocationHelper.dart';
import '../Screens/Stalls_Screen.dart';
import '../Widgets/DetailsForPark.dart';
import '../Widgets/DetailsContainer.dart';

class ParkDetail extends StatelessWidget {
  Park currentPark;
  Widget icon;

  ParkDetail(this.currentPark, this.icon);

  List<double> getHeights(bool isLandscape, BoxConstraints constraints) {
    if (!isLandscape) {
      List<double> heights = [
        constraints.maxHeight * 0.45,
        constraints.maxHeight * 0.08,
        constraints.maxHeight * 0.40
      ];
      return heights;
    } else {
      List<double> heights = [constraints.maxHeight * 0.93, 50.0, 228.0];
      return heights;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return LayoutBuilder(builder: (ctx, constraints) {
      List<double> heights = getHeights(isLandscape, constraints);
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DetailsContainer(
              details: DetailsForPark(currentPark),
              title: "Informácie o parkovisku",
              height: heights[0],
              icon: icon,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              height: heights[1],
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(StallsScreen.routeName,
                      arguments: currentPark.id);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FittedBox(
                        child: Text(
                          'Zobraziť parkovacie miesta',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600]),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.local_library),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
              height: heights[2],
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 30,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: NetworkImage(
                          LocationHelper.generateLocationPreviewImage(
                              currentPark.latitude, currentPark.longtitude),
                        ),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
