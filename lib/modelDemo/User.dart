// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.name,
    required this.email,
    required this.mother,
    required this.friends,
  });

  String name;
  String email;
  Mother mother;
  List<Friend> friends;

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    email: json["email"],
    mother: Mother.fromJson(json["mother"]),
    friends: List<Friend>.from(json["friends"].map((x) => Friend.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "mother": mother.toJson(),
    "friends": List<dynamic>.from(friends.map((x) => x.toJson())),
  };
}

class Friend {
  Friend({
    required this.name,
    required this.email,
    required this.age,
  });

  String name;
  String email;
  int age;

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
    name: json["name"],
    email: json["email"],
    age: json["age"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "age": age,
  };
}

class Mother {
  Mother({
    required this.name,
    required this.email,
  });

  String name;
  String email;

  factory Mother.fromJson(Map<String, dynamic> json) => Mother(
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
  };
}
