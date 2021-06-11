import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/product_master/body_type.dart';
import '../../../../infrastructures/models/product_master/brand.dart';
import '../../../../infrastructures/models/product_master/car_color.dart';
import '../../../../infrastructures/models/product_master/fuel_type.dart';
import '../../../../infrastructures/models/product_master/transmission.dart';
import '../../../../infrastructures/models/product_master/variant.dart';
import '../../../../infrastructures/params/product/add_product_params.dart';
import '../../../../infrastructures/repositories/product_master_repository.dart';
import '../../../../infrastructures/repositories/product_repository.dart';
import '../../account/viewmodels/vendor_cars_notifier.dart';
import '../../vendor_cars/viewmodels/vendor_cars_viewmodel.dart';

final vendorCarsAddViewModel =
    ChangeNotifierProvider<VendorCarsAddViewModel>((ref) {
  return VendorCarsAddViewModel(ref.read);
});

class VendorCarsAddViewModel extends ChangeNotifier {
  final Reader _read;

  VendorCarsAddViewModel(this._read);

  bool isUploading = false;

  late AppState<List<Brand>> brandState;
  late AppState<List<Variant>> variantState;
  late AppState<List<CarColor>> colorState;
  late AppState<List<BodyType>> bodyTypeState;
  late AppState<List<FuelType>> fuelTypeState;
  late AppState<List<Transmission>> transmissionState;

  List<File> files = [];
  String carName = '';
  String price = '';
  String type = 'new';
  Brand? brandId;
  Variant? variantId;
  CarColor? colorId;
  BodyType? bodyTypeId;
  FuelType? fuelTypeId;
  Transmission? transmissionId;
  String? year;
  String kilometers = '';
  String descriptionTitle = '';
  String description = '';

  Future<void> initialize() async {
    files.clear();
    carName = '';
    price = '';
    type = 'new';
    brandId = null;
    variantId = null;
    colorId = null;
    bodyTypeId = null;
    fuelTypeId = null;
    transmissionId = null;
    year = null;
    kilometers = '';
    descriptionTitle = '';
    description = '';

    brandState = AppState.initial();
    variantState = AppState.initial();
    colorState = AppState.initial();
    bodyTypeState = AppState.initial();
    fuelTypeState = AppState.initial();
    transmissionState = AppState.initial();

    fetchBrands();
    fetchVariants();
    fetchColors();
    fetchBodyTypes();
    fetchFuelTypes();
    fetchTransmissions();
  }

  Future<void> fetchBrands() async {
    try {
      final items = await _read(productMasterRepository).brands();
      brandState = AppState.data(data: items.data);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      fetchBrands();
      brandState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> fetchVariants() async {
    try {
      final items = await _read(productMasterRepository).variants();
      variantState = AppState.data(data: items);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      fetchBrands();
      variantState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> fetchColors() async {
    try {
      final items = await _read(productMasterRepository).colors();
      colorState = AppState.data(data: items);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      fetchBrands();
      colorState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> fetchBodyTypes() async {
    try {
      final items = await _read(productMasterRepository).bodyTypes();
      bodyTypeState = AppState.data(data: items);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      fetchBrands();
      bodyTypeState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> fetchFuelTypes() async {
    try {
      final items = await _read(productMasterRepository).fuelTypes();
      fuelTypeState = AppState.data(data: items);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      fetchBrands();
      fuelTypeState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> fetchTransmissions() async {
    try {
      final items = await _read(productMasterRepository).transmissions();
      transmissionState = AppState.data(data: items);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      fetchBrands();
      transmissionState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> addProduct(BuildContext context) async {
    isUploading = true;
    notifyListeners();
    
    try {
      final product = await _read(productRepository).add(
        AddProductParams(
          title: carName,
          price: price,
          type: type,
          brand: brandId!,
          variant: variantId!,
          color: colorId!,
          bodyType: bodyTypeId!,
          fuelType: fuelTypeId!,
          transmission: transmissionId!,
          year: year!,
          kilometers: kilometers,
          descriptionTitle: descriptionTitle,
          description: description,
        ),
      );

      files.forEach((element) async {
        await _read(productRepository).addFile(product['product_id'], element);
      });

      _read(vendorCarsNotifier).fetch();
      _read(vendorCarsViewModel).fetch();

      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Success')));
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }

    isUploading = false;
    notifyListeners();
  }

  // ==
  void changeType(String? value) {
    type = value!;
    notifyListeners();
  }

  void addFile(File file) {
    files.add(file);
    notifyListeners();
  }

  void removeFile(int index) {
    files.removeAt(index);
    notifyListeners();
  }
}
