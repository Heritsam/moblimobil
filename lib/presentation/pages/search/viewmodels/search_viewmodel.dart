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

final searchViewModel = ChangeNotifierProvider<SearchViewModel>((ref) {
  return SearchViewModel(ref.read);
});

class SearchViewModel extends ChangeNotifier {
  final Reader _read;

  SearchViewModel(this._read) {
    initializeSort();
    search();
  }

  AppState<List<Product>> carState = AppState.initial();
  List<City> cities = [];
  List<Brand> brands = [];
  List<BodyType> bodyTypes = [];
  List<FuelType> fuelTypes = [];
  List<Transmission> transmissions = [];
  List<CarColor> colors = [];

  String type = '';

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

  Future<void> search() async {
    carState = AppState.loading();
    notifyListeners();

    try {
      final cars = await _read(productRepository).index(
        type: type,
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

      carState = AppState.data(data: cars.data);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      carState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> resetAndSearch() async {
    query = '';
    sort = null;
    rangePrice = null;
    rangeKm = null;
    yearBefore = null;
    yearAfter = null;
    byYear = null;
    cityId = null;
    brandId = null;
    bodyTypeId = null;
    fuelTypeId = null;
    transmissionId = null;
    colorId = null;
    notifyListeners();
    await search();
  }

  void resetFilter() {
    sort = null;
    rangePrice = null;
    rangeKm = null;
    yearBefore = null;
    yearAfter = null;
    byYear = null;
    cityId = null;
    brandId = null;
    bodyTypeId = null;
    fuelTypeId = null;
    transmissionId = null;
    colorId = null;
    notifyListeners();
  }

  void changeSearchText(String value) {
    query = value;
    notifyListeners();
  }

  // ==
  void changeCategory(String value) {
    type = value;
    notifyListeners();
    search();
  }
  
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
