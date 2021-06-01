import 'dart:io';

import 'package:dio/dio.dart';

class UpdateProfileParams {
  final File? avatar;
  final String fullname;
  final String phone;
  final String email;
  final String birthDate;
  final int provinceId;
  final int cityId;
  final int subdistrictId;
  final String postcode;
  final String address;

  const UpdateProfileParams({
    this.avatar,
    required this.fullname,
    required this.phone,
    required this.email,
    required this.birthDate,
    required this.provinceId,
    required this.cityId,
    required this.subdistrictId,
    required this.postcode,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      if (avatar != null) 'file_profile': MultipartFile.fromFile(avatar!.path),
      'fullname': fullname,
      'phone': phone,
      'email': email,
      'born_date': birthDate,
      'province_id': provinceId,
      'city_id': cityId,
      'subdistrict_id': subdistrictId,
      'postcode': postcode,
      'address': address,
    };
  }
}
