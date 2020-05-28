import 'package:flutter/foundation.dart';

class Park with ChangeNotifier {
  final int id;
  String adress;
  int maxCapacity;
  String name;
  int status;
  double latitude;
  double longtitude;
  int freeFree;
  int freeFull;
  int reservedFree;
  int reservedFull;
  int service;

  Park({
    @required this.id,
    @required this.name,
    @required this.adress,
    @required this.maxCapacity,
    @required this.status,
    @required this.latitude,
    @required this.longtitude,
    @required this.freeFree,
    @required this.freeFull,
    @required this.reservedFree,
    @required this.reservedFull,
    @required this.service,
  });

  String get getCityFromAdress {
    String city;
    int index;
    for (int i = 0; i < adress.length; i++) {
      if (adress[i] == ",") {
        index = i + 1;
        break;
      }
    }
    city = adress.substring(index, adress.length);
    return city;
  }

  String get getAdressWithoutCityFromAdress {
    String adressWithoutCity;
    int index;
    for (int i = 0; i < adress.length; i++) {
      if (adress[i] == ",") {
        index = i;
        break;
      }
    }
    adressWithoutCity = adress.substring(0, index);
    return adressWithoutCity;
  }
}
