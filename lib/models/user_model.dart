import 'dart:convert';

class UserDetails {
  String username;
  String contactNo;
  List<String> address;


  
  UserDetails({
    required this.username,
    required this.contactNo,
    required this.address
  });
  

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      username: json['username'],
      contactNo: json['contactNo'],
      address: json['address']
    );
  }

  static List<UserDetails> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<UserDetails>((dynamic d) => UserDetails.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(UserDetails userDetails) {
    return {
      'username': userDetails.username,
      'contactNo': userDetails.contactNo,
      'address': userDetails.address
    };
  }
}