import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NumberFormater {
  final formater = NumberFormat("#,##0", "fr_FR");
  String formaterNumber(int number) {
    return formater.format(number);
  }
}
