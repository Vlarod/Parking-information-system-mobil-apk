import 'package:flutter/material.dart';

import '../Widgets/DetailsInfoRow.dart';
import '../Providers/Park.dart';

class DetailsForPark extends StatelessWidget {
  Park currentPark;

  DetailsForPark(this.currentPark);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        margin: EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DetailInfoRow(
              title: "Id parkoviska",
              data: currentPark.id.toString(),
              editable: false,
            ),
            DetailInfoRow(
              title: "Názov",
              data: currentPark.name,
              editable: true,
            ),
            DetailInfoRow(
              title: "Adresa",
              data: currentPark.getAdressWithoutCityFromAdress,
              editable: true,
            ),
            DetailInfoRow(
              title: "Mesto",
              data: currentPark.getCityFromAdress,
              editable: true,
            ),
            DetailInfoRow(
              title: "Kapacita",
              data: currentPark.maxCapacity.toString(),
              editable: false,
            ),
            DetailInfoRow(
              title: "Rezervácie",
              data: currentPark.reservedFull.toString() +
                  "/" +
                  (currentPark.reservedFull + currentPark.reservedFree)
                      .toString(),
              editable: false,
            ),
            DetailInfoRow(
              title: "Voľné",
              data: currentPark.freeFull.toString() +
                  "/" +
                  (currentPark.freeFree + currentPark.freeFull).toString(),
              editable: false,
            ),
            DetailInfoRow(
              title: "Servis",
              data: currentPark.service.toString(),
              editable: false,
            ),
          ],
        ),
      );
    });
  }
}
