import 'package:flutter/material.dart';

import '../Providers/Stall.dart';
import '../Widgets/DetailsContainer.dart';
import '../Widgets/DetailsForStalls.dart';

class StallDetails extends StatelessWidget {
  Stall currentStall;
  Widget icon;
  StallDetails(this.currentStall, this.icon);

  double getHeight(double height, bool isLandscape) {
    if (!isLandscape) {
      return height * 0.45;
    } else {
      return height * 0.95;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return DetailsContainer(
      details: DetailsForStalls(currentStall),
      title: "Informácie o mieste",
      height: getHeight(MediaQuery.of(context).size.height, isLandscape),
      icon: icon,
    );
  }
}
