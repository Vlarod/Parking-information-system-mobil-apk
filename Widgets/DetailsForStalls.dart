import 'package:flutter/material.dart';

import '../Widgets/DetailsInfoRow.dart';
import '../Providers/Stall.dart';

class DetailsForStalls extends StatelessWidget {
  Stall currentStall;

  DetailsForStalls(this.currentStall);

  String showStallType(int type) {
    switch (type) {
      case 0:
        return "Volné";
        break;
      case 1:
        return "Rezervačné";
        break;
      case 2:
        return "Servis";
        break;
      default:
        return "Servis";
    }
  }

  String showStallStatus(int status) {
    switch (status) {
      case 0:
        return "Voľné";
        break;
      case 1:
        return "Obsadené";
        break;
      default:
        return "Obsadené";
    }
  }

  String showStallOrientation(int orientation) {
    switch (orientation) {
      case 0:
        return "Horizontálne";
        break;
      case 1:
        return "Vertikálne";
        break;
      default:
        return "Horizontálne";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DetailInfoRow(
            title: "Id",
            data: currentStall.id.toString(),
            editable: false,
          ),
          DetailInfoRow(
            title: "Id parkoviska",
            data: currentStall.parkId.toString(),
            editable: false,
          ),
          DetailInfoRow(
            title: "Stav miesta",
            data: showStallStatus(currentStall.status),
            editable: true,
          ),
          DetailInfoRow(
            title: "Typ miesta",
            data: showStallType(currentStall.type),
            editable: currentStall.type != 1 ? true : false,
          ),
          DetailInfoRow(
            title: "Súradnica X",
            data: currentStall.x.toString(),
            editable: false,
          ),
          DetailInfoRow(
            title: "Súradnica Y",
            data: currentStall.y.toString(),
            editable: false,
          ),
          DetailInfoRow(
            title: "Orientácia",
            data: showStallOrientation(currentStall.orientation),
            editable: false,
          ),
          DetailInfoRow(
            title: "Dĺžka",
            data: currentStall.lenght.toString(),
            editable: false,
          ),
          DetailInfoRow(
            title: "Šírka",
            data: currentStall.width.toString(),
            editable: false,
          ),
        ],
      ),
    );
  }
}
