import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../infrastructures/models/car.dart';

final carCompareViewModel =
    ChangeNotifierProvider((ref) => CarCompareViewModel());

class CarCompareViewModel extends ChangeNotifier {
  List<Car> selectedCars = [];

  void addCar({
    required BuildContext context,
    required Car car,
  }) {
    if (selectedCars.length == 4) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Couldn\'t add more cars'),
        duration: Duration(seconds: 2),
      ));
      return;
    }

    if (selectedCars.contains(car)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('You\'ve already selected this car'),
        duration: Duration(seconds: 2),
      ));
      return;
    }

    selectedCars.add(car);
    notifyListeners();
  }

  void removeCar(Car car) {
    selectedCars.remove(car);
    notifyListeners();
  }
}
