import 'package:flutter/material.dart';

class AdminRecordsViewModel with ChangeNotifier {
  Map<String, dynamic> adminDetails = {
    'Warehouse': 'Warehouse 01',
    'CNIC': '45402-6789012-3',
    'Phone Number': '0304-1234567',
    'Address': 'Shah Faisal Colony, Karachi',
    'Email': 'ahsan@gmail.com',
    'Password': '12345',
    'Age': 24,
  };
}
