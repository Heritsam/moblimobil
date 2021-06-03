import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/location/city.dart';
import '../../../../infrastructures/models/location/province.dart';
import '../../../../infrastructures/models/location/subdistrict.dart';
import '../../../../infrastructures/models/profile/user.dart';
import '../../../../infrastructures/params/profile/update_profile_params.dart';
import '../../../../infrastructures/repositories/location_repository.dart';
import '../../../../infrastructures/repositories/profile_repository.dart';
import 'account_user_notifier.dart';

final editProfileViewModel =
    ChangeNotifierProvider<EditProfileViewModel>((ref) {
  return EditProfileViewModel(ref.read);
});

class EditProfileViewModel extends ChangeNotifier {
  final Reader _read;

  EditProfileViewModel(this._read) {
    userState = AppState.initial();
    provinceState = AppState.initial();
    cityState = AppState.initial();
    subdistrictState = AppState.initial();

    avatar = null;
    newAvatar = null;
    fullname = '';
    phone = '';
    email = '';
    provinceId = 0;
    cityId = 0;
    subdistrictId = 0;
    postcode = '';
    address = '';

    fetchUser();
    fetchProvinces();
  }

  late AppState<User> userState;
  late AppState<List<Province>> provinceState;
  late AppState<List<City>> cityState;
  late AppState<List<Subdistrict>> subdistrictState;

  bool isUpdating = false;

  late String? avatar;
  late File? newAvatar;

  late String fullname;
  late String phone;
  late String email;
  late int provinceId;
  late int cityId;
  late int subdistrictId;
  late String postcode;
  late String address;

  TextEditingController birthController = TextEditingController();

  @override
  void dispose() {
    birthController.dispose();
    super.dispose();
  }

  Future<void> fetchUser() async {
    userState = AppState.loading();
    notifyListeners();

    try {
      final me = await _read(profileRepository).me();

      newAvatar = null;
      userState = AppState.data(data: me);
      avatar = me.file;
      fullname = me.fullname;
      phone = me.phone;
      email = me.email;
      address = me.address ?? '';
      provinceId = me.provinceId != null ? int.parse(me.provinceId!) : 0;
      cityId = me.cityId != null ? int.parse(me.cityId!) : 0;
      subdistrictId =
          me.subdistrictId != null ? int.parse(me.subdistrictId!) : 0;
      postcode = me.postcode ?? '';

      birthController.text =
          DateFormat('yyyy-MM-dd').format(me.bornDate ?? DateTime.now());

      if (cityId != 0) {
        fetchCities();
      }

      if (subdistrictId != 0) {
        fetchSubdistricts();
      }

      notifyListeners();
    } on NetworkExceptions catch (e) {
      userState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> fetchProvinces() async {
    provinceState = AppState.loading();
    cityState = AppState.initial();
    subdistrictState = AppState.initial();
    notifyListeners();

    try {
      final provinces = await _read(locationRepository).provinces();

      provinceState = AppState.data(data: provinces);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      fetchProvinces();
      provinceState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> fetchCities() async {
    cityState = AppState.loading();
    subdistrictState = AppState.initial();
    notifyListeners();

    try {
      final cities = await _read(locationRepository).cities(provinceId);

      cityState = AppState.data(data: cities);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      fetchCities();
      cityState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> fetchSubdistricts() async {
    subdistrictState = AppState.loading();
    notifyListeners();

    try {
      final subDistricts =
          await _read(locationRepository).subDistricts(cityId);

      subdistrictState = AppState.data(data: subDistricts);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      fetchSubdistricts();
      subdistrictState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> updateProfile(BuildContext context) async {
    isUpdating = true;
    notifyListeners();

    try {
      await _read(profileRepository).update(
        UpdateProfileParams(
          avatar: newAvatar,
          fullname: fullname,
          phone: phone,
          email: email,
          birthDate: birthController.text,
          provinceId: provinceId,
          cityId: cityId,
          subdistrictId: subdistrictId,
          postcode: postcode,
          address: address,
        ),
      );

      Navigator.popUntil(context, ModalRoute.withName('/home'));
      _read(accountUserNotifier).fetchUser();
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }

    isUpdating = false;
    notifyListeners();
  }
}
