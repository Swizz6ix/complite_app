class Company {
  final int id;
  final String name;
  final String country;
  final String address;
  final int employeeCount;
  final String industry;
  int? marketCap;
  final String domain;
  final String logo;
  final String ceoName;
  final String zip;

  Company({
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
}
