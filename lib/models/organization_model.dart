import 'dart:convert';

class Organization {
  String? id;
  String userId;
  String name;
  String? about;
  List<dynamic> proofs;
  String donationStatus;
  List<dynamic>? donations; // foreign keys to the donations
  String approvalStatus;

  Organization(
      {this.id,
      required this.userId,
      required this.name,
      this.about,
      required this.proofs,
      required this.donationStatus,
      this.donations,
      required this.approvalStatus});

  // Factory constructor to instantiate object from json format
  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
        id: json['id'],
        userId: json['userId'],
        name: json['name'],
        about: json['about'],
        proofs: json['proofs'],
        donationStatus: json['donationStatus'],
        approvalStatus: json['approvalStatus'],
        donations: json['donations']);
  }

  static List<Organization> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data
        .map<Organization>((dynamic d) => Organization.fromJson(d))
        .toList();
  }

  Map<String, dynamic> toJson(Organization organization) {
    return {
      'userId': organization.userId,
      'name': organization.name,
      'about': organization.about,
      'proofs': organization.proofs,
      'donationStatus': organization.donationStatus,
      'approvalStatus': organization.approvalStatus,
      'donations': organization.donations
    };
  }
}
