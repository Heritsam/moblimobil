class About {
  const About({
    required this.brandName,
    required this.logo,
    required this.logo2,
    required this.aboutUs,
    required this.aboutUsImg,
    required this.phone,
    required this.email,
    required this.address,
  });

  String get formattedPhone {
    String format = 'xxxx xxxx xxxx';

    this.phone.split('').forEach((char) {
      format = format.replaceFirst('x', char);
    });
    
    return format.replaceAll('x', '');
  }

  final String brandName;
  final String logo;
  final String logo2;
  final String aboutUs;
  final String aboutUsImg;
  final String phone;
  final String email;
  final String address;

  factory About.fromJson(Map<String, dynamic> json) => About(
        brandName: json['brand_name'],
        logo: json['logo'],
        logo2: json['logo2'],
        aboutUs: json['about_us'],
        aboutUsImg: json['about_us_img'],
        phone: json['phone'],
        email: json['email'],
        address: json['address'],
      );

  Map<String, dynamic> toJson() => {
        'brand_name': brandName,
        'logo': logo,
        'logo2': logo2,
        'about_us': aboutUs,
        'about_us_img': aboutUsImg,
        'phone': phone,
        'email': email,
        'address': address,
      };
}
