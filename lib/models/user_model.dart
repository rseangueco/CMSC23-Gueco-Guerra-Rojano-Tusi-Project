import 'dart:convert';

class User {
  String name;
  String username;

  
  User({
    required this.name,
    required this.username
  });
  

  /*
  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      firstName: json['firstName'],
      lastName: json['lastName']
    );
  }
  */

  /*
  static List<UserDetails> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<UserDetails>((dynamic d) => UserDetails.fromJson(d)).toList();
  }
  */

  /*
  Map<String, dynamic> toJson(UserDetails userDetails) {
    return {
      'firstName': userDetails.firstName,
      'lastName': userDetails.lastName
    };
  }
  */
}