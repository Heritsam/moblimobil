import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';
import '../models/bank/bank.dart';
import '../models/bank/bank_account.dart';

final bankRepository = Provider<BankRepository>((ref) {
  return BankRepositoryImpl(ref.watch(dioClient));
});

abstract class BankRepository {
  Future<List<Bank>> banks();
  Future<List<BankAccount>> bankAccounts();
}

class BankRepositoryImpl implements BankRepository {
  final DioClient _client;

  const BankRepositoryImpl(this._client);

  @override
  Future<List<Bank>> banks() async {
    try {
      final response = await _client.get('/api/bank');

      return BankResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<List<BankAccount>> bankAccounts() async {
    try {
      final response = await _client.get('/api/bank-account');

      return BankAccountResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
