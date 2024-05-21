import 'dart:convert';

class Organization {
  String? id;
  String name;
  String aboutOrganization;
  bool donationStatus;

  Organization(
      {this.id,
      required this.name,
      required this.aboutOrganization,
      required this.donationStatus});

  // Factory constructor to instantiate object from json format
  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
        id: json['id'],
        name: json['name'],
        aboutOrganization: json['aboutOrganization'],
        donationStatus: json['donationStatus']);
  }

  static List<Organization> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data
        .map<Organization>((dynamic d) => Organization.fromJson(d))
        .toList();
  }

  Map<String, dynamic> toJson(Organization organization) {
    return {
      'name': organization.name,
      'aboutOrganization': organization.aboutOrganization,
      'donationStatus': organization.donationStatus
    };
  }
}