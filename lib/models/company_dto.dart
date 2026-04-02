class CompanyDto {
  final int id;
  final String name;
  final String country;
  final String address;
  final int employeeCount;
  final String industry;
  final int? marketCap;
  final String domain;
  final String logo;
  final String ceoName;
  final String zip;

  CompanyDto({
    required this.id,
    required this.name,
    required this.country,
    required this.address,
    required this.employeeCount,
    required this.industry,
    this.marketCap,
    required this.domain,
    required this.logo,
    required this.ceoName,
    required this.zip,
  });

   factory CompanyDto.fromJson(Map<String, dynamic> json) {
    return CompanyDto(
      id: json.getInt('id'),
      name: json.getString('name'),
      country: json.getString('country'),
      address: json.getString('address'),
      employeeCount: json.getInt('employeecount'),
      industry: json.getString('industry'),
      marketCap: json.getInt('marketCap'),
      domain: json.getString('domain'),
      logo: json.getString('logo'),
      ceoName: json.getString('ceoName'),
      zip: json.getString('zip'),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'address': address,
      'employeeCount': employeeCount,
      'industry': industry,
      'marketCap': marketCap,
      'domain': domain,
      'logo': logo,
      'ceoName': ceoName,
      'zip': zip,
    };
  }
}

extension JsonParsing on Map<String, dynamic> {
  int getInt(String key, {int defaultValue = 0}) {
    final value = this[key];
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  String getString(String key, {String defaultValue = ''}) {
    final value = this[key];
    if (value is String) return value;
    return defaultValue;
  }
}