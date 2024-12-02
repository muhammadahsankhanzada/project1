import 'package:flutter/material.dart';

class AdminCheckReportsViewModel with ChangeNotifier {
  final Map<String, double> deliveryReportsDataMap = {
    "Total Deliveries": 40,
    "Pending Deliveries": 20,
    "Late Deliveries": 10,
    "On time Deliveries": 30,
  };

  final List<Color> deliveryReportsColorList = [
    Colors.blue,
    Colors.red,
    Colors.orange,
    Colors.green,
  ];
  final Map<String, double> inventoryAndStocksReportsDataMap = {
    "Stock Available": 70,
    "Stock Required": 20,
    "Incoming Shipments": 10,
  };

  final List<Color> inventoryAndStocksReportsColorList = [
    Colors.blue,
    Colors.red,
    Colors.green,
  ];
  final Map<String, double> orderReportsDataMap = {
    "Orders Recieved": 50,
    "Orders Canceled": 10,
    "Orders Completed": 40,
  };

  final List<Color> orderReportsColorList = [
    Colors.blue,
    Colors.red,
    Colors.green,
  ];
}
