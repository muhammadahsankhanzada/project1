import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';

class SearchBoxWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final Color fillColor;
  final Function(String)? onChanged;

  const SearchBoxWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    this.fillColor = AppColors.white,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: fillColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 30),
        suffixIcon: Icon(
          Icons.search,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
