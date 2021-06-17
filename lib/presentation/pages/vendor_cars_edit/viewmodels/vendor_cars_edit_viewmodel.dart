import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/product/product.dart';
import '../../../../infrastructures/models/product_master/body_type.dart';
import '../../../../infrastructures/models/product_master/brand.dart';
import '../../../../infrastructures/models/product_master/car_color.dart';
import '../../../../infrastructures/models/product_master/fuel_type.dart';
import '../../../../infrastructures/models/product_master/transmission.dart';
import '../../../../infrastructures/models/product_master/variant.dart';
import '../../../../infrastructures/params/product/add_product_params.dart';
import '../../../../infrastructures/params/product/product_file_params.dart';
import '../../../../infrastructures/repositories/product_master_repository.dart';
import '../../../../infrastructures/repositories/product_repository.dart';
import '../../account/viewmodels/vendor_cars_notifier.dart';
import '../../vendor_cars/viewmodels/vendor_cars_detail_viewmodel.dart';
import '../../vendor_cars/viewmodels/vendor_cars_viewmodel.dart';

final vendorCarsEditViewModel =
    ChangeNotifierProvider.family<VendorCarsEditViewModel, int>((ref, carId) {
  return VendorCarsEditViewModel(ref.read, carId);
});

class VendorCarsEditViewModel extends ChangeNotifier {
  final Reader _read;
  final int id;

  VendorCarsEditViewModel(this._read, this.id);

  bool isUploading = false;

  late AppState<List<Brand>> brandState;
  late AppState<List<Variant>> variantState;
  late AppState<List<CarColor>> colorState;
  late AppState<List<BodyType>> bodyTypeState;
  late AppState<List<FuelType>> fuelTypeState;
  late AppState<List<Transmission>> transmissionState;

  List<ProductFileParams> files = [];
  List<int> filesToDelete = [];

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

  late AppState<Product> carState;

  Future<void> fetchCar() async {
    carState = AppState.loading();

    try {
      final car = await _read(productRepository).detail(id);

      files.clear();
      filesToDelete.clear();

      files = car.file
          .map((e) => ProductFileParams(id: e.id, imageUrl: e.file))
          .toList();
      carName = car.title;
      price = car.price;
      type = car.type;
      brandId = null;
      variantId = null;
      colorId = null;
      bodyTypeId = null;
      fuelTypeId = null;
      transmissionId = null;
      year = car.yearProduct;
      kilometers = car.kilometer;
      descriptionTitle = car.descriptionTitle;
      description = car.description;

      brandState = AppState.initial();
      variantState = AppState.initial();
      colorState = AppState.initial();
      bodyTypeState = AppState.initial();
      fuelTypeState = AppState.initial();
      transmissionState = AppState.initial();

      fetchBrands(int.parse(car.brandId));
      fetchVariants(int.parse(car.variantId));
      fetchColors(int.parse(car.colorId));
      fetchBodyTypes(int.parse(car.bodyTypeId));
      fetchFuelTypes(int.parse(car.fuelTypeId));
      fetchTransmissions(int.parse(car.transmissionId));

      carState = AppState.data(data: car);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      carState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> fetchBrands(int itemId) async {
    try {
      final items = await _read(productMasterRepository).brands();

      brandId = items.data.firstWhere((item) => item.id == itemId);

      brandState = AppState.data(data: items.data);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      fetchBrands(itemId);
      brandState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> fetchVariants(int itemId) async {
    try {
      final items = await _read(productMasterRepository).variants();

      variantId = items.firstWhere((item) => item.id == itemId);

      variantState = AppState.data(data: items);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      fetchVariants(itemId);
      variantState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> fetchColors(int itemId) async {
    try {
      final items = await _read(productMasterRepository).colors();

      colorId = items.firstWhere((item) => item.id == itemId);

      colorState = AppState.data(data: items);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      fetchColors(itemId);
      colorState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> fetchBodyTypes(int itemId) async {
    try {
      final items = await _read(productMasterRepository).bodyTypes();

      bodyTypeId = items.firstWhere((item) => item.id == itemId);

      bodyTypeState = AppState.data(data: items);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      fetchBodyTypes(itemId);
      bodyTypeState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> fetchFuelTypes(int itemId) async {
    try {
      final items = await _read(productMasterRepository).fuelTypes();
      fuelTypeId = items.firstWhere((item) => item.id == itemId);

      fuelTypeState = AppState.data(data: items);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      fetchFuelTypes(itemId);
      fuelTypeState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> fetchTransmissions(int itemId) async {
    try {
      final items = await _read(productMasterRepository).transmissions();
      transmissionId = items.firstWhere((item) => item.id == itemId);

      transmissionState = AppState.data(data: items);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      fetchTransmissions(itemId);
      transmissionState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> addProduct(BuildContext context) async {
    isUploading = true;
    notifyListeners();

    try {
      await _read(productRepository).update(
        id,
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
        if (element.file != null) {
          Future.wait([
            _read(productRepository).addFile(id, element.file!),
          ]).then((value) {
            _read(vendorCarsViewModel).fetch();
            _read(vendorCarsDetailViewModel(id)).fetch();
          });
        }
      });

      filesToDelete.forEach((element) async {
        Future.wait([
          _read(productRepository).deleteFile(element),
        ]).then((value) {
          _read(vendorCarsViewModel).fetch();
          _read(vendorCarsDetailViewModel(id)).fetch();
        });
      });

      Navigator.popUntil(context, ModalRoute.withName('/vendor-cars'));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Success')));

      _read(vendorCarsNotifier).fetch();
      _read(vendorCarsViewModel).fetch();
      _read(vendorCarsDetailViewModel(id)).fetch();
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
    files.add(ProductFileParams(file: file));
    notifyListeners();
  }

  void removeFile(int index) {
    if (files[index].id != null) {
      filesToDelete.add(files[index].id!);
      print(filesToDelete);
    }

    files.removeAt(index);
    notifyListeners();
  }
}
