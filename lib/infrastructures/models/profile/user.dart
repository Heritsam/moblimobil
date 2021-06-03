class User {
  User({
    required this.id,
    required this.fullname,
    required this.phone,
    required this.email,
    this.bornDate,
    this.file,
    required this.status,
    required this.emailVerifiedToken,
    this.emailVerifiedAt,
    required this.isVendor,
    required this.createdAt,
    required this.updatedAt,
    this.address,
    this.provinceId,
    this.provinceName,
    this.cityId,
    this.cityName,
    this.subdistrictId,
    this.subdistrictName,
    this.postcode,
    this.statusVendor,
    this.isVerified,
    this.monthlyContrBill,
  });

  String get formattedPhone {
    String format = 'xxxx xxxx xxxx';

    this.phone.split('').forEach((char) {
      format = format.replaceFirst('x', char);
    });
    
    return format.replaceAll('x', '');
  }

  final int id;
  final String fullname;
  final String phone;
  final String email;
  final DateTime? bornDate;
  final String? file;
  final String status;
  final String emailVerifiedToken;
  final DateTime? emailVerifiedAt;
  final String isVendor;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? address;
  final String? provinceId;
  final String? provinceName;
  final String? cityId;
  final String? cityName;
  final String? subdistrictId;
  final String? subdistrictName;
  final String? postcode;
  final String? statusVendor;
  final bool? isVerified;
  final DateTime? monthlyContrBill;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        fullname: json['fullname'],
        phone: json['phone'],
        email: json['email'],
        bornDate: json['born_date'] != null
            ? DateTime.tryParse(json['born_date'])
            : null,
        file: json['file'],
        status: json['status'],
        emailVerifiedToken: json['email_verified_token'],
        emailVerifiedAt: json['email_verified_at'] != null
            ? DateTime.tryParse(json['email_verified_at'])
            : null,
        isVendor: json['is_vendor'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        address: json['address'] != null ? json['address'] : null,
        provinceId: json['province_id'] != null ? json['province_id'] : null,
        provinceName:
            json['province_name'] != null ? json['province_name'] : null,
        cityId: json['city_id'] != null ? json['city_id'] : null,
        cityName: json['city_name'] != null ? json['city_name'] : null,
        subdistrictId:
            json['subdistrict_id'] != null ? json['subdistrict_id'] : null,
        subdistrictName:
            json['subdistrict_name'] != null ? json['subdistrict_name'] : null,
        postcode: json['postcode'] != null ? json['postcode'] : null,
        statusVendor:
            json['status_vendor'] != null ? json['status_vendor'] : null,
        isVerified: json['is_verified'] != null ? json['is_verified'] : null,
        monthlyContrBill: json['monthly_contr_bill'] != null
            ? DateTime.tryParse(json['monthly_contr_bill'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullname': fullname,
        'phone': phone,
        'email': email,
        'born_date': bornDate,
        'file': file,
        'status': status,
        'email_verified_token': emailVerifiedToken,
        'email_verified_at': emailVerifiedAt?.toIso8601String(),
        'is_vendor': isVendor,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'address': address,
        'province_id': provinceId,
        'province_name': provinceName,
        'city_id': cityId,
        'city_name': cityName,
        'subdistrict_id': subdistrictId,
        'subdistrict_name': subdistrictName,
        'postcode': postcode,
        'status_vendor': statusVendor,
        'is_verified': isVerified,
        'monthly_contr_bill':
            '${monthlyContrBill?.year.toString().padLeft(4, '0')}-${monthlyContrBill?.month.toString().padLeft(2, '0')}-${monthlyContrBill?.day.toString().padLeft(2, '0')}',
      };
}
