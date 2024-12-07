import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project1/Models/salesman_trips_list_model.dart';
import 'package:project1/Utils/app_urls.dart';
import 'package:http/http.dart' as http;

class SalesmanEndTripViewModel with ChangeNotifier {
  List<SalesmanTripsListModel> tripsList = [];
  Future<List<SalesmanTripsListModel>> fetchSalesmanTrips() async {
    String salesmanName = 'Muhammad Ahsan';
    try {
      final response = await http.get(Uri.parse(AppUrls.getSalesmanTripsList(
        salesmanName: salesmanName,
      )));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        tripsList = data
            .map((tripData) =>
                SalesmanTripsListModel.fromMap(tripData, tripData['id']))
            .toList();
        notifyListeners();
        return tripsList;
      } else {
        print('Failed to load trips');
        return [];
      }
    } catch (error) {
      notifyListeners();
      print('Error: $error');
      print('Error fetching trips: $error');
      return [];
    }
  }
}
