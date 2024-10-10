import 'package:flutter/material.dart';

class Task {
  int id;
  String name;
  DateTime date;
  TimeOfDay start;
  TimeOfDay end;
  Task({
    required this.id,
    required this.name,
    required this.date,
    required this.start,
    required this.end,
  });
}
