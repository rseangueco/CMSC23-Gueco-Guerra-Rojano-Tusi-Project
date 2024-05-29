import 'dart:convert';

class DonationDrive {
  String? id;
  String title;
  String description;
  String organizationId; // foreign key to the organization
  Map<String, String> photos; // key(donation id): value(photo of donation)
  List<dynamic> donations; // foreign keys to the donations

  DonationDrive(
      {this.id,
      required this.title,
      required this.description,
      required this.organizationId,
      required this.photos,
      required this.donations});

  // Factory constructor to instantiate object from json format
  factory DonationDrive.fromJson(Map<String, dynamic> json) {
    return DonationDrive(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        organizationId: json['organizationId'],
        photos: json['photos'],
        donations: json['donations']);
  }

  static List<DonationDrive> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data
        .map<DonationDrive>((dynamic d) => DonationDrive.fromJson(d))
        .toList();
  }

  Map<String, dynamic> toJson(DonationDrive organization) {
    return {
      'title': organization.title,
      'description': organization.description,
      'organizationId': organization.organizationId,
      'photos': organization.photos,
      'donations': organization.donations
    };
  }
}
