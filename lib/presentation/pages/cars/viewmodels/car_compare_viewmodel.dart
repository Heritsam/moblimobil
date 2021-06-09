import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/location/city.dart';
import '../../../../infrastructures/models/product/product.dart';
import '../../../../infrastructures/models/product_master/body_type.dart';
import '../../../../infrastructures/models/product_master/brand.dart';
import '../../../../infrastructures/models/product_master/car_color.dart';
import '../../../../infrastructures/models/product_master/fuel_type.dart';
import '../../../../infrastructures/models/product_master/transmission.dart';
import '../../../../infrastructures/models/sort/sort_template.dart';
import '../../../../infrastructures/repositories/location_repository.dart';
import '../../../../infrastructures/repositories/product_master_repository.dart';
import '../../../../infrastructures/repositories/product_repository.dart';

final carCompareViewModel = ChangeNotifierProvider<CarCompareViewModel>((ref) {
  return CarCompareViewModel(ref.read);
});

class CarCompareViewModel extends ChangeNotifier {
  final Reader _read;

  CarCompareViewModel(this._read) {
    initializeSort();
    fetch();
  }

  AppState<List<Product>> carsState = AppState.initial();
  List<Product> selectedCars = [];

  List<City> cities = [];
  List<Brand> brands = [];
  List<BodyType> bodyTypes = [];
  List<FuelType> fuelTypes = [];
  List<Transmission> transmissions = [];
  List<CarColor> colors = [];

  String query = '';
  String? sort;
  SortTemplate? rangePrice;
  SortTemplate? rangeKm;
  String? yearBefore;
  String? yearAfter;
  SortTemplate? byYear;
  City? cityId;
  Brand? brandId;
  BodyType? bodyTypeId;
  FuelType? fuelTypeId;
  Transmission? transmissionId;
  CarColor? colorId;

  Future<void> initializeSort() async {
    try {
      cities = await _read(locationRepository).cityAll();
      brands = (await _read(productMasterRepository).brands()).data;
      bodyTypes = await _read(productMasterRepository).bodyTypes();
      fuelTypes = await _read(productMasterRepository).fuelTypes();
      transmissions = await _read(productMasterRepository).transmissions();
      colors = await _read(productMasterRepository).colors();
    } catch (e) {
      initializeSort();
    }
  }

  Future<void> fetch() async {
    carsState = AppState.loading();
    notifyListeners();

    try {
      final cars = await _read(productRepository).index(
        search: query,
        rangePrice: rangePrice,
        rangeKm: rangeKm,
        yearBefore: yearBefore,
        yearAfter: yearAfter,
        byYear: byYear,
        sort: sort,
        brandId: brandId?.id,
        bodyTypeId: bodyTypeId?.id,
        cityId: cityId?.cityId,
        colorId: colorId?.id,
        fuelTypeId: fuelTypeId?.id,
        transmissionId: transmissionId?.id,
      );
      carsState = AppState.data(data: cars.data);

      notifyListeners();
    } on NetworkExceptions catch (e) {
      carsState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  void changeSearchText(String value) {
    query = value;
    notifyListeners();
  }

  Future<void> resetAndFetch() async {
    query = '';
    notifyListeners();
    await fetch();
  }

  void addCar({
    required BuildContext context,
    required Product car,
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

  void removeCar(Product car) {
    selectedCars.remove(car);
    notifyListeners();
  }

  // ==
  void selectSorting(String? value) {
    sort = value;
    notifyListeners();
  }

  void selectPrice(SortTemplate? value) {
    rangePrice = value;
    notifyListeners();
  }

  void selectCity(City? value) {
    cityId = value;
    notifyListeners();
  }

  void selectBrand(Brand? value) {
    brandId = value;
    notifyListeners();
  }

  void selectBodyType(BodyType? value) {
    bodyTypeId = value;
    notifyListeners();
  }

  void selectFuelType(FuelType? value) {
    fuelTypeId = value;
    notifyListeners();
  }

  void selectTransmission(Transmission? value) {
    transmissionId = value;
    notifyListeners();
  }

  void selectYear(SortTemplate? value) {
    byYear = value;
    notifyListeners();
  }

  void selectKilometers(SortTemplate? value) {
    rangeKm = value;
    notifyListeners();
  }

  void selectColor(CarColor? value) {
    colorId = value;
    notifyListeners();
  }
}
