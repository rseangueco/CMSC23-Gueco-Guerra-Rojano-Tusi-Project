import 'dart:convert';

class UserDetails {
  String username;
  String name;
  String contactNo;
  List<String> address;
  String type;
  String? organizationId; // foreign key for organization type users

  
  UserDetails({
    required this.username,
    required this.name,
    required this.contactNo,
    required this.address,
    required this.type,
    this.organizationId
  });
  

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      username: json['username'],
      name: json['name'],
      contactNo: json['contactNo'],
      address: json['address'],
      type: json['type'],
      organizationId: json['organizationId']
    );
  }

  static List<UserDetails> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<UserDetails>((dynamic d) => UserDetails.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(UserDetails userDetails) {
    return {
      'username': userDetails.username,
      'name': userDetails.name,
      'contactNo': userDetails.contactNo,
      'address': userDetails.address,
      'type': userDetails.type
    };
  }
}