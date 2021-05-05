import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final creditSimulationNotifier =
    ChangeNotifierProvider((ref) => CreditSimulationNotifier());

class CreditSimulationNotifier extends ChangeNotifier {
  String? dp;
  int price = 250000000;
  int? month;
}
