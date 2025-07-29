// lib/models/user.dart
class User {
  final int id;
  final String name;
  final String email;
  final String phone;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory User.fromResponse(Map<String, dynamic> map){
    return User(id: map["id"],
        name: map["name"],
        email: map["email"],
        phone: map["phone"]);
  }

}