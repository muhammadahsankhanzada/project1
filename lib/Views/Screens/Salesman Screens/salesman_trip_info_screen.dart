import 'package:flutter/material.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class SalesmanTripInfoScreen extends StatelessWidget {
  const SalesmanTripInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Trip Info'),
    );
  }
}
