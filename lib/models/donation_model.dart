import 'dart:convert';

class Donation {
  String? id;
  String userId; // foreign key for the donor
  String username;
  List<dynamic> category;
  double weight;
  int collectionMethod;
  String? photo;
  String collectionDate;
  String collectionTime;
  String? pickupContactNo;
  List<dynamic>? pickupAddress;
  String organizationId; // foreign key for the organization
  String? donationDriveId; // foreign key for the donation drivae
  String status;

  Donation(
      {this.id,
      required this.userId,
      required this.username,
      required this.category,
      required this.weight,
      required this.collectionMethod,
      this.photo,
      required this.collectionDate,
      required this.collectionTime,
      this.pickupContactNo,
      this.pickupAddress,
      required this.organizationId,
      this.donationDriveId,
      required this.status});

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      userId: json['userId'],
      username: json['username'],
      category: json['category'],
      weight: json['weight'],
      collectionMethod: json['collectionMethod'],
      photo: json['photo'],
      collectionDate: json['collectionDate'],
      collectionTime: json['collectionTime'],
      pickupContactNo: json['pickupContactNo'],
      pickupAddress: json['pickupAddress'],
      organizationId: json['organizationId'],
      donationDriveId: json['donationDriveId'],
      status: json['status'],
    );
  }

  static List<Donation> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donation>((dynamic d) => Donation.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donation donation) {
    return {
      'userId': donation.userId,
      'username': donation.username,
      'category': donation.category,
      'weight': donation.weight,
      'collectionMethod': donation.collectionMethod,
      'photo': donation.photo,
      'collectionDate': donation.collectionDate,
      'collectionTime': donation.collectionTime,
      'pickupContactNo': donation.pickupContactNo,
      'pickupAddress': donation.pickupAddress,
      'organizationId': donation.organizationId,
      'donationDriveId': donation.donationDriveId,
      'status': donation.status
    };
  }
}
