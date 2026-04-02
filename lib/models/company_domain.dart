import 'package:complite/models/company.dart';
import 'package:complite/models/company_dto.dart';

extension CompanyMapper on CompanyDto {
  Company toDomain() {
    return Company(
      id: id, 
      name: name, 
      country: country, 
      address: address, 
      employeeCount: employeeCount, 
      industry: industry, 
      domain: domain, 
      logo: logo, 
      ceoName: ceoName, 
      zip: zip
    );
  }
}

extension CompanyDomainMapper on Company {
  CompanyDto toDto() {
    return CompanyDto(
      id: id, 
      name: name, 
      country: country, 
      address: address, 
      employeeCount: employeeCount, 
      industry: industry, 
      domain: domain, 
      logo: logo, 
      ceoName: ceoName, 
      zip: zip
    );
  }
}