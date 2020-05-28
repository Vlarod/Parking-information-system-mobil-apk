import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/Stall.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Stalls with ChangeNotifier {
  List<Stall> _stalls = [];

  Future<void> getStallsFromServer(
      int parkId, Map<String, int> stallsFilters) async {
    final parkIdS = parkId.toString();
    String url =
        'http://sponn-test-back.azurewebsites.net/api/Reservation/parkingPlaces/' +
            parkIdS;
    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body);
      final List<Stall> loadedStalls = [];
      for (int i = 0; i < extractedData.length; i++) {
        loadedStalls.add(Stall(
          id: extractedData[i]['id'],
          parkId: extractedData[i]['idParkoviska'],
          type: extractedData[i]['typ'],
          status: extractedData[i]['stav'],
          x: extractedData[i]['x'],
          y: extractedData[i]['y'],
          orientation: extractedData[i]['orientacia'],
          lenght: extractedData[i]['dlzka'],
          width: extractedData[i]['sirka'],
        ));
      }

      if (stallsFilters['type'] == 3) {
        _stalls = loadedStalls;
      } else if (stallsFilters['type'] == 2) {
        _stalls = loadedStalls.where((stall) {
          if (stall.type != 2) {
            return false;
          } else {
            return true;
          }
        }).toList();
      } else if (stallsFilters['type'] == 1) {
        _stalls = loadedStalls.where((stall) {
          if (stall.type != 1) {
            return false;
          } else {
            return true;
          }
        }).toList();
      } else if (stallsFilters['type'] == 0) {
        _stalls = loadedStalls.where((stall) {
          if (stall.type != 0) {
            return false;
          } else {
            return true;
          }
        }).toList();
      }

      if (stallsFilters['state'] == 1) {
        _stalls = _stalls.where((stall) {
          if (stall.status != 1) {
            return false;
          } else {
            return true;
          }
        }).toList();
      } else if (stallsFilters['state'] == 0) {
        _stalls = _stalls.where((stall) {
          if (stall.status != 0) {
            return false;
          } else {
            return true;
          }
        }).toList();
      }

      if (stallsFilters['stallId'] != 0) {
        _stalls = _stalls.where((stall) {
          if (stall.id != stallsFilters['stallId']) {
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

  Future<void> getStallFromServer(int parkId, int stallId) async {
    final parkIdS = parkId.toString();
    final stallIdS = stallId.toString();
    String url =
        'http://sponn-test-back.azurewebsites.net/api/Reservation/parkingPlace/' +
            parkIdS +
            '/' +
            stallIdS;
    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body);

      Stall newStall = Stall(
        id: extractedData['id'],
        parkId: extractedData['idParkoviska'],
        type: extractedData['typ'],
        status: extractedData['stav'],
        x: extractedData['x'],
        y: extractedData['y'],
        orientation: extractedData['orientacia'],
        lenght: extractedData['dlzka'],
        width: extractedData['sirka'],
      );

      _stalls.remove(findById(stallId));
      _stalls.add(newStall);
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> updateStallSyncData(int parkId) async {
    String url1 =
        'http://sponn-test-back.azurewebsites.net/api/Editation/getPLSyncVersion/' +
            parkId.toString();
    final response1 = await http.get(url1);

    final newVersion = (json.decode(response1.body) + 1).toString();

    String url =
        'http://sponn-test-back.azurewebsites.net/api/Editation/PLsyncVersionUpdate/' +
            parkId.toString() +
            '/' +
            newVersion.toString();
    try {
      await http.put(url);
    } catch (e) {
      throw (e);
    }
  }

  Future<void> updateStallType(int parkId, int stallId, int type) async {
    String url =
        'http://sponn-test-back.azurewebsites.net/api/Editation/parkingPlaceTypeChange';

    try {
      await http.post(url,
          body: json.encode({
            'parkingLotId': parkId,
            'parkingPlaceId': stallId,
            'type': type,
          }),
          headers: {"Content-Type": "application/json"});
    } catch (e) {
      throw (e);
    }
  }

  List<Stall> get getStalls {
    return [..._stalls];
  }

  Stall findById(int stallId) {
    return _stalls.firstWhere((stall) => stall.id == stallId);
  }

  List<Stall> getStallsFromPark(int parkId) {
    return [..._stalls.where((stall) => stall.parkId == parkId)];
  }
}
