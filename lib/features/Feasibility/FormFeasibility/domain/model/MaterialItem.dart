import 'package:flutter/material.dart';

class MaterialItem {
  final String id;
  final String name;
  final String value;
  final String unit;
  final TextEditingController controller;
  MaterialItem(
      {
        required this.id,
        required this.name,
        required this.value,
        required this.unit,
        required this.controller
      });
}