import 'dart:convert';

class Organization {
  String name;
  String? status;
  String? about;
  List<String>? donations;
  String userID; //foreign key for user

  Organization({
    required this.name,
    this.status,
    this.about,
    this.donations,
    required this.userID,
  });

  // Factory constructor to instantiate object from json format
  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      name: json['name'],
      status: json['status'],
      about: json['about'],
      donations: json['donations'],
      userID: json['userID']
    );
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
      'status': organization.status,
      'about': organization.about,
      'donations': organization.donations,
      'userID': organization.userID
    };
  }
}