import 'dart:async';

import 'package:flutter/material.dart';
import '../Providers/Park.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Parks with ChangeNotifier {
  List<Park> _parks = [];

  Future<void> getParksFromServer(Map<String, int> parksFilters) async {
    const url =
        'http://sponn-test-back.azurewebsites.net/api/Reservation/activeParkingLots';
    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body);
      final List<Park> loadedParks = [];
      for (int i = 0; i < extractedData.length; i++) {
        loadedParks.add(Park(
          id: extractedData[i]['id'],
          adress: extractedData[i]['adresa'],
          maxCapacity: extractedData[i]['kapacita'],
          name: extractedData[i]['nazov'],
          latitude: extractedData[i]['x'],
          longtitude: extractedData[i]['y'],
          status: extractedData[i]['status'],
          freeFree: extractedData[i]['volnyVolny'],
          freeFull: extractedData[i]['volnyObsa'],
          reservedFree: extractedData[i]['rezVolny'],
          reservedFull: extractedData[i]['rezObsa'],
          service: extractedData[i]['servis'],
        ));
      }

      if (parksFilters['status'] == 2) {
        _parks = loadedParks;
      } else if (parksFilters['status'] == 1) {
        _parks = loadedParks.where((park) {
          if (park.status != 1) {
            return false;
          } else {
            return true;
          }
        }).toList();
      } else if (parksFilters['status'] == 0) {
        _parks = loadedParks.where((park) {
          if (park.status != 0) {
            return false;
          } else {
            return true;
          }
        }).toList();
      }

      if (parksFilters['parkId'] != 0) {
        _parks = _parks.where((park) {
          if (park.id != parksFilters['parkId']) {
            return false;
          } else {
            return true;
          }
        }).toList();
      }

      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> getParkFromDatabase(int parkId) async {
    String url =
        'http://sponn-test-back.azurewebsites.net/api/Reservation/activeParkingLot/' +
            parkId.toString();

    try {
      final response = await http.get(url);
      print(response.statusCode);
      final extractedData = json.decode(response.body);

      Park newPark = Park(
        id: extractedData['id'],
        adress: extractedData['adresa'],
        maxCapacity: extractedData['kapacita'],
        name: extractedData['nazov'],
        latitude: extractedData['x'],
        longtitude: extractedData['y'],
        status: extractedData['status'],
        freeFree: extractedData['volnyVolny'],
        freeFull: extractedData['volnyObsa'],
        reservedFree: extractedData['rezVolny'],
        reservedFull: extractedData['rezObsa'],
        service: extractedData['servis'],
      );

      _parks.remove(findById(parkId));
      _parks.add(newPark);
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> updateParkName(int parkId, String newName) async {
    const url =
        'http://sponn-test-back.azurewebsites.net/api/Editation/parkingLotNameChange';

    try {
      await http.post(url,
          body: json.encode({
            'parkingLotId': parkId,
            'name': newName,
          }),
          headers: {"Content-Type": "application/json"});
    } catch (e) {
      throw (e);
    }
  }

  Future<void> updateParkStatus(int parkId, bool newStatus) async {
    const url =
        'http://sponn-test-back.azurewebsites.net/api/Editation/parkingLotStatusChange';
    int status;
    if (newStatus == true) {
      status = 1;
    } else {
      status = 0;
    }
    try {
      await http.post(url,
          body: json.encode({
            'parkingLotId': parkId,
            'status': status,
          }),
          headers: {"Content-Type": "application/json"});
    } catch (e) {
      throw (e);
    }
  }

  Future<void> updateParkSyncData() async {
    const url1 =
        "http://sponn-test-back.azurewebsites.net/api/Editation/getSyncVersion";

    try {
      final response1 = await http.get(url1);

      final newSyncVersion = (json.decode(response1.body) + 1).toString();
      String url2 =
          "http://sponn-test-back.azurewebsites.net/api/Editation/syncVersionUpdate/" +
              newSyncVersion;
      final response2 = await http.put(url2);
      String url3 =
          "http://sponn-test-back.azurewebsites.net/api/Editation/syncVersionParkoviskoUpdate";
      final response3 = await http.put(url3);

      print(response2.statusCode);
      print(response3.statusCode);
    } catch (e) {}
  }

  List<Park> get getParks {
    return [..._parks];
  }

  Park findById(int parkId) {
    return _parks.firstWhere((park) => park.id == parkId);
  }
}
