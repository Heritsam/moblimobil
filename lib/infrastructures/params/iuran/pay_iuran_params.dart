import 'dart:io';

import 'package:dio/dio.dart';

import '../../models/bank/bank.dart';

class PayIuranParams {
  final String fullname;
  final Bank bankId;
  final String accountNumber;
  final String nominal;
  final String type;
  final File file;

  const PayIuranParams({
    required this.fullname,
    required this.bankId,
    required this.accountNumber,
    required this.nominal,
    required this.type,
    required this.file,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'bank_id': bankId.id,
      'account_number': accountNumber,
      'nominal': nominal,
      'type': type,
      'file_upload': MultipartFile.fromBytes(
        file.readAsBytesSync(),
        filename: file.path.split('/').last,
      ),
    };
  }
}
