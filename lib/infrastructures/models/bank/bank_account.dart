class BankAccountResponse {
  const BankAccountResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final List<BankAccount> data;

  factory BankAccountResponse.fromJson(Map<String, dynamic> json) =>
      BankAccountResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        data: List<BankAccount>.from(
            json['data'].map((x) => BankAccount.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BankAccount {
  BankAccount({
    required this.id,
    required this.bankId,
    required this.atasNama,
    required this.accountNumber,
    required this.bankName,
  });

  final int id;
  final String bankId;
  final String atasNama;
  final String accountNumber;
  final String bankName;

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
        id: json['id'],
        bankId: json['bank_id'],
        atasNama: json['atas_nama'],
        accountNumber: json['account_number'],
        bankName: json['bank_name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'bank_id': bankId,
        'atas_nama': atasNama,
        'account_number': accountNumber,
        'bank_name': bankName,
      };
}
