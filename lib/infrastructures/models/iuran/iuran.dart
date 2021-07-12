class IuranResponse {
  IuranResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final int currentPage;
  final int lastPage;
  final int total;
  final List<Iuran> data;

  factory IuranResponse.fromJson(Map<String, dynamic> json) => IuranResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        currentPage: json['current_page'],
        lastPage: json['last_page'],
        total: json['total'],
        data: List<Iuran>.from(json['data'].map((x) => Iuran.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'current_page': currentPage,
        'last_page': lastPage,
        'total': total,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Iuran {
  Iuran({
    required this.id,
    required this.userId,
    required this.feeFromDate,
    required this.feeForDate,
    required this.typeFee,
    required this.detailName,
    required this.bankId,
    required this.accountNumber,
    required this.file,
    required this.createdAt,
    required this.updatedAt,
    required this.fee,
    required this.bankName,
  });

  final int id;
  final String userId;
  final DateTime feeFromDate;
  final DateTime feeForDate;
  final String typeFee;
  final String detailName;
  final String bankId;
  final String accountNumber;
  final String file;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String fee;
  final String bankName;

  factory Iuran.fromJson(Map<String, dynamic> json) => Iuran(
        id: json['id'],
        userId: json['user_id'],
        feeFromDate: DateTime.parse(json['fee_from_date']),
        feeForDate: DateTime.parse(json['fee_for_date']),
        typeFee: json['type_fee'],
        detailName: json['detail_name'],
        bankId: json['bank_id'],
        accountNumber: json['account_number'],
        file: json['file'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        fee: json['fee'],
        bankName: json['bank_name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'fee_from_date':
            '${feeFromDate.year.toString().padLeft(4, '0')}-${feeFromDate.month.toString().padLeft(2, '0')}-${feeFromDate.day.toString().padLeft(2, '0')}',
        'fee_for_date':
            '${feeForDate.year.toString().padLeft(4, '0')}-${feeForDate.month.toString().padLeft(2, '0')}-${feeForDate.day.toString().padLeft(2, '0')}',
        'type_fee': typeFee,
        'detail_name': detailName,
        'bank_id': bankId,
        'account_number': accountNumber,
        'file': file,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'fee': fee,
        'bank_name': bankName,
      };
}
